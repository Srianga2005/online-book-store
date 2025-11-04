package servlets;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bittercode.model.UserRole;
import com.bittercode.service.BookService;
import com.bittercode.service.OrderService;
import com.bittercode.service.UserService;
import com.bittercode.service.impl.BookServiceImpl;
import com.bittercode.service.impl.OrderServiceImpl;
import com.bittercode.service.impl.UserServiceImpl;
import com.bittercode.util.StoreUtil;

public class AdminDashboardServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {
        
        // Check if user is logged in as admin
        if (!StoreUtil.isLoggedIn(UserRole.SELLER, req.getSession())) {
            res.sendRedirect("SellerLogin.jsp");
            return;
        }
        try {
            // Services
            BookService bookService = new BookServiceImpl();
            UserService userService = new UserServiceImpl();
            OrderService orderService = new OrderServiceImpl();

            // Metrics
            int totalBooks = bookService.getAllBooks().size();
            int totalUsers = userService.getAllUsers().size();
            double inventoryValue = bookService.getAllBooks().stream()
                    .mapToDouble(b -> b.getPrice() * b.getQuantity())
                    .sum();
            int booksSoldToday = orderService.getBooksSoldToday();
            int totalBooksSold = orderService.getTotalBooksSold();

            // Attributes
            req.setAttribute("totalBooks", totalBooks);
            req.setAttribute("totalUsers", totalUsers);
            req.setAttribute("inventoryValue", String.format("%.2f", inventoryValue));
            req.setAttribute("booksSoldToday", booksSoldToday);
            req.setAttribute("totalBooksSold", totalBooksSold);

            // Forward to admin dashboard
            RequestDispatcher rd = req.getRequestDispatcher("AdminDashboard.jsp");
            rd.forward(req, res);
        } catch (Exception e) {
            // On error, still forward but with safe defaults
            req.setAttribute("totalBooks", 0);
            req.setAttribute("totalUsers", 0);
            req.setAttribute("inventoryValue", String.format("%.2f", 0.0));
            req.setAttribute("booksSoldToday", 0);
            req.setAttribute("totalBooksSold", 0);
            RequestDispatcher rd = req.getRequestDispatcher("AdminDashboard.jsp");
            rd.forward(req, res);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {
        doGet(req, res);
    }
}
