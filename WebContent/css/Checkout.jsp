<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.bittercode.model.User" %>
<%
    // Safely get user information
    String userName = "Customer";
    String userEmail = "";
    
    try {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            userName = user.getFirstName() != null ? user.getFirstName() : "Customer";
            userEmail = user.getMailId() != null ? user.getMailId() : "";
        }
    } catch (Exception e) {
        // Use defaults if error
    }
    
    // Safely get amount
    Double amountToPay = 0.0;
    try {
        Object amountObj = session.getAttribute("amountToPay");
        if (amountObj != null) {
            amountToPay = (Double) amountObj;
        }
    } catch (Exception e) {
        amountToPay = 0.0;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Bookoe</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/customer-modern.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .checkout-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
        }
        
        .checkout-header {
            text-align: center;
            margin-bottom: 50px;
        }
        
        .checkout-header h1 {
            font-size: 2.5rem;
            color: #fff;
            margin-bottom: 10px;
        }
        
        .checkout-header p {
            color: rgba(255, 255, 255, 0.8);
            font-size: 1.1rem;
        }
        
        .checkout-grid {
            display: grid;
            grid-template-columns: 1.5fr 1fr;
            gap: 30px;
            margin-bottom: 30px;
        }
        
        .checkout-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 35px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }
        
        .card-title {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .card-title i {
            color: #7c3aed;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-label {
            display: block;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            font-size: 0.95rem;
        }
        
        .form-input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e5e7eb;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s;
        }
        
        .form-input:focus {
            outline: none;
            border-color: #7c3aed;
            box-shadow: 0 0 0 3px rgba(124, 58, 237, 0.1);
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }
        
        .form-row-3 {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 15px;
        }
        
        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 10px;
        }
        
        .checkbox-group input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }
        
        .order-summary {
            position: sticky;
            top: 20px;
        }
        
        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 15px 0;
            border-bottom: 1px solid #e5e7eb;
        }
        
        .summary-row:last-child {
            border-bottom: none;
            padding-top: 20px;
            margin-top: 10px;
            border-top: 2px solid #7c3aed;
        }
        
        .summary-label {
            color: #666;
            font-size: 1rem;
        }
        
        .summary-value {
            font-weight: 600;
            color: #333;
        }
        
        .total-amount {
            font-size: 1.8rem;
            color: #10b981;
            font-weight: 700;
        }
        
        .btn-place-order {
            width: 100%;
            padding: 18px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 15px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 20px;
        }
        
        .btn-place-order:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }
        
        .accepted-cards {
            display: flex;
            gap: 10px;
            margin-top: 15px;
            flex-wrap: wrap;
        }
        
        .card-icon {
            width: 50px;
            height: 35px;
            background: #f3f4f6;
            border-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
        }
        
        @media (max-width: 968px) {
            .checkout-grid {
                grid-template-columns: 1fr;
            }
            
            .order-summary {
                position: static;
            }
        }
    </style>
</head>
<body>
    <%@ include file="includes/customer-navbar.jsp" %>
    
    <div class="checkout-container">
        <div class="checkout-header">
            <h1><i class="fas fa-credit-card"></i> Secure Checkout</h1>
            <p>Complete your purchase securely</p>
        </div>
        
        <form action="<%=request.getContextPath()%>/processpayment" method="post">
            <div class="checkout-grid">
                <!-- Billing & Payment Section -->
                <div>
                    <!-- Billing Address -->
                    <div class="checkout-card">
                        <h2 class="card-title">
                            <i class="fas fa-map-marker-alt"></i>
                            Billing Address
                        </h2>
                        
                        <div class="form-group">
                            <label class="form-label">Full Name</label>
                            <input type="text" name="fullName" class="form-input" placeholder="John M. Doe" value="<%= userName %>" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Email</label>
                            <input type="email" name="email" class="form-input" placeholder="john@example.com" value="<%= userEmail %>" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Address</label>
                            <input type="text" name="address" class="form-input" placeholder="542 W. 15th Street" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">City</label>
                            <input type="text" name="city" class="form-input" placeholder="New York" required>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">State</label>
                                <input type="text" name="state" class="form-input" placeholder="NY" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Zip</label>
                                <input type="text" name="zip" class="form-input" placeholder="10001" required>
                            </div>
                        </div>
                        
                        <div class="checkbox-group">
                            <input type="checkbox" id="sameAddress" checked>
                            <label for="sameAddress">Shipping address same as billing</label>
                        </div>
                    </div>
                    
                    <!-- Payment Method -->
                    <div class="checkout-card" style="margin-top: 30px;">
                        <h2 class="card-title">
                            <i class="fas fa-credit-card"></i>
                            Payment
                        </h2>
                        
                        <div class="form-group">
                            <label class="form-label">Accepted Cards</label>
                            <div class="accepted-cards">
                                <div class="card-icon"><i class="fab fa-cc-visa" style="color: #1434CB;"></i></div>
                                <div class="card-icon"><i class="fab fa-cc-mastercard" style="color: #EB001B;"></i></div>
                                <div class="card-icon"><i class="fab fa-cc-amex" style="color: #006FCF;"></i></div>
                                <div class="card-icon"><i class="fab fa-cc-discover" style="color: #FF6000;"></i></div>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Name on Card</label>
                            <input type="text" name="cardName" class="form-input" placeholder="John More Doe" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Credit card number</label>
                            <input type="text" name="cardNumber" class="form-input" placeholder="1111 2222 3333 4444" maxlength="19" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Exp Month</label>
                            <input type="text" name="expMonth" class="form-input" placeholder="September" required>
                        </div>
                        
                        <div class="form-row-3">
                            <div class="form-group">
                                <label class="form-label">Exp Year</label>
                                <input type="text" name="expYear" class="form-input" placeholder="2018" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">CVV</label>
                                <input type="text" name="cvv" class="form-input" placeholder="352" maxlength="4" required>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Order Summary -->
                <div class="order-summary">
                    <div class="checkout-card">
                        <h2 class="card-title">
                            <i class="fas fa-shopping-bag"></i>
                            Order Summary
                        </h2>
                        
                        <div class="summary-row">
                            <span class="summary-label">Subtotal</span>
                            <span class="summary-value">₹<%= String.format("%.2f", amountToPay) %></span>
                        </div>
                        
                        <div class="summary-row">
                            <span class="summary-label">Shipping</span>
                            <span class="summary-value" style="color: #10b981;">FREE</span>
                        </div>
                        
                        <div class="summary-row">
                            <span class="summary-label">Tax (GST 18%)</span>
                            <span class="summary-value">₹<%= String.format("%.2f", amountToPay * 0.18) %></span>
                        </div>
                        
                        <div class="summary-row">
                            <span class="summary-label" style="font-size: 1.2rem; font-weight: 600;">Total Amount</span>
                            <span class="total-amount">₹<%= String.format("%.2f", amountToPay * 1.18) %></span>
                        </div>
                        
                        <button type="submit" class="btn-place-order">
                            <i class="fas fa-lock"></i> Pay & Place Order
                        </button>
                        
                        <p style="text-align: center; color: #666; font-size: 0.85rem; margin-top: 15px;">
                            <i class="fas fa-shield-alt"></i> Your payment information is secure
                        </p>
                    </div>
                </div>
            </div>
        </form>
    </div>
    
    <%@ include file="includes/customer-footer.jsp" %>
    
    <script>
        // Format credit card number
        document.querySelector('input[name="cardNumber"]').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\s/g, '');
            let formattedValue = value.match(/.{1,4}/g)?.join(' ') || value;
            e.target.value = formattedValue;
        });
    </script>
</body>
</html>
