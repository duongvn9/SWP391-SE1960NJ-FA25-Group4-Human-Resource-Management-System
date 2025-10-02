package group4.hrms.filter;

import group4.hrms.util.CsrfTokenUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Filter để xử lý CSRF protection
 * Áp dụng cho tất cả các POST request
 */
// Tạm thời disable CSRF filter để test login
// @WebFilter(filterName = "CsrfFilter", urlPatterns = {"/*"})
public class CsrfFilter implements Filter {

    private static final String[] CSRF_PROTECTED_METHODS = { "POST", "PUT", "DELETE", "PATCH" };
    private static final String[] CSRF_EXEMPT_PATHS = {
            "/auth/login",
            "/auth/login-google",
            "/auth/logout",
            "/api/",
            "/assets/",
            "/resources/",
            "/"
    };

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization logic if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String method = httpRequest.getMethod();
        String requestURI = httpRequest.getRequestURI();

        // Chỉ áp dụng CSRF protection cho các method cần bảo vệ
        if (isCsrfProtectedMethod(method) && !isCsrfExemptPath(requestURI, httpRequest)) {

            // Validate CSRF token
            if (!CsrfTokenUtil.validateCsrfToken(httpRequest)) {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "CSRF token không hợp lệ");
                return;
            }
        }

        // Thêm CSRF token vào response header cho AJAX requests
        HttpSession session = httpRequest.getSession(false);
        if (session != null) {
            String csrfToken = CsrfTokenUtil.getOrCreateCsrfToken(session);
            if (csrfToken != null) {
                httpResponse.setHeader("X-CSRF-TOKEN", csrfToken);
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup logic if needed
    }

    /**
     * Kiểm tra method có cần CSRF protection không
     */
    private boolean isCsrfProtectedMethod(String method) {
        for (String protectedMethod : CSRF_PROTECTED_METHODS) {
            if (protectedMethod.equalsIgnoreCase(method)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Kiểm tra path có được exempt khỏi CSRF không
     */
    private boolean isCsrfExemptPath(String requestURI, HttpServletRequest request) {
        // Remove context path để lấy relative path
        String contextPath = request.getContextPath();
        String relativePath = requestURI;
        if (!contextPath.isEmpty() && requestURI.startsWith(contextPath)) {
            relativePath = requestURI.substring(contextPath.length());
        }

        for (String exemptPath : CSRF_EXEMPT_PATHS) {
            if (relativePath.equals(exemptPath) || relativePath.startsWith(exemptPath)) {
                return true;
            }
        }
        return false;
    }
}