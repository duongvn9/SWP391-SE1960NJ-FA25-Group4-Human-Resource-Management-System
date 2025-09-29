package group4.hrms.filter;

import group4.hrms.util.DatabaseUtil;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Context Listener để quản lý lifecycle của database connection pool
 * 
 * @author Group4
 * @since 1.0
 */
@WebListener
public class DatabaseContextListener implements ServletContextListener {
    private static final Logger logger = LoggerFactory.getLogger(DatabaseContextListener.class);
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        logger.info("=== Khởi tạo HRMS Application ===");
        logger.info("Đang khởi tạo database connection pool...");
        
        try {
            // Test connection để đảm bảo database hoạt động
            if (DatabaseUtil.testConnection()) {
                logger.info("✓ Kết nối database thành công");
                logger.info("✓ Pool info: {}", DatabaseUtil.getPoolInfo());
            } else {
                logger.warn("⚠ Không thể kết nối đến database - Application vẫn khởi động");
                logger.warn("⚠ Các chức năng database sẽ không hoạt động cho đến khi database được khôi phục");
            }
        } catch (Exception e) {
            logger.warn("⚠ Lỗi khi khởi tạo database: {} - Application vẫn khởi động", e.getMessage());
            logger.debug("Chi tiết lỗi database:", e);
        }
        
        logger.info("=== HRMS Application đã sẵn sàng ===");
    }
    
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        logger.info("=== Đang tắt HRMS Application ===");
        logger.info("Đang đóng database connection pool...");
        
        try {
            DatabaseUtil.shutdown();
            logger.info("✓ Đã đóng database connection pool thành công");
        } catch (Exception e) {
            logger.error("✗ Lỗi khi đóng database connection pool", e);
        }
        
        logger.info("=== HRMS Application đã tắt hoàn toàn ===");
    }
}