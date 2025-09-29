package group4.hrms.config;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import group4.hrms.constants.DatabaseConstants;

import javax.sql.DataSource;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * Cấu hình kết nối cơ sở dữ liệu
 * Sử dụng HikariCP làm connection pool
 */
public class DatabaseConfig {

    private static DataSource dataSource;
    private static final Object lock = new Object();

    /**
     * Khởi tạo DataSource với HikariCP
     * Singleton pattern để đảm bảo chỉ có một instance
     */
    public static DataSource getDataSource() {
        if (dataSource == null) {
            synchronized (lock) {
                if (dataSource == null) {
                    dataSource = createDataSource();
                }
            }
        }
        return dataSource;
    }

    private static DataSource createDataSource() {
        try {
            Properties props = loadDatabaseProperties();

            HikariConfig config = new HikariConfig();
            config.setJdbcUrl(props.getProperty("db.url"));
            config.setUsername(props.getProperty("db.username"));
            config.setPassword(props.getProperty("db.password"));
            config.setDriverClassName(props.getProperty("db.driver"));

            // Connection pool configuration
            config.setMaximumPoolSize(DatabaseConstants.MAX_POOL_SIZE);
            config.setMinimumIdle(DatabaseConstants.MIN_IDLE);
            config.setConnectionTimeout(DatabaseConstants.CONNECTION_TIMEOUT);
            config.setIdleTimeout(DatabaseConstants.IDLE_TIMEOUT);
            config.setMaxLifetime(DatabaseConstants.MAX_LIFETIME);

            // Connection testing
            config.setConnectionTestQuery("SELECT 1");

            return new HikariDataSource(config);

        } catch (Exception e) {
            throw new RuntimeException("Không thể khởi tạo DataSource", e);
        }
    }

    private static Properties loadDatabaseProperties() throws IOException {
        Properties props = new Properties();
        try (InputStream input = DatabaseConfig.class.getClassLoader()
                .getResourceAsStream("application.properties")) {
            if (input == null) {
                throw new IOException("Không tìm thấy file application.properties");
            }
            props.load(input);
        }
        return props;
    }

    /**
     * Đóng DataSource khi ứng dụng shutdown
     */
    public static void closeDataSource() {
        if (dataSource instanceof HikariDataSource) {
            ((HikariDataSource) dataSource).close();
        }
    }
}