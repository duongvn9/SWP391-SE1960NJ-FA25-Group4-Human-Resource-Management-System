package group4.hrms.repository;

import group4.hrms.entity.Account;

import group4.hrms.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * Repository để tương tác với bảng accounts
 */
public class AccountRepository {

    /**
     * Tìm account theo username
     * 
     * @param username tên đăng nhập
     * @return Account nếu tìm thấy
     */
    public Optional<Account> findByUsername(String username) {
        String sql = "SELECT a.id, a.user_id, a.username, a.password_hash, a.is_active, a.created_at " +
                "FROM accounts a WHERE a.username = ? AND a.is_active = true";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Account account = mapResultSetToAccount(rs);
                    return Optional.of(account);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi tìm account theo username", e);
        }

        return Optional.empty();
    }

    /**
     * Tìm account theo ID
     * 
     * @param id ID của account
     * @return Account nếu tìm thấy
     */
    public Optional<Account> findById(Long id) {
        String sql = "SELECT a.id, a.user_id, a.username, a.password_hash, a.is_active, a.created_at " +
                "FROM accounts a WHERE a.id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Account account = mapResultSetToAccount(rs);
                    return Optional.of(account);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi tìm account theo ID", e);
        }

        return Optional.empty();
    }

    /**
     * Tạo account mới
     * 
     * @param account Account cần tạo
     * @return ID của account mới tạo
     */
    public Long create(Account account) {
        String sql = "INSERT INTO accounts (user_id, username, password_hash, is_active, created_at) " +
                "VALUES (?, ?, ?, ?, NOW())";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            stmt.setLong(1, account.getUserId());
            stmt.setString(2, account.getUsername());
            stmt.setString(3, account.getPasswordHash());
            stmt.setBoolean(4, account.isActive());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Tạo account thất bại, không có bản ghi nào được tạo");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    Long accountId = generatedKeys.getLong(1);
                    account.setId(accountId);
                    return accountId;
                } else {
                    throw new SQLException("Tạo account thất bại, không lấy được ID");
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi tạo account mới", e);
        }
    }

    /**
     * Cập nhật account
     * 
     * @param account Account cần cập nhật
     * @return true nếu cập nhật thành công
     */
    public boolean update(Account account) {
        String sql = "UPDATE accounts SET user_id = ?, username = ?, password_hash = ?, is_active = ? " +
                "WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, account.getUserId());
            stmt.setString(2, account.getUsername());
            stmt.setString(3, account.getPasswordHash());
            stmt.setBoolean(4, account.isActive());
            stmt.setLong(5, account.getId());

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi cập nhật account", e);
        }
    }

    /**
     * Kiểm tra username đã tồn tại chưa
     * 
     * @param username tên đăng nhập
     * @return true nếu đã tồn tại
     */
    public boolean existsByUsername(String username) {
        String sql = "SELECT COUNT(*) FROM accounts WHERE username = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi kiểm tra username tồn tại", e);
        }

        return false;
    }

    /**
     * Lấy tất cả accounts với thông tin user
     */
    public List<Account> findAllWithUserInfo() {
        List<Account> accounts = new ArrayList<>();
        String sql = """
            SELECT a.id, a.user_id, a.username, a.password_hash, a.is_active, a.created_at,
                   u.full_name, u.email, u.phone, d.name as department_name, p.name as position_name
            FROM accounts a
            JOIN users u ON a.user_id = u.id
            LEFT JOIN departments d ON u.department_id = d.id
            LEFT JOIN positions p ON u.position_id = p.id
            ORDER BY a.created_at DESC
            """;

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Account account = mapResultSetToAccountWithUserInfo(rs);
                accounts.add(account);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi lấy danh sách accounts", e);
        }

        return accounts;
    }

    /**
     * Tìm account theo ID với thông tin user cho edit form
     */
    public Optional<Account> findByIdWithUserInfo(Long id) {
        if (id == null) {
            return Optional.empty();
        }

        // Đơn giản hóa: chỉ lấy account basic info
        // Service layer sẽ query user info riêng
        return findById(id);
    }

    /**
     * Tìm account theo user ID
     */
    public Optional<Account> findByUserId(Long userId) {
        if (userId == null) {
            return Optional.empty();
        }

        String sql = "SELECT a.id, a.user_id, a.username, a.password_hash, a.is_active, a.created_at " +
                     "FROM accounts a WHERE a.user_id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Account account = mapResultSetToAccount(rs);
                    return Optional.of(account);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi tìm account theo user ID", e);
        }

        return Optional.empty();
    }

    /**
     * Xóa account (soft delete bằng cách set is_active = false)
     */
    public boolean deleteById(Long id) {
        if (id == null) {
            return false;
        }

        String sql = "UPDATE accounts SET is_active = false WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, id);
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi xóa account", e);
        }
    }

    /**
     * Kiểm tra username đã tồn tại chưa (loại trừ account hiện tại)
     */
    public boolean existsByUsernameExceptId(String username, Long accountId) {
        String sql = "SELECT COUNT(*) FROM accounts WHERE username = ? AND id != ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setLong(2, accountId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi kiểm tra username tồn tại", e);
        }

        return false;
    }

    /**
     * Map ResultSet thành Account object
     */
    private Account mapResultSetToAccount(ResultSet rs) throws SQLException {
        Account account = new Account();
        account.setId(rs.getLong("id"));
        account.setUserId(rs.getLong("user_id"));
        account.setUsername(rs.getString("username"));
        account.setPasswordHash(rs.getString("password_hash"));
        account.setIsActive(rs.getBoolean("is_active"));

        // Map created_at từ database
        java.sql.Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            account.setCreatedAt(createdAt.toLocalDateTime());
        }

        return account;
    }

    /**
     * Map ResultSet thành Account object với thông tin user
     */
    private Account mapResultSetToAccountWithUserInfo(ResultSet rs) throws SQLException {
        // Map basic account info
        Account account = new Account();
        account.setId(rs.getLong("id"));
        account.setUserId(rs.getLong("user_id"));
        account.setUsername(rs.getString("username"));
        account.setPasswordHash(rs.getString("password_hash"));
        account.setIsActive(rs.getBoolean("is_active"));
        
        // Map timestamp
        java.sql.Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            account.setCreatedAt(createdAt.toLocalDateTime());
        }
        
        // Lưu thông tin user vào transient fields của account để service layer sử dụng
        // (Tạm thời store trong một Map hoặc custom fields - đây là workaround)
        
        return account;
    }
}