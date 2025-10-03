package group4.hrms.controller;

import group4.hrms.entity.RecruitmentRequest;
import group4.hrms.service.RecruitmentRequestService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Date;

@WebServlet(name = "RecruitmentRequestCreateServlet", urlPatterns = {"/recruitment-request/form", "/recruitment-request/create"})
public class RecruitmentRequestCreateServlet extends HttpServlet {

    private final RecruitmentRequestService service = new RecruitmentRequestService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy role từ session
        String userRole = (String) req.getSession().getAttribute("userRole");
        if (!"MANAGER".equals(userRole)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập.");
            return;
        }

        // Forward đến form tạo yêu cầu tuyển dụng
        req.getRequestDispatcher("/WEB-INF/views/recruitment_form.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy role từ session
        String userRole = (String) req.getSession().getAttribute("userRole");
        if (!"MANAGER".equals(userRole)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền thực hiện.");
            return;
        }

        // Lấy dữ liệu từ form
        String jobTitle = req.getParameter("jobTitle");
        String headcountStr = req.getParameter("headcount");
        String budgetStr = req.getParameter("budget");
        String description = req.getParameter("description");

        int headcount = 0;
        double budget = 0;
        try { headcount = Integer.parseInt(headcountStr); } catch (NumberFormatException ignored) {}
        try { budget = Double.parseDouble(budgetStr); } catch (NumberFormatException ignored) {}

        HttpSession session = req.getSession();
        Long userId = (Long) session.getAttribute("userId");
        Long deptId = (Long) session.getAttribute("departmentId");

        if (userId == null) userId = 0L;
        if (deptId == null) deptId = 0L;

        // Tạo entity RecruitmentRequest
        RecruitmentRequest request = new RecruitmentRequest();
        request.setRequesterId(userId);
        request.setDepartmentId(deptId);
        request.setJobTitle(jobTitle);
        request.setHeadcount(headcount);
        request.setBudget(budget);
        request.setDescription(description);
        request.setStatus("PENDING");       // trạng thái mặc định
        request.setCreatedAt(new Date());
        request.setUpdatedAt(new Date());

        // Validate
        String error = service.validate(request);
        if (error != null) {
            req.setAttribute("error", error);
            req.getRequestDispatcher("/WEB-INF/views/recruitment_form.jsp").forward(req, resp);
            return;
        }

        // Lưu request
        long id = service.createRequest(request);
        if (id > 0) {
            // Redirect về dashboard với thông báo thành công
            resp.sendRedirect(req.getContextPath() + "/dashboard?msg=success");
        } else {
            req.setAttribute("error", "Lưu yêu cầu thất bại. Vui lòng thử lại.");
            req.getRequestDispatcher("/WEB-INF/views/recruitment_form.jsp").forward(req, resp);
        }
    }
}
