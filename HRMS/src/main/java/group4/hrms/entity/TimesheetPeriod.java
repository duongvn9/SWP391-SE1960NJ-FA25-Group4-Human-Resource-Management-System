package group4.hrms.entity;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class TimesheetPeriod {

    private Long id;
    private String periodCode;
    private LocalDate startDate;
    private LocalDate endDate;
    private String status;
    private Long lockedById;
    private LocalDateTime lockedAt;

    public TimesheetPeriod() {
    }

    public TimesheetPeriod(Long id, String periodCode, LocalDate startDate, LocalDate endDate,
            String status, Long lockedById, LocalDateTime lockedAt) {
        this.id = id;
        this.periodCode = periodCode;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = status;
        this.lockedById = lockedById;
        this.lockedAt = lockedAt;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getPeriodCode() {
        return periodCode;
    }

    public void setPeriodCode(String periodCode) {
        this.periodCode = periodCode;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Long getLockedById() {
        return lockedById;
    }

    public void setLockedById(Long lockedById) {
        this.lockedById = lockedById;
    }

    public LocalDateTime getLockedAt() {
        return lockedAt;
    }

    public void setLockedAt(LocalDateTime lockedAt) {
        this.lockedAt = lockedAt;
    }
}
