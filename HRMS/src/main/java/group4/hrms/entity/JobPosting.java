// File: src/main/java/group4/hrms/entity/JobPosting.java
package group4.hrms.entity;

import java.time.LocalDateTime;

public class JobPosting {
    private Long id;
    private Long requestId;
    private String title;
    private String description;
    private String criteria; // JSON dạng String
    private String channel;
    private String status;
    private LocalDateTime publishedAt;
    private Integer headcount;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private String createdBy;

    public JobPosting() {}

    // Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getRequestId() { return requestId; }
    public void setRequestId(Long requestId) { this.requestId = requestId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getCriteria() { return criteria; }
    public void setCriteria(String criteria) { this.criteria = criteria; }

    public String getChannel() { return channel; }
    public void setChannel(String channel) { this.channel = channel; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public LocalDateTime getPublishedAt() { return publishedAt; }
    public void setPublishedAt(LocalDateTime publishedAt) { this.publishedAt = publishedAt; }

    public Integer getHeadcount() { return headcount; }
    public void setHeadcount(Integer headcount) { this.headcount = headcount; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    public String getCreatedBy() {
    return createdBy;
}
public void setCreatedBy(String createdBy) {
    this.createdBy = createdBy;
}
}
