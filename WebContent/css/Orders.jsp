<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.bittercode.model.Cart" %>
<%@ page import="com.bittercode.model.Book" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bittercode.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    String userName = user != null ? user.getFirstName() : "Customer";
    
    @SuppressWarnings("unchecked")
    List<Cart> orders = (List<Cart>) request.getAttribute("orders");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Orders - Bookoe</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/customer-modern.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Payment toast */
        .toast-success {
            position: fixed;
            right: 20px;
            bottom: 20px;
            background: #10b981;
            color: #fff;
            padding: 14px 18px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(16,185,129,.35);
            display: none;
            z-index: 9999;
            font-weight: 600;
        }
        .toast-success.show { display: block; animation: fadeInOut 4s ease-in-out forwards; }
        @keyframes fadeInOut { 0%{opacity:0; transform: translateY(10px);} 10%{opacity:1; transform: translateY(0);} 80%{opacity:1;} 100%{opacity:0; transform: translateY(10px);} }
        
        /* Payment modal */
        .modal-backdrop { position: fixed; inset: 0; background: rgba(0,0,0,.5); display: none; align-items: center; justify-content: center; z-index: 10000; }
        .modal-backdrop.show { display: flex; }
        .modal-card { background: #fff; border-radius: 16px; padding: 24px; max-width: 420px; width: 92%; box-shadow: 0 20px 60px rgba(0,0,0,.25); text-align: center; }
        .modal-card .icon { font-size: 48px; color: #10b981; margin-bottom: 10px; }
        .modal-card h3 { margin: 6px 0 8px; color: #111827; }
        .modal-card p { color: #4b5563; margin-bottom: 16px; }
        .modal-card .btn { display: inline-block; background: #10b981; color: #fff; padding: 10px 18px; border-radius: 10px; text-decoration: none; font-weight: 600; border: 0; cursor: pointer; }
        
        .orders-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
        }
        
        .orders-header {
            text-align: center;
            margin-bottom: 50px;
        }
        
        .success-alert {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
            padding: 30px;
            border-radius: 20px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(16, 185, 129, 0.3);
            animation: slideDown 0.5s ease-out;
        }
        
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .success-alert h2 {
            font-size: 2rem;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .success-alert p {
            font-size: 1.1rem;
            opacity: 0.95;
        }
        
        .orders-header h1 {
            font-size: 2.5rem;
            color: #fff;
            margin-bottom: 10px;
        }
        
        .orders-header p {
            color: rgba(255, 255, 255, 0.8);
            font-size: 1.1rem;
        }
        
        .order-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 25px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        
        .order-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
        }
        
        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
            margin-bottom: 20px;
        }
        
        .order-id {
            font-size: 1.1rem;
            font-weight: 600;
            color: #7c3aed;
        }
        
        .order-status {
            display: inline-block;
            padding: 8px 20px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
        }
        
        .status-placed {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .status-pending {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
        }
        
        .order-body {
            display: grid;
            grid-template-columns: 120px 1fr auto;
            gap: 25px;
            align-items: center;
        }
        
        .order-image {
            width: 120px;
            height: 160px;
            border-radius: 12px;
            object-fit: cover;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .order-details h3 {
            font-size: 1.3rem;
            color: #333;
            margin-bottom: 10px;
        }
        
        .order-details p {
            color: #666;
            margin: 5px 0;
        }
        
        .author {
            color: #7c3aed;
            font-weight: 600;
        }
        
        .order-price {
            text-align: right;
        }
        
        .price-label {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 5px;
        }
        
        .price-value {
            font-size: 1.8rem;
            font-weight: 700;
            color: #10b981;
        }
        
        .empty-orders {
            text-align: center;
            padding: 80px 20px;
        }
        
        .empty-orders i {
            font-size: 5rem;
            color: rgba(255, 255, 255, 0.3);
            margin-bottom: 20px;
        }
        
        .empty-orders h2 {
            color: #fff;
            font-size: 2rem;
            margin-bottom: 10px;
        }
        
        .empty-orders p {
            color: rgba(255, 255, 255, 0.7);
            margin-bottom: 30px;
        }
        
        .btn-shop {
            display: inline-block;
            padding: 15px 40px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 30px;
            font-weight: 600;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        
        .btn-shop:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }
        
        @media (max-width: 768px) {
            .order-body {
                grid-template-columns: 1fr;
                text-align: center;
            }
            
            .order-image {
                margin: 0 auto;
            }
            
            .order-price {
                text-align: center;
            }
        }
    </style>
</head>
<body>
    <%@ include file="includes/customer-navbar.jsp" %>
    
    <div class="orders-container">
        <!-- Success Alert -->
        <div class="success-alert">
            <h2>
                <i class="fas fa-check-circle"></i>
                Payment Successful!
            </h2>
            <p>✅ Your order has been placed successfully and payment has been processed.</p>
            <p>📧 A confirmation email has been sent to your registered email address.</p>
        </div>
        <% if (request.getAttribute("transactionId") != null) { %>
        <div style="background:#fff;border-radius:16px;padding:16px 20px;margin-bottom:20px;box-shadow:0 10px 25px rgba(0,0,0,.08);display:flex;gap:18px;flex-wrap:wrap;align-items:center;">
            <div style="font-weight:700;color:#111827;">Transaction:</div>
            <div style="background:#eef2ff;color:#3730a3;padding:6px 10px;border-radius:8px;font-weight:700;">
                <%= (String)request.getAttribute("transactionId") %>
            </div>
            <div style="color:#4b5563;">Receipt sent to</div>
            <div style="background:#ecfeff;color:#065f46;padding:6px 10px;border-radius:8px;font-weight:600;">
                <%= (String)request.getAttribute("receiptEmail") %>
            </div>
            <div style="margin-left:auto;color:#111827;font-weight:700;">Total: ₹<%= String.format("%.2f", (request.getAttribute("totalAmount")!=null? (Double)request.getAttribute("totalAmount"):0.0)) %></div>
        </div>
        <% } %>
        <% if (request.getAttribute("transactionId") != null) { %>
        <div id="paymentToast" class="toast-success show"><i class="fas fa-check-circle"></i> Payment successful</div>
        <!-- Custom success modal -->
        <div id="paymentModal" class="modal-backdrop" role="dialog" aria-modal="true" aria-labelledby="payTitle">
          <div class="modal-card">
            <div class="icon"><i class="fas fa-check-circle"></i></div>
            <h3 id="payTitle">Payment Successful</h3>
            <p>Your order has been placed. A confirmation has been recorded.</p>
            <button id="closePaymentModal" class="btn">OK</button>
          </div>
        </div>
        <script>
          (function(){
            var toast = document.getElementById('paymentToast');
            var modal = document.getElementById('paymentModal');
            var closeBtn = document.getElementById('closePaymentModal');
            if (toast) {
              // toast is initially visible; auto-hide after 4.3s
              setTimeout(function(){ toast.classList.remove('show'); }, 4300);
            }
            if (modal) {
              // show modal shortly after load
              setTimeout(function(){ modal.classList.add('show'); }, 200);
              // close handlers
              if (closeBtn) closeBtn.onclick = function(){ modal.classList.remove('show'); };
              modal.addEventListener('click', function(e){ if(e.target === modal){ modal.classList.remove('show'); } });
              document.addEventListener('keydown', function(e){ if(e.key === 'Escape'){ modal.classList.remove('show'); } });
            }
          })();
        </script>
        <% } %>
        
        <div class="orders-header">
            <h1>Your Order Details</h1>
            <p>Thank you for your purchase, <%= userName %>! Here are your order details:</p>
        </div>
        
        <% if (orders != null && !orders.isEmpty()) { %>
            <% for (Cart cart : orders) { 
                Book book = cart.getBook();
                String orderId = "ORD" + book.getBarcode() + "TM";
            %>
            <div class="order-card">
                <div class="order-header">
                    <div class="order-id">
                        <i class="fas fa-receipt"></i> Order ID: <%= orderId %>
                    </div>
                    <span class="order-status status-pending">
                        <i class="fas fa-clock"></i> Yet to be Delivered
                    </span>
                </div>
                
                <div class="order-body">
                    <img src="<%=request.getContextPath()%>/logo.png" alt="<%= book.getName() %>" class="order-image">
                    
                    <div class="order-details">
                        <h3><%= book.getName() %></h3>
                        <p>Author: <span class="author"><%= book.getAuthor() %></span></p>
                        <p><i class="fas fa-box"></i> Quantity: <%= cart.getQuantity() %></p>
                        <p><i class="fas fa-barcode"></i> ISBN: <%= book.getBarcode() %></p>
                    </div>
                    
                    <div class="order-price">
                        <div class="price-label">Amount Paid</div>
                        <div class="price-value">₹<%= String.format("%.2f", book.getPrice() * cart.getQuantity()) %></div>
                    </div>
                </div>
            </div>
            <% } %>
        <% } else { %>
            <div class="empty-orders">
                <i class="fas fa-shopping-bag"></i>
                <h2>No Orders Yet</h2>
                <p>Start shopping to see your orders here!</p>
                <a href="<%=request.getContextPath()%>/viewbook" class="btn-shop">
                    <i class="fas fa-book"></i> Browse Books
                </a>
            </div>
        <% } %>
    </div>
    
    <%@ include file="includes/customer-footer.jsp" %>
</body>
</html>
