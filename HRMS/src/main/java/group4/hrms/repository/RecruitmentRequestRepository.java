/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package group4.hrms.repository;
import group4.hrms.entity.RecruitmentRequest;
import java.sql.*;

/**
 *
 * @author HieuTrung
 */
public class RecruitmentRequestRepository extends BaseDAO {

    public long save(RecruitmentRequest req) {
        String sql = "INSERT INTO recruitment_requests "
                   + "(requester_id, department_id, job_title, headcount, budget, description, status) "
                   + "VALUES (?, ?, ?, ?, ?, ?, 'PENDING')";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = getConnection(); // Lấy connection từ BaseDAO
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setLong(1, req.getRequesterId());
            if (req.getDepartmentId() != null) {
                ps.setLong(2, req.getDepartmentId());
            } else {
                ps.setNull(2, Types.BIGINT);
            }
            ps.setString(3, req.getJobTitle());
            ps.setInt(4, req.getHeadcount());
            ps.setDouble(5, req.getBudget());
            ps.setString(6, req.getDescription());

            ps.executeUpdate();

            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getLong(1); // trả về ID vừa tạo
            }
        } catch (SQLException e) {
            logger.error("Lỗi khi lưu recruitment request", e);
        } finally {
            closeResources(conn, ps, rs); // dùng hàm tiện ích của BaseDAO
        }
        return -1;
    }
}