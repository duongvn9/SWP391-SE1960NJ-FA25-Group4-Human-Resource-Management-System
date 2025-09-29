package group4.hrms.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import java.io.IOException;

/**
 * Filter thiết lập encoding UTF-8 cho tất cả request và response
 * Đảm bảo hỗ trợ tiếng Việt trong toàn bộ ứng dụng
 */
@WebFilter(filterName = "EncodingFilter", urlPatterns = { "/*" })
public class EncodingFilter implements Filter {

    private static final String ENCODING = "UTF-8";

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Khởi tạo filter
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        // Set encoding cho request và response
        request.setCharacterEncoding(ENCODING);
        response.setCharacterEncoding(ENCODING);
        response.setContentType("text/html; charset=" + ENCODING);

        // Tiếp tục chuỗi filter
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup khi filter bị hủy
    }
}