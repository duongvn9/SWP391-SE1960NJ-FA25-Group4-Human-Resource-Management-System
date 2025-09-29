package group4.hrms.repository;

import group4.hrms.config.DatabaseConfig;
import group4.hrms.entity.BaseEntity;
import group4.hrms.exception.DatabaseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.sql.DataSource;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * Abstract base repository implementation
 */
public abstract class AbstractBaseRepository<T extends BaseEntity, ID> implements BaseRepository<T, ID> {

    protected final Logger logger = LoggerFactory.getLogger(getClass());
    protected final DataSource dataSource;

    public AbstractBaseRepository() {
        this.dataSource = DatabaseConfig.getDataSource();
    }

    /**
     * Tên bảng database
     */
    protected abstract String getTableName();

    /**
     * Map ResultSet thành Entity
     */
    protected abstract T mapResultSetToEntity(ResultSet rs) throws SQLException;

    /**
     * Map Entity thành PreparedStatement cho INSERT
     */
    protected abstract void mapEntityToInsertStatement(PreparedStatement ps, T entity) throws SQLException;

    /**
     * Map Entity thành PreparedStatement cho UPDATE
     */
    protected abstract void mapEntityToUpdateStatement(PreparedStatement ps, T entity) throws SQLException;

    /**
     * Lấy danh sách tất cả columns cho SELECT
     */
    protected abstract String getSelectColumns();

    @Override
    public Optional<T> findById(ID id) throws DatabaseException {
        String sql = String.format("SELECT %s FROM %s WHERE id = ? AND deleted_at IS NULL",
                getSelectColumns(), getTableName());

        try (Connection conn = dataSource.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setObject(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapResultSetToEntity(rs));
                }
                return Optional.empty();
            }

        } catch (SQLException e) {
            logger.error("Error finding entity by id: {}", id, e);
            throw new DatabaseException("Lỗi truy vấn cơ sở dữ liệu", e);
        }
    }

    @Override
    public List<T> findAll() throws DatabaseException {
        String sql = String.format("SELECT %s FROM %s WHERE deleted_at IS NULL ORDER BY created_at DESC",
                getSelectColumns(), getTableName());

        try (Connection conn = dataSource.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            List<T> entities = new ArrayList<>();
            while (rs.next()) {
                entities.add(mapResultSetToEntity(rs));
            }
            return entities;

        } catch (SQLException e) {
            logger.error("Error finding all entities", e);
            throw new DatabaseException("Lỗi truy vấn cơ sở dữ liệu", e);
        }
    }

    @Override
    public List<T> findAll(int offset, int limit) throws DatabaseException {
        String sql = String.format(
                "SELECT %s FROM %s WHERE deleted_at IS NULL ORDER BY created_at DESC LIMIT ? OFFSET ?",
                getSelectColumns(), getTableName());

        try (Connection conn = dataSource.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);
            ps.setInt(2, offset);

            try (ResultSet rs = ps.executeQuery()) {
                List<T> entities = new ArrayList<>();
                while (rs.next()) {
                    entities.add(mapResultSetToEntity(rs));
                }
                return entities;
            }

        } catch (SQLException e) {
            logger.error("Error finding entities with pagination: offset={}, limit={}", offset, limit, e);
            throw new DatabaseException("Lỗi truy vấn cơ sở dữ liệu", e);
        }
    }

    @Override
    public long count() throws DatabaseException {
        String sql = String.format("SELECT COUNT(*) FROM %s WHERE deleted_at IS NULL", getTableName());

        try (Connection conn = dataSource.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getLong(1);
            }
            return 0;

        } catch (SQLException e) {
            logger.error("Error counting entities", e);
            throw new DatabaseException("Lỗi truy vấn cơ sở dữ liệu", e);
        }
    }

    @Override
    public boolean existsById(ID id) throws DatabaseException {
        String sql = String.format("SELECT 1 FROM %s WHERE id = ? AND deleted_at IS NULL", getTableName());

        try (Connection conn = dataSource.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setObject(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }

        } catch (SQLException e) {
            logger.error("Error checking entity existence: {}", id, e);
            throw new DatabaseException("Lỗi truy vấn cơ sở dữ liệu", e);
        }
    }

    @Override
    public void deleteById(ID id) throws DatabaseException {
        String sql = String.format("DELETE FROM %s WHERE id = ?", getTableName());

        try (Connection conn = dataSource.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setObject(1, id);
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected == 0) {
                throw new DatabaseException("Không tìm thấy bản ghi để xóa");
            }

        } catch (SQLException e) {
            logger.error("Error deleting entity by id: {}", id, e);
            throw new DatabaseException("Lỗi xóa dữ liệu", e);
        }
    }

    @Override
    public void softDeleteById(ID id) throws DatabaseException {
        String sql = String.format("UPDATE %s SET deleted_at = ?, updated_at = ? WHERE id = ?", getTableName());

        try (Connection conn = dataSource.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            LocalDateTime now = LocalDateTime.now();
            ps.setTimestamp(1, Timestamp.valueOf(now));
            ps.setTimestamp(2, Timestamp.valueOf(now));
            ps.setObject(3, id);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected == 0) {
                throw new DatabaseException("Không tìm thấy bản ghi để xóa");
            }

        } catch (SQLException e) {
            logger.error("Error soft deleting entity by id: {}", id, e);
            throw new DatabaseException("Lỗi xóa dữ liệu", e);
        }
    }

    // Helper methods
    protected void setCommonEntityFields(T entity, boolean isInsert) {
        LocalDateTime now = LocalDateTime.now();

        if (isInsert) {
            entity.setCreatedAt(now);
        }
        entity.setUpdatedAt(now);
    }
}