package group4.hrms.dto.response;

/**
 * DTO cho response của quá trình đăng nhập
 */
public class LoginResponseDTO {

    private boolean success;
    private String message;
    private Long userId;
    private String username;
    private String fullName;
    private String role;
    private String redirectUrl;

    // Constructor mặc định
    public LoginResponseDTO() {
    }

    // Constructor cho trường hợp thành công
    public LoginResponseDTO(boolean success, Long userId, String username, String fullName, String role,
            String redirectUrl) {
        this.success = success;
        this.userId = userId;
        this.username = username;
        this.fullName = fullName;
        this.role = role;
        this.redirectUrl = redirectUrl;
        this.message = success ? "Đăng nhập thành công" : null;
    }

    // Constructor cho trường hợp thất bại
    public LoginResponseDTO(boolean success, String message) {
        this.success = success;
        this.message = message;
    }

    // Getters và Setters
    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getRedirectUrl() {
        return redirectUrl;
    }

    public void setRedirectUrl(String redirectUrl) {
        this.redirectUrl = redirectUrl;
    }

    @Override
    public String toString() {
        return "LoginResponseDTO{" +
                "success=" + success +
                ", message='" + message + '\'' +
                ", userId=" + userId +
                ", username='" + username + '\'' +
                ", fullName='" + fullName + '\'' +
                ", role='" + role + '\'' +
                ", redirectUrl='" + redirectUrl + '\'' +
                '}';
    }
}