package group4.hrms.entity;

import java.time.LocalDateTime;

/**
 * Entity class cho User
 */
public class User extends BaseEntity {

    private String email;
    private String passwordHash;
    private String fullName;
    private String phoneNumber;
    private UserRole role;
    private UserStatus status;
    private LocalDateTime lastLoginAt;
    private String resetToken;
    private LocalDateTime resetTokenExpiresAt;

    // Enums
    public enum UserRole {
        ADMIN("Admin"),
        HR("HR"),
        MANAGER("Manager"),
        EMPLOYEE("Employee");

        private final String displayName;

        UserRole(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }

    public enum UserStatus {
        ACTIVE("Hoạt động"),
        INACTIVE("Không hoạt động"),
        LOCKED("Bị khóa"),
        PENDING("Chờ kích hoạt");

        private final String displayName;

        UserStatus(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }

    // Constructors
    public User() {
        super();
        this.status = UserStatus.PENDING;
    }

    public User(String email, String fullName) {
        this();
        this.email = email;
        this.fullName = fullName;
    }

    // Getters and Setters
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public UserRole getRole() {
        return role;
    }

    public void setRole(UserRole role) {
        this.role = role;
    }

    public UserStatus getStatus() {
        return status;
    }

    public void setStatus(UserStatus status) {
        this.status = status;
    }

    public LocalDateTime getLastLoginAt() {
        return lastLoginAt;
    }

    public void setLastLoginAt(LocalDateTime lastLoginAt) {
        this.lastLoginAt = lastLoginAt;
    }

    public String getResetToken() {
        return resetToken;
    }

    public void setResetToken(String resetToken) {
        this.resetToken = resetToken;
    }

    public LocalDateTime getResetTokenExpiresAt() {
        return resetTokenExpiresAt;
    }

    public void setResetTokenExpiresAt(LocalDateTime resetTokenExpiresAt) {
        this.resetTokenExpiresAt = resetTokenExpiresAt;
    }

    // Helper methods
    public boolean isActive() {
        return UserStatus.ACTIVE.equals(this.status);
    }

    public boolean isAdmin() {
        return UserRole.ADMIN.equals(this.role);
    }

    public boolean isHR() {
        return UserRole.HR.equals(this.role);
    }

    public boolean isManager() {
        return UserRole.MANAGER.equals(this.role);
    }

    public String getRoleDisplayName() {
        return role != null ? role.getDisplayName() : "";
    }

    public String getStatusDisplayName() {
        return status != null ? status.getDisplayName() : "";
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", email='" + email + '\'' +
                ", fullName='" + fullName + '\'' +
                ", role=" + role +
                ", status=" + status +
                ", createdAt=" + createdAt +
                '}';
    }
}