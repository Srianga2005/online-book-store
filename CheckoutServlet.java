package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CheckoutServlet extends HttpServlet {
    
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        doPost(req, res);
    }
    
    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        System.out.println("=== CheckoutServlet Called ===");
        System.out.println("Request URI: " + req.getRequestURI());
        System.out.println("Context Path: " + req.getContextPath());
        
        try {
            // Get session without creating new one
            HttpSession session = req.getSession(false);
            System.out.println("Session exists: " + (session != null));
            
            if (session != null) {
                Object user = session.getAttribute("user");
                System.out.println("User in session: " + (user != null));
                System.out.println("Cart items: " + session.getAttribute("cartItems"));
                System.out.println("Amount to pay: " + session.getAttribute("amountToPay"));
            }
            
            // Forward to simple checkout page
            System.out.println("Forwarding to Checkout-simple.jsp...");
            RequestDispatcher rd = req.getRequestDispatcher("Checkout-simple.jsp");
            rd.forward(req, res);
            System.out.println("Forward successful!");
            
        } catch (Exception e) {
            System.out.println("ERROR in CheckoutServlet: " + e.getMessage());
            e.printStackTrace();
            // Show error instead of redirecting
            throw new ServletException("Checkout failed", e);
        }
    }

}
