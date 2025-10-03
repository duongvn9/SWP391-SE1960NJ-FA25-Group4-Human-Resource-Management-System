<!-- File: WEB-INF/views/job_posting_form.jsp -->
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<jsp:include page="/layout/header.jsp"/>

<div class="container mt-4">
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <h3>Job Posting</h3>
    <form action="${pageContext.request.contextPath}/job-posting/create" method="post" class="needs-validation" novalidate>
        <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}" />

        <div class="mb-3">
            <label for="requestId" class="form-label">Request ID</label>
            <input type="number" class="form-control" id="requestId" name="requestId"
                   value="${param.requestId}">
        </div>

        <div class="mb-3">
            <label for="title" class="form-label">Title <span class="text-danger">*</span></label>
            <input type="text" class="form-control" id="title" name="title" maxlength="255" required
                   value="${param.title}">
            <div class="invalid-feedback">Vui lòng nhập tiêu đề.</div>
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">Description</label>
            <textarea class="form-control" id="description" name="description" rows="3">${param.description}</textarea>
        </div>

        <div class="mb-3">
            <label for="criteria" class="form-label">Criteria (JSON)</label>
            <textarea class="form-control" id="criteria" name="criteria" rows="3">${param.criteria}</textarea>
        </div>

        <div class="mb-3">
            <label for="channel" class="form-label">Channel</label>
            <input type="text" class="form-control" id="channel" name="channel" maxlength="100"
                   value="${param.channel}">
        </div>

        <div class="mb-3">
            <label for="headcount" class="form-label">Planned Headcount</label>
            <input type="number" class="form-control" id="headcount" name="headcount" min="1"
                   value="${param.headcount}">
        </div>

        <button type="submit" class="btn btn-primary">Publish</button>
        <button type="button" class="btn btn-secondary"
                onclick="window.location.href='${pageContext.request.contextPath}/dashboard'">
            Quay lại Dashboard
        </button>
    </form>
</div>

<jsp:include page="/layout/footer.jsp"/>

<script>
document.addEventListener('DOMContentLoaded', () => {
    const form = document.querySelector('.needs-validation');

    form.addEventListener('submit', event => {
        event.preventDefault();
        event.stopPropagation();

        if (!form.checkValidity()) {
            form.classList.add('was-validated');
            return;
        }

        if (confirm('Bạn có chắc chắn muốn publish Job Posting này?')) {
            form.submit();
        }
    });
});
</script>
