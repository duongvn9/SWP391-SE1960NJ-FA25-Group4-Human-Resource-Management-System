package group4.hrms.dto.request;

/**
 * DTO cho yêu cầu tạo account mới
 */
public class CreateAccountRequestDTO {
    // User information
    private String fullName;
    private String email;
    private String phone;
    private Long departmentId;
    
    // Account information  
    private String username;
    private String password;
    private String confirmPassword;
    private Long[] roleIds;
    private boolean isActive = true;

    // Constructors
    public CreateAccountRequestDTO() {}

    public CreateAccountRequestDTO(String fullName, String email, String phone, Long departmentId,
                                 String username, String password, String confirmPassword, 
                                 Long[] roleIds, boolean isActive) {
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.departmentId = departmentId;
        this.username = username;
        this.password = password;
        this.confirmPassword = confirmPassword;
        this.roleIds = roleIds;
        this.isActive = isActive;
    }

    // Getters and Setters
    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Long getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(Long departmentId) {
        this.departmentId = departmentId;
    }

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
        return "CreateAccountRequestDTO{" +
                "fullName='" + fullName + '\'' +
                ", email='" + email + '\'' +
                ", username='" + username + '\'' +
                ", isActive=" + isActive +
                '}';
    }
}