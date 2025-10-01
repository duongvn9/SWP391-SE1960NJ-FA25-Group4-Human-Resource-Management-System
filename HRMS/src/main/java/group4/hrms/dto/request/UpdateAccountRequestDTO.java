package group4.hrms.dto.request;

/**
 * DTO cho yêu cầu cập nhật account
 */
public class UpdateAccountRequestDTO {
    private Long accountId;
    private String username;
    private String newPassword;
    private String confirmPassword;
    private Long[] roleIds;
    private boolean isActive;

    // Constructors
    public UpdateAccountRequestDTO() {}

    public UpdateAccountRequestDTO(Long accountId, String username, String newPassword, 
                                 String confirmPassword, Long[] roleIds, boolean isActive) {
        this.accountId = accountId;
        this.username = username;
        this.newPassword = newPassword;
        this.confirmPassword = confirmPassword;
        this.roleIds = roleIds;
        this.isActive = isActive;
    }

    // Getters and Setters
    public Long getAccountId() {
        return accountId;
    }

    public void setAccountId(Long accountId) {
        this.accountId = accountId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getNewPassword() {
        return newPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public Long[] getRoleIds() {
        return roleIds;
    }

    public void setRoleIds(Long[] roleIds) {
        this.roleIds = roleIds;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    @Override
    public String toString() {
        return "UpdateAccountRequestDTO{" +
                "accountId=" + accountId +
                ", username='" + username + '\'' +
                ", isActive=" + isActive +
                '}';
    }
}