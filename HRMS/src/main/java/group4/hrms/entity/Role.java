package group4.hrms.entity;

/**
 * Entity class cho Role
 */
public class Role extends BaseEntity {
    private String code;
    private String name;

    // Constructors
    public Role() {
        super();
    }

    public Role(String code, String name) {
        this();
        this.code = code;
        this.name = name;
    }

    // Getters and Setters
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Role{" +
                "id=" + getId() +
                ", code='" + code + '\'' +
                ", name='" + name + '\'' +
                '}';
    }
}