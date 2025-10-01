package group4.hrms.entity;

/**
 * Entity đại diện cho bảng oauth_accounts
 * Lưu thông tin liên kết giữa account và OAuth provider
 */
public class OAuthAccount extends BaseEntity {

    private Long accountId;
    private Long providerId;
    private String providerUid;

    // Constructor mặc định
    public OAuthAccount() {
        super();
    }

    // Constructor với tham số
    public OAuthAccount(Long accountId, Long providerId, String providerUid) {
        this();
        this.accountId = accountId;
        this.providerId = providerId;
        this.providerUid = providerUid;
    }

    // Getters và Setters
    public Long getAccountId() {
        return accountId;
    }

    public void setAccountId(Long accountId) {
        this.accountId = accountId;
    }

    public Long getProviderId() {
        return providerId;
    }

    public void setProviderId(Long providerId) {
        this.providerId = providerId;
    }

    public String getProviderUid() {
        return providerUid;
    }

    public void setProviderUid(String providerUid) {
        this.providerUid = providerUid;
    }

    @Override
    public String toString() {
        return "OAuthAccount{" +
                "id=" + getId() +
                ", accountId=" + accountId +
                ", providerId=" + providerId +
                ", providerUid='" + providerUid + '\'' +
                '}';
    }
}