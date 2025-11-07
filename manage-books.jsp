<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.bittercode.model.User" %>
<%@ page import="com.bittercode.model.UserRole" %>
<%@ page import="com.bittercode.util.StoreUtil" %>
<%@ page import="com.bittercode.service.BookService" %>
<%@ page import="com.bittercode.service.impl.BookServiceImpl" %>
<%@ page import="com.bittercode.model.Book" %>
<%@ page import="java.util.List" %>
<%
    if (!StoreUtil.isLoggedIn(UserRole.SELLER, session)) {
        response.sendRedirect("../SellerLogin.jsp");
        return;
    }
    User user = (User) session.getAttribute("user");
    String userName = user != null ? user.getFirstName() + " " + user.getLastName() : "Admin";
    
    List<Book> books = new java.util.ArrayList<>();
    try {
        BookService bookService = new BookServiceImpl();
        books = bookService.getAllBooks();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Books - Admin Dashboard</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin-dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <%@ include file="sidebar.jsp" %>
    
    <main class="main-content">
        <%@ include file="topbar.jsp" %>
        
        <div class="content-wrapper">
            <div class="content-header">
                <div>
                    <h1>Manage Books</h1>
                    <p class="subtitle">Add, edit, and manage your book inventory</p>
                </div>
                <div class="header-actions">
                    <button class="btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/addbook'">
                        <i class="fas fa-plus"></i> Add New Book
                    </button>
                </div>
            </div>
            
            <div class="card">
                <div class="card-header">
                    <h3>Book Inventory</h3>
                    <div class="card-actions">
                        <input type="text" id="searchBooks" placeholder="Search books..." class="form-control">
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Barcode</th>
                                    <th>Book Name</th>
                                    <th>Author</th>
                                    <th>Category</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Book book : books) { %>
                                <tr>
                                    <td><%= book.getBarcode() %></td>
                                    <td><%= book.getName() %></td>
                                    <td><%= book.getAuthor() %></td>
                                    <td><span class="badge badge-info"><%= book.getCategory() != null ? book.getCategory() : "General" %></span></td>
                                    <td>$<%= book.getPrice() %></td>
                                    <td><span class="badge <%= book.getQuantity() > 10 ? "badge-success" : "badge-warning" %>"><%= book.getQuantity() %></span></td>
                                    <td>
                                        <button class="btn-icon" onclick="editBook('<%= book.getBarcode() %>')" title="Edit">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn-icon btn-danger" onclick="deleteBook('<%= book.getBarcode() %>')" title="Delete">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </main>
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/admin-dashboard.js"></script>
    <script>
        function editBook(barcode) {
            window.location.href = '<%=request.getContextPath()%>/updatebook?barcode=' + barcode;
        }
        
        function deleteBook(barcode) {
            if (confirm('Are you sure you want to delete this book?')) {
                window.location.href = '<%=request.getContextPath()%>/removebook?barcode=' + barcode;
            }
        }
        
        // Search functionality
        document.getElementById('searchBooks').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const rows = document.querySelectorAll('.data-table tbody tr');
            
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(searchTerm) ? '' : 'none';
            });
        });
    </script>
</body>
</html>
