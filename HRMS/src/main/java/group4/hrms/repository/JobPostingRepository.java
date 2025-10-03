// File: src/main/java/group4/hrms/repository/JobPostingRepository.java
package group4.hrms.repository;

import group4.hrms.entity.JobPosting;
import java.sql.*;
import java.time.LocalDateTime;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class JobPostingRepository extends BaseDAO {

    private static final Logger logger = LoggerFactory.getLogger(JobPostingRepository.class);

    public long save(JobPosting job) {
        String sql = "INSERT INTO job_postings "
                   + "(request_id, title, description, criteria, channel, status, published_at, headcount, created_at, updated_at) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            if (job.getRequestId() != null) {
                ps.setLong(1, job.getRequestId());
            } else {
                ps.setNull(1, Types.BIGINT);
            }

            ps.setString(2, job.getTitle());

            if (job.getDescription() != null) {
                ps.setString(3, job.getDescription());
            } else {
                ps.setNull(3, Types.LONGVARCHAR);
            }

            if (job.getCriteria() != null) {
                ps.setString(4, job.getCriteria()); // JSON lưu dưới dạng String
            } else {
                ps.setNull(4, Types.VARCHAR);
            }

            if (job.getChannel() != null) {
                ps.setString(5, job.getChannel());
            } else {
                ps.setNull(5, Types.VARCHAR);
            }

            ps.setString(6, job.getStatus() != null ? job.getStatus() : "DRAFT");

            if (job.getPublishedAt() != null) {
                ps.setTimestamp(7, Timestamp.valueOf(job.getPublishedAt()));
            } else {
                ps.setNull(7, Types.TIMESTAMP);
            }

            if (job.getHeadcount() != null) {
                ps.setInt(8, job.getHeadcount());
            } else {
                ps.setNull(8, Types.INTEGER);
            }

            LocalDateTime now = LocalDateTime.now();
            ps.setTimestamp(9, Timestamp.valueOf(job.getCreatedAt() != null ? job.getCreatedAt() : now));
            ps.setTimestamp(10, Timestamp.valueOf(job.getUpdatedAt() != null ? job.getUpdatedAt() : now));

            ps.executeUpdate();

            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getLong(1);
            }

        } catch (SQLException e) {
            logger.error("Lỗi khi lưu Job Posting", e);
        } finally {
            closeResources(conn, ps, rs);
        }
        return -1;
    }
}
