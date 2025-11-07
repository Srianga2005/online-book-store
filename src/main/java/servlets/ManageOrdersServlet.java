package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bittercode.constant.ResponseCode;
import com.bittercode.model.Order;
import com.bittercode.model.UserRole;
import com.bittercode.service.OrderService;
import com.bittercode.service.impl.OrderServiceImpl;
import com.bittercode.util.StoreUtil;

public class ManageOrdersServlet extends HttpServlet {
    
    OrderService orderService = new OrderServiceImpl();
    
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
            String action = req.getParameter("action");
            String orderId = req.getParameter("orderId");
            String newStatus = req.getParameter("status");
            
            RequestDispatcher rd = req.getRequestDispatcher("/SellerHome.jsp");
            rd.include(req, res);
            StoreUtil.setActiveTab(pw, "manageorders");
            pw.println("<div class='container my-4'>");
            
            if ("updateStatus".equals(action) && orderId != null && newStatus != null) {
                String response = orderService.updateOrderStatus(orderId, newStatus);
                if (ResponseCode.SUCCESS.name().equalsIgnoreCase(response)) {
                    pw.println("<script>setTimeout(function(){ window.showToast && showToast('success','Order status updated successfully.'); }, 0);</script>");
                } else {
                    pw.println("<script>setTimeout(function(){ window.showToast && showToast('danger','Failed to update order status.'); }, 0);</script>");
                }
            }
            
            String filterStatus = req.getParameter("filterStatus");
            List<Order> orders;
            if (filterStatus != null && !filterStatus.isEmpty() && !"All".equals(filterStatus)) {
                orders = orderService.getOrdersByStatus(filterStatus);
            } else {
                orders = orderService.getAllOrders();
            }
            
            displayOrdersTable(pw, orders, filterStatus);
            pw.println("</div>");
            
        } catch (Exception e) {
            e.printStackTrace();
            pw.println("<div class='alert alert-danger'>Error loading orders</div>");
        }
    }
    
    private void displayOrdersTable(PrintWriter pw, List<Order> orders, String currentFilter) {
        pw.println("<div class='auth-card' style='padding:16px;'>");
        pw.println("<h3 class='mb-3' style='font-weight:800;color:#111827;'>Order Management</h3>");
        
        // Filter form
        pw.println("<form method='get' action='manageorders' class='mb-3'>");
        pw.println("<div class='form-row align-items-center'>");
        pw.println("<div class='col-auto'>");
        pw.println("<label class='form-label'>Filter by Status:</label>");
        pw.println("</div>");
        pw.println("<div class='col-auto'>");
        pw.println("<select name='filterStatus' class='form-control' onchange='this.form.submit()'>");
        pw.println("<option value='All'" + ("All".equals(currentFilter) || currentFilter == null ? " selected" : "") + ">All Orders</option>");
        pw.println("<option value='Pending'" + ("Pending".equals(currentFilter) ? " selected" : "") + ">Pending</option>");
        pw.println("<option value='Processing'" + ("Processing".equals(currentFilter) ? " selected" : "") + ">Processing</option>");
        pw.println("<option value='Shipped'" + ("Shipped".equals(currentFilter) ? " selected" : "") + ">Shipped</option>");
        pw.println("<option value='Delivered'" + ("Delivered".equals(currentFilter) ? " selected" : "") + ">Delivered</option>");
        pw.println("<option value='Cancelled'" + ("Cancelled".equals(currentFilter) ? " selected" : "") + ">Cancelled</option>");
        pw.println("</select>");
        pw.println("</div>");
        pw.println("</div>");
        pw.println("</form>");
        
        pw.println("<table class='table table-hover table-borderless' style='background-color:#fff;border-radius:10px;overflow:hidden;box-shadow:0 10px 25px rgba(0,0,0,.12)'>");
        pw.println("<thead>");
        pw.println("<tr style='background-color:#1f7a74; color:white;'>");
        pw.println("<th>Order ID</th>");
        pw.println("<th>Customer</th>");
        pw.println("<th>Date</th>");
        pw.println("<th>Amount</th>");
        pw.println("<th>Status</th>");
        pw.println("<th>Actions</th>");
        pw.println("</tr>");
        pw.println("</thead>");
        pw.println("<tbody>");
        
        if (orders == null || orders.isEmpty()) {
            pw.println("<tr><td colspan='6' style='text-align:center;color:#1f7a74;'>No orders found</td></tr>");
        } else {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            for (Order order : orders) {
                pw.println("<tr>");
                pw.println("<td>" + order.getOrderId() + "</td>");
                pw.println("<td>" + order.getUserEmail() + "</td>");
                pw.println("<td>" + sdf.format(order.getOrderDate()) + "</td>");
                pw.println("<td>₹" + String.format("%.2f", order.getTotalAmount()) + "</td>");
                pw.println("<td><span class='badge badge-" + getStatusBadgeClass(order.getStatus()) + "'>" + order.getStatus() + "</span></td>");
                pw.println("<td>");
                pw.println("<form method='post' action='manageorders' style='display:inline;'>");
                pw.println("<input type='hidden' name='orderId' value='" + order.getOrderId() + "'/>");
                pw.println("<input type='hidden' name='action' value='updateStatus'/>");
                pw.println("<select name='status' class='form-control form-control-sm' style='width:auto;display:inline;' onchange='this.form.submit()'>");
                pw.println("<option value=''>Change Status</option>");
                if (!"Processing".equals(order.getStatus())) pw.println("<option value='Processing'>Processing</option>");
                if (!"Shipped".equals(order.getStatus())) pw.println("<option value='Shipped'>Shipped</option>");
                if (!"Delivered".equals(order.getStatus())) pw.println("<option value='Delivered'>Delivered</option>");
                if (!"Cancelled".equals(order.getStatus())) pw.println("<option value='Cancelled'>Cancelled</option>");
                pw.println("</select>");
                pw.println("</form>");
                pw.println("</td>");
                pw.println("</tr>");
            }
        }
        
        pw.println("</tbody>");
        pw.println("</table>");
        pw.println("</div>");
    }
    
    private String getStatusBadgeClass(String status) {
        switch (status) {
            case "Pending": return "warning";
            case "Processing": return "info";
            case "Shipped": return "primary";
            case "Delivered": return "success";
            case "Cancelled": return "danger";
            default: return "secondary";
        }
    }
}
