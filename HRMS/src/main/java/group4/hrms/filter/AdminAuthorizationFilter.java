package group4.hrms.filter;

import group4.hrms.constants.AppConstants;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

/**
 * Filter để kiểm tra quyền truy cập admin
 */
@WebFilter(urlPatterns = {"/admin/*"})
public class AdminAuthorizationFilter implements Filter {

    private static final Logger logger = LoggerFactory.getLogger(AdminAuthorizationFilter.class);

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // Lấy session
        HttpSession session = httpRequest.getSession(false);
        
        // Kiểm tra đã đăng nhập chưa
        if (session == null || session.getAttribute(AppConstants.SESSION_USER_ID) == null) {
            // Chưa đăng nhập, redirect về login
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }
        
        // Lấy role của user
        String userRole = (String) session.getAttribute(AppConstants.SESSION_USER_ROLE);
        
        // Debug logging - để kiểm tra role thực tế
        logger.info("AdminAuthorizationFilter - UserRole: '{}'", userRole);
        
        // Kiểm tra quyền admin - chấp nhận nhiều định dạng role
        boolean isAdmin = userRole != null && (
            "ADMIN".equalsIgnoreCase(userRole) || 
            "Admin".equals(userRole) ||
            "Administrator".equalsIgnoreCase(userRole) ||
            "System Administrator".equalsIgnoreCase(userRole) ||
            userRole.toLowerCase().contains("admin")
        );
        
        if (!isAdmin) {
            // Không có quyền admin
            httpRequest.setAttribute(AppConstants.REQUEST_ERROR_MESSAGE, 
                "Bạn không có quyền truy cập trang này. Chỉ Admin mới có thể truy cập. " +
                "Role hiện tại: " + userRole);
            httpRequest.getRequestDispatcher("/WEB-INF/views/error/403.jsp")
                .forward(httpRequest, httpResponse);
            return;
        }
        
        // Có quyền admin, tiếp tục xử lý
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}