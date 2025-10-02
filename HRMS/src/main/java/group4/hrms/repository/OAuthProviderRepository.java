package group4.hrms.repository;

import group4.hrms.entity.OAuthProvider;
import group4.hrms.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Optional;

/**
 * Repository để tương tác với bảng oauth_providers
 */
public class OAuthProviderRepository {

    /**
     * Tìm OAuth provider theo code
     * 
     * @param code mã định danh provider (google, facebook, etc.)
     * @return OAuthProvider nếu tìm thấy
     */
    public Optional<OAuthProvider> findByCode(String code) {
        String sql = "SELECT id, code, name FROM oauth_providers WHERE code = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, code);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    OAuthProvider provider = mapResultSetToProvider(rs);
                    return Optional.of(provider);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi tìm OAuth provider theo code", e);
        }

        return Optional.empty();
    }

    /**
     * Tìm OAuth provider theo ID
     * 
     * @param id ID của provider
     * @return OAuthProvider nếu tìm thấy
     */
    public Optional<OAuthProvider> findById(Long id) {
        String sql = "SELECT id, code, name FROM oauth_providers WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    OAuthProvider provider = mapResultSetToProvider(rs);
                    return Optional.of(provider);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi tìm OAuth provider theo ID", e);
        }

        return Optional.empty();
    }

    /**
     * Tạo OAuth provider mới
     * 
     * @param provider OAuthProvider cần tạo
     * @return ID của provider mới tạo
     */
    public Long create(OAuthProvider provider) {
        String sql = "INSERT INTO oauth_providers (code, name) VALUES (?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, provider.getCode());
            stmt.setString(2, provider.getName());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Tạo OAuth provider thất bại, không có bản ghi nào được tạo");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    Long providerId = generatedKeys.getLong(1);
                    provider.setId(providerId);
                    return providerId;
                } else {
                    throw new SQLException("Tạo OAuth provider thất bại, không lấy được ID");
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi tạo OAuth provider mới", e);
        }
    }

    /**
     * Map ResultSet thành OAuthProvider object
     */
    private OAuthProvider mapResultSetToProvider(ResultSet rs) throws SQLException {
        OAuthProvider provider = new OAuthProvider();
        provider.setId(rs.getLong("id"));
        provider.setCode(rs.getString("code"));
        provider.setName(rs.getString("name"));
        return provider;
    }
}