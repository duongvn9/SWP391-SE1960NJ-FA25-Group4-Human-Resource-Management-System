package group4.hrms.service.employee;

import group4.hrms.dto.request.CreateAccountRequestDTO;
import group4.hrms.dto.request.UpdateAccountRequestDTO;
import group4.hrms.dto.response.AccountResponseDTO;
import group4.hrms.entity.Account;
import group4.hrms.entity.Department;
import group4.hrms.entity.Role;
import group4.hrms.entity.User;
import group4.hrms.repository.AccountRepository;
import group4.hrms.repository.RoleRepository;
import group4.hrms.repository.DepartmentRepository;
import group4.hrms.repository.employee.UserRepository;
import group4.hrms.util.PasswordUtil;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * Service xử lý Account management
 */
public class AccountManagementService {
    private final AccountRepository accountRepository;
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final DepartmentRepository departmentRepository;

    public AccountManagementService() {
        this.accountRepository = new AccountRepository();
        this.userRepository = new UserRepository();
        this.roleRepository = new RoleRepository();
        this.departmentRepository = new DepartmentRepository();
    }

    // Constructor for testing
    public AccountManagementService(AccountRepository accountRepository, 
                                   UserRepository userRepository,
                                   RoleRepository roleRepository) {
        this.accountRepository = accountRepository;
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.departmentRepository = new DepartmentRepository();
    }

    /**
     * Lấy tất cả accounts với thông tin user và roles
     */
    public List<AccountResponseDTO> getAllAccounts() {
        try {
            List<Account> accounts = accountRepository.findAllWithUserInfo();
            List<AccountResponseDTO> result = new ArrayList<>();

            for (Account account : accounts) {
                AccountResponseDTO dto = buildAccountResponseDTO(account);
                result.add(dto);
            }

            return result;
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi lấy danh sách accounts", e);
        }
    }

    /**
     * Lấy account theo ID
     */
    public Optional<AccountResponseDTO> getAccountById(Long accountId) {
        try {
            Optional<Account> accountOpt = accountRepository.findByIdWithUserInfo(accountId);
            if (accountOpt.isPresent()) {
                AccountResponseDTO dto = buildAccountResponseDTO(accountOpt.get());
                return Optional.of(dto);
            }
            return Optional.empty();
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi lấy thông tin account", e);
        }
    }

    /**
     * Tạo account mới
     */
    public Long createAccount(CreateAccountRequestDTO request) {
        try {
            // Validate input
            validateCreateAccountRequest(request);

            // Kiểm tra username đã tồn tại
            if (accountRepository.existsByUsername(request.getUsername())) {
                throw new IllegalArgumentException("Username đã tồn tại");
            }

            // Tạo User trước
            User newUser = new User();
            newUser.setFullName(request.getFullName());
            newUser.setEmail(request.getEmail());
            if (request.getPhone() != null && !request.getPhone().trim().isEmpty()) {
                newUser.setPhoneNumber(request.getPhone());
            }
            // TODO: Implement department assignment later
            
            Long userId = userRepository.create(newUser);

            // Hash password
            String hashedPassword = PasswordUtil.hashPassword(request.getPassword());

            // Tạo account
            Account account = new Account();
            account.setUserId(userId);
            account.setUsername(request.getUsername());
            account.setPasswordHash(hashedPassword);
            account.setIsActive(request.isActive());

            Long accountId = accountRepository.create(account);

            // Gán roles nếu có
            if (request.getRoleIds() != null && request.getRoleIds().length > 0) {
                roleRepository.assignRolesToAccount(accountId, request.getRoleIds());
            }

            return accountId;
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi tạo account", e);
        }
    }

    /**
     * Cập nhật account
     */
    public boolean updateAccount(UpdateAccountRequestDTO request) {
        try {
            // Validate input
            validateUpdateAccountRequest(request);

            // Kiểm tra account tồn tại
            Optional<Account> accountOpt = accountRepository.findById(request.getAccountId());
            if (accountOpt.isEmpty()) {
                throw new IllegalArgumentException("Không tìm thấy account");
            }

            Account account = accountOpt.get();

            // Kiểm tra username đã tồn tại (ngoại trừ account hiện tại)
            if (!account.getUsername().equals(request.getUsername()) &&
                accountRepository.existsByUsernameExceptId(request.getUsername(), request.getAccountId())) {
                throw new IllegalArgumentException("Username đã tồn tại");
            }

            // Update thông tin
            account.setUsername(request.getUsername());
            account.setIsActive(request.isActive());

            // Update password nếu có
            if (request.getNewPassword() != null && !request.getNewPassword().trim().isEmpty()) {
                String hashedPassword = PasswordUtil.hashPassword(request.getNewPassword());
                account.setPasswordHash(hashedPassword);
            }

            boolean updated = accountRepository.update(account);

            // Update roles
            if (request.getRoleIds() != null) {
                roleRepository.assignRolesToAccount(request.getAccountId(), request.getRoleIds());
            } else {
                roleRepository.removeAllRolesFromAccount(request.getAccountId());
            }

            return updated;
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi cập nhật account", e);
        }
    }

    /**
     * Xóa account (soft delete)
     */
    public boolean deleteAccount(Long accountId) {
        try {
            if (accountId == null) {
                throw new IllegalArgumentException("Account ID không được null");
            }

            // Kiểm tra account tồn tại
            Optional<Account> accountOpt = accountRepository.findById(accountId);
            if (accountOpt.isEmpty()) {
                throw new IllegalArgumentException("Không tìm thấy account");
            }

            // Xóa các roles trước
            roleRepository.removeAllRolesFromAccount(accountId);

            // Soft delete account
            return accountRepository.deleteById(accountId);
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi xóa account", e);
        }
    }

    /**
     * Bật/tắt trạng thái account
     */
    public boolean toggleAccountStatus(Long accountId) {
        try {
            Optional<Account> accountOpt = accountRepository.findById(accountId);
            if (accountOpt.isEmpty()) {
                throw new IllegalArgumentException("Không tìm thấy account");
            }

            Account account = accountOpt.get();
            account.setIsActive(!account.isActive());

            return accountRepository.update(account);
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi thay đổi trạng thái account", e);
        }
    }

    /**
     * Lấy tất cả roles để hiển thị trong form
     */
    public List<Role> getAllRoles() {
        try {
            return roleRepository.findAll();
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi lấy danh sách roles", e);
        }
    }

    /**
     * Lấy tất cả departments để hiển thị trong form
     */
    public List<Department> getAllDepartments() {
        try {
            return departmentRepository.findAll();
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi lấy danh sách departments", e);
        }
    }

    /**
     * Lấy tất cả users chưa có account
     */
    public List<User> getUsersWithoutAccount() {
        try {
            List<User> allUsers = userRepository.findAll();
            return allUsers.stream()
                    .filter(user -> {
                        Optional<Account> accountOpt = accountRepository.findByUserId(user.getId());
                        return accountOpt.isEmpty();
                    })
                    .collect(Collectors.toList());
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi lấy danh sách users chưa có account", e);
        }
    }

    /**
     * Build AccountResponseDTO từ Account entity
     */
    private AccountResponseDTO buildAccountResponseDTO(Account account) {
        // Lấy thông tin user
        Optional<User> userOpt = userRepository.findById(account.getUserId());
        if (userOpt.isEmpty()) {
            return null;
        }

        User user = userOpt.get();

        // Lấy thông tin roles
        List<Role> roles = roleRepository.findByAccountId(account.getId());
        List<AccountResponseDTO.RoleInfo> roleInfos = roles.stream()
                .map(role -> new AccountResponseDTO.RoleInfo(role.getId(), role.getCode(), role.getName()))
                .collect(Collectors.toList());

        // Build DTO
        AccountResponseDTO dto = new AccountResponseDTO();
        dto.setAccountId(account.getId());
        dto.setUserId(user.getId());
        dto.setUsername(account.getUsername());
        dto.setUserFullName(user.getFullName());
        dto.setUserEmail(user.getEmail());
        dto.setUserPhone(user.getPhoneNumber());
        // TODO: Set department and position names (cần query thêm)
        dto.setActive(account.isActive());
        dto.setRoles(roleInfos);
        dto.setCreatedAt(account.getCreatedAt());

        return dto;
    }

    /**
     * Validate CreateAccountRequestDTO
     */
    private void validateCreateAccountRequest(CreateAccountRequestDTO request) {
        if (request == null) {
            throw new IllegalArgumentException("Request không được null");
        }

        if (request.getFullName() == null || request.getFullName().trim().isEmpty()) {
            throw new IllegalArgumentException("Họ và tên không được rỗng");
        }
        
        if (request.getEmail() == null || request.getEmail().trim().isEmpty()) {
            throw new IllegalArgumentException("Email không được rỗng");
        }

        if (request.getUsername() == null || request.getUsername().trim().isEmpty()) {
            throw new IllegalArgumentException("Username không được rỗng");
        }

        if (request.getPassword() == null || request.getPassword().trim().isEmpty()) {
            throw new IllegalArgumentException("Password không được rỗng");
        }

        if (request.getPassword().length() < 6) {
            throw new IllegalArgumentException("Password phải có ít nhất 6 ký tự");
        }

        if (!request.getPassword().equals(request.getConfirmPassword())) {
            throw new IllegalArgumentException("Password xác nhận không khớp");
        }
    }

    /**
     * Validate UpdateAccountRequestDTO
     */
    private void validateUpdateAccountRequest(UpdateAccountRequestDTO request) {
        if (request == null) {
            throw new IllegalArgumentException("Request không được null");
        }

        if (request.getAccountId() == null) {
            throw new IllegalArgumentException("Account ID không được null");
        }

        if (request.getUsername() == null || request.getUsername().trim().isEmpty()) {
            throw new IllegalArgumentException("Username không được rỗng");
        }

        // Validate password nếu có
        if (request.getNewPassword() != null && !request.getNewPassword().trim().isEmpty()) {
            if (request.getNewPassword().length() < 6) {
                throw new IllegalArgumentException("Password phải có ít nhất 6 ký tự");
            }

            if (!request.getNewPassword().equals(request.getConfirmPassword())) {
                throw new IllegalArgumentException("Password xác nhận không khớp");
            }
        }
    }
}