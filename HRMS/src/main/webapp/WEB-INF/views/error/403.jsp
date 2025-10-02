<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Không có quyền truy cập - HRMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="text-center mt-5">
                    <!-- Error Icon -->
                    <div class="mb-4">
                        <i class="bi bi-shield-x display-1 text-danger"></i>
                    </div>
                    
                    <!-- Error Title -->
                    <h1 class="display-4 fw-bold text-danger mb-3">403</h1>
                    <h2 class="h4 mb-4">Không có quyền truy cập</h2>
                    
                    <!-- Error Message -->
                    <div class="alert alert-danger" role="alert">
                        <i class="bi bi-exclamation-triangle me-2"></i>
                        <c:choose>
                            <c:when test="${not empty errorMessage}">
                                <c:out value="${errorMessage}" />
                            </c:when>
                            <c:otherwise>
                                Bạn không có quyền truy cập trang này. Vui lòng liên hệ quản trị viên để được hỗ trợ.
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <!-- Additional Info -->
                    <p class="text-muted mb-4">
                        Trang bạn đang cố gắng truy cập yêu cầu quyền đặc biệt mà tài khoản của bạn không có.
                    </p>
                    
                    <!-- Action Buttons -->
                    <div class="d-flex justify-content-center gap-3 flex-wrap">
                        <a href="${pageContext.request.contextPath}/dashboard" 
                           class="btn btn-primary">
                            <i class="bi bi-house-door me-2"></i>Về Dashboard
                        </a>
                        
                        <button type="button" 
                                class="btn btn-outline-secondary"
                                onclick="history.back()">
                            <i class="bi bi-arrow-left me-2"></i>Quay lại
                        </button>
                        
                        <a href="${pageContext.request.contextPath}/contact" 
                           class="btn btn-outline-info">
                            <i class="bi bi-envelope me-2"></i>Liên hệ hỗ trợ
                        </a>
                    </div>
                    
                    <!-- User Info -->
                    <c:if test="${not empty sessionScope.userFullName}">
                        <div class="card mt-4">
                            <div class="card-body">
                                <h6 class="card-title mb-2">
                                    <i class="bi bi-person-circle me-2"></i>Thông tin tài khoản
                                </h6>
                                <p class="card-text mb-1">
                                    <strong>Họ tên:</strong> 
                                    <c:out value="${sessionScope.userFullName}" />
                                </p>
                                <p class="card-text mb-1">
                                    <strong>Email:</strong> 
                                    <c:out value="${sessionScope.userEmail}" />
                                </p>
                                <p class="card-text mb-0">
                                    <strong>Quyền hiện tại:</strong> 
                                    <span class="badge bg-secondary">
                                        <c:out value="${sessionScope.userRole}" />
                                    </span>
                                </p>
                            </div>
                        </div>
                    </c:if>
                    
                    <!-- Footer Info -->
                    <div class="mt-5">
                        <small class="text-muted">
                            <i class="bi bi-info-circle me-1"></i>
                            Nếu bạn tin rằng đây là lỗi, vui lòng liên hệ với quản trị viên hệ thống.
                        </small>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>