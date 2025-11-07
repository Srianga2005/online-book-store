package servlets;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Locale;

public class LanguageFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException { }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        if (request instanceof HttpServletRequest) {
            HttpServletRequest req = (HttpServletRequest) request;
            HttpSession session = req.getSession(false);
            String selected = null;
            if (session != null && session.getAttribute("lang") != null) {
                selected = String.valueOf(session.getAttribute("lang"));
            }
            Locale locale = toLocale(selected);
            request.setAttribute("javax.servlet.jsp.jstl.fmt.locale.request", locale);
        }
        chain.doFilter(request, response);
    }

    private Locale toLocale(String langLabel) {
        if (langLabel == null) return Locale.ENGLISH;
        switch (langLabel) {
            case "हिंदी": return new Locale("hi");
            case "తెలుగు": return new Locale("te");
            case "English":
            default: return Locale.ENGLISH;
        }
    }

    @Override
    public void destroy() { }
}
