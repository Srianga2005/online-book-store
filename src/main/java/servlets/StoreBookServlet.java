package servlets;

import java.io.IOException;
import java.io.PrintWriter;
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

public class StoreBookServlet extends HttpServlet {

    // book service for database operations and logics
    BookService bookService = new BookServiceImpl();

    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        PrintWriter pw = res.getWriter();
        res.setContentType("text/html");

        // Check if the customer is logged in, or else return to login page
        if (!StoreUtil.isLoggedIn(UserRole.SELLER, req.getSession())) {
            RequestDispatcher rd = req.getRequestDispatcher("/SellerLogin.jsp");
            rd.include(req, res);
            pw.println("<table class=\"tab\"><tr><td>Please Login First to Continue!!</td></tr></table>");
            return;
        }
        try {

            // Add/Remove Item from the cart if requested
            // store the comma separated bookIds of cart in the session
            // StoreUtil.updateCartItems(req);

            RequestDispatcher rd = req.getRequestDispatcher("/SellerHome.jsp");
            rd.include(req, res);
            pw.println("<div class='container my-4'>");
            // Set the active tab as cart
            StoreUtil.setActiveTab(pw, "storebooks");

            // Read the books from the database with the respective bookIds
            List<Book> books = bookService.getAllBooks();
            pw.println("<div class='auth-card' style='padding:16px;'>");
            pw.println("<h3 class='mb-3' style='font-weight:800;color:#111827;'>Books Available In the Store</h3>");
            pw.println("<table id=\"storebooks-table\" class=\"table table-hover table-borderless\" style='background-color:#fff;border-radius:10px;overflow:hidden;box-shadow:0 10px 25px rgba(0,0,0,.12)'>\r\n"
                    + "  <thead>\r\n"
                    + "    <tr style='background-color:#1f7a74; color:white;'>\r\n"
                    + "      <th scope=\"col\">BookId</th>\r\n"
                    + "      <th scope=\"col\">Name</th>\r\n"
                    + "      <th scope=\"col\">Author</th>\r\n"
                    + "      <th scope=\"col\">Price</th>\r\n"
                    + "      <th scope=\"col\">Quantity</th>\r\n"
                    + "      <th scope=\"col\">Action</th>\r\n"
                    + "    </tr>\r\n"
                    + "  </thead>\r\n"
                    + "  <tbody>\r\n");
            if (books == null || books.size() == 0) {
                pw.println("    <tr style='background-color:rgba(31,122,116,.08)'>\r\n"
                        + "      <th scope=\"row\" colspan='6' style='color:#1f7a74; text-align:center;'> No Books Available in the store </th>\r\n"
                        + "    </tr>\r\n");
            }
            for (Book book : books) {
                pw.println(getRowData(book));
            }

            pw.println("  </tbody>\r\n"
                    + "</table></div></div>");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getRowData(Book book) {
        return "    <tr>\r\n"
                + "      <th scope=\"row\">" + book.getBarcode() + "</th>\r\n"
                + "      <td>" + book.getName() + "</td>\r\n"
                + "      <td>" + book.getAuthor() + "</td>\r\n"
                + "      <td><span>&#8377;</span> " + book.getPrice() + "</td>\r\n"
                + "      <td>"
                + book.getQuantity()
                + "      </td>\r\n"
                + "      <td><form method='post' action='updatebook'>"
                + "          <input type='hidden' name='bookId' value='" + book.getBarcode() + "'/>"
                + "          <button type='submit' class=\"btn btn-success\">Update</button>"
                + "          </form>"
                + "    </tr>\r\n";
    }

}
