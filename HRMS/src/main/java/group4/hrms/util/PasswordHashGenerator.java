package group4.hrms.util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Utility để generate BCrypt hash cho passwords
 * Chạy class này để tạo hash cho testing
 */
public class PasswordHashGenerator {

    public static void main(String[] args) {
        // Generate hash cho các passwords test
        String[] passwords = { "admin123", "vduong123", "test123" };

        System.out.println("BCrypt Password Hashes (cost=12):");
        System.out.println("==================================");

        for (String password : passwords) {
            String hash = BCrypt.hashpw(password, BCrypt.gensalt(12));
            System.out.println("Password: " + password);
            System.out.println("Hash: " + hash);
            System.out.println("Verify: " + BCrypt.checkpw(password, hash));
            System.out.println();
        }

        // Test với hash hiện tại trong database
        System.out.println("Testing existing hashes:");
        System.out.println("========================");

        // Hash của admin trong seed data
        String adminHash = "$2b$12$o3tfR3el4d32b645ZO1n7ubjKkq1q8mZgRZj/FPhqVmpcfbUNCpYO";
        System.out.println("admin123 vs existing hash: " + BCrypt.checkpw("admin123", adminHash));
        System.out.println("admin vs existing hash: " + BCrypt.checkpw("admin", adminHash));

        // Hash của vduong trong seed data
        String vduongHash = "$2b$12$tlR5tX76l/jNVqQGnVod0uYV6/ZvB4G87ipj0O9uqolbxtSNqfk5u";
        System.out.println("vduong123 vs existing hash: " + BCrypt.checkpw("vduong123", vduongHash));
        System.out.println("vduong vs existing hash: " + BCrypt.checkpw("vduong", vduongHash));

        // Hash của user a,b,c trong seed data
        String userHash = "$2b$12$V.Cw68tktpZXokHZcsMAWepLU3LLYVgJmYj8GQdtmB.bkVARFq9uC";
        System.out.println("test123 vs existing hash: " + BCrypt.checkpw("test123", userHash));
        System.out.println("sa123 vs existing hash: " + BCrypt.checkpw("sa123", userHash));
    }
}