<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý tài khoản - HRMS</title>
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
                        <i class="bi bi-people-fill me-2"></i>Quản lý tài khoản
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/accounts/create" 
                           class="btn btn-primary">
                            <i class="bi bi-plus-circle me-1"></i>Tạo tài khoản mới
                        </a>
                    </div>
                </div>

                <!-- Filters -->
                <div class="card mb-4">
                    <div class="card-body py-2">
                        <div class="row align-items-center">
                            <div class="col-md-6">
                                <h6 class="mb-0">Bộ lọc</h6>
                            </div>
                            <div class="col-md-6 text-end">
                                <div class="form-check form-switch d-inline-block">
                                    <input class="form-check-input" type="checkbox" id="showInactiveAccounts" 
                                           onchange="toggleInactiveAccounts()">
                                    <label class="form-check-label" for="showInactiveAccounts">
                                        Hiển thị tài khoản đã vô hiệu hóa
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Success/Error Messages -->
                <c:if test="${not empty sessionScope.successMessage}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="bi bi-check-circle me-2"></i>
                        <c:out value="${sessionScope.successMessage}" />
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <c:remove var="successMessage" scope="session" />
                </c:if>

                <c:if test="${not empty sessionScope.errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle me-2"></i>
                        <c:out value="${sessionScope.errorMessage}" />
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <c:remove var="errorMessage" scope="session" />
                </c:if>

                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle me-2"></i>
                        <c:out value="${errorMessage}" />
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Accounts Table -->
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0">Danh sách tài khoản</h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty accounts}">
                                <div class="text-center py-4">
                                    <i class="bi bi-inbox display-4 text-muted"></i>
                                    <p class="text-muted mt-3">Chưa có tài khoản nào</p>
                                    <a href="${pageContext.request.contextPath}/admin/accounts/create" 
                                       class="btn btn-primary">
                                        <i class="bi bi-plus-circle me-1"></i>Tạo tài khoản đầu tiên
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle">
                                        <thead class="table-light">
                                            <tr>
                                                <th>ID</th>
                                                <th>Username</th>
                                                <th>Họ tên</th>
                                                <th>Email</th>
                                                <th>Số điện thoại</th>
                                                <th>Roles</th>
                                                <th>Trạng thái</th>
                                                <th>Ngày tạo</th>
                                                <th class="text-center">Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="account" items="${accounts}">
                                                <tr data-active="${account.active}">
                                                    <td>
                                                        <span class="badge bg-secondary">${account.accountId}</span>
                                                    </td>
                                                    <td>
                                                        <strong><c:out value="${account.username}" /></strong>
                                                    </td>
                                                    <td>
                                                        <c:out value="${account.userFullName}" />
                                                    </td>
                                                    <td>
                                                        <c:out value="${account.userEmail}" />
                                                    </td>
                                                    <td>
                                                        <c:out value="${account.userPhone != null ? account.userPhone : 'Chưa có'}" />
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty account.roles}">
                                                                <c:forEach var="role" items="${account.roles}" varStatus="status">
                                                                    <span class="badge bg-info me-1">
                                                                        <c:out value="${role.roleName}" />
                                                                    </span>
                                                                </c:forEach>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">Chưa có role</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
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
                                                    </td>
                                                    <td>
                                                        <c:out value="${account.createdAt}" />
                                                    </td>
                                                    <td class="text-center">
                                                        <div class="btn-group" role="group">
                                                            <!-- Edit Button -->
                                                            <a href="${pageContext.request.contextPath}/admin/accounts/edit?id=${account.accountId}" 
                                                               class="btn btn-outline-primary btn-sm" 
                                                               title="Chỉnh sửa">
                                                                <i class="bi bi-pencil"></i>
                                                            </a>
                                                            
                                                            <!-- Toggle Status Button -->
                                                            <button type="button" 
                                                                    class="btn btn-outline-warning btn-sm" 
                                                                    title="${account.active ? 'Vô hiệu hóa' : 'Kích hoạt'}"
                                                                    data-account-id="${account.accountId}"
                                                                    data-username="${account.username}"
                                                                    data-is-active="${account.active}"
                                                                    onclick="toggleAccountStatus(this.dataset.accountId, this.dataset.username, this.dataset.isActive === 'true')">
                                                                <i class="bi ${account.active ? 'bi-toggle-on' : 'bi-toggle-off'}"></i>
                                                            </button>
                                                            
                                                            <!-- Delete Button -->
                                                            <button type="button" 
                                                                    class="btn btn-outline-danger btn-sm" 
                                                                    title="Xóa"
                                                                    data-account-id="${account.accountId}"
                                                                    data-username="${account.username}"
                                                                    onclick="deleteAccount(this.dataset.accountId, this.dataset.username)">
                                                                <i class="bi bi-trash"></i>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="bi bi-exclamation-triangle text-warning me-2"></i>
                        Xác nhận xóa
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xóa tài khoản <strong id="deleteAccountName"></strong>?</p>
                    <p class="text-muted">Hành động này sẽ vô hiệu hóa tài khoản và không thể hoàn tác.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <form id="deleteForm" method="post" style="display: inline;">
                        <input type="hidden" name="id" id="deleteAccountId">
                        <button type="submit" class="btn btn-danger">
                            <i class="bi bi-trash me-1"></i>Xóa
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Toggle Status Confirmation Modal -->
    <div class="modal fade" id="toggleStatusModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="bi bi-toggle2-off text-warning me-2"></i>
                        Thay đổi trạng thái
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn <span id="toggleAction"></span> tài khoản <strong id="toggleAccountName"></strong>?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <form id="toggleForm" method="post" style="display: inline;">
                        <input type="hidden" name="id" id="toggleAccountId">
                        <button type="submit" class="btn btn-warning">
                            <i class="bi bi-toggle2-off me-1"></i>Thay đổi
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Ẩn/hiện tài khoản deactive - gọi khi trang load
        document.addEventListener('DOMContentLoaded', function() {
            // Mặc định ẩn tài khoản inactive
            toggleInactiveAccounts();
        });
        
        function toggleInactiveAccounts() {
            const showInactive = document.getElementById('showInactiveAccounts').checked;
            const inactiveRows = document.querySelectorAll('tr[data-active="false"]');
            
            inactiveRows.forEach(row => {
                if (showInactive) {
                    row.style.display = ''; // Hiển thị
                } else {
                    row.style.display = 'none'; // Ẩn
                }
            });
        }
    
        function deleteAccount(accountId, username) {
            document.getElementById('deleteAccountId').value = accountId;
            document.getElementById('deleteAccountName').textContent = username;
            document.getElementById('deleteForm').action = '${pageContext.request.contextPath}/admin/accounts/delete';
            
            const modal = new bootstrap.Modal(document.getElementById('deleteModal'));
            modal.show();
        }

        function toggleAccountStatus(accountId, username, isActive) {
            document.getElementById('toggleAccountId').value = accountId;
            document.getElementById('toggleAccountName').textContent = username;
            document.getElementById('toggleAction').textContent = isActive ? 'vô hiệu hóa' : 'kích hoạt';
            document.getElementById('toggleForm').action = '${pageContext.request.contextPath}/admin/accounts/toggle-status';
            
            const modal = new bootstrap.Modal(document.getElementById('toggleStatusModal'));
            modal.show();
        }
    </script>
</body>
</html>