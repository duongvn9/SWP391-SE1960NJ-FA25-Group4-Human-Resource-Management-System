package group4.hrms.controller;

import java.io.IOException;

import group4.hrms.entity.Attendance;
import group4.hrms.repository.AttendanceRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/attendance/appeal")
public class AttendanceAppealServlet extends HttpServlet {

    private final AttendanceRepository repo = new AttendanceRepository();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Lấy logId từ parameter
        String logIdStr = req.getParameter("logId");
        if (logIdStr == null || logIdStr.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "logId is required");
            return;
        }

        Long logId;
        try {
            logId = Long.valueOf(logIdStr);
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid logId");
            return;
        }

        // Lấy bản ghi Attendance theo logId
        Attendance log = repo.findById(logId);
        if (log == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Attendance log not found");
            return;
        }

        // Lấy thông tin nhân viên từ session
        Long userId = (Long) req.getSession().getAttribute("userId");
        String userName = (String) req.getSession().getAttribute("username");
        if (userId == null || userName == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Set các attribute cho JSP
        req.setAttribute("log", log);
        req.setAttribute("userId", userId);
        req.setAttribute("userName", userName);

        // Forward sang JSP form kháng nghị
        req.getRequestDispatcher("/WEB-INF/views/attendanceAppeal.jsp").forward(req, resp);
    }
}
