<%@ page import="com.bittercode.model.User" %>
<%
    User topbarUser = null;
    String topbarUserName = "Admin";
    try {
        topbarUser = (User) session.getAttribute("user");
        if (topbarUser != null) {
            topbarUserName = topbarUser.getFirstName() + " " + topbarUser.getLastName();
        }
    } catch (Exception e) {
        // Use default values
    }
%>
<header class="topbar">
    <div class="topbar-left">
        <button class="menu-toggle">
            <i class="fas fa-bars"></i>
        </button>
        <div class="search-box">
            <i class="fas fa-search"></i>
            <input type="text" placeholder="Search books, orders, users...">
        </div>
    </div>
    
    <div class="topbar-right">
        <button class="icon-btn">
            <i class="fas fa-bell"></i>
            <span class="badge">3</span>
        </button>
        <button class="icon-btn">
            <i class="fas fa-envelope"></i>
            <span class="badge">5</span>
        </button>
        <button class="icon-btn">
            <i class="fas fa-shopping-cart"></i>
        </button>
        <div class="user-menu">
            <button class="user-menu-btn">
                <span>English</span>
                <i class="fas fa-chevron-down"></i>
            </button>
        </div>
        <div class="user-menu">
            <button class="user-menu-btn">
                <div class="avatar-small">
                    <i class="fas fa-user"></i>
                </div>
                <span><%= topbarUserName %></span>
                <i class="fas fa-chevron-down"></i>
            </button>
        </div>
    </div>
</header>

<div class="promo-banner">
    <div class="promo-content">
        <p>Like what you see? Check out our premium version for more.</p>
    </div>
    <div class="promo-actions">
        <button class="btn btn-outline">Download Free Version</button>
        <button class="btn btn-warning">Upgrade To Pro</button>
        <button class="btn-close"><i class="fas fa-times"></i></button>
    </div>
</div>
