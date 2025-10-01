package group4.hrms.controller.auth;

import group4.hrms.dto.response.LoginResponseDTO;
import group4.hrms.service.auth.OAuthService;
import group4.hrms.util.ConfigUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

/**
 * Servlet xử lý Google OAuth callback
 */
@WebServlet(name = "GoogleLoginServlet", urlPatterns = { "/login-google" })
public class GoogleLoginServlet extends HttpServlet {

    private static final String UTF_8 = "UTF-8";
    private static final String DASHBOARD_URL = "/dashboard";

    private OAuthService oAuthService;
    private String googleClientId;
    private String googleClientSecret;
    private String googleRedirectUri;

    @Override
    public void init() throws ServletException {
        super.init();
        this.oAuthService = new OAuthService();

        // Đọc config từ application.properties thông qua ConfigUtil
        this.googleClientId = ConfigUtil.getProperty("google.oauth.client.id");
        this.googleClientSecret = ConfigUtil.getProperty("google.oauth.client.secret");
        this.googleRedirectUri = ConfigUtil.getProperty("google.oauth.redirect.uri");

        // Validate required properties
        ConfigUtil.validateRequiredProperties(
                "google.oauth.client.id",
                "google.oauth.client.secret",
                "google.oauth.redirect.uri");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set encoding
        request.setCharacterEncoding(UTF_8);
        response.setCharacterEncoding(UTF_8);
        response.setContentType("text/html; charset=UTF-8");

        // Lấy authorization code từ Google
        String authCode = request.getParameter("code");
        String error = request.getParameter("error");
        String state = request.getParameter("state");

        if (error != null) {
            // User từ chối hoặc có lỗi từ Google
            String errorMessage = "access_denied".equals(error) ? "Bạn đã từ chối đăng nhập bằng Google"
                    : "Có lỗi xảy ra khi đăng nhập bằng Google: " + error;

            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            return;
        }

        if (authCode == null || authCode.trim().isEmpty()) {
            // Không có authorization code, redirect về Google OAuth
            String googleAuthUrl = oAuthService.createGoogleAuthUrl(
                    googleClientId,
                    googleRedirectUri,
                    "openid email profile",
                    generateState(request));

            response.sendRedirect(googleAuthUrl);
            return;
        }

        // Xử lý OAuth callback
        LoginResponseDTO loginResponse = oAuthService.handleGoogleCallback(
                authCode, googleClientId, googleClientSecret, googleRedirectUri);

        if (loginResponse.isSuccess()) {
            // Đăng nhập thành công
            HttpSession session = request.getSession(true);
            session.setAttribute("userId", loginResponse.getUserId());
            session.setAttribute("username", loginResponse.getUsername());
            session.setAttribute("userFullName", loginResponse.getFullName());
            session.setAttribute("userRole", loginResponse.getRole());
            session.setAttribute("loginMethod", "google");

            // Kiểm tra có redirect URL không
            String redirectUrl = (String) session.getAttribute("redirectAfterLogin");
            if (redirectUrl != null) {
                session.removeAttribute("redirectAfterLogin");
                response.sendRedirect(redirectUrl);
            } else {
                response.sendRedirect(request.getContextPath() + DASHBOARD_URL);
            }
        } else {
            // Đăng nhập thất bại
            request.setAttribute("error", loginResponse.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Redirect POST requests to GET
        doGet(request, response);
    }

    /**
     * Tạo state parameter để bảo mật OAuth flow
     */
    private String generateState(HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        String state = "hrms_" + System.currentTimeMillis();
        session.setAttribute("oauth_state", state);
        return state;
    }

    @Override
    public String getServletInfo() {
        return "Google OAuth Login Servlet cho hệ thống HRMS";
    }
}