<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="mypackage.UserDAO" %>
<%
    if(request.getMethod().equals("POST")) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        UserDAO userDAO = new UserDAO();
        if(userDAO.login(username, password)) {
            session.setAttribute("username", username);
            response.sendRedirect("home.jsp");
        } else {
            out.println("Invalid credentials");
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
</head>
<body>
    <form method="post">
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Login</button>
    </form>
</body>
</html>