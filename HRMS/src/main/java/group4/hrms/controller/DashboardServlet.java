package group4.hrms.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet điều khiển trang dashboard chính của hệ thống HRMS
 * Hiển thị tổng quan thống kê và các thông tin quan trọng
 * Yêu cầu đăng nhập để truy cập
 */
@WebServlet(name = "DashboardServlet", urlPatterns = { "/dashboard", "/dashboard/" })
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // Kiểm tra session đăng nhập
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            // Chưa đăng nhập, redirect về trang login
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        // Lấy thông tin từ session (nếu có)
        String userFullName = (String) session.getAttribute("userFullName");
        String userRole = (String) session.getAttribute("userRole");

        // Set default nếu chưa có dữ liệu
        if (userFullName == null) {
            userFullName = "Admin User";
            session.setAttribute("userFullName", userFullName);
        }
        if (userRole == null) {
            userRole = "Administrator";
            session.setAttribute("userRole", userRole);
        }

        // TODO: Lấy dữ liệu thống kê từ database thông qua Service layer
        // Tạm thời dùng dữ liệu demo
        setDashboardStats(request);

        // Forward đến trang dashboard JSP
        request.getRequestDispatcher("/WEB-INF/views/dashboard/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * Set các thống kê demo cho dashboard
     * TODO: Thay thế bằng dữ liệu thực từ database
     */
    private void setDashboardStats(HttpServletRequest request) {
        // Thống kê nhân viên
        request.setAttribute("totalEmployees", 156);
        request.setAttribute("presentToday", 142);
        request.setAttribute("onLeaveToday", 8);
        request.setAttribute("absentToday", 6);

        // TODO: Thêm các thống kê khác từ Service layer
        // - Dữ liệu biểu đồ chấm công 7 ngày
        // - Thông báo gần đây từ database
        // - Hoạt động gần đây từ audit log
    }

    @Override
    public String getServletInfo() {
        return "Dashboard Servlet cho hệ thống HRMS";
    }
}