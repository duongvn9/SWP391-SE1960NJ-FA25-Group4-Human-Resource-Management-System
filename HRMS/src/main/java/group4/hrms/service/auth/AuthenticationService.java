package group4.hrms.service.auth;

import group4.hrms.dto.request.LoginRequestDTO;
import group4.hrms.dto.response.LoginResponseDTO;
import group4.hrms.entity.Account;
import group4.hrms.entity.User;
import group4.hrms.repository.AccountRepository;
import group4.hrms.repository.employee.UserRepository;
import group4.hrms.util.PasswordUtil;

import java.util.Optional;

/**
 * Service xử lý authentication
 */
public class AuthenticationService {

    private final AccountRepository accountRepository;
    private final UserRepository userRepository;

    public AuthenticationService() {
        this.accountRepository = new AccountRepository();
        this.userRepository = new UserRepository();
    }

    // Constructor cho testing
    public AuthenticationService(AccountRepository accountRepository, UserRepository userRepository) {
        this.accountRepository = accountRepository;
        this.userRepository = userRepository;
    }

    /**
     * Xác thực đăng nhập bằng username/password
     * 
     * @param loginRequest thông tin đăng nhập
     * @return LoginResponseDTO
     */
    public LoginResponseDTO authenticate(LoginRequestDTO loginRequest) {
        try {
            // Validate input
            if (loginRequest.getUsername() == null || loginRequest.getUsername().trim().isEmpty()) {
                return new LoginResponseDTO(false, "Tên đăng nhập không được rỗng");
            }

            if (loginRequest.getPassword() == null || loginRequest.getPassword().trim().isEmpty()) {
                return new LoginResponseDTO(false, "Mật khẩu không được rỗng");
            }

            // Tìm account theo username
            Optional<Account> accountOpt = accountRepository.findByUsername(loginRequest.getUsername().trim());
            if (accountOpt.isEmpty()) {
                return new LoginResponseDTO(false, "Tên đăng nhập hoặc mật khẩu không đúng");
            }

            Account account = accountOpt.get();

            // Kiểm tra account có active không
            if (!account.isActive()) {
                return new LoginResponseDTO(false, "Tài khoản đã bị khóa. Vui lòng liên hệ quản trị viên");
            }

            // Kiểm tra password
            if (account.getPasswordHash() == null ||
                    !PasswordUtil.verifyPassword(loginRequest.getPassword(), account.getPasswordHash())) {
                return new LoginResponseDTO(false, "Tên đăng nhập hoặc mật khẩu không đúng");
            }

            // Lấy thông tin user
            Optional<User> userOpt = userRepository.findById(account.getUserId());
            if (userOpt.isEmpty()) {
                return new LoginResponseDTO(false, "Không tìm thấy thông tin người dùng");
            }

            User user = userOpt.get();

            // Tạo response thành công
            return new LoginResponseDTO(
                    true,
                    user.getId(),
                    account.getUsername(),
                    user.getFullName(),
                    getUserRole(user), // Cần implement method này
                    "/dashboard");

        } catch (Exception e) {
            // Log lỗi nếu cần
            return new LoginResponseDTO(false, "Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau");
        }
    }

    /**
     * Tạo tài khoản mới
     * 
     * @param userId        ID của user
     * @param username      tên đăng nhập
     * @param plainPassword mật khẩu gốc
     * @return Account mới tạo
     */
    public Account createAccount(Long userId, String username, String plainPassword) {
        // Validate input
        if (userId == null) {
            throw new IllegalArgumentException("User ID không được null");
        }

        if (username == null || username.trim().isEmpty()) {
            throw new IllegalArgumentException("Username không được rỗng");
        }

        if (plainPassword == null || plainPassword.trim().isEmpty()) {
            throw new IllegalArgumentException("Password không được rỗng");
        }

        // Kiểm tra username đã tồn tại chưa
        if (accountRepository.existsByUsername(username.trim())) {
            throw new IllegalArgumentException("Tên đăng nhập đã tồn tại");
        }

        // Validate password strength
        String passwordError = PasswordUtil.validatePassword(plainPassword);
        if (passwordError != null) {
            throw new IllegalArgumentException(passwordError);
        }

        // Hash password
        String hashedPassword = PasswordUtil.hashPassword(plainPassword);

        // Tạo account
        Account account = new Account(userId, username.trim(), hashedPassword);
        Long accountId = accountRepository.create(account);
        account.setId(accountId);

        return account;
    }

    /**
     * Thay đổi mật khẩu
     * 
     * @param accountId       ID của account
     * @param currentPassword mật khẩu hiện tại
     * @param newPassword     mật khẩu mới
     * @return true nếu thành công
     */
    public boolean changePassword(Long accountId, String currentPassword, String newPassword) {
        // Validate input
        if (accountId == null) {
            throw new IllegalArgumentException("Account ID không được null");
        }

        if (currentPassword == null || currentPassword.trim().isEmpty()) {
            throw new IllegalArgumentException("Mật khẩu hiện tại không được rỗng");
        }

        if (newPassword == null || newPassword.trim().isEmpty()) {
            throw new IllegalArgumentException("Mật khẩu mới không được rỗng");
        }

        // Tìm account
        Optional<Account> accountOpt = accountRepository.findById(accountId);
        if (accountOpt.isEmpty()) {
            throw new IllegalArgumentException("Không tìm thấy tài khoản");
        }

        Account account = accountOpt.get();

        // Kiểm tra mật khẩu hiện tại
        if (!PasswordUtil.verifyPassword(currentPassword, account.getPasswordHash())) {
            throw new IllegalArgumentException("Mật khẩu hiện tại không đúng");
        }

        // Validate mật khẩu mới
        String passwordError = PasswordUtil.validatePassword(newPassword);
        if (passwordError != null) {
            throw new IllegalArgumentException(passwordError);
        }

        // Hash mật khẩu mới
        String newHashedPassword = PasswordUtil.hashPassword(newPassword);
        account.setPasswordHash(newHashedPassword);

        // Cập nhật database
        return accountRepository.update(account);
    }

    /**
     * Lấy role của user
     */
    private String getUserRole(User user) {
        if (user.getRole() != null) {
            return user.getRole().getDisplayName();
        }
        return User.UserRole.EMPLOYEE.getDisplayName();
    }
}