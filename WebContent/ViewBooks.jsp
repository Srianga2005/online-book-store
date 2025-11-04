<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.bittercode.model.User" %>
<%@ page import="com.bittercode.model.UserRole" %>
<%@ page import="com.bittercode.model.Book" %>
<%@ page import="com.bittercode.util.StoreUtil" %>
<%@ page import="java.util.List" %>
<%
    if (!StoreUtil.isLoggedIn(UserRole.CUSTOMER, session)) {
        response.sendRedirect("CustomerLogin.jsp");
        return;
    }
    User user = (User) session.getAttribute("user");
    String userName = user != null ? user.getFirstName() : "Customer";
    
    List<Book> books = (List<Book>) request.getAttribute("books");
    if (books == null) books = new java.util.ArrayList<>();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Books - Bookoe</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/customer-modern.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <!-- Modern Header -->
    <header class="modern-header">
        <div class="header-container">
            <div class="logo-section">
                <div class="logo-icon">
                    <i class="fas fa-book"></i>
                </div>
                <div class="logo-text">
                    <h1>Bookoe</h1>
                    <p>Online Book Store Website</p>
                </div>
            </div>
            
            <div class="header-search">
                <input type="text" class="search-box" id="searchBox" placeholder="Search over 30 million book titles...">
            </div>
            
            <div class="header-actions">
                <a href="<%=request.getContextPath()%>/cart" class="header-btn btn-outline">
                    <i class="fas fa-shopping-cart"></i> Cart
                </a>
                <a href="<%=request.getContextPath()%>/logout" class="header-btn btn-primary">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>
    </header>

    <!-- Main Container -->
    <div class="main-container">
        <!-- Section Header -->
        <div class="section-header">
            <div>
                <h2 class="section-title">Available Books</h2>
                <p class="section-subtitle">Browse our collection of <%= books.size() %> amazing books</p>
            </div>
            <a href="<%=request.getContextPath()%>/cart" class="view-all-btn">
                <i class="fas fa-shopping-cart"></i> View Cart
            </a>
        </div>

        <!-- Category Tabs -->
        <div class="category-tabs">
            <button class="category-tab active" data-category="all">All Books</button>
            <button class="category-tab" data-category="Programming">Programming</button>
            <button class="category-tab" data-category="Web Development">Web Development</button>
            <button class="category-tab" data-category="General">General</button>
        </div>

        <!-- Books Grid -->
        <div class="books-grid" id="booksGrid">
            <% 
            for (Book book : books) {
                String bCode = book.getBarcode();
                int bQty = book.getQuantity();
                int cartItemQty = 0;
                if (session.getAttribute("qty_" + bCode) != null) {
                    cartItemQty = (int) session.getAttribute("qty_" + bCode);
                }
                String category = book.getCategory() != null ? book.getCategory() : "General";
            %>
                <div class="book-card" data-category="<%= category %>">
                    <div class="book-image">
                        <div class="book-favorite">
                            <i class="far fa-heart"></i>
                        </div>
                        <% if (bQty < 10 && bQty > 0) { %>
                            <span class="book-badge">Only <%= bQty %> left</span>
                        <% } else if (bQty == 0) { %>
                            <span class="book-badge" style="background: #ef4444;">Out of Stock</span>
                        <% } else { %>
                            <span class="book-badge" style="background: #10b981;">In Stock</span>
                        <% } %>
                        <div style="width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; background: linear-gradient(135deg, #667eea, #764ba2);">
                            <i class="fas fa-book" style="font-size: 48px; color: white;"></i>
                        </div>
                    </div>
                    <div class="book-info">
                        <div class="book-category"><%= category %></div>
                        <h3 class="book-title"><%= book.getName() %></h3>
                        <p class="book-author">by <%= book.getAuthor() %></p>
                        <div class="book-rating">
                            <div class="stars">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="far fa-star"></i>
                            </div>
                            <span class="rating-count">(4.0)</span>
                        </div>
                        <div class="book-footer">
                            <div class="book-price">₹<%= book.getPrice() %></div>
                            <% if (bQty > 0) { %>
                                <% if (cartItemQty == 0) { %>
                                    <form method="post" action="viewbook" style="display: inline;">
                                        <input type="hidden" name="selectedBookId" value="<%= bCode %>"/>
                                        <input type="hidden" name="qty_<%= bCode %>" value="1"/>
                                        <button type="submit" name="addToCart" class="add-to-cart-btn">
                                            <i class="fas fa-shopping-cart"></i> Add
                                        </button>
                                    </form>
                                <% } else { %>
                                    <form method="post" action="cart" style="display: inline-flex; align-items: center; gap: 8px;">
                                        <input type="hidden" name="selectedBookId" value="<%= bCode %>"/>
                                        <button type="submit" name="removeFromCart" class="qty-btn" style="width: 28px; height: 28px; font-size: 12px;">
                                            <i class="fas fa-minus"></i>
                                        </button>
                                        <span style="font-weight: 600; min-width: 20px; text-align: center;"><%= cartItemQty %></span>
                                        <button type="submit" name="addToCart" class="qty-btn" style="width: 28px; height: 28px; font-size: 12px;">
                                            <i class="fas fa-plus"></i>
                                        </button>
                                    </form>
                                <% } %>
                            <% } else { %>
                                <button class="add-to-cart-btn" disabled style="background: #ef4444; cursor: not-allowed;">
                                    Out of Stock
                                </button>
                            <% } %>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>

        <% if (books.isEmpty()) { %>
            <div style="text-align: center; padding: 4rem; background: white; border-radius: 16px; margin-top: 2rem;">
                <i class="fas fa-book" style="font-size: 64px; color: var(--text-light); margin-bottom: 1rem;"></i>
                <h3 style="color: var(--text-dark); margin-bottom: 0.5rem;">No Books Available</h3>
                <p style="color: var(--text-light);">Check back later for new arrivals!</p>
            </div>
        <% } %>
    </div>

    <script>
        // Category filtering
        const categoryTabs = document.querySelectorAll('.category-tab');
        const bookCards = document.querySelectorAll('.book-card');

        categoryTabs.forEach(tab => {
            tab.addEventListener('click', function() {
                // Update active tab
                categoryTabs.forEach(t => t.classList.remove('active'));
                this.classList.add('active');

                const selectedCategory = this.getAttribute('data-category');

                // Filter books
                bookCards.forEach(card => {
                    const cardCategory = card.getAttribute('data-category');
                    if (selectedCategory === 'all' || cardCategory === selectedCategory) {
                        card.style.display = 'block';
                    } else {
                        card.style.display = 'none';
                    }
                });
            });
        });

        // Search functionality
        const searchBox = document.getElementById('searchBox');
        searchBox.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            
            bookCards.forEach(card => {
                const title = card.querySelector('.book-title').textContent.toLowerCase();
                const author = card.querySelector('.book-author').textContent.toLowerCase();
                
                if (title.includes(searchTerm) || author.includes(searchTerm)) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        });

        // Favorite toggle
        document.querySelectorAll('.book-favorite').forEach(fav => {
            fav.addEventListener('click', function(e) {
                e.preventDefault();
                const icon = this.querySelector('i');
                icon.classList.toggle('far');
                icon.classList.toggle('fas');
            });
        });
    </script>
</body>
</html>
