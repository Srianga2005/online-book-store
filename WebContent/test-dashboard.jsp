<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.bittercode.model.User" %>
<%@ page import="com.bittercode.model.UserRole" %>
<%@ page import="com.bittercode.util.StoreUtil" %>
<%
    if (!StoreUtil.isLoggedIn(UserRole.SELLER, session)) {
        response.sendRedirect("SellerLogin.jsp");
        return;
    }
    User user = (User) session.getAttribute("user");
    String userName = user != null ? user.getFirstName() + " " + user.getLastName() : "Admin";
%>
<!DOCTYPE html>
<html>
<head>
    <title>Test Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        .success { color: green; font-size: 24px; }
    </style>
</head>
<body>
    <h1 class="success">✅ Dashboard Loaded Successfully!</h1>
    <p>Welcome, <%= userName %>!</p>
    <p>If you see this, the basic authentication and JSP rendering is working.</p>
    <hr>
    <h3>Next Step: Testing Database Connection</h3>
    <a href="AdminDashboard.jsp">Go to Full Dashboard</a>
</body>
</html>
