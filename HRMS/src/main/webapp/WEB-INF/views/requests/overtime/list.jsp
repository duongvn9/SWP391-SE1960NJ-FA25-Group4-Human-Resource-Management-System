<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách đơn xin làm thêm giờ - HRMS</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">

    <style>
        .status-badge {
            padding: 0.35rem 0.8rem;
            font-size: 0.875rem;
            border-radius: 15px;
            font-weight: 500;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
        }

        .status-approved {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .status-rejected {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .overtime-type-badge {
            padding: 0.25rem 0.6rem;
            font-size: 0.8rem;
            border-radius: 10px;
            font-weight: 500;
        }

        .type-weekday {
            background-color: #e7f3ff;
            color: #0056b3;
        }

        .type-weekend {
            background-color: #fff0e6;
            color: #cc7a00;
        }

        .type-holiday {
            background-color: #f0e6ff;
            color: #6600cc;
        }

        .page-header {
            background: linear-gradient(135deg, #FF6B6B 0%, #4ECDC4 100%);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
            border-radius: 0 0 15px 15px;
        }

        .stats-card {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.3s ease;
        }

        .stats-card:hover {
            transform: translateY(-5px);
        }

        .stats-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }

        .filter-card {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }

        .table-card {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .btn-action {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
            border-radius: 5px;
            margin: 0 0.1rem;
        }

        .hours-badge {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            padding: 0.3rem 0.7rem;
            border-radius: 12px;
            font-weight: 600;
        }

        .rate-info {
            font-size: 0.85rem;
            color: #6c757d;
        }
    </style>
</head>

<body>
    <div class="wrapper">
        <!-- Sidebar -->
        <jsp:include page="/WEB-INF/views/layout/sidebar.jsp" />

        <!-- Main Content -->
        <div class="main-content">
            <!-- Header -->
            <jsp:include page="/WEB-INF/views/layout/header.jsp" />

            <!-- Page Header -->
            <div class="page-header">
                <div class="container-fluid">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <h1 class="h3 mb-0">
                                <i class="fas fa-clock me-3"></i>
                                Danh sách đơn xin làm thêm giờ
                            </h1>
                            <p class="mb-0 opacity-75">Quản lý và theo dõi các đơn xin làm thêm giờ của bạn</p>
                        </div>
                        <div class="col-md-4 text-end">
                            <a href="${pageContext.request.contextPath}/requests/overtime/create" 
                               class="btn btn-light btn-lg">
                                <i class="fas fa-plus me-2"></i>Tạo đơn mới
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Success Message -->
            <c:if test="${not empty sessionScope.successMessage}">
                <div class="container-fluid">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>
                        ${sessionScope.successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </div>
                <c:remove var="successMessage" scope="session" />
            </c:if>

            <!-- Main Content -->
            <div class="container-fluid">
                <!-- Statistics Cards -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="stats-card">
                            <div class="stats-icon text-warning">
                                <i class="fas fa-clock"></i>
                            </div>
                            <h4 class="mb-1">8</h4>
                            <p class="text-muted mb-0">Đang chờ duyệt</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stats-card">
                            <div class="stats-icon text-success">
                                <i class="fas fa-check-circle"></i>
                            </div>
                            <h4 class="mb-1">32</h4>
                            <p class="text-muted mb-0">Đã duyệt</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stats-card">
                            <div class="stats-icon text-danger">
                                <i class="fas fa-times-circle"></i>
                            </div>
                            <h4 class="mb-1">3</h4>
                            <p class="text-muted mb-0">Bị từ chối</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stats-card">
                            <div class="stats-icon text-info">
                                <i class="fas fa-hourglass-half"></i>
                            </div>
                            <h4 class="mb-1">156.5</h4>
                            <p class="text-muted mb-0">Tổng giờ tháng này</p>
                        </div>
                    </div>
                </div>

                <!-- Filters -->
                <div class="filter-card">
                    <div class="row">
                        <div class="col-md-3">
                            <label class="form-label">Trạng thái</label>
                            <select class="form-select" id="statusFilter">
                                <option value="">Tất cả trạng thái</option>
                                <option value="pending">Đang chờ duyệt</option>
                                <option value="approved">Đã duyệt</option>
                                <option value="rejected">Bị từ chối</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Loại overtime</label>
                            <select class="form-select" id="typeFilter">
                                <option value="">Tất cả loại</option>
                                <option value="weekday">Ngày thường</option>
                                <option value="weekend">Cuối tuần</option>
                                <option value="holiday">Ngày lễ</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Từ ngày</label>
                            <input type="date" class="form-control" id="fromDate">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Đến ngày</label>
                            <input type="date" class="form-control" id="toDate">
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-md-6">
                            <input type="text" class="form-control" id="searchBox" 
                                   placeholder="Tìm kiếm theo lý do hoặc mô tả công việc...">
                        </div>
                        <div class="col-md-6">
                            <button class="btn btn-primary me-2" onclick="applyFilters()">
                                <i class="fas fa-search me-1"></i>Tìm kiếm
                            </button>
                            <button class="btn btn-outline-secondary" onclick="clearFilters()">
                                <i class="fas fa-times me-1"></i>Xóa bộ lọc
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Table -->
                <div class="table-card">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>Mã đơn</th>
                                    <th>Ngày làm thêm</th>
                                    <th>Thời gian</th>
                                    <th>Số giờ</th>
                                    <th>Loại</th>
                                    <th>Hệ số</th>
                                    <th>Lý do</th>
                                    <th>Trạng thái</th>
                                    <th>Ngày tạo</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody id="overtimeTableBody">
                                <!-- Demo data -->
                                <tr>
                                    <td><strong>OT001</strong></td>
                                    <td>15/01/2025</td>
                                    <td>18:00 - 22:00</td>
                                    <td><span class="hours-badge">4.0h</span></td>
                                    <td><span class="overtime-type-badge type-weekday">Ngày thường</span></td>
                                    <td>
                                        <span class="rate-info">x1.5</span>
                                    </td>
                                    <td class="text-truncate" style="max-width: 200px;">Hoàn thành báo cáo tháng</td>
                                    <td><span class="status-badge status-pending">Đang chờ duyệt</span></td>
                                    <td>14/01/2025</td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-primary btn-action" 
                                                onclick="viewOvertime('OT001')">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-warning btn-action" 
                                                onclick="editOvertime('OT001')">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger btn-action" 
                                                onclick="cancelOvertime('OT001')">
                                            <i class="fas fa-times"></i>
                                        </button>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>OT002</strong></td>
                                    <td>12/01/2025</td>
                                    <td>09:00 - 17:00</td>
                                    <td><span class="hours-badge">8.0h</span></td>
                                    <td><span class="overtime-type-badge type-weekend">Cuối tuần</span></td>
                                    <td>
                                        <span class="rate-info">x2.0</span>
                                    </td>
                                    <td class="text-truncate" style="max-width: 200px;">Xử lý sự cố hệ thống khẩn cấp</td>
                                    <td><span class="status-badge status-approved">Đã duyệt</span></td>
                                    <td>11/01/2025</td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-primary btn-action" 
                                                onclick="viewOvertime('OT002')">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>OT003</strong></td>
                                    <td>01/01/2025</td>
                                    <td>10:00 - 14:00</td>
                                    <td><span class="hours-badge">4.0h</span></td>
                                    <td><span class="overtime-type-badge type-holiday">Ngày lễ</span></td>
                                    <td>
                                        <span class="rate-info">x3.0</span>
                                    </td>
                                    <td class="text-truncate" style="max-width: 200px;">Bảo trì hệ thống ngày Tết</td>
                                    <td><span class="status-badge status-approved">Đã duyệt</span></td>
                                    <td>29/12/2024</td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-primary btn-action" 
                                                onclick="viewOvertime('OT003')">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>OT004</strong></td>
                                    <td>28/12/2024</td>
                                    <td>19:00 - 21:00</td>
                                    <td><span class="hours-badge">2.0h</span></td>
                                    <td><span class="overtime-type-badge type-weekday">Ngày thường</span></td>
                                    <td>
                                        <span class="rate-info">x1.5</span>
                                    </td>
                                    <td class="text-truncate" style="max-width: 200px;">Meeting với khách hàng quốc tế</td>
                                    <td><span class="status-badge status-rejected">Bị từ chối</span></td>
                                    <td>27/12/2024</td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-primary btn-action" 
                                                onclick="viewOvertime('OT004')">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination -->
                    <nav aria-label="Overtime pagination" class="mt-4">
                        <ul class="pagination justify-content-center">
                            <li class="page-item disabled">
                                <a class="page-link" href="#" tabindex="-1">Trước</a>
                            </li>
                            <li class="page-item active">
                                <a class="page-link" href="#">1</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="#">2</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="#">3</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="#">Sau</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>

            <!-- Footer -->
            <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Custom JavaScript -->
    <script>
        // Filter functions
        function applyFilters() {
            const status = document.getElementById('statusFilter').value;
            const type = document.getElementById('typeFilter').value;
            const fromDate = document.getElementById('fromDate').value;
            const toDate = document.getElementById('toDate').value;
            const search = document.getElementById('searchBox').value;

            // TODO: Implement filtering logic
            console.log('Filters applied:', { status, type, fromDate, toDate, search });
        }

        function clearFilters() {
            document.getElementById('statusFilter').value = '';
            document.getElementById('typeFilter').value = '';
            document.getElementById('fromDate').value = '';
            document.getElementById('toDate').value = '';
            document.getElementById('searchBox').value = '';
            
            // TODO: Reset table data
            console.log('Filters cleared');
        }

        // Action functions
        function viewOvertime(id) {
            window.location.href = `${pageContext.request.contextPath}/requests/overtime/view/${id}`;
        }

        function editOvertime(id) {
            // TODO: Implement edit functionality
            console.log('Edit overtime:', id);
        }

        function cancelOvertime(id) {
            if (confirm('Bạn có chắc chắn muốn hủy đơn này?')) {
                // TODO: Implement cancel functionality
                console.log('Cancel overtime:', id);
            }
        }

        // Auto-hide success message
        document.addEventListener('DOMContentLoaded', function() {
            const alert = document.querySelector('.alert-success');
            if (alert) {
                setTimeout(() => {
                    alert.classList.remove('show');
                    setTimeout(() => alert.remove(), 150);
                }, 5000);
            }
        });
    </script>
</body>

</html>