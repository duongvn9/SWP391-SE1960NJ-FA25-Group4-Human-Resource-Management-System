package group4.hrms.repository;

import group4.hrms.entity.Department;
import group4.hrms.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * Repository để tương tác với bảng departments
 */
public class DepartmentRepository {

    /**
     * Lấy tất cả departments
     */
    public List<Department> findAll() {
        List<Department> departments = new ArrayList<>();
        String sql = "SELECT id, name, manager_id FROM departments ORDER BY name";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Department department = mapResultSetToDepartment(rs);
                departments.add(department);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi lấy danh sách departments", e);
        }

        return departments;
    }

    /**
     * Tìm department theo ID
     */
    public Optional<Department> findById(Long id) {
        String sql = "SELECT id, name, manager_id FROM departments WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Department department = mapResultSetToDepartment(rs);
                    return Optional.of(department);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi tìm department theo ID", e);
        }

        return Optional.empty();
    }

    /**
     * Map ResultSet thành Department object
     */
    private Department mapResultSetToDepartment(ResultSet rs) throws SQLException {
        Department department = new Department();
        department.setId(rs.getLong("id"));
        department.setName(rs.getString("name"));
        
        // manager_id có thể null nên cần check
        Long managerId = rs.getLong("manager_id");
        if (!rs.wasNull()) {
            department.setManagerId(managerId);
        }

        return department;
    }
}