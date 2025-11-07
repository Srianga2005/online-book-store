<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Users - Admin Dashboard</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin-dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div style="padding: 40px;">
        <h1>✅ Users Page Loading Successfully!</h1>
        <p>Server Time: <%= new java.util.Date() %></p>
        <p>Context Path: <%= request.getContextPath() %></p>
        
        <div style="margin-top: 30px;">
            <h2>This proves the server is working!</h2>
            <p>The original users.jsp has a compilation error. Working on fix...</p>
        </div>
        
        <div style="margin-top: 30px;">
            <a href="test.jsp" style="padding: 10px 20px; background: #667eea; color: white; text-decoration: none; border-radius: 5px;">
                Go to Test Page
            </a>
            <a href="../" style="padding: 10px 20px; background: #10b981; color: white; text-decoration: none; border-radius: 5px; margin-left: 10px;">
                Go to Home
            </a>
        </div>
    </div>
</body>
</html>
