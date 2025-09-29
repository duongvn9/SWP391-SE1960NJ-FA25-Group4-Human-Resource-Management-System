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

        // Hủy session hiện tại
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // Redirect về trang chủ
        response.sendRedirect(request.getContextPath() + "/");
    }

    @Override
    public String getServletInfo() {
        return "Logout Servlet cho hệ thống HRMS";
    }
}