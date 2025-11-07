<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Bookoe</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 40px auto;
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
        }
        h1 { color: #667eea; margin-bottom: 30px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; font-weight: bold; margin-bottom: 5px; color: #333; }
        input, select {
            width: 100%;
            padding: 12px;
            border: 2px solid #e5e7eb;
            border-radius: 8px;
            font-size: 16px;
        }
        input:focus, select:focus {
            outline: none;
            border-color: #667eea;
        }
        .btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 20px;
        }
        .btn:hover { opacity: 0.9; }
        .summary {
            background: #f9fafb;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
        }
        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 18px;
        }
        .total { font-weight: bold; font-size: 24px; color: #667eea; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🛒 Checkout</h1>
        
        <%
            // Get amount from session
            Double amount = 0.0;
            try {
                Object amountObj = session.getAttribute("amountToPay");
                if (amountObj != null) {
                    amount = (Double) amountObj;
                }
            } catch (Exception e) {
                amount = 0.0;
            }
        %>
        
        <div class="summary">
            <h2>Order Summary</h2>
            <div class="summary-row">
                <span>Subtotal:</span>
                <span>₹<%= String.format("%.2f", amount) %></span>
            </div>
            <div class="summary-row">
                <span>Shipping:</span>
                <span>Free</span>
            </div>
            <hr style="margin: 15px 0;">
            <div class="summary-row total">
                <span>Total:</span>
                <span>₹<%= String.format("%.2f", amount) %></span>
            </div>
        </div>
        
        <form action="<%=request.getContextPath()%>/processpayment" method="post">
            <h2>Billing Information</h2>
            
            <div class="form-group">
                <label>Full Name *</label>
                <input type="text" name="fullName" required>
            </div>
            
            <div class="form-group">
                <label>Email *</label>
                <input type="email" name="email" required>
            </div>
            
            <div class="form-group">
                <label>Phone *</label>
                <input type="tel" name="phone" required>
            </div>
            
            <div class="form-group">
                <label>Address *</label>
                <input type="text" name="address" required>
            </div>
            
            <h2 style="margin-top: 30px;">Payment Information</h2>
            
            <div class="form-group">
                <label>Card Number *</label>
                <input type="text" name="cardNumber" placeholder="1234 5678 9012 3456" required>
            </div>
            
            <div class="form-group">
                <label>Cardholder Name *</label>
                <input type="text" name="cardName" required>
            </div>
            
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                <div class="form-group">
                    <label>Expiry Date *</label>
                    <input type="text" name="expiry" placeholder="MM/YY" required>
                </div>
                <div class="form-group">
                    <label>CVV *</label>
                    <input type="text" name="cvv" placeholder="123" required>
                </div>
            </div>
            
            <button type="submit" class="btn">
                🔒 Complete Payment - ₹<%= String.format("%.2f", amount) %>
            </button>
        </form>
        
        <p style="text-align: center; margin-top: 20px; color: #666;">
            <a href="<%=request.getContextPath()%>/cart" style="color: #667eea; text-decoration: none;">
                ← Back to Cart
            </a>
        </p>
    </div>
</body>
</html>
