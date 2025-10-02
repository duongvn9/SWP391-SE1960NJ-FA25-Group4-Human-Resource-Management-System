package group4.hrms.repository;

import group4.hrms.util.DatabaseUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Base DAO class cung cấp các phương thức chung cho các DAO khác
 * 
 * @author Group4
 * @since 1.0
 */
public abstract class BaseDAO {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());

    /**
     * Lấy connection từ connection pool
     * 
     * @return Connection object
     * @throws SQLException nếu không thể lấy connection
     */
    protected Connection getConnection() throws SQLException {
        return DatabaseUtil.getConnection();
    }

    /**
     * Đóng resources một cách an toàn
     * 
     * @param conn Connection cần đóng
     * @param stmt PreparedStatement cần đóng
     * @param rs   ResultSet cần đóng
     */
    protected void closeResources(Connection conn, PreparedStatement stmt, ResultSet rs) {
        closeResultSet(rs);
        closePreparedStatement(stmt);
        closeConnection(conn);
    }

    /**
     * Đóng resources một cách an toàn (không có ResultSet)
     * 
     * @param conn Connection cần đóng
     * @param stmt PreparedStatement cần đóng
     */
    protected void closeResources(Connection conn, PreparedStatement stmt) {
        closeResources(conn, stmt, null);
    }

    /**
     * Đóng Connection một cách an toàn
     */
    private void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
                logger.debug("Đã đóng Connection");
            } catch (SQLException e) {
                logger.warn("Lỗi khi đóng Connection", e);
            }
        }
    }

    /**
     * Đóng PreparedStatement một cách an toàn
     */
    private void closePreparedStatement(PreparedStatement stmt) {
        if (stmt != null) {
            try {
                stmt.close();
                logger.debug("Đã đóng PreparedStatement");
            } catch (SQLException e) {
                logger.warn("Lỗi khi đóng PreparedStatement", e);
            }
        }
    }

    /**
     * Đóng ResultSet một cách an toàn
     */
    private void closeResultSet(ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
                logger.debug("Đã đóng ResultSet");
            } catch (SQLException e) {
                logger.warn("Lỗi khi đóng ResultSet", e);
            }
        }
    }

    /**
     * Rollback transaction một cách an toàn
     * 
     * @param conn Connection cần rollback
     */
    protected void rollback(Connection conn) {
        if (conn != null) {
            try {
                conn.rollback();
                logger.info("Đã rollback transaction");
            } catch (SQLException e) {
                logger.error("Lỗi khi rollback transaction", e);
            }
        }
    }

    /**
     * Bắt đầu transaction
     * 
     * @param conn Connection để bắt đầu transaction
     * @throws SQLException nếu có lỗi
     */
    protected void beginTransaction(Connection conn) throws SQLException {
        if (conn != null) {
            conn.setAutoCommit(false);
            logger.debug("Bắt đầu transaction");
        }
    }

    /**
     * Commit transaction
     * 
     * @param conn Connection để commit
     * @throws SQLException nếu có lỗi
     */
    protected void commitTransaction(Connection conn) throws SQLException {
        if (conn != null) {
            conn.commit();
            logger.debug("Commit transaction thành công");
        }
    }

    /**
     * Kiểm tra xem connection có đang trong transaction không
     * 
     * @param conn Connection cần kiểm tra
     * @return true nếu đang trong transaction
     */
    protected boolean isInTransaction(Connection conn) {
        try {
            return conn != null && !conn.getAutoCommit();
        } catch (SQLException e) {
            logger.warn("Lỗi khi kiểm tra transaction status", e);
            return false;
        }
    }
}