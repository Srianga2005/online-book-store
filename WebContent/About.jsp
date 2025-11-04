<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Bookoe</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            padding: 15px 0;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .navbar-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 700;
            color: #7c3aed;
            text-decoration: none;
        }
        
        .navbar-menu {
            display: flex;
            gap: 30px;
            list-style: none;
        }
        
        .navbar-menu a {
            color: #333;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s;
        }
        
        .navbar-menu a:hover {
            color: #7c3aed;
        }
        
        .footer {
            background: rgba(0, 0, 0, 0.3);
            color: white;
            text-align: center;
            padding: 20px;
            margin-top: 80px;
        }
        .about-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 80px 20px;
        }
        
        .about-header {
            text-align: center;
            margin-bottom: 60px;
        }
        
        .about-title {
            font-size: 2.5rem;
            color: #ff9966;
            margin-bottom: 10px;
            font-weight: 300;
        }
        
        .about-content {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 60px;
            align-items: center;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 60px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
        }
        
        .about-image {
            position: relative;
        }
        
        .about-image img {
            width: 100%;
            height: auto;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
        }
        
        .about-text h2 {
            font-size: 2.5rem;
            color: #333;
            margin-bottom: 30px;
            line-height: 1.2;
        }
        
        .about-text h2 .highlight {
            color: #ff9966;
        }
        
        .about-text p {
            font-size: 1.1rem;
            line-height: 1.8;
            color: #666;
            text-align: justify;
            margin-bottom: 20px;
        }
        
        .skills-section {
            margin-top: 80px;
            text-align: center;
        }
        
        .skills-title {
            font-size: 2rem;
            color: #333;
            margin-bottom: 40px;
        }
        
        .skills-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
            margin-top: 40px;
        }
        
        .skill-card {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            transition: all 0.3s;
        }
        
        .skill-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
        }
        
        .skill-icon {
            font-size: 3rem;
            color: #7c3aed;
            margin-bottom: 20px;
        }
        
        .skill-card h3 {
            font-size: 1.3rem;
            color: #333;
            margin-bottom: 15px;
        }
        
        .skill-card p {
            color: #666;
            line-height: 1.6;
        }
        
        @media (max-width: 968px) {
            .about-content {
                grid-template-columns: 1fr;
                padding: 40px 30px;
                gap: 40px;
            }
            
            .about-text h2 {
                font-size: 2rem;
            }
            
            .about-title {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="navbar-container">
            <a href="/onlinebookstore/" class="navbar-brand">
                <i class="fas fa-book-open"></i> Bookoe
            </a>
            <ul class="navbar-menu">
                <li><a href="/onlinebookstore/"><i class="fas fa-home"></i> Home</a></li>
                <li><a href="/onlinebookstore/viewbook"><i class="fas fa-book"></i> Books</a></li>
                <li><a href="/onlinebookstore/cart"><i class="fas fa-shopping-cart"></i> Cart</a></li>
                <li><a href="/onlinebookstore/about" class="active"><i class="fas fa-info-circle"></i> About</a></li>
                <li><a href="/onlinebookstore/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </div>
    </nav>
    
    <div class="about-container">
        <div class="about-header">
            <h1 class="about-title">Srianga Kinkar Nayak</h1>
        </div>
        
        <div class="about-content">
            <div class="about-image">
                <img src="<%=request.getContextPath()%>/images/profile.jpg" alt="Srianga Kinkar Nayak" onerror="this.src='https://via.placeholder.com/500x600/667eea/ffffff?text=Srianga+Kinkar+Nayak'">
            </div>
            
            <div class="about-text">
                <h2>Srianga Kinkar Nayak</h2>
                <p style="font-size: 1.2rem; color: #7c3aed; font-weight: 500; margin-bottom: 25px;">
                    He/Him
                </p>
                <p style="font-size: 1.15rem; line-height: 1.9;">
                    <strong style="color: #ff9966;">💻 Web Developer</strong> | 
                    <strong style="color: #667eea;">☁️⚙️ Cloud & DevOps Explorer</strong> | 
                    <strong style="color: #764ba2;">🎓 CSE Student</strong>
                </p>
                <p style="font-size: 1.15rem; line-height: 1.9;">
                    <strong style="color: #ff9966;">🧑‍🏫 Class Representative</strong> | 
                    <strong style="color: #667eea;">🧩 Problem Solver</strong>
                </p>
            </div>
        </div>
        
        <div class="skills-section">
            <h2 class="skills-title">What We Offer</h2>
            
            <div class="skills-grid">
                <div class="skill-card">
                    <div class="skill-icon">
                        <i class="fas fa-book-open"></i>
                    </div>
                    <h3>Vast Collection</h3>
                    <p>Access to thousands of books across multiple genres and categories for all reading preferences.</p>
                </div>
                
                <div class="skill-card">
                    <div class="skill-icon">
                        <i class="fas fa-shipping-fast"></i>
                    </div>
                    <h3>Fast Delivery</h3>
                    <p>Quick and reliable shipping to get your favorite books delivered right to your doorstep.</p>
                </div>
                
                <div class="skill-card">
                    <div class="skill-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <h3>Secure Payment</h3>
                    <p>Safe and encrypted payment processing to ensure your transactions are always protected.</p>
                </div>
                
                <div class="skill-card">
                    <div class="skill-icon">
                        <i class="fas fa-headset"></i>
                    </div>
                    <h3>24/7 Support</h3>
                    <p>Round-the-clock customer support to assist you with any queries or concerns you may have.</p>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2025 Bookoe - Online Bookstore. All rights reserved.</p>
    </footer>
</body>
</html>
