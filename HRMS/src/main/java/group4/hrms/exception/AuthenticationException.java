package group4.hrms.exception;

import group4.hrms.constants.AppConstants;

/**
 * Exception cho các lỗi liên quan đến authentication
 */
public class AuthenticationException extends HRMSException {

    public AuthenticationException(String message) {
        super(message, AppConstants.ERROR_INVALID_CREDENTIALS);
    }

    public AuthenticationException(String message, Throwable cause) {
        super(message, AppConstants.ERROR_INVALID_CREDENTIALS, cause);
    }
}