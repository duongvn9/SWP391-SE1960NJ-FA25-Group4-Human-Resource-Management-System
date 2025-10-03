<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<jsp:include page="layout/header.jsp"/>

<div class="container mt-4">
    <h3>Yêu cầu tuyển dụng mới</h3>
    <form action="${pageContext.request.contextPath}/recruitment-request/create" method="post" class="needs-validation" novalidate>
        <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}" />

        <div class="mb-3">
            <label for="jobTitle" class="form-label">Tiêu đề vị trí <span class="text-danger">*</span></label>
            <input type="text" class="form-control" id="jobTitle" name="jobTitle" required maxlength="100" placeholder="VD: Lập trình viên Java">
            <div class="invalid-feedback">Vui lòng nhập tiêu đề vị trí.</div>
        </div>

        <div class="mb-3">
            <label for="headcount" class="form-label">Số lượng cần tuyển <span class="text-danger">*</span></label>
            <input type="number" class="form-control" id="headcount" name="headcount" min="1" max="100" required>
            <div class="invalid-feedback">Vui lòng nhập số lượng hợp lệ.</div>
        </div>

        <div class="mb-3">
            <label for="budget" class="form-label">Ngân sách dự kiến (VNĐ) <span class="text-danger">*</span></label>
            <input type="number" class="form-control" id="budget" name="budget" min="1000000" step="100000" required>
            <div class="invalid-feedback">Vui lòng nhập ngân sách hợp lệ.</div>
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">Mô tả chi tiết</label>
            <textarea class="form-control" id="description" name="description" rows="3" maxlength="1000"></textarea>
        </div>

        <!-- Nút gửi yêu cầu -->
        <button type="submit" class="btn btn-primary">Gửi yêu cầu</button>
        <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary">Hủy</a>

        <br>
    </br>
        <br>

        <br>

        <!-- Nút quay lại dashboard -->
        <button type="button" class="btn btn-success" onclick="window.location.href='${pageContext.request.contextPath}/dashboard'">Quay lại Dashboard</button>
    </form>
</div>

<jsp:include page="layout/footer.jsp"/>

<script>
document.addEventListener('DOMContentLoaded', () => {
    const form = document.querySelector('.needs-validation');

    form.addEventListener('submit', event => {
        event.preventDefault(); // Ngăn submit mặc định
        event.stopPropagation();

        if (!form.checkValidity()) {
            form.classList.add('was-validated');
            return; // Không gửi nếu form không hợp lệ
        }

        // Popup xác nhận
        if (confirm('Bạn có chắc chắn muốn gửi yêu cầu?')) {
            fetch(form.action, {
                method: 'POST',
                body: new FormData(form)
            })
            .then(response => {
                if (response.ok) {
                    alert('Yêu cầu đã được ghi nhận thành công!');
                    window.location.href = `${pageContext.request.contextPath}/dashboard`;
                } else {
                    alert('Có lỗi xảy ra, vui lòng thử lại.');
                }
            })
            .catch(error => {
                console.error(error);
                alert('Có lỗi xảy ra, vui lòng thử lại.');
            });
        }
    });
});
</script>
