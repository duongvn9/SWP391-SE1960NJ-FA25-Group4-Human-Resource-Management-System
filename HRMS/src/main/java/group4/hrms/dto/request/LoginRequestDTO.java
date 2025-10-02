package group4.hrms.dto.request;

/**
 * DTO cho request đăng nhập bằng username/password
 */
public class LoginRequestDTO {

    private String username;
    private String password;
    private String csrfToken;

    // Constructor mặc định
    public LoginRequestDTO() {
    }

    // Constructor với tham số
    public LoginRequestDTO(String username, String password, String csrfToken) {
        this.username = username;
        this.password = password;
        this.csrfToken = csrfToken;
    }

    // Getters và Setters
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCsrfToken() {
        return csrfToken;
    }

    public void setCsrfToken(String csrfToken) {
        this.csrfToken = csrfToken;
    }

    @Override
    public String toString() {
        return "LoginRequestDTO{" +
                "username='" + username + '\'' +
                ", csrfToken='" + csrfToken + '\'' +
                '}';
    }
}