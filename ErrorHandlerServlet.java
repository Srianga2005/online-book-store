package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Optional;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bittercode.constant.ResponseCode;
import com.bittercode.model.StoreException;
import com.bittercode.model.UserRole;
import com.bittercode.util.StoreUtil;

public class ErrorHandlerServlet extends HttpServlet {

    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        PrintWriter pw = res.getWriter();
        res.setContentType("text/html");

        // Fetch the exceptions
        Throwable throwable = (Throwable) req.getAttribute("javax.servlet.error.exception");
        Integer statusCode = (Integer) req.getAttribute("javax.servlet.error.status_code");
        String servletName = (String) req.getAttribute("javax.servlet.error.servlet_name");
        String requestUri = (String) req.getAttribute("javax.servlet.error.request_uri");
        String errorMessage = ResponseCode.INTERNAL_SERVER_ERROR.getMessage();
        String errorCode = ResponseCode.INTERNAL_SERVER_ERROR.name();

        if (statusCode == null)
            statusCode = 0;
        Optional<ResponseCode> errorCodes = ResponseCode.getMessageByStatusCode(statusCode);
        if (errorCodes.isPresent()) {
            errorMessage = errorCodes.get().getMessage();
            errorCode = errorCodes.get().name();
        }

        if (throwable != null && throwable instanceof StoreException) {
            StoreException storeException = (StoreException) throwable;
            if (storeException != null) {
                errorMessage = storeException.getMessage();
                statusCode = storeException.getStatusCode();
                errorCode = storeException.getErrorCode();
                storeException.printStackTrace();
            }
        }

        System.out.println("======ERROR TRIGGERED========");
        System.out.println("Servlet Name: " + servletName);
        System.out.println("Request URI: " + requestUri);
        System.out.println("Status Code: " + statusCode);
        System.out.println("Error Code: " + errorCode);
        System.out.println("Error Message: " + errorMessage);
        System.out.println("=============================");

        String reqUriSafe = requestUri == null ? "" : requestUri.toLowerCase();
        boolean isHtmlRequest = reqUriSafe.endsWith(".html") || reqUriSafe.endsWith("/") || reqUriSafe.isEmpty();

        if (!isHtmlRequest) {
            res.setStatus(statusCode);
            pw.flush();
            return;
        }

        if (StoreUtil.isLoggedIn(UserRole.CUSTOMER, req.getSession())) {
            req.setAttribute("errorCode", errorCode);
            req.setAttribute("errorMessage", errorMessage);
            RequestDispatcher rd = req.getRequestDispatcher("CustomerHome.jsp");
            rd.include(req, res);

        } else if (StoreUtil.isLoggedIn(UserRole.SELLER, req.getSession())) {
            req.setAttribute("errorCode", errorCode);
            req.setAttribute("errorMessage", errorMessage);
            RequestDispatcher rd = req.getRequestDispatcher("admin-dashboard");
            rd.include(req, res);

        } else {
            req.setAttribute("errorCode", errorCode);
            req.setAttribute("errorMessage", errorMessage);
            RequestDispatcher rd = req.getRequestDispatcher("index.jsp");
            rd.include(req, res);
        }

    }

}
