package group4.hrms.controller.auth;

import group4.hrms.dto.request.LoginRequestDTO;
import group4.hrms.dto.response.LoginResponseDTO;
import group4.hrms.service.auth.AuthenticationService;
import group4.hrms.util.CsrfTokenUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet xử lý đăng nhập vào hệ thống HRMS Hiển thị form đăng nhập và xử lý
 * authenticate
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/auth/login"})
public class LoginServlet extends HttpServlet {

    private AuthenticationService authenticationService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.authenticationService = new AuthenticationService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // Kiểm tra nếu đã đăng nhập rồi thì redirect về dashboard
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("userId") != null) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        // Tạo CSRF token cho form
        session = request.getSession(true);
        String csrfToken = CsrfTokenUtil.getOrCreateCsrfToken(session);
        request.setAttribute("csrfToken", csrfToken);

        // Hiển thị trang đăng nhập
        request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Tạo login request DTO (không cần CSRF token khi filter disabled)
        LoginRequestDTO loginRequest = new LoginRequestDTO(username, password, null);

        // Authenticate
        LoginResponseDTO loginResponse = authenticationService.authenticate(loginRequest);

        if (loginResponse.isSuccess()) {
            // Đăng nhập thành công
            HttpSession session = request.getSession(true);
            session.setAttribute("userId", loginResponse.getUserId());
            session.setAttribute("username", loginResponse.getUsername());
            session.setAttribute("userFullName", loginResponse.getFullName());
            session.setAttribute("userRole", loginResponse.getRole());
            // Kiểm tra có redirect URL không
            String redirectUrl = (String) session.getAttribute("redirectAfterLogin");
            if (redirectUrl != null) {
                session.removeAttribute("redirectAfterLogin");
                response.sendRedirect(redirectUrl);
            } else {
                response.sendRedirect(request.getContextPath() + loginResponse.getRedirectUrl());
            }
        } else {
            // Đăng nhập thất bại
            request.setAttribute("error", loginResponse.getMessage());

            // Tạo lại CSRF token
            HttpSession session = request.getSession(true);
            String csrfToken2 = CsrfTokenUtil.getOrCreateCsrfToken(session);
            request.setAttribute("csrfToken", csrfToken2);

            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Login Servlet cho hệ thống HRMS";
    }
}
