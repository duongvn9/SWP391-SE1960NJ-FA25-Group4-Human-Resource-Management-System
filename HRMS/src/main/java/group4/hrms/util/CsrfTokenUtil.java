package group4.hrms.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.security.SecureRandom;
import java.util.Base64;

/**
 * Utility class để xử lý CSRF token
 */
public final class CsrfTokenUtil {

    private static final String CSRF_TOKEN_SESSION_KEY = "_csrf_token";
    private static final String CSRF_TOKEN_PARAMETER = "_csrf_token";
    private static final String CSRF_TOKEN_HEADER = "X-CSRF-TOKEN";
    private static final int TOKEN_LENGTH = 32;
    private static final SecureRandom secureRandom = new SecureRandom();

    // Private constructor để ngăn instantiation
    private CsrfTokenUtil() {
        throw new UnsupportedOperationException("Utility class không thể được khởi tạo");
    }

    /**
     * Tạo CSRF token mới và lưu vào session
     * 
     * @param session HTTP session
     * @return CSRF token
     */
    public static String generateCsrfToken(HttpSession session) {
        byte[] tokenBytes = new byte[TOKEN_LENGTH];
        secureRandom.nextBytes(tokenBytes);
        String token = Base64.getUrlEncoder().withoutPadding().encodeToString(tokenBytes);

        session.setAttribute(CSRF_TOKEN_SESSION_KEY, token);
        return token;
    }

    /**
     * Lấy CSRF token từ session
     * 
     * @param session HTTP session
     * @return CSRF token hoặc null nếu không có
     */
    public static String getCsrfToken(HttpSession session) {
        if (session == null) {
            return null;
        }
        return (String) session.getAttribute(CSRF_TOKEN_SESSION_KEY);
    }

    /**
     * Xác thực CSRF token từ request
     * 
     * @param request HTTP request
     * @return true nếu token hợp lệ
     */
    public static boolean validateCsrfToken(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return false;
        }

        String sessionToken = getCsrfToken(session);
        if (sessionToken == null) {
            return false;
        }

        // Lấy token từ parameter hoặc header
        String requestToken = request.getParameter(CSRF_TOKEN_PARAMETER);
        if (requestToken == null) {
            requestToken = request.getHeader(CSRF_TOKEN_HEADER);
        }

        return sessionToken.equals(requestToken);
    }

    /**
     * Xóa CSRF token khỏi session
     * 
     * @param session HTTP session
     */
    public static void removeCsrfToken(HttpSession session) {
        if (session != null) {
            session.removeAttribute(CSRF_TOKEN_SESSION_KEY);
        }
    }

    /**
     * Tạo token mới nếu chưa có trong session
     * 
     * @param session HTTP session
     * @return CSRF token
     */
    public static String getOrCreateCsrfToken(HttpSession session) {
        if (session == null) {
            return null;
        }

        String token = getCsrfToken(session);
        if (token == null) {
            token = generateCsrfToken(session);
        }
        return token;
    }
}