<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.bittercode.model.User" %>
<%@ page import="com.bittercode.model.UserRole" %>
<%@ page import="com.bittercode.util.StoreUtil" %>
<%
    if (!StoreUtil.isLoggedIn(UserRole.SELLER, session)) {
        response.sendRedirect("../SellerLogin.jsp");
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
    <title>Settings - Admin Dashboard</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin-dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <%@ include file="sidebar.jsp" %>
    
    <main class="main-content">
        <%@ include file="topbar.jsp" %>
        
        <div class="content-wrapper">
            <div class="content-header">
                <div>
                    <h1>Settings</h1>
                    <p class="subtitle">Manage your application settings and preferences</p>
                </div>
            </div>
            
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(400px, 1fr)); gap: 20px;">
                <!-- General Settings -->
                <div class="card">
                    <div class="card-header">
                        <h3><i class="fas fa-cog"></i> General Settings</h3>
                    </div>
                    <div class="card-body">
                        <div class="form-group">
                            <label class="form-label">Store Name</label>
                            <input type="text" class="form-control" value="Online BookStore" placeholder="Enter store name">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Store Email</label>
                            <input type="email" class="form-control" value="admin@bookstore.com" placeholder="Enter email">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Store Phone</label>
                            <input type="tel" class="form-control" value="+1 234 567 8900" placeholder="Enter phone">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Currency</label>
                            <select class="form-control">
                                <option>USD ($)</option>
                                <option>EUR (€)</option>
                                <option>GBP (£)</option>
                                <option>INR (₹)</option>
                            </select>
                        </div>
                        <button class="btn btn-primary">Save Changes</button>
                    </div>
                </div>
                
                <!-- Database Settings -->
                <div class="card">
                    <div class="card-header">
                        <h3><i class="fas fa-database"></i> Database Settings</h3>
                    </div>
                    <div class="card-body">
                        <div class="form-group">
                            <label class="form-label">Database Host</label>
                            <input type="text" class="form-control" value="localhost" placeholder="Database host">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Database Port</label>
                            <input type="text" class="form-control" value="3306" placeholder="Port">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Database Name</label>
                            <input type="text" class="form-control" value="onlinebookstore" placeholder="Database name">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Database Username</label>
                            <input type="text" class="form-control" value="root" placeholder="Username">
                        </div>
                        <button class="btn btn-primary">Test Connection</button>
                        <button class="btn btn-outline">Save</button>
                    </div>
                </div>
                
                <!-- Email Settings -->
                <div class="card">
                    <div class="card-header">
                        <h3><i class="fas fa-envelope"></i> Email Settings</h3>
                    </div>
                    <div class="card-body">
                        <div class="form-group">
                            <label class="form-label">SMTP Host</label>
                            <input type="text" class="form-control" placeholder="smtp.gmail.com">
                        </div>
                        <div class="form-group">
                            <label class="form-label">SMTP Port</label>
                            <input type="text" class="form-control" placeholder="587">
                        </div>
                        <div class="form-group">
                            <label class="form-label">SMTP Username</label>
                            <input type="text" class="form-control" placeholder="your-email@gmail.com">
                        </div>
                        <div class="form-group">
                            <label class="form-label">SMTP Password</label>
                            <input type="password" class="form-control" placeholder="••••••••">
                        </div>
                        <div class="form-group">
                            <label class="checkbox-label">
                                <input type="checkbox"> Enable SSL/TLS
                            </label>
                        </div>
                        <button class="btn btn-primary">Save Settings</button>
                    </div>
                </div>
                
                <!-- Security Settings -->
                <div class="card">
                    <div class="card-header">
                        <h3><i class="fas fa-shield-alt"></i> Security Settings</h3>
                    </div>
                    <div class="card-body">
                        <div class="form-group">
                            <label class="checkbox-label">
                                <input type="checkbox" checked> Enable Two-Factor Authentication
                            </label>
                        </div>
                        <div class="form-group">
                            <label class="checkbox-label">
                                <input type="checkbox" checked> Force HTTPS
                            </label>
                        </div>
                        <div class="form-group">
                            <label class="checkbox-label">
                                <input type="checkbox"> Enable IP Whitelist
                            </label>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Session Timeout (minutes)</label>
                            <input type="number" class="form-control" value="30" placeholder="30">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Max Login Attempts</label>
                            <input type="number" class="form-control" value="5" placeholder="5">
                        </div>
                        <button class="btn btn-primary">Update Security</button>
                    </div>
                </div>
            </div>
        </div>
    </main>
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/admin-dashboard.js"></script>
</body>
</html>
