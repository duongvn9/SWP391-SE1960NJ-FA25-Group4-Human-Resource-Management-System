package group4.hrms.entity;

/**
 * Entity đại diện cho bảng oauth_providers
 * Lưu thông tin các nhà cung cấp OAuth (Google, Facebook, etc.)
 */
public class OAuthProvider extends BaseEntity {

    private String code;
    private String name;

    // Constructor mặc định
    public OAuthProvider() {
        super();
    }

    // Constructor với tham số
    public OAuthProvider(String code, String name) {
        this();
        this.code = code;
        this.name = name;
    }

    // Getters và Setters
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
        return "OAuthProvider{" +
                "id=" + getId() +
                ", code='" + code + '\'' +
                ", name='" + name + '\'' +
                '}';
    }
}