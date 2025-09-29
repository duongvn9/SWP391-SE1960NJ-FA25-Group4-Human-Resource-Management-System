package group4.hrms.constants;

/**
 * Các hằng số ứng dụng chung
 */
public final class AppConstants {

    // Application Information
    public static final String APP_NAME = "HRMS";
    public static final String APP_VERSION = "1.0.0";
    public static final String APP_DESCRIPTION = "Human Resource Management System";

    // Session Attributes
    public static final String SESSION_USER_ID = "userId";
    public static final String SESSION_USER_EMAIL = "userEmail";
    public static final String SESSION_USER_FULL_NAME = "userFullName";
    public static final String SESSION_USER_ROLE = "userRole";
    public static final String SESSION_CSRF_TOKEN = "csrfToken";

    // Request Attributes
    public static final String REQUEST_ERROR_MESSAGE = "errorMessage";
    public static final String REQUEST_SUCCESS_MESSAGE = "successMessage";
    public static final String REQUEST_INFO_MESSAGE = "infoMessage";

    // Date & Time Formats
    public static final String DATE_FORMAT = "dd/MM/yyyy";
    public static final String DATETIME_FORMAT = "dd/MM/yyyy HH:mm:ss";
    public static final String TIME_FORMAT = "HH:mm";
    public static final String TIMEZONE = "Asia/Ho_Chi_Minh";

    // Pagination
    public static final int DEFAULT_PAGE_SIZE = 10;
    public static final int MAX_PAGE_SIZE = 100;

    // File Upload
    public static final long MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB
    public static final String[] ALLOWED_IMAGE_TYPES = { "jpg", "jpeg", "png", "gif" };
    public static final String[] ALLOWED_DOCUMENT_TYPES = { "pdf", "doc", "docx", "xls", "xlsx" };

    // Validation
    public static final int MIN_PASSWORD_LENGTH = 8;
    public static final int MAX_PASSWORD_LENGTH = 128;
    public static final int MAX_EMAIL_LENGTH = 255;
    public static final int MAX_NAME_LENGTH = 100;

    // Error Codes
    public static final String ERROR_INVALID_CREDENTIALS = "INVALID_CREDENTIALS";
    public static final String ERROR_USER_NOT_FOUND = "USER_NOT_FOUND";
    public static final String ERROR_ACCESS_DENIED = "ACCESS_DENIED";
    public static final String ERROR_VALIDATION_FAILED = "VALIDATION_FAILED";
    public static final String ERROR_DATABASE_ERROR = "DATABASE_ERROR";

    // Prevent instantiation
    private AppConstants() {
        throw new UnsupportedOperationException("Utility class không thể khởi tạo");
    }
}