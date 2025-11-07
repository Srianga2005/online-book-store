<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.bittercode.model.User" %>
<%@ page import="com.bittercode.model.UserRole" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%
    // Initialize variables
    String userName = "Admin";
    List<User> allUsers = new ArrayList<User>();
    int totalUsers = 3;
    int activeUsers = 3;
    int blockedUsers = 0;
    int adminUsers = 1;
    String errorMessage = null;
    boolean dbConnected = false;
    
    try {
        // Check if user is logged in
        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser != null) {
            userName = sessionUser.getFirstName() + " " + sessionUser.getLastName();
        }
        
        // Try to get users from database
        try {
            Class.forName("com.bittercode.service.UserService");
            com.bittercode.service.UserService userService = new com.bittercode.service.impl.UserServiceImpl();
            allUsers = userService.getAllUsers();
            
            if (allUsers != null && !allUsers.isEmpty()) {
                dbConnected = true;
                totalUsers = allUsers.size();
                activeUsers = 0;
                blockedUsers = 0;
                adminUsers = 0;
                
                for (User u : allUsers) {
                    if (u.isBlocked()) {
                        blockedUsers++;
                    } else {
                        activeUsers++;
                    }
                    if (u.getUserType() == UserRole.SELLER.getValue()) {
                        adminUsers++;
                    }
                }
            }
        } catch (Exception dbEx) {
            errorMessage = "Database connection failed: " + dbEx.getMessage();
            // Use sample data
            dbConnected = false;
        }
    } catch (Exception e) {
        errorMessage = "Error: " + e.getMessage();
        e.printStackTrace();
    }
%>
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
    <%@ include file="sidebar.jsp" %>
    
    <main class="main-content">
        <%@ include file="topbar.jsp" %>
        
        <div class="content-wrapper">
            <div class="content-header">
                <div>
                    <h1>Users Management</h1>
                    <p class="subtitle">Manage customer accounts and permissions</p>
                </div>
                <div class="header-actions">
                    <button class="btn btn-outline">
                        <i class="fas fa-filter"></i> Filter
                    </button>
                    <button class="btn btn-primary">
                        <i class="fas fa-user-plus"></i> Add User
                    </button>
                </div>
            </div>
            
            <!-- Error Message (if any) -->
            <% if (errorMessage != null) { %>
            <div style="background: #fee; border-left: 4px solid #f00; padding: 15px; margin-bottom: 20px; border-radius: 4px;">
                <strong>⚠️ Database Connection Error:</strong> <%= errorMessage %>
                <p style="margin-top: 10px; font-size: 0.9rem;">Please ensure MySQL is running and the database is properly configured.</p>
            </div>
            <% } %>
            
            <!-- User Stats -->
            <div class="stats-grid" style="margin-bottom: 30px;">
                <div class="stat-card" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
                    <div class="stat-header">
                        <h3>Total Users</h3>
                        <div class="stat-icon">
                            <i class="fas fa-users"></i>
                        </div>
                    </div>
                    <div class="stat-value"><%= totalUsers %></div>
                    <div class="stat-footer">Total registered users</div>
                </div>
                
                <div class="stat-card" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); color: white;">
                    <div class="stat-header">
                        <h3>Active Users</h3>
                        <div class="stat-icon">
                            <i class="fas fa-user-check"></i>
                        </div>
                    </div>
                    <div class="stat-value"><%= activeUsers %></div>
                    <div class="stat-footer">Not blocked</div>
                </div>
                
                <div class="stat-card" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); color: white;">
                    <div class="stat-header">
                        <h3>New Users</h3>
                        <div class="stat-icon">
                            <i class="fas fa-user-plus"></i>
                        </div>
                    </div>
                    <div class="stat-value"><%= blockedUsers %></div>
                    <div class="stat-footer">Blocked users</div>
                </div>
                
                <div class="stat-card" style="background: linear-gradient(135deg, #fa709a 0%, #fee140 100%); color: white;">
                    <div class="stat-header">
                        <h3>Admin Users</h3>
                        <div class="stat-icon">
                            <i class="fas fa-user-shield"></i>
                        </div>
                    </div>
                    <div class="stat-value"><%= adminUsers %></div>
                    <div class="stat-footer">Administrator accounts</div>
                </div>
            </div>
            
            <!-- Users Table -->
            <div class="card">
                <div class="card-header">
                    <h3>All Users</h3>
                    <div class="card-actions">
                        <input type="text" id="searchUsers" placeholder="Search users..." class="form-control">
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Username</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Type</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (dbConnected && allUsers != null && !allUsers.isEmpty()) {
                                    for (User u : allUsers) { %>
                                <tr>
                                    <td><%= u.getUsername() %></td>
                                    <td><%= u.getFirstName() + " " + u.getLastName() %></td>
                                    <td><%= u.getMailId() %></td>
                                    <td><%= u.getPhone() %></td>
                                    <td><span class="badge <%= u.getUserType() == UserRole.SELLER.getValue() ? "badge-warning" : "badge-info" %>">
                                        <%= u.getUserType() == UserRole.SELLER.getValue() ? "Admin" : "Customer" %>
                                    </span></td>
                                    <td><span class="badge <%= u.isBlocked() ? "badge-danger" : "badge-success" %>">
                                        <%= u.isBlocked() ? "Blocked" : "Active" %>
                                    </span></td>
                                    <td>
                                        <button class="btn-icon" title="View"><i class="fas fa-eye"></i></button>
                                        <button class="btn-icon" title="Edit"><i class="fas fa-edit"></i></button>
                                        <% if (u.getUserType() != UserRole.SELLER.getValue()) { %>
                                        <button class="btn-icon btn-danger" title="<%= u.isBlocked() ? "Unblock" : "Block" %>">
                                            <i class="fas fa-<%= u.isBlocked() ? "check" : "ban" %>"></i>
                                        </button>
                                        <% } %>
                                    </td>
                                </tr>
                                <% }
                                } else { %>
                                <!-- Sample Data when DB not connected -->
                                <tr>
                                    <td>Admin</td>
                                    <td>Mr. Admin</td>
                                    <td>admin@gmail.com</td>
                                    <td>9584552224521</td>
                                    <td><span class="badge badge-warning">Admin</span></td>
                                    <td><span class="badge badge-success">Active</span></td>
                                    <td>
                                        <button class="btn-icon" title="View"><i class="fas fa-eye"></i></button>
                                        <button class="btn-icon" title="Edit"><i class="fas fa-edit"></i></button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>shashi</td>
                                    <td>Shashi Raj</td>
                                    <td>shashi@gmail.com</td>
                                    <td>1236547089</td>
                                    <td><span class="badge badge-info">Customer</span></td>
                                    <td><span class="badge badge-success">Active</span></td>
                                    <td>
                                        <button class="btn-icon" title="View"><i class="fas fa-eye"></i></button>
                                        <button class="btn-icon" title="Edit"><i class="fas fa-edit"></i></button>
                                        <button class="btn-icon btn-danger" title="Block"><i class="fas fa-ban"></i></button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>demo</td>
                                    <td>Demo User</td>
                                    <td>demo@gmail.com</td>
                                    <td>42502216225</td>
                                    <td><span class="badge badge-info">Customer</span></td>
                                    <td><span class="badge badge-success">Active</span></td>
                                    <td>
                                        <button class="btn-icon" title="View"><i class="fas fa-eye"></i></button>
                                        <button class="btn-icon" title="Edit"><i class="fas fa-edit"></i></button>
                                        <button class="btn-icon btn-danger" title="Block"><i class="fas fa-ban"></i></button>
                                    </td>
                                </tr>
                                <% } %>
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
        document.getElementById('searchUsers').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const rows = document.querySelectorAll('.data-table tbody tr');
            
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(searchTerm) ? '' : 'none';
            });
        });
        
        function viewUser(username) {
            alert('View user details for: ' + username + '\n\nThis feature will show detailed user information.');
        }
        
        function editUser(username) {
            window.location.href = '<%=request.getContextPath()%>/manageusers?action=edit&username=' + username;
        }
        
        function toggleBlockUser(username, isBlocked) {
            const action = isBlocked ? 'unblock' : 'block';
            if (confirm('Are you sure you want to ' + action + ' user: ' + username + '?')) {
                window.location.href = '<%=request.getContextPath()%>/manageusers?action=' + action + '&username=' + username;
            }
        }
    </script>
</body>
</html>
