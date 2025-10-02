package group4.hrms.controller;

import java.io.IOException;

import group4.hrms.util.AttendanceExcelReader;
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

        Part filePart = request.getPart("excelFile");

        if (filePart != null) {
            try {
                AttendanceExcelReader.readAndSaveToDB(filePart.getInputStream());
                request.setAttribute("message", "Import thành công dữ liệu từ Excel!");
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("message", "Import thất bại: " + e.getMessage());
            }
        } else {
            request.setAttribute("message", "Không có file nào được chọn!");
        }

        request.getRequestDispatcher("/WEB-INF/views/uploadExcel.jsp").forward(request, response);
    }
}
