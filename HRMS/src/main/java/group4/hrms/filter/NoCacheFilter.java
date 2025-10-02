package group4.hrms.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Filter để ngăn browser cache các trang bảo mật
 * Ngăn user access vào trang đã logout bằng back button
 */
@WebFilter(filterName = "NoCacheFilter", urlPatterns = {
        "/dashboard/*",
        "/auth/login",
        "/admin/*",
        "/api/*"
})
public class NoCacheFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization logic if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Set no-cache headers
        httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        httpResponse.setHeader("Pragma", "no-cache");
        httpResponse.setDateHeader("Expires", 0);

        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String relativePath = requestURI.substring(contextPath.length());

        // Nếu là trang dashboard hoặc protected pages, kiểm tra session
        if (isProtectedPage(relativePath)) {
            HttpSession session = httpRequest.getSession(false);
            if (session == null || session.getAttribute("userId") == null) {
                // Không có session, redirect về login
                httpResponse.sendRedirect(contextPath + "/auth/login");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup logic if needed
    }

    /**
     * Kiểm tra có phải trang bảo mật không
     */
    private boolean isProtectedPage(String path) {
        return path.startsWith("/dashboard") ||
                path.startsWith("/admin") ||
                path.startsWith("/api");
    }
}