package group4.hrms.dto.response;

import java.time.LocalDateTime;
import java.util.List;

/**
 * DTO cho response thông tin account
 */
public class AccountResponseDTO {
    private Long accountId;
    private Long userId;
    private String username;
    private String userFullName;
    private String userEmail;
    private String userPhone;
    private String departmentName;
    private String positionName;
    private boolean isActive;
    private List<RoleInfo> roles;
    private LocalDateTime createdAt;

    // Constructors
    public AccountResponseDTO() {}

    public AccountResponseDTO(Long accountId, Long userId, String username, String userFullName,
                            String userEmail, String userPhone, String departmentName, 
                            String positionName, boolean isActive, List<RoleInfo> roles, 
                            LocalDateTime createdAt) {
        this.accountId = accountId;
        this.userId = userId;
        this.username = username;
        this.userFullName = userFullName;
        this.userEmail = userEmail;
        this.userPhone = userPhone;
        this.departmentName = departmentName;
        this.positionName = positionName;
        this.isActive = isActive;
        this.roles = roles;
        this.createdAt = createdAt;
    }

    // Nested class cho role information
    public static class RoleInfo {
        private Long roleId;
        private String roleCode;
        private String roleName;

        public RoleInfo() {}

        public RoleInfo(Long roleId, String roleCode, String roleName) {
            this.roleId = roleId;
            this.roleCode = roleCode;
            this.roleName = roleName;
        }

        // Getters and Setters
        public Long getRoleId() {
            return roleId;
        }

        public void setRoleId(Long roleId) {
            this.roleId = roleId;
        }

        public String getRoleCode() {
            return roleCode;
        }

        public void setRoleCode(String roleCode) {
            this.roleCode = roleCode;
        }

        public String getRoleName() {
            return roleName;
        }

        public void setRoleName(String roleName) {
            this.roleName = roleName;
        }
    }

    // Getters and Setters
    public Long getAccountId() {
        return accountId;
    }

    public void setAccountId(Long accountId) {
        this.accountId = accountId;
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

    public String getUserFullName() {
        return userFullName;
    }

    public void setUserFullName(String userFullName) {
        this.userFullName = userFullName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    public String getPositionName() {
        return positionName;
    }

    public void setPositionName(String positionName) {
        this.positionName = positionName;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public List<RoleInfo> getRoles() {
        return roles;
    }

    public void setRoles(List<RoleInfo> roles) {
        this.roles = roles;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    /**
     * Lấy danh sách tên roles dưới dạng chuỗi
     */
    public String getRoleNames() {
        if (roles == null || roles.isEmpty()) {
            return "Chưa có role";
        }
        return String.join(", ", roles.stream().map(RoleInfo::getRoleName).toList());
    }

    /**
     * Lấy trạng thái hiển thị
     */
    public String getStatusDisplay() {
        return isActive ? "Hoạt động" : "Không hoạt động";
    }

    @Override
    public String toString() {
        return "AccountResponseDTO{" +
                "accountId=" + accountId +
                ", userId=" + userId +
                ", username='" + username + '\'' +
                ", userFullName='" + userFullName + '\'' +
                ", isActive=" + isActive +
                '}';
    }
}