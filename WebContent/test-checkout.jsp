<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Test Checkout</title>
</head>
<body>
    <h1>Test Checkout Button</h1>
    
    <h2>Test 1: Direct Link</h2>
    <a href="<%=request.getContextPath()%>/checkout">Click here to test checkout servlet</a>
    
    <h2>Test 2: Form POST</h2>
    <form action="<%=request.getContextPath()%>/checkout" method="post">
        <button type="submit" style="padding: 10px 20px; background: blue; color: white; border: none; cursor: pointer;">
            Test Checkout Form
        </button>
    </form>
    
    <h2>Test 3: Form GET</h2>
    <form action="<%=request.getContextPath()%>/checkout" method="get">
        <button type="submit" style="padding: 10px 20px; background: green; color: white; border: none; cursor: pointer;">
            Test Checkout GET
        </button>
    </form>
    
    <hr>
    <p>Context Path: <%= request.getContextPath() %></p>
    <p>Full Checkout URL: <%= request.getContextPath() %>/checkout</p>
    
    <hr>
    <h2>Session Info:</h2>
    <p>Session ID: <%= session.getId() %></p>
    <p>User in session: <%= session.getAttribute("user") != null ? "YES" : "NO" %></p>
    
</body>
</html>
