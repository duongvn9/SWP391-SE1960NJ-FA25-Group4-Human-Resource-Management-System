package group4.hrms.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Filter kiểm tra authentication cho các trang yêu cầu đăng nhập
 * Áp dụng cho tất cả URL trừ trang chủ, login và các tài nguyên tĩnh
 */
@WebFilter(filterName = "AuthenticationFilter", urlPatterns = {
        "/dashboard/*",
        "/identity/*",
        "/attendance/*",
        "/payroll/*",
        "/leave/*",
        "/recruitment/*",
        "/contracts/*",
        "/reports/*",
        "/system/*"
})
public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Khởi tạo filter
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Lấy session hiện tại (không tạo mới)
        HttpSession session = httpRequest.getSession(false);

        // Kiểm tra xem user đã đăng nhập chưa
        boolean isLoggedIn = (session != null && session.getAttribute("userId") != null);

        if (isLoggedIn) {
            // Đã đăng nhập, cho phép tiếp tục
            chain.doFilter(request, response);
        } else {
            // Chưa đăng nhập, redirect về trang login
            String loginURL = httpRequest.getContextPath() + "/auth/login";
            httpResponse.sendRedirect(loginURL);
        }
    }

    @Override
    public void destroy() {
        // Cleanup khi filter bị hủy
    }
}