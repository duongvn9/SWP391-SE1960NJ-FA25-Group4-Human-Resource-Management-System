package group4.hrms.controller;

import java.io.IOException;
import java.util.List;

import group4.hrms.entity.Attendance;
import group4.hrms.service.AttendanceExcelReader;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/uploadExcel")
@MultipartConfig
public class UploadExcelServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/uploadExcel.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("preview".equals(action)) {
            // Người dùng upload file để xem trước
            Part filePart = request.getPart("excelFile");
            if (filePart != null) {
                try {
                    List<Attendance> previewData = AttendanceExcelReader.readFromExcel(filePart.getInputStream());
                    request.getSession().setAttribute("previewData", previewData);
                    request.setAttribute("previewData", previewData);
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("message", "Lỗi khi đọc file Excel: " + e.getMessage());
                }
            } else {
                request.setAttribute("message", "Không có file nào được chọn!");
            }
            request.getRequestDispatcher("/WEB-INF/views/uploadExcel.jsp").forward(request, response);

        } else if ("save".equals(action)) {
            // Người dùng confirm để lưu DB
            List<Attendance> previewData = (List<Attendance>) request.getSession().getAttribute("previewData");
            if (previewData != null && !previewData.isEmpty()) {
                try {
                    AttendanceExcelReader.saveToDB(previewData);
                    request.getSession().removeAttribute("previewData");
                    request.setAttribute("message", "Import thành công dữ liệu từ Excel!");
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("message", "Import thất bại: " + e.getMessage());
                }
            } else {
                request.setAttribute("message", "Không có dữ liệu để lưu!");
            }
            request.getRequestDispatcher("/WEB-INF/views/uploadExcel.jsp").forward(request, response);
        }
    }
}
