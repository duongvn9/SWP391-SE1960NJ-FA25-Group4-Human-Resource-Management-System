package group4.hrms.service.auth;

import group4.hrms.dto.response.LoginResponseDTO;
import group4.hrms.entity.Account;
import group4.hrms.entity.OAuthAccount;
import group4.hrms.entity.OAuthProvider;
import group4.hrms.entity.User;
import group4.hrms.repository.AccountRepository;
import group4.hrms.repository.OAuthAccountRepository;
import group4.hrms.repository.OAuthProviderRepository;
import group4.hrms.repository.employee.UserRepository;
import group4.hrms.util.GoogleOAuthUtil;

import java.io.IOException;
import java.util.Map;
import java.util.Optional;

/**
 * Service xử lý OAuth authentication
 */
public class OAuthService {

    private final OAuthProviderRepository oAuthProviderRepository;
    private final OAuthAccountRepository oAuthAccountRepository;
    private final AccountRepository accountRepository;
    private final UserRepository userRepository;
    private final AuthenticationService authenticationService;

    public OAuthService() {
        this.oAuthProviderRepository = new OAuthProviderRepository();
        this.oAuthAccountRepository = new OAuthAccountRepository();
        this.accountRepository = new AccountRepository();
        this.userRepository = new UserRepository();
        this.authenticationService = new AuthenticationService();
    }

    // Constructor cho testing
    public OAuthService(OAuthProviderRepository oAuthProviderRepository,
            OAuthAccountRepository oAuthAccountRepository,
            AccountRepository accountRepository,
            UserRepository userRepository,
            AuthenticationService authenticationService) {
        this.oAuthProviderRepository = oAuthProviderRepository;
        this.oAuthAccountRepository = oAuthAccountRepository;
        this.accountRepository = accountRepository;
        this.userRepository = userRepository;
        this.authenticationService = authenticationService;
    }

    /**
     * Tạo Google OAuth URL để redirect user
     * 
     * @param clientId    Google Client ID
     * @param redirectUri Redirect URI
     * @param scopes      OAuth scopes
     * @param state       State parameter
     * @return Google OAuth URL
     */
    public String createGoogleAuthUrl(String clientId, String redirectUri, String scopes, String state) {
        return GoogleOAuthUtil.buildAuthUrl(clientId, redirectUri, scopes, state);
    }

    /**
     * Xử lý Google OAuth callback
     * 
     * @param authCode     Authorization code từ Google
     * @param clientId     Google Client ID
     * @param clientSecret Google Client Secret
     * @param redirectUri  Redirect URI
     * @return LoginResponseDTO
     */
    public LoginResponseDTO handleGoogleCallback(String authCode, String clientId,
            String clientSecret, String redirectUri) {
        try {
            // Exchange code for token
            Map<String, Object> tokenResponse = GoogleOAuthUtil.exchangeCodeForToken(
                    authCode, clientId, clientSecret, redirectUri);

            String accessToken = (String) tokenResponse.get("access_token");
            if (accessToken == null) {
                return new LoginResponseDTO(false, "Không thể lấy access token từ Google");
            }

            // Get user info from Google
            Map<String, Object> userInfo = GoogleOAuthUtil.getUserInfo(accessToken);
            String googleId = (String) userInfo.get("id");
            String email = (String) userInfo.get("email");
            String name = (String) userInfo.get("name");

            if (googleId == null || email == null) {
                return new LoginResponseDTO(false, "Không thể lấy thông tin user từ Google");
            }

            // Tìm hoặc tạo OAuth provider
            OAuthProvider provider = findOrCreateGoogleProvider();

            // Tìm OAuth account
            Optional<OAuthAccount> oauthAccountOpt = oAuthAccountRepository
                    .findByProviderAndUid(provider.getId(), googleId);

            if (oauthAccountOpt.isPresent()) {
                // User đã liên kết Google account
                return loginExistingOAuthAccount(oauthAccountOpt.get());
            } else {
                // Kiểm tra user có tồn tại theo email không
                Optional<User> existingUserOpt = userRepository.findByEmail(email);

                if (existingUserOpt.isPresent()) {
                    // Link Google account với user hiện có
                    return linkGoogleToExistingUser(existingUserOpt.get(), provider.getId(), googleId);
                } else {
                    // Tạo user mới và link với Google
                    return createNewUserWithGoogle(email, name, provider.getId(), googleId);
                }
            }

        } catch (IOException e) {
            return new LoginResponseDTO(false, "Lỗi khi giao tiếp với Google: " + e.getMessage());
        } catch (Exception e) {
            return new LoginResponseDTO(false, "Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau");
        }
    }

    /**
     * Đăng nhập với OAuth account đã tồn tại
     */
    private LoginResponseDTO loginExistingOAuthAccount(OAuthAccount oauthAccount) {
        Optional<Account> accountOpt = accountRepository.findById(oauthAccount.getAccountId());
        if (accountOpt.isEmpty()) {
            return new LoginResponseDTO(false, "Không tìm thấy tài khoản liên kết");
        }

        Account account = accountOpt.get();
        if (!account.isActive()) {
            return new LoginResponseDTO(false, "Tài khoản đã bị khóa. Vui lòng liên hệ quản trị viên");
        }

        Optional<User> userOpt = userRepository.findById(account.getUserId());
        if (userOpt.isEmpty()) {
            return new LoginResponseDTO(false, "Không tìm thấy thông tin người dùng");
        }

        User user = userOpt.get();

        return new LoginResponseDTO(
                true,
                user.getId(),
                account.getUsername(),
                user.getFullName(),
                getUserRole(user),
                "/dashboard");
    }

    /**
     * Link Google account với user hiện có
     */
    private LoginResponseDTO linkGoogleToExistingUser(User user, Long providerId, String googleId) {
        try {
            // Tìm account của user
            Optional<Account> accountOpt = findAccountByUserId(user.getId());
            if (accountOpt.isEmpty()) {
                // Tạo account mới cho user
                Account newAccount = new Account(user.getId(), user.getEmail(), null);
                Long accountId = accountRepository.create(newAccount);
                newAccount.setId(accountId);
                accountOpt = Optional.of(newAccount);
            }

            Account account = accountOpt.get();

            // Tạo OAuth account link
            OAuthAccount oauthAccount = new OAuthAccount(account.getId(), providerId, googleId);
            oAuthAccountRepository.create(oauthAccount);

            return new LoginResponseDTO(
                    true,
                    user.getId(),
                    account.getUsername(),
                    user.getFullName(),
                    getUserRole(user),
                    "/dashboard");

        } catch (Exception e) {
            return new LoginResponseDTO(false, "Lỗi khi liên kết tài khoản Google");
        }
    }

    /**
     * Tạo user mới và link với Google
     */
    private LoginResponseDTO createNewUserWithGoogle(String email, String name, Long providerId, String googleId) {
        try {
            // Tạo user mới
            User newUser = new User(email, name);
            newUser.setRole(User.UserRole.EMPLOYEE);
            newUser.setStatus(User.UserStatus.ACTIVE);
            Long userId = userRepository.create(newUser);
            newUser.setId(userId);

            // Tạo account cho user
            Account newAccount = new Account(userId, email, null);
            Long accountId = accountRepository.create(newAccount);
            newAccount.setId(accountId);

            // Tạo OAuth account link
            OAuthAccount oauthAccount = new OAuthAccount(accountId, providerId, googleId);
            oAuthAccountRepository.create(oauthAccount);

            return new LoginResponseDTO(
                    true,
                    userId,
                    email,
                    name,
                    getUserRole(newUser),
                    "/dashboard");

        } catch (Exception e) {
            return new LoginResponseDTO(false, "Lỗi khi tạo tài khoản mới");
        }
    }

    /**
     * Tìm hoặc tạo Google OAuth provider
     */
    private OAuthProvider findOrCreateGoogleProvider() {
        Optional<OAuthProvider> providerOpt = oAuthProviderRepository.findByCode("google");

        if (providerOpt.isPresent()) {
            return providerOpt.get();
        }

        // Tạo provider mới
        OAuthProvider provider = new OAuthProvider("google", "Google");
        Long providerId = oAuthProviderRepository.create(provider);
        provider.setId(providerId);

        return provider;
    }

    /**
     * Tìm account theo user ID
     */
    private Optional<Account> findAccountByUserId(Long userId) {
        // Tạm thời implement đơn giản, có thể cần optimize sau
        // Trong thực tế nên tạo method findByUserId trong AccountRepository
        return Optional.empty();
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