package group4.hrms.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import group4.hrms.entity.Attendance;
import group4.hrms.util.DatabaseUtil;

public class AttendanceRepository {

    public void saveImportAttendance(Attendance att) {
        String sql = "INSERT INTO attendance_logs "
                + "(user_id, check_type, checked_at, source, note, period_id) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, att.getUserId());
            ps.setString(2, att.getCheckType());
            ps.setTimestamp(3, Timestamp.valueOf(att.getCheckedAt())); // LocalDateTime -> Timestamp

            // source có thể null
            if (att.getSource() != null) {
                ps.setString(4, att.getSource());
            } else {
                ps.setNull(4, java.sql.Types.VARCHAR);
            }

            // note có thể null
            if (att.getNote() != null) {
                ps.setString(5, att.getNote());
            } else {
                ps.setNull(5, java.sql.Types.VARCHAR);
            }

            // periodId có thể null
            if (att.getPeriodId() != null) {
                ps.setLong(6, att.getPeriodId());
            } else {
                ps.setNull(6, java.sql.Types.BIGINT);
            }

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Attendance> findByUserId(Long userId) {
        List<Attendance> list = new ArrayList<>();
        String sql = "SELECT id, user_id, check_type, checked_at, source, note, period_id, created_at "
                + "FROM attendance_logs WHERE user_id = ? ORDER BY checked_at DESC";

        try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Attendance att = new Attendance();
                att.setId(rs.getLong("id"));
                att.setUserId(rs.getLong("user_id"));
                att.setCheckType(rs.getString("check_type"));
                att.setCheckedAt(rs.getTimestamp("checked_at").toLocalDateTime());
                att.setSource(rs.getString("source"));
                att.setNote(rs.getString("note"));
                att.setPeriodId(rs.getObject("period_id", Long.class));
                list.add(att);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}
