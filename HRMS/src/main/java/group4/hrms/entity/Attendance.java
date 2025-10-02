package group4.hrms.entity;

import java.time.LocalDateTime;

public class Attendance {

    private Long id;
    private Long userId;
    private String checkType;   // IN hoặc OUT
    private LocalDateTime checkedAt;
    private String source;
    private String note;
    private Long periodId;
    private LocalDateTime createdAt;

    public Attendance() {
    }

    public Attendance(Long id, Long userId, String checkType, LocalDateTime checkedAt,
            String source, String note, Long periodId, LocalDateTime createdAt) {
        this.id = id;
        this.userId = userId;
        this.checkType = checkType;
        this.checkedAt = checkedAt;
        this.source = source;
        this.note = note;
        this.periodId = periodId;
        this.createdAt = createdAt;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getCheckType() {
        return checkType;
    }

    public void setCheckType(String checkType) {
        this.checkType = checkType;
    }

    public LocalDateTime getCheckedAt() {
        return checkedAt;
    }

    public void setCheckedAt(LocalDateTime checkedAt) {
        this.checkedAt = checkedAt;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Long getPeriodId() {
        return periodId;
    }

    public void setPeriodId(Long periodId) {
        this.periodId = periodId;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
