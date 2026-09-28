<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Asset Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="auth-body">
    <div class="auth-card">
        <h2>Create Account</h2>
        <p class="subtitle">Register to manage assets</p>

        <c:if test="${not empty error}">
            <div class="msg error">${error}</div>
        </c:if>

        <form action="register" method="post">
            <label>Username</label>
            <input type="text" name="username" placeholder="Choose a username" maxlength="50" required>
            <label>Password</label>
            <input type="password" name="password" placeholder="Choose a password" maxlength="50" required>
            <label>Confirm Password</label>
            <input type="password" name="confirmPassword" placeholder="Re-enter password" maxlength="50" required>
            <button type="submit" class="btn">Register</button>
        </form>

        <p class="auth-link">Already have an account? <a href="login.jsp">Login</a></p>
    </div>
</body>
</html>