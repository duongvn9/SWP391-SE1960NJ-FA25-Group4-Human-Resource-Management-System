
package group4.hrms.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import group4.hrms.entity.RecruitmentRequest;
import group4.hrms.repository.RecruitmentRequestRepository;

public class RecruitmentRequestService {
    private static final Logger logger = LoggerFactory.getLogger(RecruitmentRequestService.class);
    private final RecruitmentRequestRepository repo = new RecruitmentRequestRepository();

    /**
     * Kiểm tra ràng buộc dữ liệu yêu cầu tuyển dụng.
     * @param req RecruitmentRequest
     * @return null nếu hợp lệ, ngược lại trả về thông báo lỗi
     */
    public String validate(RecruitmentRequest req) {
        if (req == null) return "Dữ liệu không hợp lệ.";
        if (req.getJobTitle() == null || req.getJobTitle().isBlank()) return "Tiêu đề không được để trống.";
        if (req.getHeadcount() < 1 || req.getHeadcount() > 100) return "Số lượng không hợp lệ.";
        if (req.getBudget() < 1_000_000) return "Ngân sách không hợp lệ.";
        return null;
    }

    /**
     * Tạo mới yêu cầu tuyển dụng.
     * @param req RecruitmentRequest
     * @return id nếu thành công, -1 nếu lỗi
     */
    public long createRequest(RecruitmentRequest req) {
        String error = validate(req);
        if (error != null) {
            logger.info("Tạo yêu cầu tuyển dụng thất bại: {}", error);
            return -1;
        }
        long id = repo.save(req);
        if (id > 0) {
            logger.info("Tạo yêu cầu tuyển dụng thành công, id={}", id);
        } else {
            logger.error("Lỗi khi lưu yêu cầu tuyển dụng vào DB.");
        }
        return id;
    }
}