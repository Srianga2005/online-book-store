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

public class SearchBooksServlet extends HttpServlet {
    
    BookService bookService = new BookServiceImpl();
    
    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        PrintWriter pw = res.getWriter();
        res.setContentType("text/html");
        
        if (!StoreUtil.isLoggedIn(UserRole.SELLER, req.getSession())) {
            RequestDispatcher rd = req.getRequestDispatcher("/SellerLogin.jsp");
            rd.include(req, res);
            pw.println("<table class=\"tab\"><tr><td>Please Login First to Continue!!</td></tr></table>");
            return;
        }
        
        try {
            String searchTerm = req.getParameter("search");
            String category = req.getParameter("category");
            String author = req.getParameter("author");
            String minPriceStr = req.getParameter("minPrice");
            String maxPriceStr = req.getParameter("maxPrice");
            
            RequestDispatcher rd = req.getRequestDispatcher("/SellerHome.jsp");
            rd.include(req, res);
            StoreUtil.setActiveTab(pw, "searchbooks");
            pw.println("<div class='container my-4'>");
            
            List<Book> books = null;
            
            if (searchTerm != null && !searchTerm.isEmpty()) {
                books = bookService.searchBooks(searchTerm);
            } else if (category != null && !category.isEmpty()) {
                books = bookService.getBooksByCategory(category);
            } else if (author != null && !author.isEmpty()) {
                books = bookService.getBooksByAuthor(author);
            } else if (minPriceStr != null && maxPriceStr != null && !minPriceStr.isEmpty() && !maxPriceStr.isEmpty()) {
                double minPrice = Double.parseDouble(minPriceStr);
                double maxPrice = Double.parseDouble(maxPriceStr);
                books = bookService.getBooksByPriceRange(minPrice, maxPrice);
            } else {
                books = bookService.getAllBooks();
            }
            
            displaySearchForm(pw);
            displayBooksTable(pw, books);
            pw.println("</div>");
            
        } catch (Exception e) {
            e.printStackTrace();
            pw.println("<div class='alert alert-danger'>Error searching books</div>");
        }
    }
    
    private void displaySearchForm(PrintWriter pw) {
        pw.println("<div class='auth-card' style='padding:16px;margin-bottom:20px;'>");
        pw.println("<h3 class='mb-3' style='font-weight:800;color:#111827;'>Search & Filter Books</h3>");
        pw.println("<form method='get' action='searchbooks'>");
        pw.println("<div class='form-row'>");
        
        pw.println("<div class='form-group col-md-6'>");
        pw.println("<label class='form-label'>Search by Name/Author</label>");
        pw.println("<input type='text' name='search' class='form-control' placeholder='Enter book name or author'>");
        pw.println("</div>");
        
        pw.println("<div class='form-group col-md-6'>");
        pw.println("<label class='form-label'>Category</label>");
        pw.println("<select name='category' class='form-control'>");
        pw.println("<option value=''>All Categories</option>");
        pw.println("<option value='Programming'>Programming</option>");
        pw.println("<option value='Web Development'>Web Development</option>");
        pw.println("<option value='Data Science'>Data Science</option>");
        pw.println("<option value='Database'>Database</option>");
        pw.println("<option value='General'>General</option>");
        pw.println("</select>");
        pw.println("</div>");
        
        pw.println("</div>");
        pw.println("<div class='form-row'>");
        
        pw.println("<div class='form-group col-md-4'>");
        pw.println("<label class='form-label'>Author</label>");
        pw.println("<input type='text' name='author' class='form-control' placeholder='Enter author name'>");
        pw.println("</div>");
        
        pw.println("<div class='form-group col-md-3'>");
        pw.println("<label class='form-label'>Min Price</label>");
        pw.println("<input type='number' name='minPrice' class='form-control' placeholder='0'>");
        pw.println("</div>");
        
        pw.println("<div class='form-group col-md-3'>");
        pw.println("<label class='form-label'>Max Price</label>");
        pw.println("<input type='number' name='maxPrice' class='form-control' placeholder='10000'>");
        pw.println("</div>");
        
        pw.println("<div class='form-group col-md-2'>");
        pw.println("<label class='form-label'>&nbsp;</label>");
        pw.println("<button type='submit' class='btn btn-gradient btn-block'>Search</button>");
        pw.println("</div>");
        
        pw.println("</div>");
        pw.println("</form>");
        pw.println("</div>");
    }
    
    private void displayBooksTable(PrintWriter pw, List<Book> books) {
        pw.println("<div class='auth-card' style='padding:16px;'>");
        pw.println("<h3 class='mb-3' style='font-weight:800;color:#111827;'>Search Results (" + (books != null ? books.size() : 0) + " books)</h3>");
        pw.println("<table class='table table-hover table-borderless' style='background-color:#fff;border-radius:10px;overflow:hidden;box-shadow:0 10px 25px rgba(0,0,0,.12)'>");
        pw.println("<thead>");
        pw.println("<tr style='background-color:#1f7a74; color:white;'>");
        pw.println("<th>Book ID</th>");
        pw.println("<th>Name</th>");
        pw.println("<th>Author</th>");
        pw.println("<th>Category</th>");
        pw.println("<th>Price</th>");
        pw.println("<th>Quantity</th>");
        pw.println("<th>Action</th>");
        pw.println("</tr>");
        pw.println("</thead>");
        pw.println("<tbody>");
        
        if (books == null || books.isEmpty()) {
            pw.println("<tr><td colspan='7' style='text-align:center;color:#1f7a74;'>No books found</td></tr>");
        } else {
            for (Book book : books) {
                pw.println("<tr>");
                pw.println("<td>" + book.getBarcode() + "</td>");
                pw.println("<td>" + book.getName() + "</td>");
                pw.println("<td>" + book.getAuthor() + "</td>");
                pw.println("<td>" + (book.getCategory() != null ? book.getCategory() : "General") + "</td>");
                pw.println("<td>₹" + book.getPrice() + "</td>");
                pw.println("<td>" + book.getQuantity() + "</td>");
                pw.println("<td>");
                pw.println("<form method='post' action='updatebook' style='display:inline;'>");
                pw.println("<input type='hidden' name='bookId' value='" + book.getBarcode() + "'/>");
                pw.println("<button type='submit' class='btn btn-success btn-sm'>Edit</button>");
                pw.println("</form>");
                pw.println("</td>");
                pw.println("</tr>");
            }
        }
        
        pw.println("</tbody>");
        pw.println("</table>");
        pw.println("</div>");
    }
}
