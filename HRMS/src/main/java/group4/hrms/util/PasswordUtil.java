package group4.hrms.util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Utility class cho việc hash và verify password
 */
public final class PasswordUtil {

    private static final int BCRYPT_ROUNDS = 12;

    /**
     * Hash password với BCrypt
     */
    public static String hashPassword(String plainPassword) {
        if (plainPassword == null || plainPassword.trim().isEmpty()) {
            throw new IllegalArgumentException("Password không được null hoặc rỗng");
        }

        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(BCRYPT_ROUNDS));
    }

    /**
     * Verify password với hash
     */
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null) {
            return false;
        }

        try {
            return BCrypt.checkpw(plainPassword, hashedPassword);
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * Kiểm tra độ mạnh của password
     */
    public static boolean isStrongPassword(String password) {
        if (password == null || password.length() < 8) {
            return false;
        }

        boolean hasUppercase = password.chars().anyMatch(Character::isUpperCase);
        boolean hasLowercase = password.chars().anyMatch(Character::isLowerCase);
        boolean hasDigit = password.chars().anyMatch(Character::isDigit);
        boolean hasSpecialChar = password.chars().anyMatch(ch -> "!@#$%^&*()_+-=[]{}|;:,.<>?".indexOf(ch) >= 0);

        return hasUppercase && hasLowercase && hasDigit && hasSpecialChar;
    }

    /**
     * Validate password và trả về thông báo lỗi
     * 
     * @param password mật khẩu cần validate
     * @return thông báo lỗi, null nếu password hợp lệ
     */
    public static String validatePassword(String password) {
        if (password == null || password.trim().isEmpty()) {
            return "Mật khẩu không được rỗng";
        }

        if (password.length() < 8) {
            return "Mật khẩu phải có ít nhất 8 ký tự";
        }

        if (!password.matches(".*[A-Z].*")) {
            return "Mật khẩu phải có ít nhất 1 chữ hoa";
        }

        if (!password.matches(".*[a-z].*")) {
            return "Mật khẩu phải có ít nhất 1 chữ thường";
        }

        if (!password.matches(".*\\d.*")) {
            return "Mật khẩu phải có ít nhất 1 chữ số";
        }

        return null; // Password hợp lệ
    }

    /**
     * Tạo password ngẫu nhiên
     */
    public static String generateRandomPassword(int length) {
        if (length < 8) {
            length = 8;
        }

        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*";
        StringBuilder password = new StringBuilder();

        for (int i = 0; i < length; i++) {
            int index = (int) (Math.random() * chars.length());
            password.append(chars.charAt(index));
        }

        return password.toString();
    }

    // Prevent instantiation
    private PasswordUtil() {
        throw new UnsupportedOperationException("Utility class không thể khởi tạo");
    }
}