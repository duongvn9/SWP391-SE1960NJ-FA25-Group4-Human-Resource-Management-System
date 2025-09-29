package group4.hrms.util;

import org.apache.commons.lang3.StringUtils;

import java.util.regex.Pattern;

/**
 * Utility class cho validation
 */
public final class ValidationUtil {

    // Regex patterns
    private static final Pattern EMAIL_PATTERN = Pattern.compile(
            "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$");

    private static final Pattern PHONE_PATTERN = Pattern.compile(
            "^(\\+84|0)[0-9]{9,10}$");

    private static final Pattern NAME_PATTERN = Pattern.compile(
            "^[\\p{L}\\s'.-]{2,50}$", Pattern.UNICODE_CHARACTER_CLASS);

    /**
     * Validate email address
     */
    public static boolean isValidEmail(String email) {
        return StringUtils.isNotBlank(email) && EMAIL_PATTERN.matcher(email.trim()).matches();
    }

    /**
     * Validate phone number (Vietnam format)
     */
    public static boolean isValidPhoneNumber(String phone) {
        return StringUtils.isNotBlank(phone) && PHONE_PATTERN.matcher(phone.trim()).matches();
    }

    /**
     * Validate name (support Vietnamese characters)
     */
    public static boolean isValidName(String name) {
        return StringUtils.isNotBlank(name) && NAME_PATTERN.matcher(name.trim()).matches();
    }

    /**
     * Validate password strength
     */
    public static boolean isValidPassword(String password) {
        if (StringUtils.isBlank(password)) {
            return false;
        }

        return password.length() >= 8 && password.length() <= 128;
    }

    /**
     * Sanitize input string (remove dangerous characters for XSS)
     */
    public static String sanitizeInput(String input) {
        if (StringUtils.isBlank(input)) {
            return "";
        }

        return input.trim()
                .replaceAll("<", "&lt;")
                .replaceAll(">", "&gt;")
                .replaceAll("\"", "&quot;")
                .replaceAll("'", "&#x27;")
                .replaceAll("/", "&#x2F;");
    }

    /**
     * Check if string is null or empty after trim
     */
    public static boolean isEmpty(String str) {
        return StringUtils.isBlank(str);
    }

    /**
     * Check if string is not null and not empty after trim
     */
    public static boolean isNotEmpty(String str) {
        return StringUtils.isNotBlank(str);
    }

    /**
     * Validate string length
     */
    public static boolean isValidLength(String str, int minLength, int maxLength) {
        if (StringUtils.isBlank(str)) {
            return minLength == 0;
        }

        int length = str.trim().length();
        return length >= minLength && length <= maxLength;
    }

    /**
     * Format phone number to standard format
     */
    public static String formatPhoneNumber(String phone) {
        if (StringUtils.isBlank(phone)) {
            return "";
        }

        String cleaned = phone.replaceAll("[^0-9+]", "");

        if (cleaned.startsWith("84")) {
            return "+" + cleaned;
        } else if (cleaned.startsWith("0")) {
            return "+84" + cleaned.substring(1);
        }

        return cleaned;
    }

    // Prevent instantiation
    private ValidationUtil() {
        throw new UnsupportedOperationException("Utility class không thể khởi tạo");
    }
}