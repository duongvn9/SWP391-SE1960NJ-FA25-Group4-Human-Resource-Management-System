package group4.hrms.controller.requests;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

/**
 * Controller xử lý Leave Request
 * Quản lý việc tạo, xem và duyệt đơn xin nghỉ phép
 * 
 * @author Group4
 * @since 1.0
 */
@WebServlet(name = "LeaveRequestController", urlPatterns = { 
    "/requests/leave/create",
    "/requests/leave/submit",
    "/requests/leave/list",
    "/requests/leave/view/*"
})
public class LeaveRequestController extends HttpServlet {
    
    private static final Logger logger = LoggerFactory.getLogger(LeaveRequestController.class);
    
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
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }
        
        String path = request.getServletPath();
        
        try {
            switch (path) {
                case "/requests/leave/create":
                    showCreateForm(request, response);
                    break;
                case "/requests/leave/list":
                    showLeaveList(request, response);
                    break;
                default:
                    if (path.startsWith("/requests/leave/view/")) {
                        showLeaveDetail(request, response);
                    } else {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    }
            }
        } catch (Exception e) {
            logger.error("Lỗi xử lý Leave Request: ", e);
            request.setAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Set encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        // Kiểm tra session đăng nhập
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }
        
        String path = request.getServletPath();
        
        try {
            if ("/requests/leave/submit".equals(path)) {
                submitLeaveRequest(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            logger.error("Lỗi submit Leave Request: ", e);
            request.setAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }
    
    /**
     * Hiển thị form tạo đơn xin nghỉ phép
     */
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Set demo data cho leave balance
        request.setAttribute("annualLeaveBalance", new BigDecimal("15.5"));
        request.setAttribute("sickLeaveBalance", new BigDecimal("8.0"));
        request.setAttribute("personalLeaveBalance", new BigDecimal("3.0"));
        
        // Set current date
        request.setAttribute("currentDate", LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
        
        // Forward đến trang tạo đơn
        request.getRequestDispatcher("/WEB-INF/views/requests/leave/create.jsp").forward(request, response);
    }
    
    /**
     * Xử lý submit đơn xin nghỉ phép
     */
    private void submitLeaveRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Lấy thông tin từ form
            String leaveType = request.getParameter("leaveType");
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            String halfDayType = request.getParameter("halfDayType");
            String reason = request.getParameter("reason");
            String emergencyContact = request.getParameter("emergencyContact");
            String workHandover = request.getParameter("workHandover");
            
            // Validate input
            if (leaveType == null || leaveType.trim().isEmpty() ||
                startDate == null || startDate.trim().isEmpty() ||
                endDate == null || endDate.trim().isEmpty() ||
                reason == null || reason.trim().isEmpty()) {
                
                request.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin bắt buộc!");
                showCreateForm(request, response);
                return;
            }
            
            // Validate dates
            LocalDate start = LocalDate.parse(startDate);
            LocalDate end = LocalDate.parse(endDate);
            
            if (start.isAfter(end)) {
                request.setAttribute("errorMessage", "Ngày bắt đầu không thể sau ngày kết thúc!");
                showCreateForm(request, response);
                return;
            }
            
            if (start.isBefore(LocalDate.now())) {
                request.setAttribute("errorMessage", "Ngày bắt đầu không thể trong quá khứ!");
                showCreateForm(request, response);
                return;
            }
            
            // TODO: Lưu đơn vào database thông qua Service layer
            
            // Log thông tin
            logger.info("Đơn xin nghỉ phép mới: {} - {} đến {}", leaveType, startDate, endDate);
            
            // Redirect với thông báo thành công
            request.getSession().setAttribute("successMessage", 
                "Đơn xin nghỉ phép đã được gửi thành công! Vui lòng chờ phê duyệt.");
            response.sendRedirect(request.getContextPath() + "/requests/leave/list");
            
        } catch (DateTimeParseException e) {
            request.setAttribute("errorMessage", "Định dạng ngày không hợp lệ!");
            showCreateForm(request, response);
        } catch (Exception e) {
            logger.error("Lỗi submit đơn xin nghỉ phép: ", e);
            request.setAttribute("errorMessage", "Có lỗi xảy ra khi gửi đơn: " + e.getMessage());
            showCreateForm(request, response);
        }
    }
    
    /**
     * Hiển thị danh sách đơn xin nghỉ phép
     */
    private void showLeaveList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // TODO: Lấy danh sách đơn từ database
        // Tạm thời set dữ liệu demo
        
        request.getRequestDispatcher("/WEB-INF/views/requests/leave/list.jsp").forward(request, response);
    }
    
    /**
     * Hiển thị chi tiết đơn xin nghỉ phép
     */
    private void showLeaveDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        if (pathInfo != null && pathInfo.length() > 1) {
            String requestId = pathInfo.substring(1); // Bỏ dấu "/" đầu
            
            // TODO: Lấy thông tin đơn từ database
            request.setAttribute("requestId", requestId);
        }
        
        request.getRequestDispatcher("/WEB-INF/views/requests/leave/detail.jsp").forward(request, response);
    }
    
    @Override
    public String getServletInfo() {
        return "Leave Request Controller cho hệ thống HRMS";
    }
}