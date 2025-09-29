package group4.hrms.dto.response;

import group4.hrms.entity.User;

/**
 * DTO cho login response
 */
public class LoginResponse {

    private boolean success;
    private String message;
    private UserData user;
    private String redirectUrl;

    // Nested class cho user data
    public static class UserData {
        private Long id;
        private String email;
        private String fullName;
        private String role;
        private String status;

        public UserData() {
        }

        public UserData(User user) {
            this.id = user.getId();
            this.email = user.getEmail();
            this.fullName = user.getFullName();
            this.role = user.getRoleDisplayName();
            this.status = user.getStatusDisplayName();
        }

        // Getters and Setters
        public Long getId() {
            return id;
        }

        public void setId(Long id) {
            this.id = id;
        }

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
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

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
        }
    }

    // Constructors
    public LoginResponse() {
    }

    public LoginResponse(boolean success, String message) {
        this.success = success;
        this.message = message;
    }

    public static LoginResponse success(User user, String redirectUrl) {
        LoginResponse response = new LoginResponse(true, "Đăng nhập thành công");
        response.setUser(new UserData(user));
        response.setRedirectUrl(redirectUrl);
        return response;
    }

    public static LoginResponse failure(String message) {
        return new LoginResponse(false, message);
    }

    // Getters and Setters
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

    public UserData getUser() {
        return user;
    }

    public void setUser(UserData user) {
        this.user = user;
    }

    public String getRedirectUrl() {
        return redirectUrl;
    }

    public void setRedirectUrl(String redirectUrl) {
        this.redirectUrl = redirectUrl;
    }

    @Override
    public String toString() {
        return "LoginResponse{" +
                "success=" + success +
                ", message='" + message + '\'' +
                ", redirectUrl='" + redirectUrl + '\'' +
                '}';
    }
}