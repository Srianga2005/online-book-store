package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//Http Servlet extended class for showing the about information
public class AboutServlet extends HttpServlet {

    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        // Forward to modern About JSP
        RequestDispatcher rd = req.getRequestDispatcher("About.jsp");
        rd.forward(req, res);
    }

}
