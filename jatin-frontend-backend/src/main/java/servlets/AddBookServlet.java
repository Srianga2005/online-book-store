package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bittercode.constant.BookStoreConstants;
import com.bittercode.constant.db.BooksDBConstants;
import com.bittercode.model.Book;
import com.bittercode.model.UserRole;
import com.bittercode.service.BookService;
import com.bittercode.service.impl.BookServiceImpl;
import com.bittercode.util.StoreUtil;

public class AddBookServlet extends HttpServlet {
    BookService bookService = new BookServiceImpl();

    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        PrintWriter pw = res.getWriter();
        res.setContentType(BookStoreConstants.CONTENT_TYPE_TEXT_HTML);

        if (!StoreUtil.isLoggedIn(UserRole.SELLER, req.getSession())) {
            RequestDispatcher rd = req.getRequestDispatcher("/SellerLogin.jsp");
            rd.include(req, res);
            pw.println("<table class=\"tab\"><tr><td>Please Login First to Continue!!</td></tr></table>");
            return;
        }

        String bName = req.getParameter(BooksDBConstants.COLUMN_NAME);
        RequestDispatcher rd = req.getRequestDispatcher("/SellerHome.jsp");
        rd.include(req, res);
        StoreUtil.setActiveTab(pw, "addbook");
        pw.println("<div class='container my-4'>");
        if(bName == null || bName.isBlank()) {
            //render the add book form;
            showAddBookForm(pw);
            return;
        } //else process the add book
        
 
        try {
            String uniqueID = UUID.randomUUID().toString();
            String bCode = uniqueID;
            String bAuthor = req.getParameter(BooksDBConstants.COLUMN_AUTHOR);
            String priceStr = req.getParameter(BooksDBConstants.COLUMN_PRICE);
            String qtyStr = req.getParameter(BooksDBConstants.COLUMN_QUANTITY);
            String bCategory = req.getParameter("category");
            String bDescription = req.getParameter("description");
            String bImageUrl = req.getParameter("imageUrl");

            if (bAuthor == null || bAuthor.isBlank() || priceStr == null || qtyStr == null
                || priceStr.isBlank() || qtyStr.isBlank()) {
                pw.println(
                    "<script>setTimeout(function(){ window.showToast && showToast('danger','Please fill all fields correctly.'); }, 0);</script>"
                );
                showAddBookForm(pw);
                return;
            }

            double bPrice;
            int bQty;
            try {
                bPrice = Double.parseDouble(priceStr.trim());
                bQty = Integer.parseInt(qtyStr.trim());
                if (bPrice < 0 || bQty < 0) {
                    throw new NumberFormatException("Negative values not allowed");
                }
            } catch (NumberFormatException nfe) {
                pw.println(
                    "<script>setTimeout(function(){ window.showToast && showToast('danger','Enter a valid numeric price and quantity.'); }, 0);</script>"
                );
                showAddBookForm(pw);
                return;
            }

            Book book = new Book(bCode, bName, bAuthor, bPrice, bQty, 
                                bCategory != null ? bCategory : "General",
                                bDescription != null ? bDescription : "",
                                bImageUrl != null ? bImageUrl : "");
            String message = bookService.addBook(book);
            if ("SUCCESS".equalsIgnoreCase(message)) {
                pw.println(
                    "<div class='auth-card p-3' style='padding:16px; display:flex; flex-direction:column; gap:12px;'>"
                  + "  <script>setTimeout(function(){ window.showToast && showToast('success','Book added successfully.'); }, 0);</script>"
                  + "  <div style='display:flex; gap:10px; flex-wrap:wrap;'>"
                  + "    <a class='btn btn-gradient' href='addbook'>Add more books</a>"
                  + "    <a class='btn btn-outline-light' href='" + req.getContextPath() + "/admin/manage-books.jsp' style='border-radius:10px;'>Go to Manage Books</a>"
                  + "    <a class='btn btn-success' href='" + req.getContextPath() + "/viewbook?preview=1' style='border-radius:10px;'>Confirm & View as User</a>"
                  + "  </div>"
                  + "</div>"
                );
            } else {
                pw.println(
                    "<div class='auth-card p-3' style='padding:16px;'>"
                  + "  <script>setTimeout(function(){ window.showToast && showToast('danger','Failed to add book. Please check the details.'); }, 0);</script>"
                  + "  <div><a class='btn btn-outline-light' href='addbook' style='border-radius:10px;'>Try again</a></div>"
                  + "</div>"
                );
                //rd.include(req, res);
            }
        } catch (Exception e) {
            e.printStackTrace();
            pw.println(
                "<div class='auth-card p-3' style='padding:16px;'>"
              + "  <script>setTimeout(function(){ window.showToast && showToast('danger','Failed to add book. Please check the details.'); }, 0);</script>"
              + "  <div><a class='btn btn-outline-light' href='addbook' style='border-radius:10px;'>Try again</a></div>"
              + "</div>"
            );
        }
    }
    
    private static void showAddBookForm(PrintWriter pw) {
        String form = "<div class='auth-card' style='padding:16px;'>\r\n"
                + "  <h3 class='mb-3' style='font-weight:800;color:#111827;'>Add a new book</h3>\r\n"
                + "  <form action=\"addbook\" method=\"post\">\r\n"
                + "    <div class='form-group'>\r\n"
                + "      <label class='form-label' for=\"bookName\">Book Name</label>\r\n"
                + "      <input class='form-control' type=\"text\" name=\"name\" id=\"bookName\" placeholder=\"Enter book name\" required>\r\n"
                + "    </div>\r\n"
                + "    <div class='form-group'>\r\n"
                + "      <label class='form-label' for=\"bookAuthor\">Author</label>\r\n"
                + "      <input class='form-control' type=\"text\" name=\"author\" id=\"bookAuthor\" placeholder=\"Enter author name\" required>\r\n"
                + "    </div>\r\n"
                + "    <div class='form-row'>\r\n"
                + "      <div class='form-group col-md-6'>\r\n"
                + "        <label class='form-label' for=\"bookPrice\">Price</label>\r\n"
                + "        <input class='form-control' type=\"number\" name=\"price\" id=\"bookPrice\" placeholder=\"Enter price\" required>\r\n"
                + "      </div>\r\n"
                + "      <div class='form-group col-md-6'>\r\n"
                + "        <label class='form-label' for=\"bookQuantity\">Quantity</label>\r\n"
                + "        <input class='form-control' type=\"number\" name=\"quantity\" id=\"bookQuantity\" placeholder=\"Enter quantity\" required>\r\n"
                + "      </div>\r\n"
                + "    </div>\r\n"
                + "    <div class='form-group'>\r\n"
                + "      <label class='form-label' for=\"bookCategory\">Category</label>\r\n"
                + "      <select class='form-control' name=\"category\" id=\"bookCategory\">\r\n"
                + "        <option value=\"General\">General</option>\r\n"
                + "        <option value=\"Programming\">Programming</option>\r\n"
                + "        <option value=\"Web Development\">Web Development</option>\r\n"
                + "        <option value=\"Data Science\">Data Science</option>\r\n"
                + "        <option value=\"Database\">Database</option>\r\n"
                + "        <option value=\"Networking\">Networking</option>\r\n"
                + "        <option value=\"Mobile Development\">Mobile Development</option>\r\n"
                + "        <option value=\"DevOps\">DevOps</option>\r\n"
                + "      </select>\r\n"
                + "    </div>\r\n"
                + "    <div class='form-group'>\r\n"
                + "      <label class='form-label' for=\"bookDescription\">Description</label>\r\n"
                + "      <textarea class='form-control' name=\"description\" id=\"bookDescription\" rows=\"3\" placeholder=\"Enter book description\"></textarea>\r\n"
                + "    </div>\r\n"
                + "    <div class='form-group'>\r\n"
                + "      <label class='form-label' for=\"bookImageUrl\">Image URL</label>\r\n"
                + "      <input class='form-control' type=\"text\" name=\"imageUrl\" id=\"bookImageUrl\" placeholder=\"Enter image URL (optional)\">\r\n"
                + "    </div>\r\n"
                + "    <div style=\"margin-top:16px;\">\r\n"
                + "      <button class=\"btn btn-success btn-lg\" type=\"submit\" style=\"border-radius:10px; padding:10px 20px;\">Submit & Add Book</button>\r\n"
                + "    </div>\r\n"
                + "  </form>\r\n"
                + "</div>";
        pw.println(form);
    }
}
