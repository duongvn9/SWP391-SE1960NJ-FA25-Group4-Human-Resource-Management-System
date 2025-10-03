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
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

/**
 * Controller xử lý Overtime Request
 * Quản lý việc tạo, xem và duyệt đơn xin làm thêm giờ
 * 
 * @author Group4
 * @since 1.0
 */
@WebServlet(name = "OvertimeRequestController", urlPatterns = { 
    "/requests/overtime/create",
    "/requests/overtime/submit",
    "/requests/overtime/list",
    "/requests/overtime/view/*"
})
public class OvertimeRequestController extends HttpServlet {
    
    private static final Logger logger = LoggerFactory.getLogger(OvertimeRequestController.class);
    
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
                case "/requests/overtime/create" -> showCreateForm(request, response);
                case "/requests/overtime/list" -> showOvertimeList(request, response);
                default -> {
                    if (path.startsWith("/requests/overtime/view/")) {
                        showOvertimeDetail(request, response);
                    } else {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    }
                }
            }
        } catch (ServletException | IOException e) {
            logger.error("Lỗi xử lý Overtime Request: ", e);
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
            if ("/requests/overtime/submit".equals(path)) {
                submitOvertimeRequest(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (ServletException | IOException e) {
            logger.error("Lỗi submit Overtime Request: ", e);
            request.setAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }
    
    /**
     * Hiển thị form tạo đơn xin làm thêm giờ
     */
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Set current date
        request.setAttribute("currentDate", LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
        
        // Set demo data cho overtime rates
        request.setAttribute("weekdayRate", new BigDecimal("1.5"));
        request.setAttribute("weekendRate", new BigDecimal("2.0"));
        request.setAttribute("holidayRate", new BigDecimal("3.0"));
        request.setAttribute("hourlyWage", new BigDecimal("50000"));
        
        // Forward đến trang tạo đơn
        request.getRequestDispatcher("/WEB-INF/views/requests/overtime/create.jsp").forward(request, response);
    }
    
    /**
     * Xử lý submit đơn xin làm thêm giờ
     */
    private void submitOvertimeRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Lấy thông tin từ form
            String overtimeDate = request.getParameter("overtimeDate");
            String startTime = request.getParameter("startTime");
            String endTime = request.getParameter("endTime");
            String overtimeType = request.getParameter("overtimeType");
            String reason = request.getParameter("reason");
            String taskDescription = request.getParameter("taskDescription");
            
            // Validate input
            if (overtimeDate == null || overtimeDate.trim().isEmpty() ||
                startTime == null || startTime.trim().isEmpty() ||
                endTime == null || endTime.trim().isEmpty() ||
                overtimeType == null || overtimeType.trim().isEmpty() ||
                reason == null || reason.trim().isEmpty()) {
                
                request.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin bắt buộc!");
                showCreateForm(request, response);
                return;
            }
            
            // Validate date and time
            LocalDate date = LocalDate.parse(overtimeDate);
            LocalTime start = LocalTime.parse(startTime);
            LocalTime end = LocalTime.parse(endTime);
            
            if (date.isBefore(LocalDate.now())) {
                request.setAttribute("errorMessage", "Ngày làm thêm giờ không thể trong quá khứ!");
                showCreateForm(request, response);
                return;
            }
            
            if (start.isAfter(end) || start.equals(end)) {
                request.setAttribute("errorMessage", "Thời gian bắt đầu phải nhỏ hơn thời gian kết thúc!");
                showCreateForm(request, response);
                return;
            }
            
            // Calculate overtime hours
            long minutes = java.time.Duration.between(start, end).toMinutes();
            double hours = minutes / 60.0;
            
            if (hours > 8) {
                request.setAttribute("errorMessage", "Số giờ làm thêm không được vượt quá 8 giờ trong 1 ngày!");
                showCreateForm(request, response);
                return;
            }
            
            // TODO: Lưu đơn vào database thông qua Service layer
            
            // Log thông tin
            logger.info("Đơn xin làm thêm giờ mới: {} từ {} đến {}, {} giờ", 
                        overtimeDate, startTime, endTime, hours);
            
            // Redirect với thông báo thành công
            request.getSession().setAttribute("successMessage", 
                String.format("Đơn xin làm thêm giờ đã được gửi thành công! " +
                            "Thời gian: %.1f giờ vào ngày %s. Vui lòng chờ phê duyệt.", 
                            hours, overtimeDate));
            response.sendRedirect(request.getContextPath() + "/requests/overtime/list");
            
        } catch (DateTimeParseException e) {
            request.setAttribute("errorMessage", "Định dạng ngày hoặc giờ không hợp lệ!");
            showCreateForm(request, response);
        } catch (Exception e) {
            logger.error("Lỗi submit đơn xin làm thêm giờ: ", e);
            request.setAttribute("errorMessage", "Có lỗi xảy ra khi gửi đơn: " + e.getMessage());
            showCreateForm(request, response);
        }
    }
    
    /**
     * Hiển thị danh sách đơn xin làm thêm giờ
     */
    private void showOvertimeList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // TODO: Lấy danh sách đơn từ database
        // Tạm thời set dữ liệu demo
        
        request.getRequestDispatcher("/WEB-INF/views/requests/overtime/list.jsp").forward(request, response);
    }
    
    /**
     * Hiển thị chi tiết đơn xin làm thêm giờ
     */
    private void showOvertimeDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        if (pathInfo != null && pathInfo.length() > 1) {
            String requestId = pathInfo.substring(1); // Bỏ dấu "/" đầu
            
            // TODO: Lấy thông tin đơn từ database
            request.setAttribute("requestId", requestId);
        }
        
        request.getRequestDispatcher("/WEB-INF/views/requests/overtime/detail.jsp").forward(request, response);
    }
    
    @Override
    public String getServletInfo() {
        return "Overtime Request Controller cho hệ thống HRMS";
    }
}