package group4.hrms.controller;

import java.io.IOException;
import java.util.List;

import group4.hrms.entity.Attendance;
import group4.hrms.repository.AttendanceRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/attendance/logs")
public class ViewAttendanceLogServlet extends HttpServlet {

    private final AttendanceRepository repo = new AttendanceRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Lấy userId từ session
        Long userId = (Long) req.getSession().getAttribute("userId");

        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Lấy danh sách attendance log của user
        List<Attendance> logs = repo.findByUserId(userId);
        req.setAttribute("logs", logs);

        // Forward sang JSP
        req.getRequestDispatcher("/WEB-INF/views/attendance_logs.jsp").forward(req, resp);
    }
}
