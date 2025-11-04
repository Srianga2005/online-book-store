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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Online Bookstore</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin-dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <%@ include file="admin/sidebar.jsp" %>
    
    <main class="main-content">
        <%@ include file="admin/topbar.jsp" %>
        
        <div class="content-wrapper">
            <div class="content-header">
                <div>
                    <h1>Hi, welcome back <%= userName %>!</h1>
                    <p class="subtitle">Your bookstore analytics dashboard</p>
                </div>
                <div class="header-actions">
                    <button class="btn btn-outline" onclick="window.location.href='<%=request.getContextPath()%>/addbook'">
                        <i class="fas fa-plus"></i> Add Book
                    </button>
                    <button class="btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/admin/manage-books.jsp'">
                        <i class="fas fa-book"></i> Manage Books
                    </button>
                </div>
            </div>
            
            <div class="stats-grid">
                <div class="stat-card stat-card-orange">
                    <div class="stat-header">
                        <h3>Inventory Value</h3>
                        <div class="stat-icon">
                            <i class="fas fa-dollar-sign"></i>
                        </div>
                    </div>
                    <div class="stat-value">$8,753</div>
                    <div class="stat-footer">Total inventory worth</div>
                </div>
                
                <div class="stat-card stat-card-pink">
                    <div class="stat-header">
                        <h3>Total Books</h3>
                        <div class="stat-icon">
                            <i class="fas fa-book"></i>
                        </div>
                    </div>
                    <div class="stat-value">12</div>
                    <div class="stat-footer">Books in inventory</div>
                </div>
                
                <div class="stat-card stat-card-blue">
                    <div class="stat-header">
                        <h3>Categories</h3>
                        <div class="stat-icon">
                            <i class="fas fa-list"></i>
                        </div>
                    </div>
                    <div class="stat-value">3</div>
                    <div class="stat-footer">Book categories</div>
                </div>
                
                <div class="stat-card stat-card-teal">
                    <div class="stat-header">
                        <h3>Total Users</h3>
                        <div class="stat-icon">
                            <i class="fas fa-users"></i>
                        </div>
                    </div>
                    <div class="stat-value">3</div>
                    <div class="stat-footer">Registered users</div>
                </div>
            </div>
            
            <div class="card" style="margin-top: 30px;">
                <div class="card-header">
                    <h3>Quick Actions</h3>
                </div>
                <div class="card-body">
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px;">
                        <a href="<%=request.getContextPath()%>/admin/manage-books.jsp" class="btn btn-primary" style="text-decoration: none; text-align: center;">
                            <i class="fas fa-book"></i> Manage Books
                        </a>
                        <a href="<%=request.getContextPath()%>/admin/orders.jsp" class="btn btn-primary" style="text-decoration: none; text-align: center;">
                            <i class="fas fa-shopping-cart"></i> View Orders
                        </a>
                        <a href="<%=request.getContextPath()%>/admin/users.jsp" class="btn btn-primary" style="text-decoration: none; text-align: center;">
                            <i class="fas fa-users"></i> Manage Users
                        </a>
                        <a href="<%=request.getContextPath()%>/admin/analytics.jsp" class="btn btn-primary" style="text-decoration: none; text-align: center;">
                            <i class="fas fa-chart-bar"></i> Analytics
                        </a>
                        <a href="<%=request.getContextPath()%>/admin/settings.jsp" class="btn btn-primary" style="text-decoration: none; text-align: center;">
                            <i class="fas fa-cog"></i> Settings
                        </a>
                        <a href="<%=request.getContextPath()%>/admin/reports.jsp" class="btn btn-primary" style="text-decoration: none; text-align: center;">
                            <i class="fas fa-file-alt"></i> Reports
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </main>
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/admin-dashboard.js"></script>
</body>
</html>
