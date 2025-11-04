package servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bittercode.constant.ResponseCode;
import com.bittercode.constant.BookStoreConstants;
import com.bittercode.model.User;
import com.bittercode.model.UserRole;
import com.bittercode.service.UserService;
import com.bittercode.service.impl.UserServiceImpl;
import com.bittercode.util.StoreUtil;

public class AdminCreateUserServlet extends HttpServlet {
    private final UserService userService = new UserServiceImpl();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        res.setContentType(BookStoreConstants.CONTENT_TYPE_TEXT_HTML);
        PrintWriter pw = res.getWriter();

        // Only seller/admin can access
        if (!StoreUtil.isLoggedIn(UserRole.SELLER, req.getSession())) {
            RequestDispatcher rd = req.getRequestDispatcher("/SellerLogin.jsp");
            rd.include(req, res);
            pw.println("<table class=\"tab\"><tr><td>Please login as Admin to continue.</td></tr></table>");
            return;
        }

        String submit = req.getParameter("submit");
        RequestDispatcher rd = req.getRequestDispatcher("/SellerHome.jsp");
        rd.include(req, res);
        StoreUtil.setActiveTab(pw, "manageusers");
        pw.println("<div class='container my-4'>");

        if (submit == null) {
            renderForm(pw, req.getContextPath());
            pw.println("</div>");
            return;
        }

        // Process creation
        String role = req.getParameter("role");
        String email = req.getParameter("email");
        String first = req.getParameter("firstName");
        String last = req.getParameter("lastName");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");

        try {
            User user = new User();
            user.setEmailId(email);
            user.setFirstName(first);
            user.setLastName(last);
            user.setPassword(password);
            if (phone != null && !phone.isBlank()) {
                try { user.setPhone(Long.parseLong(phone.trim())); } catch (NumberFormatException ignore) { user.setPhone(0L); }
            }
            user.setAddress(address);
            UserRole userRole = ("SELLER".equalsIgnoreCase(role)) ? UserRole.SELLER : UserRole.CUSTOMER;
            String resp = userService.register(userRole, user);
            if (ResponseCode.SUCCESS.name().equalsIgnoreCase(resp)) {
                pw.println("<div class='auth-card p-3' style='padding:16px;'>"
                        + "<script>setTimeout(function(){ window.showToast && showToast('success','User created successfully.'); }, 0);</script>"
                        + "<div style='display:flex; gap:10px; flex-wrap:wrap;'>"
                        + "<a class='btn btn-gradient' href='" + req.getContextPath() + "/create-user'>Create another</a>"
                        + "<a class='btn btn-outline-light' href='" + req.getContextPath() + "/manageusers' style='border-radius:10px;'>Manage Users</a>"
                        + "</div></div>");
            } else {
                pw.println("<div class='auth-card p-3' style='padding:16px;'>"
                        + "<script>setTimeout(function(){ window.showToast && showToast('danger','" + resp.replace("'","\\'") + "'); }, 0);</script>"
                        + "</div>");
                renderForm(pw, req.getContextPath());
            }
        } catch (Exception e) {
            e.printStackTrace();
            pw.println("<div class='auth-card p-3' style='padding:16px;'>"
                    + "<script>setTimeout(function(){ window.showToast && showToast('danger','Failed to create user.'); }, 0);</script>"
                    + "</div>");
            renderForm(pw, req.getContextPath());
        }
        pw.println("</div>");
    }

    private void renderForm(PrintWriter pw, String ctx) {
        pw.println("<div class='auth-card' style='padding:16px;'>");
        pw.println("  <h3 class='mb-3' style='font-weight:800;color:#111827;'>Create New User</h3>");
        pw.println("  <form action='" + ctx + "/create-user' method='post'>");
        pw.println("    <div class='form-group'><label class='form-label'>Role</label>"
                + "<select class='form-control' name='role' required>"
                + "<option value='CUSTOMER' selected>Customer</option>"
                + "<option value='SELLER'>Seller</option>"
                + "</select></div>");
        pw.println("    <div class='form-group'><label class='form-label'>Email</label><input class='form-control' type='email' name='email' required></div>");
        pw.println("    <div class='form-row'>"
                + "<div class='form-group col-md-6'><label class='form-label'>First Name</label><input class='form-control' type='text' name='firstName' required></div>"
                + "<div class='form-group col-md-6'><label class='form-label'>Last Name</label><input class='form-control' type='text' name='lastName'></div>"
                + "</div>");
        pw.println("    <div class='form-group'><label class='form-label'>Password</label><input class='form-control' type='password' name='password' required></div>");
        pw.println("    <div class='form-row'>"
                + "<div class='form-group col-md-6'><label class='form-label'>Phone</label><input class='form-control' type='text' name='phone'></div>"
                + "<div class='form-group col-md-6'><label class='form-label'>Address</label><input class='form-control' type='text' name='address'></div>"
                + "</div>");
        pw.println("    <div style='margin-top:16px;'><button class='btn btn-success btn-lg' type='submit' name='submit' value='1' style='border-radius:10px; padding:10px 20px;'>Create User</button>"
                + "    <a class='btn btn-outline-light' href='" + ctx + "/manageusers' style='border-radius:10px; margin-left:8px;'>Cancel</a></div>");
        pw.println("  </form>");
        pw.println("</div>");
    }
}
