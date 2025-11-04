<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.bittercode.model.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="com.bittercode.model.UserRole" %>
<%@ page import="com.bittercode.model.Book" %>
<%@ page import="com.bittercode.util.StoreUtil" %>
<%@ page import="com.bittercode.service.UserService" %>
<%@ page import="com.bittercode.service.BookService" %>
<%@ page import="com.bittercode.service.impl.UserServiceImpl" %>
<%@ page import="com.bittercode.service.impl.BookServiceImpl" %>
<%@ page import="java.util.List" %>
<%
    User user = null;
    String userName = "Mr.Admin";
    try {
        user = (User) session.getAttribute("user");
        if (user != null) {
            userName = user.getFirstName() + " " + user.getLastName();
        }
    } catch (Exception e) {
        // safe defaults already set
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><fmt:message key="app.title"/> - Admin</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin-dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body>
    <%@ include file="admin/sidebar.jsp" %>
    
    <!-- Main Content -->
    <main class="main-content">
        <%@ include file="admin/topbar.jsp" %>
        
        <!-- Dashboard Content -->
        <div class="content-wrapper" id="dashboard-content">
            <div class="content-header">
            <fmt:setBundle basename="messages"/>
            <div>
                <h1><fmt:message key="admin.welcome"/></h1>
                <p class="subtitle"><fmt:message key="admin.subtitle"/></p>
            </div>
                <div class="header-actions">
                    <button class="btn btn-icon" title="Compose Email" onclick="window.location.href='mailto:sriangnayak@gmail.com?subject=Store%20Dashboard%20Report'">
                        <i class="fas fa-envelope"></i>
                    </button>
                    <button class="btn btn-icon" title="Print this page" onclick="window.print()">
                        <i class="fas fa-print"></i>
                    </button>
                    <a class="btn btn-icon" title="View Orders" href="<%=request.getContextPath()%>/manageorders">
                        <i class="fas fa-shopping-cart"></i>
                    </a>
                    <a class="btn btn-primary" href="<%=request.getContextPath()%>/create-user" title="Add new user">
                        <i class="fas fa-user-plus"></i> Add User
                    </a>
                </div>
            </div>
            <% if (application.getAttribute("lastTxnId") != null) { %>
            <div style="background:#ffffff;border:1px solid rgba(0,0,0,.06);border-radius:16px;padding:14px 18px;margin:0 16px 16px;display:flex;gap:16px;align-items:center;box-shadow:0 10px 25px rgba(0,0,0,.06);">
                <div style="font-weight:800;color:#111827;">Last Payment</div>
                <div style="color:#4b5563;">Txn:</div>
                <div style="background:#eef2ff;color:#3730a3;padding:4px 8px;border-radius:8px;font-weight:700;">
                    <%= (String)application.getAttribute("lastTxnId") %>
                </div>
                <div style="color:#4b5563;">Email:</div>
                <div style="background:#ecfeff;color:#065f46;padding:4px 8px;border-radius:8px;font-weight:600;">
                    <%= (String)application.getAttribute("lastTxnEmail") %>
                </div>
                <div style="margin-left:auto;font-weight:800;color:#111827;">Amount: ₹<%= String.format("%.2f", (application.getAttribute("lastTxnAmount")!=null? (Double)application.getAttribute("lastTxnAmount"):0.0)) %></div>
            </div>
            <% } %>
            
            <!-- Stats Cards -->
            <div class="stats-grid">
                <div class="stat-card stat-card-orange">
                    <div class="stat-header">
                        <div class="stat-title"><fmt:message key="stat.inventory"/></div>
                        <div class="stat-icon">
                            <i class="fas fa-dollar-sign"></i>
                        </div>
                    </div>
                    <div class="stat-value">₹<%= request.getAttribute("inventoryValue") != null ? request.getAttribute("inventoryValue") : "0.00" %></div>
                    <div class="stat-footer"><fmt:message key="stat.inventory.footer"/></div>
                </div>
                
                <div class="stat-card stat-card-pink">
                    <div class="stat-header">
                        <div class="stat-title"><fmt:message key="stat.totalBooks"/></div>
                        <div class="stat-icon">
                            <i class="fas fa-book"></i>
                        </div>
                    </div>
                    <div class="stat-value"><%= request.getAttribute("totalBooks") != null ? request.getAttribute("totalBooks") : 0 %></div>
                    <div class="stat-footer"><fmt:message key="stat.totalBooks.footer"/></div>
                </div>
                
                <div class="stat-card stat-card-blue">
                    <div class="stat-header">
                        <div class="stat-title"><fmt:message key="stat.booksSoldToday"/></div>
                        <div class="stat-icon">
                            <i class="fas fa-calendar-day"></i>
                        </div>
                    </div>
                    <div class="stat-value"><%= request.getAttribute("booksSoldToday") != null ? request.getAttribute("booksSoldToday") : 0 %></div>
                    <div class="stat-footer"><fmt:message key="stat.booksSoldToday.footer"/></div>
                </div>
                
                <div class="stat-card stat-card-teal">
                    <div class="stat-header">
                        <div class="stat-title"><fmt:message key="stat.totalUsers"/></div>
                        <div class="stat-icon">
                            <i class="fas fa-users"></i>
                        </div>
                    </div>
                    <div class="stat-value"><%= request.getAttribute("totalUsers") != null ? request.getAttribute("totalUsers") : 0 %></div>
                    <div class="stat-footer"><fmt:message key="stat.totalUsers.footer"/></div>
                </div>
            </div>
            
            <!-- Secondary Stats Row -->
            <div class="stats-grid" style="margin-top: 1rem;">
                <div class="stat-card stat-card-purple">
                    <div class="stat-header">
                        <div class="stat-title"><fmt:message key="stat.totalBooksSold"/></div>
                        <div class="stat-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                    </div>
                    <div class="stat-value"><%= request.getAttribute("totalBooksSold") != null ? request.getAttribute("totalBooksSold") : 0 %></div>
                    <div class="stat-footer"><fmt:message key="stat.totalBooksSold.footer"/></div>
                </div>
            </div>
        </div>
    </main>
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/admin-dashboard.js"></script>
</body>
</html>
