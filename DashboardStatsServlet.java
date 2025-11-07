package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bittercode.model.UserRole;
import com.bittercode.service.BookService;
import com.bittercode.service.UserService;
import com.bittercode.service.impl.BookServiceImpl;
import com.bittercode.service.impl.UserServiceImpl;
import com.bittercode.util.StoreUtil;

public class DashboardStatsServlet extends HttpServlet {
    
    private BookService bookService = new BookServiceImpl();
    private UserService userService = new UserServiceImpl();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {
        
        if (!StoreUtil.isLoggedIn(UserRole.SELLER, req.getSession())) {
            res.sendRedirect("SellerLogin.jsp");
            return;
        }
        
        try {
            // Get statistics
            int totalBooks = bookService.getAllBooks().size();
            int totalUsers = userService.getAllUsers().size();
            
            // Calculate total inventory value
            double totalSales = bookService.getAllBooks().stream()
                .mapToDouble(book -> book.getPrice() * book.getQuantity())
                .sum();
            
            // Set attributes
            req.setAttribute("totalBooks", totalBooks);
            req.setAttribute("totalUsers", totalUsers);
            req.setAttribute("totalSales", String.format("%.2f", totalSales));
            req.setAttribute("totalOrders", 0); // Will be implemented when orders are added
            
            // Forward to dashboard
            req.getRequestDispatcher("AdminDashboard.jsp").forward(req, res);
            
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("error");
        }
    }
}
