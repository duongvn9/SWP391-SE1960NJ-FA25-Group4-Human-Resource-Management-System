package group4.hrms.repository.employee;

import group4.hrms.entity.User;
import group4.hrms.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Optional;

/**
 * Repository để tương tác với bảng users
 */
public class UserRepository {

    /**
     * Tìm user theo ID
     * 
     * @param id ID của user
     * @return User nếu tìm thấy
     */
    public Optional<User> findById(Long id) {
        String sql = "SELECT id, full_name, email, phone, created_at FROM users WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User user = mapResultSetToUser(rs);
                    return Optional.of(user);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi tìm user theo ID", e);
        }

        return Optional.empty();
    }

    /**
     * Tìm user theo email
     * 
     * @param email email của user
     * @return User nếu tìm thấy
     */
    public Optional<User> findByEmail(String email) {
        String sql = "SELECT id, full_name, email, phone, created_at FROM users WHERE email = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User user = mapResultSetToUser(rs);
                    return Optional.of(user);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi tìm user theo email", e);
        }

        return Optional.empty();
    }

    /**
     * Tạo user mới
     * 
     * @param user User cần tạo
     * @return ID của user mới tạo
     */
    public Long create(User user) {
        String sql = "INSERT INTO users (full_name, email, phone, created_at) VALUES (?, ?, ?, NOW())";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhoneNumber());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Tạo user thất bại, không có bản ghi nào được tạo");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    Long userId = generatedKeys.getLong(1);
                    user.setId(userId);
                    return userId;
                } else {
                    throw new SQLException("Tạo user thất bại, không lấy được ID");
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi tạo user mới", e);
        }
    }

    /**
     * Lấy tất cả users
     */
    public java.util.List<User> findAll() {
        java.util.List<User> users = new java.util.ArrayList<>();
        String sql = "SELECT id, full_name, email, phone, created_at FROM users ORDER BY full_name";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                User user = mapResultSetToUser(rs);
                users.add(user);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi lấy danh sách users", e);
        }

        return users;
    }

    /**
     * Map ResultSet thành User object
     */
    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getLong("id"));
        user.setFullName(rs.getString("full_name"));
        user.setEmail(rs.getString("email"));
        user.setPhoneNumber(rs.getString("phone"));

        // Map created_at từ database
        java.sql.Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            user.setCreatedAt(createdAt.toLocalDateTime());
        }

        return user;
    }
}