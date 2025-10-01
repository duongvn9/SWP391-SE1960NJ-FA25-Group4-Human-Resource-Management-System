<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa tài khoản - HRMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
    <!-- Header -->
    <jsp:include page="../../layout/header.jsp" />

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <jsp:include page="../../layout/sidebar.jsp" />

            <!-- Main Content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">
                        <i class="bi bi-pencil-square me-2"></i>Chỉnh sửa tài khoản
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/accounts" 
                           class="btn btn-outline-secondary">
                            <i class="bi bi-arrow-left me-1"></i>Quay lại
                        </a>
                    </div>
                </div>

                <!-- Error Messages -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle me-2"></i>
                        <c:out value="${errorMessage}" />
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Edit Account Form -->
                <div class="row">
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Thông tin tài khoản</h5>
                            </div>
                            <div class="card-body">
                                <form method="post" action="${pageContext.request.contextPath}/admin/accounts/edit" 
                                      id="editAccountForm">
                                    <input type="hidden" name="accountId" value="${account.accountId}">

                                    <!-- User Info (Read-only) -->
                                    <div class="mb-3">
                                        <label class="form-label">
                                            <i class="bi bi-person me-1"></i>Người dùng
                                        </label>
                                        <div class="card bg-light">
                                            <div class="card-body py-2">
                                                <div class="row align-items-center">
                                                    <div class="col">
                                                        <strong><c:out value="${account.userFullName}" /></strong>
                                                        <br>
                                                        <small class="text-muted">
                                                            <i class="bi bi-envelope me-1"></i>
                                                            <c:out value="${account.userEmail}" />
                                                            <c:if test="${not empty account.userPhone}">
                                                                | <i class="bi bi-telephone me-1"></i>
                                                                <c:out value="${account.userPhone}" />
                                                            </c:if>
                                                        </small>
                                                    </div>
                                                    <div class="col-auto">
                                                        <span class="badge bg-secondary">ID: ${account.userId}</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Username -->
                                    <div class="mb-3">
                                        <label for="username" class="form-label">
                                            <i class="bi bi-at me-1"></i>Tên đăng nhập
                                            <span class="text-danger">*</span>
                                        </label>
                                        <input type="text" 
                                               class="form-control" 
                                               id="username" 
                                               name="username" 
                                               value="${account.username}"
                                               required 
                                               minlength="3" 
                                               maxlength="50"
                                               pattern="[a-zA-Z0-9._@-]+">
                                        <div class="form-text">
                                            Tên đăng nhập phải có từ 3-50 ký tự, chỉ được chứa chữ cái, số và các ký tự . _ @ -
                                        </div>
                                    </div>

                                    <!-- New Password (Optional) -->
                                    <div class="mb-3">
                                        <label for="newPassword" class="form-label">
                                            <i class="bi bi-lock me-1"></i>Mật khẩu mới
                                            <small class="text-muted">(để trống nếu không thay đổi)</small>
                                        </label>
                                        <div class="input-group">
                                            <input type="password" 
                                                   class="form-control" 
                                                   id="newPassword" 
                                                   name="newPassword" 
                                                   minlength="6">
                                            <button class="btn btn-outline-secondary" 
                                                    type="button" 
                                                    id="toggleNewPassword">
                                                <i class="bi bi-eye"></i>
                                            </button>
                                        </div>
                                        <div class="form-text">Để trống nếu không muốn thay đổi mật khẩu</div>
                                    </div>

                                    <!-- Confirm New Password -->
                                    <div class="mb-3">
                                        <label for="confirmPassword" class="form-label">
                                            <i class="bi bi-lock-fill me-1"></i>Xác nhận mật khẩu mới
                                        </label>
                                        <input type="password" 
                                               class="form-control" 
                                               id="confirmPassword" 
                                               name="confirmPassword">
                                        <div class="invalid-feedback" id="passwordMismatch">
                                            Mật khẩu xác nhận không khớp
                                        </div>
                                    </div>

                                    <!-- Current Roles Display -->
                                    <div class="mb-3">
                                        <label class="form-label">
                                            <i class="bi bi-shield-check me-1"></i>Quyền hiện tại
                                        </label>
                                        <div class="mb-2">
                                            <c:choose>
                                                <c:when test="${not empty account.roles}">
                                                    <c:forEach var="role" items="${account.roles}">
                                                        <span class="badge bg-info me-1">
                                                            <c:out value="${role.roleName}" />
                                                        </span>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">Chưa có quyền nào</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>

                                    <!-- New Roles -->
                                    <div class="mb-3">
                                        <label class="form-label">
                                            <i class="bi bi-shield-plus me-1"></i>Cập nhật phân quyền
                                        </label>
                                        <div class="row">
                                            <c:forEach var="role" items="${roles}">
                                                <div class="col-md-6 mb-2">
                                                    <div class="form-check">
                                                        <input class="form-check-input" 
                                                               type="checkbox" 
                                                               id="role_${role.id}" 
                                                               name="roleIds" 
                                                               value="${role.id}"
                                                               <c:forEach var="currentRole" items="${account.roles}">
                                                                   <c:if test="${currentRole.roleId == role.id}">checked</c:if>
                                                               </c:forEach>>
                                                        <label class="form-check-label" for="role_${role.id}">
                                                            <strong><c:out value="${role.name}" /></strong>
                                                            <br>
                                                            <small class="text-muted">
                                                                <c:out value="${role.code}" />
                                                            </small>
                                                        </label>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                        <div class="form-text">Chọn các quyền mới cho tài khoản này</div>
                                    </div>

                                    <!-- Active Status -->
                                    <div class="mb-3">
                                        <div class="form-check form-switch">
                                            <input class="form-check-input" 
                                                   type="checkbox" 
                                                   id="isActive" 
                                                   name="isActive" 
                                                   value="true"
                                                   ${account.active ? 'checked' : ''}>
                                            <label class="form-check-label" for="isActive">
                                                <i class="bi bi-toggle-on me-1"></i>Tài khoản hoạt động
                                            </label>
                                        </div>
                                        <div class="form-text">
                                            Tài khoản sẽ ${account.active ? 'tiếp tục' : 'được'} có thể đăng nhập
                                        </div>
                                    </div>

                                    <!-- Submit Buttons -->
                                    <div class="d-flex justify-content-end gap-2">
                                        <a href="${pageContext.request.contextPath}/admin/accounts" 
                                           class="btn btn-secondary">
                                            <i class="bi bi-x-circle me-1"></i>Hủy
                                        </a>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="bi bi-check-circle me-1"></i>Cập nhật tài khoản
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Account Info Panel -->
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-header">
                                <h6 class="card-title mb-0">
                                    <i class="bi bi-info-circle me-1"></i>Thông tin tài khoản
                                </h6>
                            </div>
                            <div class="card-body">
                                <dl class="row">
                                    <dt class="col-sm-5">ID tài khoản:</dt>
                                    <dd class="col-sm-7">
                                        <span class="badge bg-secondary">${account.accountId}</span>
                                    </dd>
                                    
                                    <dt class="col-sm-5">Trạng thái:</dt>
                                    <dd class="col-sm-7">
                                        <c:choose>
                                            <c:when test="${account.active}">
                                                <span class="badge bg-success">
                                                    <i class="bi bi-check-circle me-1"></i>Hoạt động
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger">
                                                    <i class="bi bi-x-circle me-1"></i>Không hoạt động
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </dd>
                                    
                                    <dt class="col-sm-5">Ngày tạo:</dt>
                                    <dd class="col-sm-7">
                                        <fmt:formatDate value="${account.createdAt}" 
                                                      pattern="dd/MM/yyyy HH:mm" />
                                    </dd>
                                    
                                    <dt class="col-sm-5">Số quyền:</dt>
                                    <dd class="col-sm-7">
                                        <span class="badge bg-info">${fn:length(account.roles)}</span>
                                    </dd>
                                </dl>
                            </div>
                        </div>

                        <!-- Security Notice -->
                        <div class="card mt-3">
                            <div class="card-header bg-warning text-dark">
                                <h6 class="card-title mb-0">
                                    <i class="bi bi-shield-exclamation me-1"></i>Lưu ý bảo mật
                                </h6>
                            </div>
                            <div class="card-body">
                                <ul class="small mb-0">
                                    <li class="mb-2">Chỉ thay đổi mật khẩu khi thực sự cần thiết</li>
                                    <li class="mb-2">Chọn mật khẩu mạnh có ít nhất 6 ký tự</li>
                                    <li class="mb-2">Phân quyền chỉ những gì cần thiết cho công việc</li>
                                    <li>Vô hiệu hóa tài khoản khi không còn sử dụng</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Toggle password visibility
            const toggleNewPassword = document.getElementById('toggleNewPassword');
            const newPasswordField = document.getElementById('newPassword');
            
            toggleNewPassword.addEventListener('click', function() {
                const type = newPasswordField.getAttribute('type') === 'password' ? 'text' : 'password';
                newPasswordField.setAttribute('type', type);
                
                const icon = this.querySelector('i');
                icon.classList.toggle('bi-eye');
                icon.classList.toggle('bi-eye-slash');
            });

            // Password confirmation validation
            const confirmPasswordField = document.getElementById('confirmPassword');
            const form = document.getElementById('editAccountForm');
            
            function validatePasswordMatch() {
                const newPassword = newPasswordField.value;
                const confirmPassword = confirmPasswordField.value;
                
                // Only validate if new password is entered
                if (newPassword && confirmPassword && newPassword !== confirmPassword) {
                    confirmPasswordField.setCustomValidity('Mật khẩu xác nhận không khớp');
                    confirmPasswordField.classList.add('is-invalid');
                } else {
                    confirmPasswordField.setCustomValidity('');
                    confirmPasswordField.classList.remove('is-invalid');
                }
            }

            newPasswordField.addEventListener('input', validatePasswordMatch);
            confirmPasswordField.addEventListener('input', validatePasswordMatch);

            // Form submission validation
            form.addEventListener('submit', function(e) {
                validatePasswordMatch();
                
                if (!form.checkValidity()) {
                    e.preventDefault();
                    e.stopPropagation();
                }
                
                form.classList.add('was-validated');
            });
        });
    </script>
</body>
</html>