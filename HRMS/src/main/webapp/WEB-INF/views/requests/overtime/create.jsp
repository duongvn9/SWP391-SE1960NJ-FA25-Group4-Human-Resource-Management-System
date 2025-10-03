<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tạo đơn xin làm thêm giờ - HRMS</title>
    
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-color: #2c5aa0;
            --secondary-color: #f8f9fa;
            --success-color: #28a745;
            --danger-color: #dc3545;
            --warning-color: #ffc107;
            --info-color: #17a2b8;
            --sidebar-width: 260px;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f6f9;
            overflow-x: hidden;
        }

        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: var(--sidebar-width);
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            transition: all 0.3s ease;
            z-index: 1000;
            overflow-y: auto;
            overflow-x: hidden;
        }

        .sidebar.collapsed {
            width: 70px;
        }

        .sidebar-header {
            padding: 1.5rem;
            text-align: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            white-space: nowrap;
            overflow: hidden;
        }

        .sidebar-header h4 {
            margin: 0;
            font-weight: bold;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .sidebar-header small {
            display: block;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .sidebar-nav {
            padding: 1rem 0;
        }

        .nav-item {
            margin: 0.2rem 0;
        }

        .nav-link {
            color: rgba(255, 255, 255, 0.8) !important;
            padding: 12px 20px;
            border-radius: 0;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            text-decoration: none;
            white-space: nowrap;
            overflow: hidden;
        }

        .nav-link:hover,
        .nav-link.active {
            background: rgba(255, 255, 255, 0.1);
            color: white !important;
            transform: translateX(5px);
        }

        .nav-link i {
            width: 20px;
            margin-right: 10px;
            text-align: center;
            font-size: 1.1rem;
        }

        /* Sidebar Dropdown Styles */
        .sidebar .dropdown-menu {
            background: rgba(255, 255, 255, 0.1) !important;
            border: none !important;
            margin-left: 0;
            padding: 0;
        }

        .sidebar .dropdown-menu .nav-link {
            color: rgba(255, 255, 255, 0.7) !important;
            padding: 8px 20px;
            font-size: 0.9rem;
        }

        .sidebar .dropdown-menu .nav-link:hover {
            background: rgba(255, 255, 255, 0.15) !important;
            color: white !important;
            transform: translateX(3px);
        }

        .sidebar .dropdown-toggle::after {
            margin-left: auto;
        }

        .main-content {
            margin-left: var(--sidebar-width);
            min-height: 100vh;
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
        }

        .main-content.expanded {
            margin-left: 70px;
        }

        .top-navbar {
            background: white;
            padding: 1rem 2rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .toggle-sidebar {
            background: none;
            border: none;
            font-size: 1.2rem;
            color: var(--primary-color);
            cursor: pointer;
        }

        .content-area {
            flex: 1;
            padding: 2rem;
        }

        .form-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .form-card h2 {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
        }

        .form-card h2 i {
            margin-right: 0.5rem;
            font-size: 1.2rem;
        }

        .form-group {
            margin-bottom: 1.25rem;
        }

        .form-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 0.5rem;
        }

        .form-control, .form-select {
            border: 2px solid #e9ecef;
            border-radius: 8px;
            padding: 0.75rem 1rem;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(44, 90, 160, 0.25);
        }

        .btn-primary {
            background: linear-gradient(45deg, var(--primary-color), #4a6bc5);
            border: none;
            border-radius: 8px;
            padding: 0.75rem 2rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background: linear-gradient(45deg, #1e3a6f, var(--primary-color));
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(44, 90, 160, 0.4);
        }

        .btn-secondary {
            background: #6c757d;
            border: none;
            border-radius: 8px;
            padding: 0.75rem 2rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            background: #545b62;
            transform: translateY(-2px);
        }

        .user-info {
            display: flex;
            align-items: center;
            margin-left: auto;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--primary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            margin-right: 10px;
        }

        .breadcrumb {
            background: none;
            padding: 0;
            margin-bottom: 1.5rem;
        }

        .breadcrumb-item a {
            color: var(--primary-color);
            text-decoration: none;
        }

        .breadcrumb-item.active {
            color: #6c757d;
        }

        .time-input-group {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .time-input-group .form-control {
            flex: 1;
        }

        .invalid-feedback {
            display: block;
            width: 100%;
            margin-top: 0.25rem;
            font-size: 0.875rem;
            color: var(--danger-color);
        }

        .alert-info {
            background-color: #e3f2fd;
            border-color: #bbdefb;
            color: #1976d2;
        }

        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
            }

            .sidebar.show {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
            }

            .content-area {
                padding: 1rem;
            }

            .time-input-group {
                flex-direction: column;
                align-items: stretch;
            }
        }
    </style>
</head>

<body>
    <!-- Include Sidebar -->
    <jsp:include page="/WEB-INF/views/layout/sidebar.jsp" />

    <!-- Main Content -->
    <div class="main-content" id="main-content">
        <!-- Top Navigation -->
        <div class="top-navbar">
            <button class="toggle-sidebar" id="toggle-sidebar">
                <i class="fas fa-bars"></i>
            </button>

            <div class="user-info">
                <div class="user-avatar">
                    <i class="fas fa-user"></i>
                </div>
                <div class="dropdown">
                    <button class="btn btn-link dropdown-toggle" type="button" data-bs-toggle="dropdown">
                        ${sessionScope.userFullName != null ? sessionScope.userFullName : 'User'}
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/dashboard">
                            <i class="fas fa-tachometer-alt me-2"></i>Dashboard</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">
                            <i class="fas fa-user-cog me-2"></i>Cài đặt</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/auth/logout">
                            <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Content Area -->
        <div class="content-area">
            <!-- Breadcrumb -->
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="#">Đơn từ</a></li>
                    <li class="breadcrumb-item active">Tạo đơn OT</li>
                </ol>
            </nav>

            <!-- Form Card -->
            <div class="form-card">
                <h2><i class="fas fa-clock"></i>Tạo đơn xin làm thêm giờ</h2>

                <!-- Success/Error Messages -->
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>
                        <c:out value="${successMessage}" />
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        <c:out value="${errorMessage}" />
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Info Alert -->
                <div class="alert alert-info mb-4">
                    <i class="fas fa-info-circle me-2"></i>
                    <strong>Lưu ý:</strong> Đơn xin làm thêm giờ cần được gửi trước ít nhất 24 giờ và phải được quản lý phê duyệt.
                </div>

                <!-- OT Request Form -->
                <form method="post" action="${pageContext.request.contextPath}/requests/overtime/create">
                    <!-- CSRF Token -->
                    <input type="hidden" name="csrfToken" value="${csrfToken}"/>

                    <div class="row">
                        <!-- Left Column -->
                        <div class="col-md-6">
                            <!-- Request Date -->
                            <div class="form-group">
                                <label class="form-label" for="requestDate">
                                    Ngày yêu cầu làm thêm <span class="text-danger">*</span>
                                </label>
                                <input type="date" 
                                       class="form-control ${not empty errors.requestDate ? 'is-invalid' : ''}" 
                                       id="requestDate" 
                                       name="requestDate" 
                                       value="${param.requestDate}" 
                                       min="${currentDate}"
                                       required>
                                <c:if test="${not empty errors.requestDate}">
                                    <div class="invalid-feedback">${errors.requestDate}</div>
                                </c:if>
                            </div>

                            <!-- Start Time -->
                            <div class="form-group">
                                <label class="form-label" for="startTime">
                                    Thời gian bắt đầu <span class="text-danger">*</span>
                                </label>
                                <input type="time" 
                                       class="form-control ${not empty errors.startTime ? 'is-invalid' : ''}" 
                                       id="startTime" 
                                       name="startTime" 
                                       value="${param.startTime}" 
                                       required>
                                <c:if test="${not empty errors.startTime}">
                                    <div class="invalid-feedback">${errors.startTime}</div>
                                </c:if>
                            </div>

                            <!-- End Time -->
                            <div class="form-group">
                                <label class="form-label" for="endTime">
                                    Thời gian kết thúc <span class="text-danger">*</span>
                                </label>
                                <input type="time" 
                                       class="form-control ${not empty errors.endTime ? 'is-invalid' : ''}" 
                                       id="endTime" 
                                       name="endTime" 
                                       value="${param.endTime}" 
                                       required>
                                <c:if test="${not empty errors.endTime}">
                                    <div class="invalid-feedback">${errors.endTime}</div>
                                </c:if>
                            </div>

                            <!-- Total Hours (Auto-calculated) -->
                            <div class="form-group">
                                <label class="form-label" for="totalHours">Tổng số giờ</label>
                                <input type="number" 
                                       class="form-control" 
                                       id="totalHours" 
                                       name="totalHours" 
                                       step="0.5" 
                                       min="0.5" 
                                       max="12" 
                                       readonly
                                       value="${param.totalHours}">
                                <div class="form-text">Số giờ sẽ được tính tự động dựa trên thời gian bắt đầu và kết thúc</div>
                            </div>
                        </div>

                        <!-- Right Column -->
                        <div class="col-md-6">
                            <!-- OT Type -->
                            <div class="form-group">
                                <label class="form-label" for="otType">
                                    Loại làm thêm <span class="text-danger">*</span>
                                </label>
                                <select class="form-select ${not empty errors.otType ? 'is-invalid' : ''}" 
                                        id="otType" 
                                        name="otType" 
                                        required>
                                    <option value="">-- Chọn loại làm thêm --</option>
                                    <option value="WEEKDAY" ${param.otType == 'WEEKDAY' ? 'selected' : ''}>Ngày thường (150%)</option>
                                    <option value="WEEKEND" ${param.otType == 'WEEKEND' ? 'selected' : ''}>Cuối tuần (200%)</option>
                                    <option value="HOLIDAY" ${param.otType == 'HOLIDAY' ? 'selected' : ''}>Ngày lễ (300%)</option>
                                    <option value="URGENT" ${param.otType == 'URGENT' ? 'selected' : ''}>Khẩn cấp (200%)</option>
                                </select>
                                <c:if test="${not empty errors.otType}">
                                    <div class="invalid-feedback">${errors.otType}</div>
                                </c:if>
                            </div>

                            <!-- Department -->
                            <div class="form-group">
                                <label class="form-label" for="department">Phòng ban</label>
                                <input type="text" 
                                       class="form-control" 
                                       id="department" 
                                       name="department" 
                                       value="${sessionScope.userDepartment != null ? sessionScope.userDepartment : ''}" 
                                       readonly>
                            </div>

                            <!-- Manager -->
                            <div class="form-group">
                                <label class="form-label" for="approver">Người phê duyệt</label>
                                <select class="form-select" id="approver" name="approverId">
                                    <option value="">-- Sẽ được gán tự động --</option>
                                    <!-- Managers will be loaded dynamically or pre-populated -->
                                    <c:forEach var="manager" items="${managers}">
                                        <option value="${manager.id}" ${param.approverId == manager.id ? 'selected' : ''}>
                                            ${manager.fullName} - ${manager.position}
                                        </option>
                                    </c:forEach>
                                </select>
                                <div class="form-text">Nếu không chọn, hệ thống sẽ tự động gán cho quản lý trực tiếp</div>
                            </div>

                            <!-- Priority -->
                            <div class="form-group">
                                <label class="form-label" for="priority">Mức độ ưu tiên</label>
                                <select class="form-select" id="priority" name="priority">
                                    <option value="NORMAL" ${param.priority == 'NORMAL' || empty param.priority ? 'selected' : ''}>Bình thường</option>
                                    <option value="HIGH" ${param.priority == 'HIGH' ? 'selected' : ''}>Cao</option>
                                    <option value="URGENT" ${param.priority == 'URGENT' ? 'selected' : ''}>Khẩn cấp</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- Reason -->
                    <div class="form-group">
                        <label class="form-label" for="reason">
                            Lý do làm thêm giờ <span class="text-danger">*</span>
                        </label>
                        <textarea class="form-control ${not empty errors.reason ? 'is-invalid' : ''}" 
                                  id="reason" 
                                  name="reason" 
                                  rows="4" 
                                  placeholder="Mô tả chi tiết lý do cần làm thêm giờ, công việc cần hoàn thành..."
                                  required maxlength="1000">${param.reason}</textarea>
                        <div class="form-text">Tối đa 1000 ký tự</div>
                        <c:if test="${not empty errors.reason}">
                            <div class="invalid-feedback">${errors.reason}</div>
                        </c:if>
                    </div>

                    <!-- Work Description -->
                    <div class="form-group">
                        <label class="form-label" for="workDescription">Mô tả công việc sẽ thực hiện</label>
                        <textarea class="form-control" 
                                  id="workDescription" 
                                  name="workDescription" 
                                  rows="3" 
                                  placeholder="Mô tả chi tiết các công việc sẽ thực hiện trong thời gian làm thêm..."
                                  maxlength="500">${param.workDescription}</textarea>
                        <div class="form-text">Tối đa 500 ký tự (tùy chọn)</div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="d-flex justify-content-end gap-3 mt-4">
                        <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary">
                            <i class="fas fa-times me-2"></i>Hủy
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-paper-plane me-2"></i>Gửi đơn
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Sidebar toggle
        document.getElementById('toggle-sidebar').addEventListener('click', function () {
            const sidebar = document.getElementById('sidebar');
            const mainContent = document.getElementById('main-content');

            sidebar.classList.toggle('collapsed');
            mainContent.classList.toggle('expanded');
        });

        // Auto-calculate total hours
        function calculateTotalHours() {
            const startTime = document.getElementById('startTime').value;
            const endTime = document.getElementById('endTime').value;
            
            if (startTime && endTime) {
                const start = new Date('2000-01-01 ' + startTime);
                const end = new Date('2000-01-01 ' + endTime);
                
                // Handle overnight shifts
                if (end < start) {
                    end.setDate(end.getDate() + 1);
                }
                
                const diffMs = end - start;
                const diffHours = diffMs / (1000 * 60 * 60);
                
                if (diffHours > 0 && diffHours <= 12) {
                    document.getElementById('totalHours').value = diffHours.toFixed(1);
                } else {
                    document.getElementById('totalHours').value = '';
                    if (diffHours > 12) {
                        alert('Thời gian làm thêm không được vượt quá 12 giờ trong một ngày.');
                    }
                }
            } else {
                document.getElementById('totalHours').value = '';
            }
        }

        // Add event listeners for time inputs
        document.getElementById('startTime').addEventListener('change', calculateTotalHours);
        document.getElementById('endTime').addEventListener('change', calculateTotalHours);

        // Set minimum date to today
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('requestDate').min = today;
            
            // If no date is set, default to today
            if (!document.getElementById('requestDate').value) {
                document.getElementById('requestDate').value = today;
            }
        });

        // Character counter for textareas
        function setupCharacterCounter(textareaId, maxLength) {
            const textarea = document.getElementById(textareaId);
            const counter = document.createElement('div');
            counter.className = 'form-text text-end';
            counter.style.fontSize = '0.8rem';
            
            function updateCounter() {
                const remaining = maxLength - textarea.value.length;
                counter.textContent = `${textarea.value.length}/${maxLength} ký tự`;
                counter.style.color = remaining < 50 ? '#dc3545' : '#6c757d';
            }
            
            textarea.addEventListener('input', updateCounter);
            textarea.parentNode.appendChild(counter);
            updateCounter();
        }

        // Setup character counters
        document.addEventListener('DOMContentLoaded', function() {
            setupCharacterCounter('reason', 1000);
            setupCharacterCounter('workDescription', 500);
        });

        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const startTime = document.getElementById('startTime').value;
            const endTime = document.getElementById('endTime').value;
            const totalHours = parseFloat(document.getElementById('totalHours').value);
            
            if (!totalHours || totalHours <= 0) {
                e.preventDefault();
                alert('Vui lòng nhập thời gian bắt đầu và kết thúc hợp lệ.');
                return;
            }
            
            if (totalHours > 12) {
                e.preventDefault();
                alert('Thời gian làm thêm không được vượt quá 12 giờ trong một ngày.');
                return;
            }
        });
    </script>
</body>
</html>