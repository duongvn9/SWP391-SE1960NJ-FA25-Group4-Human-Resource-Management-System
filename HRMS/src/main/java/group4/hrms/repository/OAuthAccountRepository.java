package group4.hrms.repository;

import group4.hrms.entity.OAuthAccount;
import group4.hrms.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Optional;

/**
 * Repository để tương tác với bảng oauth_accounts
 */
public class OAuthAccountRepository {

    /**
     * Tìm OAuth account theo provider ID và provider UID
     * 
     * @param providerId  ID của OAuth provider
     * @param providerUid UID từ OAuth provider
     * @return OAuthAccount nếu tìm thấy
     */
    public Optional<OAuthAccount> findByProviderAndUid(Long providerId, String providerUid) {
        String sql = "SELECT id, account_id, provider_id, provider_uid, created_at " +
                "FROM oauth_accounts WHERE provider_id = ? AND provider_uid = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, providerId);
            stmt.setString(2, providerUid);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    OAuthAccount oauthAccount = mapResultSetToOAuthAccount(rs);
                    return Optional.of(oauthAccount);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi tìm OAuth account", e);
        }

        return Optional.empty();
    }

    /**
     * Tìm OAuth account theo account ID
     * 
     * @param accountId ID của account
     * @return OAuthAccount nếu tìm thấy
     */
    public Optional<OAuthAccount> findByAccountId(Long accountId) {
        String sql = "SELECT id, account_id, provider_id, provider_uid, created_at " +
                "FROM oauth_accounts WHERE account_id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, accountId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    OAuthAccount oauthAccount = mapResultSetToOAuthAccount(rs);
                    return Optional.of(oauthAccount);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi tìm OAuth account theo account ID", e);
        }

        return Optional.empty();
    }

    /**
     * Tạo OAuth account mới
     * 
     * @param oauthAccount OAuthAccount cần tạo
     * @return ID của OAuth account mới tạo
     */
    public Long create(OAuthAccount oauthAccount) {
        String sql = "INSERT INTO oauth_accounts (account_id, provider_id, provider_uid, created_at) " +
                "VALUES (?, ?, ?, NOW())";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            stmt.setLong(1, oauthAccount.getAccountId());
            stmt.setLong(2, oauthAccount.getProviderId());
            stmt.setString(3, oauthAccount.getProviderUid());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Tạo OAuth account thất bại, không có bản ghi nào được tạo");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    Long oauthAccountId = generatedKeys.getLong(1);
                    oauthAccount.setId(oauthAccountId);
                    return oauthAccountId;
                } else {
                    throw new SQLException("Tạo OAuth account thất bại, không lấy được ID");
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi tạo OAuth account mới", e);
        }
    }

    /**
     * Xóa OAuth account
     * 
     * @param id ID của OAuth account cần xóa
     * @return true nếu xóa thành công
     */
    public boolean delete(Long id) {
        String sql = "DELETE FROM oauth_accounts WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, id);

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi xóa OAuth account", e);
        }
    }

    /**
     * Map ResultSet thành OAuthAccount object
     */
    private OAuthAccount mapResultSetToOAuthAccount(ResultSet rs) throws SQLException {
        OAuthAccount oauthAccount = new OAuthAccount();
        oauthAccount.setId(rs.getLong("id"));
        oauthAccount.setAccountId(rs.getLong("account_id"));
        oauthAccount.setProviderId(rs.getLong("provider_id"));
        oauthAccount.setProviderUid(rs.getString("provider_uid"));

        // Map created_at từ database
        java.sql.Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            oauthAccount.setCreatedAt(createdAt.toLocalDateTime());
        }

        return oauthAccount;
    }
}