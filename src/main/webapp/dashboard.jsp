<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Asset Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<div id="sidebar" class="sidebar">

    <h2>Asset Management</h2>

    <a href="dashboard.jsp">Dashboard</a>

    <a href="register.jsp">Register Employee</a>

    <a href="add-asset.jsp">Add Asset</a>

    <a href="employees.jsp">Employees</a>

    <a href="assets.jsp">Assets</a>

    <a href="assign-asset.jsp">Assign Asset</a>

    <a href="update-status.jsp">Update Asset Status</a>

    <a href="maintenance.jsp">Maintenance</a>

    <a href="assignment-history.jsp">Assignment History</a>

</div>


<!-- =========================
     NAVBAR
     ========================= -->

<div class="navbar">

    <!-- Hamburger button -->
    <button class="menu-btn" onclick="toggleSidebar()">
        &#9776;
    </button>


    <!-- Existing title -->
    <h1>Asset Management</h1>


    <!-- Existing right section -->
    <div class="right">

        <span>
            Welcome, ${sessionScope.username}
        </span>

        <a href="logout">
            Logout
        </a>

    </div>

</div>

    <div class="container">

        <div class="filter-bar">
            <form action="viewAssets" method="get">
                <label>Filter by:</label>
                <select name="filterType" onchange="this.form.submit()">
                    <option value="all"      ${filterType == 'all' ? 'selected' : ''}>All Assets</option>
                    <option value="status"   ${filterType == 'status' ? 'selected' : ''}>By Status</option>
                    <option value="employee" ${filterType == 'employee' ? 'selected' : ''}>By Employee</option>
                    <option value="date"     ${filterType == 'date' ? 'selected' : ''}>By Assigned Date</option>
                </select>

                <c:if test="${filterType == 'status'}">
                    <select name="statusValue">
                        <option ${statusValue == 'Available' ? 'selected' : ''}>Available</option>
                        <option ${statusValue == 'Assigned' ? 'selected' : ''}>Assigned</option>
                        <option ${statusValue == 'Defective' ? 'selected' : ''}>Defective</option>
                        <option ${statusValue == 'Under Maintenance' ? 'selected' : ''}>Under Maintenance</option>
                    </select>
                </c:if>

                <c:if test="${filterType == 'employee'}">
                    <input type="text" name="employeeName" placeholder="Employee name" value="${employeeName}">
                </c:if>

                <c:if test="${filterType == 'date'}">
                    <label>From</label> <input type="date" name="fromDate" value="${fromDate}">
                    <label>To</label>   <input type="date" name="toDate" value="${toDate}">
                </c:if>

                <input type="submit" value="Apply Filter">
                <a class="reset" href="viewAssets">Reset</a>
            </form>
        </div>

        <div class="table-card">
            <table>
                <thead>
                    <tr>
                        <th>ID</th><th>Code</th><th>Type</th><th>Status</th>
                        <th>Assigned To</th><th>Assigned Date</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="asset" items="${assets}">
                        <tr>
                            <td>${asset.id}</td>
                            <td><strong>${asset.code}</strong></td>
                            <td>${asset.type}</td>
                            <td>
                                <span class="badge ${asset.status == 'Available' ? 'b-green' :
                                                     asset.status == 'Assigned' ? 'b-blue' :
                                                     asset.status == 'Defective' ? 'b-red' : 'b-orange'}">
                                    ${asset.status}
                                </span>
                            </td>
                            <td>${empty asset.employeeName ? '-' : asset.employeeName}</td>
                            <td>${empty asset.assignedDate ? '-' : asset.assignedDate}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty assets}">
                        <tr><td colspan="6" class="empty">No assets found</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
    <div class = "footer">
            <p class="auth-link">Register a new User? <a href="register.jsp">Register</a></p>
    </div>
    <script>

        function toggleSidebar() {

            document.getElementById("sidebar").classList.toggle("active");

        }

    </script>
</body>
</html>