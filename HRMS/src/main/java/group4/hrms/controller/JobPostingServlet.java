/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package group4.hrms.controller;

import group4.hrms.service.JobPostingService;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import group4.hrms.entity.JobPosting;

/**
 *
 * @author ADMIN
 */
@WebServlet(name="JobPostingServlet", urlPatterns={"/job-posting/create"})
public class JobPostingServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
     private final JobPostingService service = new JobPostingService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Check login
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Check role
        String userRole = (String) session.getAttribute("userRole");
        if (!"MANAGER".equals(userRole) && !"HR".equals(userRole)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập.");
            return;
        }

        // Forward tới form
        req.getRequestDispatcher("/WEB-INF/views/job_posting_form.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Check login
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Check role
        String userRole = (String) session.getAttribute("userRole");
        if (!"MANAGER".equals(userRole) && !"HR".equals(userRole)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền thực hiện.");
            return;
        }

        // Lấy username từ session
        String username = (String) session.getAttribute("username");

        // Khởi tạo JobPosting đúng thứ tự
        JobPosting job = new JobPosting();
        job.setRequestId(req.getParameter("requestId") != null && !req.getParameter("requestId").isEmpty()
                ? Long.parseLong(req.getParameter("requestId")) : null);
        job.setTitle(req.getParameter("title"));
        job.setDescription(req.getParameter("description"));
        job.setCriteria(req.getParameter("criteria"));
        job.setChannel(req.getParameter("channel"));
        job.setStatus("DRAFT");
        job.setHeadcount(req.getParameter("headcount") != null && !req.getParameter("headcount").isEmpty()
                ? Integer.parseInt(req.getParameter("headcount")) : null);
        job.setCreatedAt(LocalDateTime.now());
        job.setUpdatedAt(LocalDateTime.now());
        job.setCreatedBy(username); 

        // Validate
        String error = service.validate(job);
        if (error != null) {
            req.setAttribute("error", error);
            req.getRequestDispatcher("/WEB-INF/views/job_posting_form.jsp").forward(req, resp);
            return;
        }
        // Lưu JobPosting
        boolean success = service.createJobPosting(job);
        if (success) {
            resp.sendRedirect(req.getContextPath() + "/dashboard?msg=success");
        } else {
            req.setAttribute("error", "Lưu Job Posting thất bại. Vui lòng thử lại.");
            req.getRequestDispatcher("/WEB-INF/views/job_posting_form.jsp").forward(req, resp);
        }
    }

}
