<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.bittercode.model.User" %>
<%@ page import="com.bittercode.model.UserRole" %>
<%@ page import="com.bittercode.util.StoreUtil" %>
<%
    if (!StoreUtil.isLoggedIn(UserRole.CUSTOMER, session)) {
        response.sendRedirect("CustomerLogin.jsp");
        return;
    }
    User user = (User) session.getAttribute("user");
    String userName = user != null ? user.getFirstName() : "Customer";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bookoe - Online Book Store</title>
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
                <input type="text" class="search-box" placeholder="Search over 30 million book titles...">
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
        <!-- Hero Banner -->
        <div class="hero-banner">
            <div class="hero-content">
                <span class="hero-badge">📚 BACK TO SCHOOL</span>
                <h2 class="hero-title">Special 50% Off</h2>
                <p class="hero-subtitle">for our student community</p>
                <p class="hero-description">
                    Get exclusive discounts on all programming and technical books. 
                    Perfect for students looking to expand their knowledge and skills. 
                    Limited time offer - grab your favorite books today!
                </p>
                <div class="hero-buttons">
                    <button class="header-btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/viewbook'">
                        Get the deal <i class="fas fa-arrow-right"></i>
                    </button>
                    <button class="header-btn btn-outline">
                        See other promos
                    </button>
                </div>
            </div>
            <div class="hero-image">
                <img src="https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=600&h=400&fit=crop" 
                     alt="Student with books" 
                     onerror="this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22600%22 height=%22400%22%3E%3Crect fill=%22%23667eea%22 width=%22600%22 height=%22400%22/%3E%3Ctext fill=%22%23fff%22 font-family=%22Arial%22 font-size=%2224%22 x=%2250%25%22 y=%2250%25%22 text-anchor=%22middle%22%3EStudent Offer%3C/text%3E%3C/svg%3E'">
            </div>
        </div>

        <!-- Features Section -->
        <div class="features-section">
            <div class="feature-card">
                <div class="feature-icon purple">
                    <i class="fas fa-shipping-fast"></i>
                </div>
                <h3 class="feature-title">Quick Delivery</h3>
                <p class="feature-description">
                    Fast and reliable delivery to your doorstep. Get your books delivered within 3-5 business days.
                </p>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon pink">
                    <i class="fas fa-shield-alt"></i>
                </div>
                <h3 class="feature-title">Secure Payment</h3>
                <p class="feature-description">
                    Safe and encrypted payment processing. Multiple payment options available for your convenience.
                </p>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon orange">
                    <i class="fas fa-award"></i>
                </div>
                <h3 class="feature-title">Best Quality</h3>
                <p class="feature-description">
                    Authentic books from trusted publishers. 100% original content guaranteed.
                </p>
            </div>
        </div>

        <!-- Recommended Books Section -->
        <div class="section-header">
            <div>
                <h2 class="section-title">Recommended For You</h2>
                <p class="section-subtitle">Discover our handpicked collection of programming and technical books curated just for you</p>
            </div>
            <button class="view-all-btn" onclick="window.location.href='<%=request.getContextPath()%>/viewbook'">
                View More <i class="fas fa-arrow-right"></i>
            </button>
        </div>

        <!-- Category Tabs -->
        <div class="category-tabs">
            <button class="category-tab active">All Books</button>
            <button class="category-tab">Programming</button>
            <button class="category-tab">Web Development</button>
            <button class="category-tab">General</button>
        </div>

        <!-- Books Grid -->
        <div class="books-grid">
            <!-- Sample Book Cards -->
            <div class="book-card" onclick="window.location.href='<%=request.getContextPath()%>/viewbook'">
                <div class="book-image">
                    <div class="book-favorite">
                        <i class="far fa-heart"></i>
                    </div>
                    <span class="book-badge">NEW</span>
                    <img src="https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=300&h=400&fit=crop" 
                         alt="Book" 
                         onerror="this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22300%22 height=%22400%22%3E%3Crect fill=%22%23667eea%22 width=%22300%22 height=%22400%22/%3E%3Ctext fill=%22%23fff%22 font-family=%22Arial%22 font-size=%2220%22 x=%2250%25%22 y=%2250%25%22 text-anchor=%22middle%22%3EBook Cover%3C/text%3E%3C/svg%3E'">
                </div>
                <div class="book-info">
                    <div class="book-category">Programming</div>
                    <h3 class="book-title">The Go Programming Language</h3>
                    <p class="book-author">Alan A. A. Donovan</p>
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
                        <div class="book-price">₹400</div>
                        <button class="add-to-cart-btn">
                            <i class="fas fa-shopping-cart"></i> Add
                        </button>
                    </div>
                </div>
            </div>

            <!-- More sample cards -->
            <div class="book-card" onclick="window.location.href='<%=request.getContextPath()%>/viewbook'">
                <div class="book-image">
                    <div class="book-favorite">
                        <i class="far fa-heart"></i>
                    </div>
                    <img src="https://images.unsplash.com/photo-1543002588-bfa74002ed7e?w=300&h=400&fit=crop" 
                         alt="Book"
                         onerror="this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22300%22 height=%22400%22%3E%3Crect fill=%22%23764ba2%22 width=%22300%22 height=%22400%22/%3E%3Ctext fill=%22%23fff%22 font-family=%22Arial%22 font-size=%2220%22 x=%2250%25%22 y=%2250%25%22 text-anchor=%22middle%22%3EBook Cover%3C/text%3E%3C/svg%3E'">
                </div>
                <div class="book-info">
                    <div class="book-category">Programming</div>
                    <h3 class="book-title">Clean Code</h3>
                    <p class="book-author">Robert C Martin</p>
                    <div class="book-rating">
                        <div class="stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <span class="rating-count">(5.0)</span>
                    </div>
                    <div class="book-footer">
                        <div class="book-price">₹288</div>
                        <button class="add-to-cart-btn">
                            <i class="fas fa-shopping-cart"></i> Add
                        </button>
                    </div>
                </div>
            </div>

            <div class="book-card" onclick="window.location.href='<%=request.getContextPath()%>/viewbook'">
                <div class="book-image">
                    <div class="book-favorite">
                        <i class="far fa-heart"></i>
                    </div>
                    <span class="book-badge">50% OFF</span>
                    <img src="https://images.unsplash.com/photo-1532012197267-da84d127e765?w=300&h=400&fit=crop" 
                         alt="Book"
                         onerror="this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22300%22 height=%22400%22%3E%3Crect fill=%22%23ec4899%22 width=%22300%22 height=%22400%22/%3E%3Ctext fill=%22%23fff%22 font-family=%22Arial%22 font-size=%2220%22 x=%2250%25%22 y=%2250%25%22 text-anchor=%22middle%22%3EBook Cover%3C/text%3E%3C/svg%3E'">
                </div>
                <div class="book-info">
                    <div class="book-category">Web Development</div>
                    <h3 class="book-title">The Road to Learn React</h3>
                    <p class="book-author">Robin Wieruch</p>
                    <div class="book-rating">
                        <div class="stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="far fa-star"></i>
                        </div>
                        <span class="rating-count">(4.2)</span>
                    </div>
                    <div class="book-footer">
                        <div class="book-price">₹239</div>
                        <button class="add-to-cart-btn">
                            <i class="fas fa-shopping-cart"></i> Add
                        </button>
                    </div>
                </div>
            </div>

            <div class="book-card" onclick="window.location.href='<%=request.getContextPath()%>/viewbook'">
                <div class="book-image">
                    <div class="book-favorite">
                        <i class="far fa-heart"></i>
                    </div>
                    <img src="https://images.unsplash.com/photo-1512820790803-83ca734da794?w=300&h=400&fit=crop" 
                         alt="Book"
                         onerror="this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22300%22 height=%22400%22%3E%3Crect fill=%22%233b82f6%22 width=%22300%22 height=%22400%22/%3E%3Ctext fill=%22%23fff%22 font-family=%22Arial%22 font-size=%2220%22 x=%2250%25%22 y=%2250%25%22 text-anchor=%22middle%22%3EBook Cover%3C/text%3E%3C/svg%3E'">
                </div>
                <div class="book-info">
                    <div class="book-category">Programming</div>
                    <h3 class="book-title">Effective Java</h3>
                    <p class="book-author">Joshua Bloch</p>
                    <div class="book-rating">
                        <div class="stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star-half-alt"></i>
                        </div>
                        <span class="rating-count">(4.5)</span>
                    </div>
                    <div class="book-footer">
                        <div class="book-price">₹368</div>
                        <button class="add-to-cart-btn">
                            <i class="fas fa-shopping-cart"></i> Add
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Popular in 2020 Section -->
        <div class="section-header" style="margin-top: 4rem;">
            <div>
                <h2 class="section-title">Popular Books</h2>
                <p class="section-subtitle">Trending books loved by developers and tech enthusiasts worldwide</p>
            </div>
            <button class="view-all-btn" onclick="window.location.href='<%=request.getContextPath()%>/viewbook'">
                View More <i class="fas fa-arrow-right"></i>
            </button>
        </div>

        <div class="books-grid">
            <!-- Add more book cards here with same structure -->
            <div class="book-card" onclick="window.location.href='<%=request.getContextPath()%>/viewbook'">
                <div class="book-image">
                    <div class="book-favorite">
                        <i class="far fa-heart"></i>
                    </div>
                    <span class="book-badge">BESTSELLER</span>
                    <img src="https://images.unsplash.com/photo-1589998059171-988d887df646?w=300&h=400&fit=crop" 
                         alt="Book"
                         onerror="this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22300%22 height=%22400%22%3E%3Crect fill=%22%23fbbf24%22 width=%22300%22 height=%22400%22/%3E%3Ctext fill=%22%23fff%22 font-family=%22Arial%22 font-size=%2220%22 x=%2250%25%22 y=%2250%25%22 text-anchor=%22middle%22%3EBook Cover%3C/text%3E%3C/svg%3E'">
                </div>
                <div class="book-info">
                    <div class="book-category">Programming</div>
                    <h3 class="book-title">The Rust Programming Language</h3>
                    <p class="book-author">Steve Klabnik</p>
                    <div class="book-rating">
                        <div class="stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <span class="rating-count">(5.0)</span>
                    </div>
                    <div class="book-footer">
                        <div class="book-price">₹560</div>
                        <button class="add-to-cart-btn">
                            <i class="fas fa-shopping-cart"></i> Add
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Category tab switching
        document.querySelectorAll('.category-tab').forEach(tab => {
            tab.addEventListener('click', function() {
                document.querySelectorAll('.category-tab').forEach(t => t.classList.remove('active'));
                this.classList.add('active');
            });
        });

        // Favorite toggle
        document.querySelectorAll('.book-favorite').forEach(fav => {
            fav.addEventListener('click', function(e) {
                e.stopPropagation();
                const icon = this.querySelector('i');
                icon.classList.toggle('far');
                icon.classList.toggle('fas');
            });
        });
    </script>
</body>
</html>
