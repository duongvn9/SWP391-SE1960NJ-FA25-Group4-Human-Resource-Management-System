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

        // Lấy userId từ URL parameter, bắt buộc phải có
        String paramUserId = req.getParameter("userId");
        if (paramUserId == null || paramUserId.isEmpty()) {
            resp.getWriter().write("userId parameter is required");
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        Long userId;
        try {
            userId = Long.valueOf(paramUserId);
        } catch (NumberFormatException e) {
            resp.getWriter().write("Invalid userId parameter");
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        // Lấy danh sách attendance
        List<Attendance> logs = repo.findByUserId(userId);
        req.setAttribute("logs", logs);

        // Forward sang JSP để render
        req.getRequestDispatcher("/WEB-INF/views/attendance_logs.jsp").forward(req, resp);
    }
}
