<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.bittercode.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Session Check</title>
    <style>
        body { font-family: Arial; padding: 20px; background: #f5f5f5; }
        .info { background: white; padding: 20px; border-radius: 10px; margin: 10px 0; }
        .success { color: green; }
        .error { color: red; }
    </style>
</head>
<body>
    <h1>Session Status Check</h1>
    
    <div class="info">
        <h2>Session Information:</h2>
        <p><strong>Session ID:</strong> <%= session.getId() %></p>
        <p><strong>Session Created:</strong> <%= new java.util.Date(session.getCreationTime()) %></p>
        <p><strong>Last Accessed:</strong> <%= new java.util.Date(session.getLastAccessedTime()) %></p>
    </div>
    
    <div class="info">
        <h2>User Login Status:</h2>
        <%
            User user = (User) session.getAttribute("user");
            if (user != null) {
        %>
            <p class="success">✅ <strong>USER IS LOGGED IN</strong></p>
            <p><strong>Username:</strong> <%= user.getUsername() %></p>
            <p><strong>Name:</strong> <%= user.getFirstName() %> <%= user.getLastName() %></p>
            <p><strong>Email:</strong> <%= user.getMailId() %></p>
            <p><strong>User Type:</strong> <%= user.getUserType() %></p>
        <%
            } else {
        %>
            <p class="error">❌ <strong>NO USER IN SESSION</strong></p>
            <p>You need to login first!</p>
            <a href="<%=request.getContextPath()%>/CustomerLogin.jsp">Go to Login</a>
        <%
            }
        %>
    </div>
    
    <div class="info">
        <h2>Cart Information:</h2>
        <%
            Object cartItems = session.getAttribute("cartItems");
            Object items = session.getAttribute("items");
            Object amountToPay = session.getAttribute("amountToPay");
        %>
        <p><strong>Cart Items:</strong> <%= cartItems != null ? "YES (" + ((java.util.List)cartItems).size() + " items)" : "NO" %></p>
        <p><strong>Items Count:</strong> <%= items != null ? items : "0" %></p>
        <p><strong>Amount to Pay:</strong> ₹<%= amountToPay != null ? amountToPay : "0.00" %></p>
    </div>
    
    <div class="info">
        <h2>Quick Actions:</h2>
        <% if (user != null) { %>
            <a href="<%=request.getContextPath()%>/viewbook" style="display: inline-block; padding: 10px 20px; background: blue; color: white; text-decoration: none; border-radius: 5px; margin: 5px;">Browse Books</a>
            <a href="<%=request.getContextPath()%>/cart" style="display: inline-block; padding: 10px 20px; background: green; color: white; text-decoration: none; border-radius: 5px; margin: 5px;">View Cart</a>
            <a href="<%=request.getContextPath()%>/checkout" style="display: inline-block; padding: 10px 20px; background: purple; color: white; text-decoration: none; border-radius: 5px; margin: 5px;">Go to Checkout</a>
        <% } else { %>
            <a href="<%=request.getContextPath()%>/CustomerLogin.jsp" style="display: inline-block; padding: 10px 20px; background: red; color: white; text-decoration: none; border-radius: 5px; margin: 5px;">Login First</a>
        <% } %>
    </div>
    
</body>
</html>
