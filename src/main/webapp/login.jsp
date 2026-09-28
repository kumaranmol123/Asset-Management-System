<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Asset Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="auth-body">
    <div class="auth-card">
        <h2>Asset Management</h2>
        <p class="subtitle">Sign in to your account</p>

        <c:if test="${not empty error}">
            <div class="msg error">${error}</div>
        </c:if>
        <c:if test="${param.registered != null}">
            <div class="msg success">Registration successful! Please login.</div>
        </c:if>

        <form action="login" method="post">
            <label>Username</label>
            <input type="text" name="username" placeholder="Enter username" required>
            <label>Password</label>
            <input type="password" name="password" placeholder="Enter password" required>
            <button type="submit" class="btn">Login</button>
        </form>

    </div>
</body>
</html>