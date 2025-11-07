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
    <title>Payments - Admin Dashboard</title>
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
                    <h1>Payment Management</h1>
                    <p class="subtitle">Track and manage all transactions</p>
                </div>
            </div>
            
            <!-- Payment Stats -->
            <div class="stats-grid" style="margin-bottom: 30px;">
                <div class="stat-card" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
                    <div class="stat-header">
                        <h3>Total Revenue</h3>
                        <div class="stat-icon"><i class="fas fa-rupee-sign"></i></div>
                    </div>
                    <div class="stat-value">₹1,24,567</div>
                    <div class="stat-footer">This month</div>
                </div>
                
                <div class="stat-card" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); color: white;">
                    <div class="stat-header">
                        <h3>Completed</h3>
                        <div class="stat-icon"><i class="fas fa-check-circle"></i></div>
                    </div>
                    <div class="stat-value">342</div>
                    <div class="stat-footer">Successful payments</div>
                </div>
                
                <div class="stat-card" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); color: white;">
                    <div class="stat-header">
                        <h3>Pending</h3>
                        <div class="stat-icon"><i class="fas fa-clock"></i></div>
                    </div>
                    <div class="stat-value">12</div>
                    <div class="stat-footer">Awaiting confirmation</div>
                </div>
                
                <div class="stat-card" style="background: linear-gradient(135deg, #fa709a 0%, #fee140 100%); color: white;">
                    <div class="stat-header">
                        <h3>Failed</h3>
                        <div class="stat-icon"><i class="fas fa-times-circle"></i></div>
                    </div>
                    <div class="stat-value">5</div>
                    <div class="stat-footer">Failed transactions</div>
                </div>
            </div>
            
            <!-- Payments Table -->
            <div class="card">
                <div class="card-header">
                    <h3>Recent Transactions</h3>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Transaction ID</th>
                                    <th>Customer</th>
                                    <th>Amount</th>
                                    <th>Method</th>
                                    <th>Status</th>
                                    <th>Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>#TXN001234</td>
                                    <td>John Doe</td>
                                    <td>₹1,299</td>
                                    <td>Credit Card</td>
                                    <td><span class="badge badge-success">Completed</span></td>
                                    <td>2025-10-24</td>
                                </tr>
                                <tr>
                                    <td>#TXN001235</td>
                                    <td>Jane Smith</td>
                                    <td>₹899</td>
                                    <td>UPI</td>
                                    <td><span class="badge badge-warning">Pending</span></td>
                                    <td>2025-10-24</td>
                                </tr>
                                <tr>
                                    <td>#TXN001236</td>
                                    <td>Bob Wilson</td>
                                    <td>₹2,499</td>
                                    <td>Debit Card</td>
                                    <td><span class="badge badge-success">Completed</span></td>
                                    <td>2025-10-23</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </main>
</body>
</html>
