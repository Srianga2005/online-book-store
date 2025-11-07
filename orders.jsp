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
    <title>Orders - Admin Dashboard</title>
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
                    <h1>Orders Management</h1>
                    <p class="subtitle">View and manage customer orders</p>
                </div>
                <div class="header-actions">
                    <button class="btn btn-outline">
                        <i class="fas fa-filter"></i> Filter
                    </button>
                    <button class="btn btn-primary">
                        <i class="fas fa-download"></i> Export
                    </button>
                </div>
            </div>
            
            <!-- Order Stats -->
            <div class="stats-grid" style="margin-bottom: 30px;">
                <div class="stat-card" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
                    <div class="stat-header">
                        <h3>Total Orders</h3>
                        <div class="stat-icon">
                            <i class="fas fa-shopping-bag"></i>
                        </div>
                    </div>
                    <div class="stat-value">1,234</div>
                    <div class="stat-footer">+12% from last month</div>
                </div>
                
                <div class="stat-card" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); color: white;">
                    <div class="stat-header">
                        <h3>Pending Orders</h3>
                        <div class="stat-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                    </div>
                    <div class="stat-value">45</div>
                    <div class="stat-footer">Need attention</div>
                </div>
                
                <div class="stat-card" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); color: white;">
                    <div class="stat-header">
                        <h3>Completed</h3>
                        <div class="stat-icon">
                            <i class="fas fa-check-circle"></i>
                        </div>
                    </div>
                    <div class="stat-value">1,189</div>
                    <div class="stat-footer">Successfully delivered</div>
                </div>
                
                <div class="stat-card" style="background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%); color: white;">
                    <div class="stat-header">
                        <h3>Revenue</h3>
                        <div class="stat-icon">
                            <i class="fas fa-dollar-sign"></i>
                        </div>
                    </div>
                    <div class="stat-value">$45,890</div>
                    <div class="stat-footer">This month</div>
                </div>
            </div>
            
            <!-- Orders Table -->
            <div class="card">
                <div class="card-header">
                    <h3>Recent Orders</h3>
                    <div class="card-actions">
                        <input type="text" id="searchOrders" placeholder="Search orders..." class="form-control">
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Customer</th>
                                    <th>Date</th>
                                    <th>Items</th>
                                    <th>Total</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>#ORD-001</td>
                                    <td>John Doe</td>
                                    <td>2024-10-18</td>
                                    <td>3</td>
                                    <td>$156.00</td>
                                    <td><span class="badge badge-warning">Pending</span></td>
                                    <td>
                                        <button class="btn-icon" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <button class="btn-icon" title="Process">
                                            <i class="fas fa-check"></i>
                                        </button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>#ORD-002</td>
                                    <td>Jane Smith</td>
                                    <td>2024-10-18</td>
                                    <td>2</td>
                                    <td>$89.50</td>
                                    <td><span class="badge badge-info">Processing</span></td>
                                    <td>
                                        <button class="btn-icon" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <button class="btn-icon" title="Process">
                                            <i class="fas fa-check"></i>
                                        </button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>#ORD-003</td>
                                    <td>Mike Johnson</td>
                                    <td>2024-10-17</td>
                                    <td>5</td>
                                    <td>$234.75</td>
                                    <td><span class="badge badge-success">Completed</span></td>
                                    <td>
                                        <button class="btn-icon" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <button class="btn-icon" title="Invoice">
                                            <i class="fas fa-file-invoice"></i>
                                        </button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </main>
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/admin-dashboard.js"></script>
    <script>
        document.getElementById('searchOrders').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const rows = document.querySelectorAll('.data-table tbody tr');
            
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(searchTerm) ? '' : 'none';
            });
        });
    </script>
</body>
</html>
