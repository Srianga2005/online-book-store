<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Users Management - Test Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 1400px;
            margin: 0 auto;
        }
        
        .header {
            background: white;
            padding: 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        
        .header h1 {
            color: #333;
            margin-bottom: 10px;
        }
        
        .header p {
            color: #666;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            color: white;
        }
        
        .stat-card h3 {
            font-size: 0.9rem;
            margin-bottom: 10px;
            opacity: 0.9;
        }
        
        .stat-value {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 5px;
        }
        
        .stat-footer {
            font-size: 0.85rem;
            opacity: 0.8;
        }
        
        .card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            overflow: hidden;
        }
        
        .card-header {
            padding: 25px 30px;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .card-header h3 {
            color: #333;
            font-size: 1.3rem;
        }
        
        .search-box {
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            width: 300px;
            font-size: 0.95rem;
        }
        
        .table-responsive {
            overflow-x: auto;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        thead {
            background: #f8f9fa;
        }
        
        th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: #333;
            border-bottom: 2px solid #dee2e6;
        }
        
        td {
            padding: 15px;
            border-bottom: 1px solid #eee;
            color: #555;
        }
        
        tbody tr:hover {
            background: #f8f9fa;
        }
        
        .badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
        }
        
        .badge-success {
            background: #d4edda;
            color: #155724;
        }
        
        .badge-danger {
            background: #f8d7da;
            color: #721c24;
        }
        
        .badge-warning {
            background: #fff3cd;
            color: #856404;
        }
        
        .badge-info {
            background: #d1ecf1;
            color: #0c5460;
        }
        
        .btn-icon {
            background: none;
            border: none;
            padding: 8px;
            cursor: pointer;
            color: #667eea;
            font-size: 1rem;
            transition: all 0.3s;
        }
        
        .btn-icon:hover {
            color: #764ba2;
            transform: scale(1.2);
        }
        
        .btn-danger {
            color: #dc3545;
        }
        
        .btn-danger:hover {
            color: #c82333;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-users"></i> Users Management</h1>
            <p>Manage customer accounts and permissions</p>
        </div>
        
        <!-- Stats -->
        <div class="stats-grid">
            <div class="stat-card" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                <h3>Total Users</h3>
                <div class="stat-value">3</div>
                <div class="stat-footer">Registered users</div>
            </div>
            
            <div class="stat-card" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);">
                <h3>Active Users</h3>
                <div class="stat-value">3</div>
                <div class="stat-footer">Not blocked</div>
            </div>
            
            <div class="stat-card" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);">
                <h3>Blocked Users</h3>
                <div class="stat-value">0</div>
                <div class="stat-footer">Blocked accounts</div>
            </div>
            
            <div class="stat-card" style="background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);">
                <h3>Admin Users</h3>
                <div class="stat-value">1</div>
                <div class="stat-footer">Administrator accounts</div>
            </div>
        </div>
        
        <!-- Users Table -->
        <div class="card">
            <div class="card-header">
                <h3>All Users</h3>
                <input type="text" id="searchUsers" placeholder="Search users..." class="search-box">
            </div>
            <div class="table-responsive">
                <table>
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
                    </tbody>
                </table>
            </div>
        </div>
        
        <div style="margin-top: 30px; text-align: center;">
            <a href="../" style="display: inline-block; padding: 12px 30px; background: white; color: #667eea; text-decoration: none; border-radius: 8px; font-weight: 600; box-shadow: 0 5px 15px rgba(0,0,0,0.2);">
                <i class="fas fa-home"></i> Back to Home
            </a>
            <a href="reports.jsp" style="display: inline-block; padding: 12px 30px; background: white; color: #667eea; text-decoration: none; border-radius: 8px; font-weight: 600; box-shadow: 0 5px 15px rgba(0,0,0,0.2); margin-left: 15px;">
                <i class="fas fa-chart-line"></i> View Reports
            </a>
        </div>
    </div>
    
    <script>
        document.getElementById('searchUsers').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const rows = document.querySelectorAll('tbody tr');
            
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(searchTerm) ? '' : 'none';
            });
        });
    </script>
</body>
</html>
