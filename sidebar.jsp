<%@ page import="com.bittercode.model.User" %>
<%
    User sidebarUser = null;
    String sidebarUserName = "Admin";
    try {
        sidebarUser = (User) session.getAttribute("user");
        if (sidebarUser != null) {
            sidebarUserName = sidebarUser.getFirstName() + " " + sidebarUser.getLastName();
        }
    } catch (Exception e) {
        // Use default values
    }
    String currentPage = request.getRequestURI();
%>
<aside class="sidebar">
    <div class="sidebar-header">
        <div class="logo" style="display:flex; align-items:center; gap:10px;">
            <div style="width:36px;height:36px;border-radius:12px;background:linear-gradient(135deg,#7c8cf8,#6d5cf6);display:flex;align-items:center;justify-content:center;color:white;">
                <i class="bi bi-journal-text"></i>
            </div>
            <div style="line-height:1;">
                <div style="color:#6366f1; font-weight:700;">Bookoe</div>
                <div style="color:#94a3b8; font-size:12px;">Online Book Store Website</div>
            </div>
        </div>
    </div>
    
    <div class="user-profile">
        <div class="avatar">
            <i class="fas fa-user"></i>
        </div>
        <div class="user-info">
            <h4><%= sidebarUserName %></h4>
            <p class="balance">$8,753.00</p>
        </div>
        <button class="add-btn">
            <i class="fas fa-plus"></i>
        </button>
    </div>
    
    <nav class="sidebar-nav">
        <a href="<%=request.getContextPath()%>/admin-dashboard" class="nav-item <%= currentPage.contains("admin-dashboard") || currentPage.contains("AdminDashboard") ? "active" : "" %>">
            <i class="fas fa-chart-line"></i>
            <span>Dashboard</span>
        </a>
        <a href="<%=request.getContextPath()%>/admin/manage-books.jsp" class="nav-item <%= currentPage.contains("manage-books") ? "active" : "" %>">
            <i class="fas fa-book"></i>
            <span>Books</span>
        </a>
        <a href="<%=request.getContextPath()%>/admin/orders.jsp" class="nav-item <%= currentPage.contains("orders") ? "active" : "" %>">
            <i class="fas fa-shopping-cart"></i>
            <span>Orders</span>
        </a>
        <a href="<%=request.getContextPath()%>/admin/users.jsp" class="nav-item <%= currentPage.contains("users") ? "active" : "" %>">
            <i class="fas fa-users"></i>
            <span>Users</span>
        </a>
        <a href="<%=request.getContextPath()%>/admin/payments.jsp" class="nav-item <%= currentPage.contains("payments") ? "active" : "" %>">
            <i class="fas fa-credit-card"></i>
            <span>Payments</span>
        </a>
    </nav>
    
    <div class="sidebar-footer">
        <a href="<%=request.getContextPath()%>/logout" class="nav-item">
            <i class="fas fa-sign-out-alt"></i>
            <span>Sign Out</span>
        </a>
    </div>
</aside>
