package com.assetmanagement.servlet;

import com.assetmanagement.servlet.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/viewAssets")
public class ViewAssetsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String filterType = request.getParameter("filterType");
        if (filterType == null) filterType = "all"; // default when page first loads

        // Base query: LEFT JOIN so assets with NO current assignment still show up
        StringBuilder sql = new StringBuilder(
                "SELECT a.asset_id, a.asset_code, a.asset_type, a.status, " +
                        "       e.employee_name, aa.assigned_date " +
                        "FROM assets a " +
                        "LEFT JOIN asset_assignment aa ON a.asset_id = aa.asset_id AND aa.status = 'Assigned' " +
                        "LEFT JOIN employees e ON aa.employee_id = e.employee_id " +
                        "WHERE 1=1 "   // dummy condition, makes it easy to append "AND ..." below
        );

        String statusValue = request.getParameter("statusValue");
        String employeeName = request.getParameter("employeeName");
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");

        // Append the right condition based on filter type
        switch (filterType) {
            case "status":
                sql.append("AND a.status = ? ");
                break;
            case "employee":
                sql.append("AND e.employee_name LIKE ? ");
                break;
            case "date":
                sql.append("AND aa.assigned_date BETWEEN ? AND ? ");
                break;
            // "all" adds no extra condition
        }

        List<Map<String, Object>> assetList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            // Fill in the '?' placeholders IN ORDER, only for the active filter
            int paramIndex = 1;
            if ("status".equals(filterType)) {
                ps.setString(paramIndex++, statusValue);
            } else if ("employee".equals(filterType)) {
                ps.setString(paramIndex++, "%" + employeeName + "%"); // % = partial match
            } else if ("date".equals(filterType)) {
                ps.setString(paramIndex++, fromDate);
                ps.setString(paramIndex++, toDate);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> asset = new HashMap<>();
                asset.put("id", rs.getInt("asset_id"));
                asset.put("code", rs.getString("asset_code"));
                asset.put("type", rs.getString("asset_type"));
                asset.put("status", rs.getString("status"));
                asset.put("employeeName", rs.getString("employee_name"));
                asset.put("assignedDate", rs.getString("assigned_date"));
                assetList.add(asset);
            }

        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }

        // Send data + which filter was chosen back to the JSP
        // (so the form remembers the user's selection after reload)
        request.setAttribute("assets", assetList);
        request.setAttribute("filterType", filterType);
        request.setAttribute("statusValue", statusValue);
        request.setAttribute("employeeName", employeeName);
        request.setAttribute("fromDate", fromDate);
        request.setAttribute("toDate", toDate);

        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}