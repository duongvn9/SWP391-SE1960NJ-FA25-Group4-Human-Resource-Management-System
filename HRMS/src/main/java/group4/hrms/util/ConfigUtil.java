package group4.hrms.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * Utility class để load configuration từ application.properties
 */
public final class ConfigUtil {

    private static final Logger logger = LoggerFactory.getLogger(ConfigUtil.class);
    private static final String PROPERTIES_FILE = "application.properties";
    private static Properties properties;

    // Private constructor để ngăn instantiation
    private ConfigUtil() {
        // Utility class
    }

    /**
     * Load properties từ file application.properties
     */
    private static synchronized void loadProperties() {
        if (properties == null) {
            properties = new Properties();
            try (InputStream inputStream = ConfigUtil.class.getClassLoader()
                    .getResourceAsStream(PROPERTIES_FILE)) {

                if (inputStream == null) {
                    logger.error("Cannot find {} file in classpath", PROPERTIES_FILE);
                    return;
                }

                properties.load(inputStream);
                logger.info("Loaded {} properties from {}", properties.size(), PROPERTIES_FILE);

            } catch (IOException e) {
                logger.error("Error loading properties from {}: {}", PROPERTIES_FILE, e.getMessage(), e);
            }
        }
    }

    /**
     * Lấy giá trị property theo key
     * 
     * @param key Property key
     * @return Property value hoặc null nếu không tìm thấy
     */
    public static String getProperty(String key) {
        if (properties == null) {
            loadProperties();
        }

        String value = properties.getProperty(key);
        if (value != null) {
            value = value.trim();
        }

        return value;
    }

    /**
     * Lấy giá trị property với default value
     * 
     * @param key          Property key
     * @param defaultValue Default value nếu property không tồn tại
     * @return Property value hoặc default value
     */
    public static String getProperty(String key, String defaultValue) {
        String value = getProperty(key);
        return (value != null && !value.isEmpty()) ? value : defaultValue;
    }

    /**
     * Kiểm tra property có tồn tại không
     * 
     * @param key Property key
     * @return true nếu property tồn tại và không rỗng
     */
    public static boolean hasProperty(String key) {
        String value = getProperty(key);
        return value != null && !value.isEmpty();
    }

    /**
     * Validate required properties
     * 
     * @param keys Danh sách các property keys bắt buộc
     * @throws IllegalStateException nếu thiếu property bắt buộc
     */
    public static void validateRequiredProperties(String... keys) {
        for (String key : keys) {
            if (!hasProperty(key)) {
                throw new IllegalStateException("Missing required property: " + key);
            }
        }
    }
}