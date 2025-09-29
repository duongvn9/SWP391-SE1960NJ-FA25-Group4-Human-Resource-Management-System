package group4.hrms.exception;

/**
 * Base exception class cho tất cả custom exceptions trong HRMS
 */
public class HRMSException extends Exception {

    private final String errorCode;

    public HRMSException(String message) {
        super(message);
        this.errorCode = "HRMS_ERROR";
    }

    public HRMSException(String message, String errorCode) {
        super(message);
        this.errorCode = errorCode;
    }

    public HRMSException(String message, Throwable cause) {
        super(message, cause);
        this.errorCode = "HRMS_ERROR";
    }

    public HRMSException(String message, String errorCode, Throwable cause) {
        super(message, cause);
        this.errorCode = errorCode;
    }

    public String getErrorCode() {
        return errorCode;
    }
}