package group4.hrms.exception;

import group4.hrms.constants.AppConstants;

/**
 * Exception cho các lỗi liên quan đến database
 */
public class DatabaseException extends HRMSException {

    public DatabaseException(String message) {
        super(message, AppConstants.ERROR_DATABASE_ERROR);
    }

    public DatabaseException(String message, Throwable cause) {
        super(message, AppConstants.ERROR_DATABASE_ERROR, cause);
    }
}