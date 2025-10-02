<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tạo tài khoản mới - HRMS</title>
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
                        <i class="bi bi-person-plus-fill me-2"></i>Tạo tài khoản mới
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

                <!-- Create Account Form -->
                <div class="row">
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Thông tin tài khoản</h5>
                            </div>
                            <div class="card-body">
                                <form method="post" action="${pageContext.request.contextPath}/admin/accounts/create" 
                                      id="createAccountForm">
                                    <!-- Thông tin người dùng mới -->
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="fullName" class="form-label">
                                                <i class="bi bi-person me-1"></i>Họ và tên
                                                <span class="text-danger">*</span>
                                            </label>
                                            <input type="text" class="form-control" id="fullName" name="fullName" required 
                                                   maxlength="100" placeholder="Nhập họ và tên đầy đủ"
                                                   value="${param.fullName}">
                                            <div class="form-text">Họ và tên đầy đủ của người dùng mới</div>
                                        </div>
                                        
                                        <div class="col-md-6 mb-3">
                                            <label for="email" class="form-label">
                                                <i class="bi bi-envelope me-1"></i>Email
                                                <span class="text-danger">*</span>
                                            </label>
                                            <input type="email" class="form-control" id="email" name="email" required 
                                                   maxlength="100" placeholder="user@company.com"
                                                   value="${param.email}">
                                            <div class="form-text">Email liên hệ và có thể dùng để đăng nhập</div>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="phone" class="form-label">
                                                <i class="bi bi-telephone me-1"></i>Số điện thoại
                                            </label>
                                            <input type="tel" class="form-control" id="phone" name="phone" 
                                                   maxlength="15" placeholder="0901234567"
                                                   value="${param.phone}">
                                            <div class="form-text">Số điện thoại liên hệ (không bắt buộc)</div>
                                        </div>
                                        
                                        <div class="col-md-6 mb-3">
                                            <label for="department" class="form-label">
                                                <i class="bi bi-building me-1"></i>Phòng ban
                                            </label>
                                            <select class="form-select" id="department" name="departmentId">
                                                <option value="">-- Chọn phòng ban --</option>
                                                <c:forEach var="dept" items="${departments}">
                                                    <option value="${dept.id}" ${param.departmentId == dept.id ? 'selected' : ''}>
                                                        <c:out value="${dept.name}" />
                                                    </option>
                                                </c:forEach>
                                            </select>
                                            <div class="form-text">Phòng ban làm việc (không bắt buộc)</div>
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
                                               value="${param.username}"
                                               required 
                                               minlength="3" 
                                               maxlength="50"
                                               pattern="[a-zA-Z0-9._@-]+">
                                        <div class="form-text">
                                            Tên đăng nhập phải có từ 3-50 ký tự, chỉ được chứa chữ cái, số và các ký tự . _ @ -
                                        </div>
                                    </div>

                                    <!-- Password -->
                                    <div class="mb-3">
                                        <label for="password" class="form-label">
                                            <i class="bi bi-lock me-1"></i>Mật khẩu
                                            <span class="text-danger">*</span>
                                        </label>
                                        <div class="input-group">
                                            <input type="password" 
                                                   class="form-control" 
                                                   id="password" 
                                                   name="password" 
                                                   required 
                                                   minlength="6">
                                            <button class="btn btn-outline-secondary" 
                                                    type="button" 
                                                    id="togglePassword">
                                                <i class="bi bi-eye"></i>
                                            </button>
                                        </div>
                                        <div class="form-text">Mật khẩu phải có ít nhất 6 ký tự</div>
                                    </div>

                                    <!-- Confirm Password -->
                                    <div class="mb-3">
                                        <label for="confirmPassword" class="form-label">
                                            <i class="bi bi-lock-fill me-1"></i>Xác nhận mật khẩu
                                            <span class="text-danger">*</span>
                                        </label>
                                        <input type="password" 
                                               class="form-control" 
                                               id="confirmPassword" 
                                               name="confirmPassword" 
                                               required>
                                        <div class="invalid-feedback" id="passwordMismatch">
                                            Mật khẩu xác nhận không khớp
                                        </div>
                                    </div>

                                    <!-- Roles -->
                                    <div class="mb-3">
                                        <label class="form-label">
                                            <i class="bi bi-shield-check me-1"></i>Phân quyền
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
                                                               ${paramValues.roleIds != null && 
                                                                 contains(paramValues.roleIds, role.id.toString()) ? 'checked' : ''}>
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
                                        <div class="form-text">Chọn các quyền cho tài khoản này</div>
                                    </div>

                                    <!-- Active Status -->
                                    <div class="mb-3">
                                        <div class="form-check form-switch">
                                            <input class="form-check-input" 
                                                   type="checkbox" 
                                                   id="isActive" 
                                                   name="isActive" 
                                                   value="true"
                                                   ${param.isActive != 'false' ? 'checked' : ''}>
                                            <label class="form-check-label" for="isActive">
                                                <i class="bi bi-toggle-on me-1"></i>Kích hoạt tài khoản ngay
                                            </label>
                                        </div>
                                        <div class="form-text">
                                            Tài khoản sẽ được kích hoạt và có thể đăng nhập ngay lập tức
                                        </div>
                                    </div>

                                    <!-- Submit Buttons -->
                                    <div class="d-flex justify-content-end gap-2">
                                        <a href="${pageContext.request.contextPath}/admin/accounts" 
                                           class="btn btn-secondary">
                                            <i class="bi bi-x-circle me-1"></i>Hủy
                                        </a>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="bi bi-plus-circle me-1"></i>Tạo tài khoản
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Info Panel -->
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-header">
                                <h6 class="card-title mb-0">
                                    <i class="bi bi-info-circle me-1"></i>Hướng dẫn
                                </h6>
                            </div>
                            <div class="card-body">
                                <div class="mb-3">
                                    <h6><i class="bi bi-1-circle text-primary me-2"></i>Chọn người dùng</h6>
                                    <p class="small text-muted">Chọn người dùng từ danh sách những người chưa có tài khoản đăng nhập.</p>
                                </div>
                                
                                <div class="mb-3">
                                    <h6><i class="bi bi-2-circle text-primary me-2"></i>Đặt tên đăng nhập</h6>
                                    <p class="small text-muted">Tên đăng nhập phải duy nhất và dễ nhớ. Có thể sử dụng email hoặc tên viết tắt.</p>
                                </div>
                                
                                <div class="mb-3">
                                    <h6><i class="bi bi-3-circle text-primary me-2"></i>Đặt mật khẩu an toàn</h6>
                                    <p class="small text-muted">Mật khẩu nên có ít nhất 6 ký tự, bao gồm chữ và số để đảm bảo an toàn.</p>
                                </div>
                                
                                <div>
                                    <h6><i class="bi bi-4-circle text-primary me-2"></i>Phân quyền</h6>
                                    <p class="small text-muted">Chọn các quyền phù hợp với vai trò của người dùng trong hệ thống.</p>
                                </div>
                            </div>
                        </div>

                        <!-- Available Users Count -->
                        <div class="card mt-3">
                            <div class="card-body text-center">
                                <i class="bi bi-people display-6 text-muted mb-2"></i>
                                <h5>${fn:length(availableUsers)}</h5>
                                <p class="text-muted mb-0">Người dùng chưa có tài khoản</p>
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
            const togglePassword = document.getElementById('togglePassword');
            const passwordField = document.getElementById('password');
            
            togglePassword.addEventListener('click', function() {
                const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
                passwordField.setAttribute('type', type);
                
                const icon = this.querySelector('i');
                icon.classList.toggle('bi-eye');
                icon.classList.toggle('bi-eye-slash');
            });

            // Auto-suggest username from email
            const userSelect = document.getElementById('userId');
            const usernameField = document.getElementById('username');
            
            userSelect.addEventListener('change', function() {
                if (this.value) {
                    const selectedOption = this.options[this.selectedIndex];
                    const email = selectedOption.getAttribute('data-email');
                    
                    if (email && !usernameField.value.trim()) {
                        // Suggest username from email (part before @)
                        const suggestedUsername = email.split('@')[0];
                        usernameField.value = suggestedUsername;
                    }
                }
            });

            // Password confirmation validation
            const confirmPasswordField = document.getElementById('confirmPassword');
            const form = document.getElementById('createAccountForm');
            
            function validatePasswordMatch() {
                const password = passwordField.value;
                const confirmPassword = confirmPasswordField.value;
                
                if (confirmPassword && password !== confirmPassword) {
                    confirmPasswordField.setCustomValidity('Mật khẩu xác nhận không khớp');
                    confirmPasswordField.classList.add('is-invalid');
                } else {
                    confirmPasswordField.setCustomValidity('');
                    confirmPasswordField.classList.remove('is-invalid');
                }
            }

            passwordField.addEventListener('input', validatePasswordMatch);
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