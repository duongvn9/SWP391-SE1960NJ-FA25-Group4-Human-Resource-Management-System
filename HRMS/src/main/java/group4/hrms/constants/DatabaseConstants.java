package group4.hrms.constants;

/**
 * Các hằng số cấu hình cơ sở dữ liệu
 */
public final class DatabaseConstants {

    // Connection Pool Configuration
    public static final int MAX_POOL_SIZE = 20;
    public static final int MIN_IDLE = 5;
    public static final long CONNECTION_TIMEOUT = 30000; // 30 seconds
    public static final long IDLE_TIMEOUT = 600000; // 10 minutes
    public static final long MAX_LIFETIME = 1800000; // 30 minutes

    // Transaction Configuration
    public static final int DEFAULT_QUERY_TIMEOUT = 30; // seconds
    public static final int BATCH_SIZE = 100;

    // Database Schema
    public static final String SCHEMA_NAME = "hrms_db";

    // Table Names
    public static final String TABLE_USERS = "users";
    public static final String TABLE_EMPLOYEES = "employees";
    public static final String TABLE_DEPARTMENTS = "departments";
    public static final String TABLE_POSITIONS = "positions";
    public static final String TABLE_ATTENDANCE = "attendance";
    public static final String TABLE_PAYROLL = "payroll";
    public static final String TABLE_LEAVE_REQUESTS = "leave_requests";

    // Common Column Names
    public static final String COLUMN_ID = "id";
    public static final String COLUMN_CREATED_AT = "created_at";
    public static final String COLUMN_UPDATED_AT = "updated_at";
    public static final String COLUMN_DELETED_AT = "deleted_at";
    public static final String COLUMN_CREATED_BY = "created_by";
    public static final String COLUMN_UPDATED_BY = "updated_by";

    // Prevent instantiation
    private DatabaseConstants() {
        throw new UnsupportedOperationException("Utility class không thể khởi tạo");
    }
}