package group4.hrms.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet điều khiển trang Contact của hệ thống HRMS
 */
@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set page title
        request.setAttribute("pageTitle", "Liên hệ - HRMS");
        request.setAttribute("pageName", "contact");

        // Forward to contact page
        request.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        // Basic validation
        if (name == null || email == null || message == null ||
                name.trim().isEmpty() || email.trim().isEmpty() || message.trim().isEmpty()) {

            request.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin bắt buộc.");
            request.setAttribute("pageTitle", "Liên hệ - HRMS");
            request.setAttribute("pageName", "contact");
            request.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(request, response);
            return;
        }

        // TODO: Process contact form (send email, save to database, etc.)
        // For now, just show success message
        request.setAttribute("successMessage",
                "Cảm ơn bạn đã liên hệ! Chúng tôi sẽ phản hồi trong thời gian sớm nhất.");
        request.setAttribute("pageTitle", "Liên hệ - HRMS");
        request.setAttribute("pageName", "contact");

        request.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(request, response);
    }
}