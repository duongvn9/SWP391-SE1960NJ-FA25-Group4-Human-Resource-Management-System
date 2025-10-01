package group4.hrms.repository;

import group4.hrms.entity.Role;
import group4.hrms.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * Repository để tương tác với bảng roles
 */
public class RoleRepository {

    /**
     * Lấy tất cả roles
     */
    public List<Role> findAll() {
        List<Role> roles = new ArrayList<>();
        String sql = "SELECT id, code, name FROM roles ORDER BY id";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Role role = mapResultSetToRole(rs);
                roles.add(role);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi lấy danh sách roles", e);
        }

        return roles;
    }

    /**
     * Tìm role theo ID
     */
    public Optional<Role> findById(Long id) {
        if (id == null) {
            return Optional.empty();
        }

        String sql = "SELECT id, code, name FROM roles WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Role role = mapResultSetToRole(rs);
                    return Optional.of(role);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi tìm role theo ID", e);
        }

        return Optional.empty();
    }

    /**
     * Tìm role theo code
     */
    public Optional<Role> findByCode(String code) {
        if (code == null || code.trim().isEmpty()) {
            return Optional.empty();
        }

        String sql = "SELECT id, code, name FROM roles WHERE code = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, code.trim());

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Role role = mapResultSetToRole(rs);
                    return Optional.of(role);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi tìm role theo code", e);
        }

        return Optional.empty();
    }

    /**
     * Lấy danh sách roles của một account
     */
    public List<Role> findByAccountId(Long accountId) {
        List<Role> roles = new ArrayList<>();
        
        if (accountId == null) {
            return roles;
        }

        String sql = """
            SELECT r.id, r.code, r.name 
            FROM roles r
            JOIN account_roles ar ON r.id = ar.role_id
            WHERE ar.account_id = ?
            ORDER BY r.id
            """;

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, accountId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Role role = mapResultSetToRole(rs);
                    roles.add(role);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi lấy roles của account", e);
        }

        return roles;
    }

    /**
     * Gán roles cho account
     */
    public void assignRolesToAccount(Long accountId, Long[] roleIds) {
        if (accountId == null || roleIds == null || roleIds.length == 0) {
            return;
        }

        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            conn.setAutoCommit(false);

            // Xóa tất cả roles cũ của account
            String deleteSql = "DELETE FROM account_roles WHERE account_id = ?";
            try (PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
                deleteStmt.setLong(1, accountId);
                deleteStmt.executeUpdate();
            }

            // Thêm roles mới
            String insertSql = "INSERT INTO account_roles (account_id, role_id) VALUES (?, ?)";
            try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                for (Long roleId : roleIds) {
                    if (roleId != null) {
                        insertStmt.setLong(1, accountId);
                        insertStmt.setLong(2, roleId);
                        insertStmt.addBatch();
                    }
                }
                insertStmt.executeBatch();
            }

            conn.commit();
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException rollbackEx) {
                    // Log rollback error
                }
            }
            throw new RuntimeException("Lỗi khi gán roles cho account", e);
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    // Log close error
                }
            }
        }
    }

    /**
     * Xóa tất cả roles của account
     */
    public void removeAllRolesFromAccount(Long accountId) {
        if (accountId == null) {
            return;
        }

        String sql = "DELETE FROM account_roles WHERE account_id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, accountId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi xóa roles của account", e);
        }
    }

    /**
     * Map ResultSet to Role object
     */
    private Role mapResultSetToRole(ResultSet rs) throws SQLException {
        Role role = new Role();
        role.setId(rs.getLong("id"));
        role.setCode(rs.getString("code"));
        role.setName(rs.getString("name"));
        return role;
    }
}