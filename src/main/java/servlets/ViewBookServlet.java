package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bittercode.model.Book;
import com.bittercode.model.UserRole;
import com.bittercode.service.BookService;
import com.bittercode.service.impl.BookServiceImpl;
import com.bittercode.util.StoreUtil;

public class ViewBookServlet extends HttpServlet {

    // book service for database operations and logics
    BookService bookService = new BookServiceImpl();

    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        // Check if the customer is logged in; allow preview bypass with ?preview=1
        String preview = req.getParameter("preview");
        boolean bypass = "1".equals(preview) || "true".equalsIgnoreCase(preview);
        if (!bypass && !StoreUtil.isLoggedIn(UserRole.CUSTOMER, req.getSession())) {
            res.sendRedirect("CustomerLogin.jsp");
            return;
        }
        
        try {
            // Add or Remove items from the cart, if requested
            StoreUtil.updateCartItems(req);

            // Read All available books from the database
            List<Book> books = bookService.getAllBooks();
            
            // Set books as request attribute
            req.setAttribute("books", books);

            // Forward to modern ViewBooks JSP
            RequestDispatcher rd = req.getRequestDispatcher("ViewBooks.jsp");
            rd.forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("error");
        }
    }
}
