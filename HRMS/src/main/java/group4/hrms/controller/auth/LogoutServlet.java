package group4.hrms.controller.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet xử lý đăng xuất khỏi hệ thống HRMS
 * Hủy session và redirect về trang chủ
 */
@WebServlet(name = "LogoutServlet", urlPatterns = { "/auth/logout" })
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processLogout(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processLogout(request, response);
    }

    private void processLogout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        // Set headers để ngăn browser cache
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        // Hủy session hiện tại
        HttpSession session = request.getSession(false);
        if (session != null) {
            // Xóa tất cả attributes trước khi invalidate
            session.removeAttribute("userId");
            session.removeAttribute("username");
            session.removeAttribute("userFullName");
            session.removeAttribute("userRole");
            session.removeAttribute("loginMethod");

            // Invalidate session
            session.invalidate();
        }

        // Redirect về trang chủ với message
        response.sendRedirect(request.getContextPath() + "/?logout=true");
    }

    @Override
    public String getServletInfo() {
        return "Logout Servlet cho hệ thống HRMS";
    }
}