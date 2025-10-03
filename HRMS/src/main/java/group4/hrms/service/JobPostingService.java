// File: src/main/java/group4/hrms/service/JobPostingService.java
package group4.hrms.service;

import group4.hrms.entity.JobPosting;
import group4.hrms.repository.JobPostingRepository;

public class JobPostingService {

    private final JobPostingRepository repository = new JobPostingRepository();

    public String validate(JobPosting job) {
        if (job.getTitle() == null || job.getTitle().trim().isEmpty()) return "Title không được bỏ trống";
        if (job.getStatus() != null && !job.getStatus().matches("DRAFT|PUBLISHED|ARCHIVED"))
            return "Status không hợp lệ";
        return null;
    }

    public boolean createJobPosting(JobPosting job) {
        long id = repository.save(job);
        return id != -1;
    }
}
