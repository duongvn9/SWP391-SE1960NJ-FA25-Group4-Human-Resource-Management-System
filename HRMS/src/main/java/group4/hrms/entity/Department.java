package group4.hrms.entity;

/**
 * Entity đại diện cho bảng departments
 */
public class Department {

    private Long id;
    private String name;
    private Long managerId;

    // Constructor mặc định
    public Department() {
    }

    // Constructor với tham số
    public Department(String name, Long managerId) {
        this.name = name;
        this.managerId = managerId;
    }

    // Getters và Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getManagerId() {
        return managerId;
    }

    public void setManagerId(Long managerId) {
        this.managerId = managerId;
    }

    @Override
    public String toString() {
        return "Department{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", managerId=" + managerId +
                '}';
    }
}