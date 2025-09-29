package group4.hrms.controller.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet xử lý đăng nhập vào hệ thống HRMS
 * Hiển thị form đăng nhập và xử lý authenticate
 */
@WebServlet(name = "LoginServlet", urlPatterns = { "/auth/login" })
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // Kiểm tra nếu đã đăng nhập rồi thì redirect về dashboard
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("userId") != null) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        // Hiển thị trang đăng nhập
        request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // TODO: Validate input và authenticate thông qua Service layer
        // Tạm thời dùng logic demo
        if (isValidLogin(username, password)) {
            // Tạo session mới
            HttpSession session = request.getSession(true);
            session.setAttribute("userId", 1L);
            session.setAttribute("username", username);
            session.setAttribute("userFullName", "Nguyễn Văn Admin");
            session.setAttribute("userRole", "Administrator");

            // Redirect về dashboard
            response.sendRedirect(request.getContextPath() + "/dashboard");
        } else {
            // Đăng nhập thất bại
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
        }
    }

    /**
     * Validate thông tin đăng nhập (logic demo)
     * TODO: Thay thế bằng authentication service thực
     */
    private boolean isValidLogin(String username, String password) {
        // Demo: admin/admin hoặc user/user
        return ("admin".equals(username) && "admin".equals(password)) ||
                ("user".equals(username) && "user".equals(password));
    }

    @Override
    public String getServletInfo() {
        return "Login Servlet cho hệ thống HRMS";
    }
}