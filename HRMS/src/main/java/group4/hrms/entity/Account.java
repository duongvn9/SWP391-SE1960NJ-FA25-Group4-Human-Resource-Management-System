package group4.hrms.entity;

/**
 * Entity đại diện cho bảng accounts
 * Lưu thông tin tài khoản đăng nhập của người dùng
 */
public class Account extends BaseEntity {

    private Long userId;
    private String username;
    private String passwordHash;
    private Boolean isActive;

    // Constructor mặc định
    public Account() {
        super();
        this.isActive = true;
    }

    // Constructor với tham số
    public Account(Long userId, String username, String passwordHash) {
        this();
        this.userId = userId;
        this.username = username;
        this.passwordHash = passwordHash;
    }

    // Getters và Setters cho các trường riêng
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

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public Boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(Boolean active) {
        this.isActive = active;
    }

    // Convenience method
    public boolean isActive() {
        return Boolean.TRUE.equals(isActive);
    }

    @Override
    public String toString() {
        return "Account{" +
                "id=" + id +
                ", userId=" + userId +
                ", username='" + username + '\'' +
                ", isActive=" + isActive +
                ", createdAt=" + createdAt +
                '}';
    }
}