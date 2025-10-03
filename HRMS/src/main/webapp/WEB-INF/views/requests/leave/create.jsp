<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tạo đơn xin nghỉ phép - HRMS</title>
    
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

        .info-card {
            background: linear-gradient(135deg, #e3f2fd 0%, #f3e5f5 100%);
            border: 1px solid #bbdefb;
            border-radius: 8px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .info-card h5 {
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        .balance-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .balance-item {
            text-align: center;
            flex: 1;
            min-width: 120px;
        }

        .balance-item .number {
            font-size: 2rem;
            font-weight: bold;
            color: var(--primary-color);
            display: block;
        }

        .balance-item .label {
            font-size: 0.9rem;
            color: #666;
        }

        .date-range {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .date-range .form-control {
            flex: 1;
        }

        .leave-type-info {
            background: #f8f9fa;
            border-radius: 6px;
            padding: 0.75rem;
            margin-top: 0.5rem;
            font-size: 0.9rem;
            color: #666;
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

            .date-range {
                flex-direction: column;
                align-items: stretch;
            }

            .balance-info {
                flex-direction: column;
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
                    <li class="breadcrumb-item active">Tạo đơn nghỉ phép</li>
                </ol>
            </nav>

            <!-- Leave Balance Info Card -->
            <div class="info-card">
                <h5><i class="fas fa-chart-pie me-2"></i>Thông tin nghỉ phép</h5>
                <div class="balance-info">
                    <div class="balance-item">
                        <span class="number">${leaveBalance.totalAllocated != null ? leaveBalance.totalAllocated : 12}</span>
                        <span class="label">Tổng phép được cấp</span>
                    </div>
                    <div class="balance-item">
                        <span class="number">${leaveBalance.used != null ? leaveBalance.used : 0}</span>
                        <span class="label">Đã sử dụng</span>
                    </div>
                    <div class="balance-item">
                        <span class="number">${leaveBalance.remaining != null ? leaveBalance.remaining : 12}</span>
                        <span class="label">Còn lại</span>
                    </div>
                    <div class="balance-item">
                        <span class="number">${leaveBalance.pending != null ? leaveBalance.pending : 0}</span>
                        <span class="label">Đang chờ duyệt</span>
                    </div>
                </div>
            </div>

            <!-- Form Card -->
            <div class="form-card">
                <h2><i class="fas fa-calendar-times"></i>Tạo đơn xin nghỉ phép</h2>

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
                    <strong>Lưu ý:</strong> Đơn xin nghỉ phép cần được gửi trước ít nhất 2 ngày làm việc và phải được quản lý phê duyệt.
                </div>

                <!-- Leave Request Form -->
                <form method="post" action="${pageContext.request.contextPath}/requests/leave/create">
                    <!-- CSRF Token -->
                    <input type="hidden" name="csrfToken" value="${csrfToken}"/>

                    <div class="row">
                        <!-- Left Column -->
                        <div class="col-md-6">
                            <!-- Leave Type -->
                            <div class="form-group">
                                <label class="form-label" for="leaveType">
                                    Loại nghỉ phép <span class="text-danger">*</span>
                                </label>
                                <select class="form-select ${not empty errors.leaveType ? 'is-invalid' : ''}" 
                                        id="leaveType" 
                                        name="leaveType" 
                                        required>
                                    <option value="">-- Chọn loại nghỉ phép --</option>
                                    <option value="ANNUAL" ${param.leaveType == 'ANNUAL' ? 'selected' : ''}>Nghỉ phép năm</option>
                                    <option value="SICK" ${param.leaveType == 'SICK' ? 'selected' : ''}>Nghỉ ốm</option>
                                    <option value="PERSONAL" ${param.leaveType == 'PERSONAL' ? 'selected' : ''}>Nghỉ cá nhân</option>
                                    <option value="MATERNITY" ${param.leaveType == 'MATERNITY' ? 'selected' : ''}>Nghỉ thai sản</option>
                                    <option value="PATERNITY" ${param.leaveType == 'PATERNITY' ? 'selected' : ''}>Nghỉ chăm con</option>
                                    <option value="BEREAVEMENT" ${param.leaveType == 'BEREAVEMENT' ? 'selected' : ''}>Nghỉ tang lễ</option>
                                    <option value="UNPAID" ${param.leaveType == 'UNPAID' ? 'selected' : ''}>Nghỉ không lương</option>
                                </select>
                                <c:if test="${not empty errors.leaveType}">
                                    <div class="invalid-feedback">${errors.leaveType}</div>
                                </c:if>
                                <div class="leave-type-info" id="leaveTypeInfo" style="display: none;">
                                    <!-- Dynamic info will be loaded here -->
                                </div>
                            </div>

                            <!-- Start Date -->
                            <div class="form-group">
                                <label class="form-label" for="startDate">
                                    Ngày bắt đầu <span class="text-danger">*</span>
                                </label>
                                <input type="date" 
                                       class="form-control ${not empty errors.startDate ? 'is-invalid' : ''}" 
                                       id="startDate" 
                                       name="startDate" 
                                       value="${param.startDate}" 
                                       min="${minDate}"
                                       required>
                                <c:if test="${not empty errors.startDate}">
                                    <div class="invalid-feedback">${errors.startDate}</div>
                                </c:if>
                            </div>

                            <!-- End Date -->
                            <div class="form-group">
                                <label class="form-label" for="endDate">
                                    Ngày kết thúc <span class="text-danger">*</span>
                                </label>
                                <input type="date" 
                                       class="form-control ${not empty errors.endDate ? 'is-invalid' : ''}" 
                                       id="endDate" 
                                       name="endDate" 
                                       value="${param.endDate}" 
                                       min="${minDate}"
                                       required>
                                <c:if test="${not empty errors.endDate}">
                                    <div class="invalid-feedback">${errors.endDate}</div>
                                </c:if>
                            </div>

                            <!-- Total Days (Auto-calculated) -->
                            <div class="form-group">
                                <label class="form-label" for="totalDays">Tổng số ngày nghỉ</label>
                                <input type="number" 
                                       class="form-control" 
                                       id="totalDays" 
                                       name="totalDays" 
                                       step="0.5" 
                                       min="0.5" 
                                       readonly
                                       value="${param.totalDays}">
                                <div class="form-text">Số ngày sẽ được tính tự động (không bao gồm cuối tuần và ngày lễ)</div>
                            </div>
                        </div>

                        <!-- Right Column -->
                        <div class="col-md-6">
                            <!-- Half Day Option -->
                            <div class="form-group">
                                <div class="form-check">
                                    <input class="form-check-input" 
                                           type="checkbox" 
                                           id="isHalfDay" 
                                           name="isHalfDay" 
                                           value="true"
                                           ${param.isHalfDay == 'true' ? 'checked' : ''}>
                                    <label class="form-check-label" for="isHalfDay">
                                        Nghỉ nửa ngày
                                    </label>
                                </div>
                                <div class="form-text">Chỉ áp dụng khi nghỉ một ngày duy nhất</div>
                            </div>

                            <!-- Half Day Period -->
                            <div class="form-group" id="halfDayPeriod" style="display: none;">
                                <label class="form-label">Buổi nghỉ</label>
                                <div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" 
                                               type="radio" 
                                               name="halfDayPeriod" 
                                               id="morning" 
                                               value="MORNING"
                                               ${param.halfDayPeriod == 'MORNING' ? 'checked' : ''}>
                                        <label class="form-check-label" for="morning">Buổi sáng</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" 
                                               type="radio" 
                                               name="halfDayPeriod" 
                                               id="afternoon" 
                                               value="AFTERNOON"
                                               ${param.halfDayPeriod == 'AFTERNOON' ? 'checked' : ''}>
                                        <label class="form-check-label" for="afternoon">Buổi chiều</label>
                                    </div>
                                </div>
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

                            <!-- Contact During Leave -->
                            <div class="form-group">
                                <label class="form-label" for="contactInfo">Thông tin liên lạc (nếu cần)</label>
                                <input type="text" 
                                       class="form-control" 
                                       id="contactInfo" 
                                       name="contactInfo" 
                                       value="${param.contactInfo}"
                                       placeholder="Số điện thoại hoặc địa chỉ liên lạc khẩn cấp">
                                <div class="form-text">Tùy chọn: Thông tin liên lạc trong trường hợp khẩn cấp</div>
                            </div>
                        </div>
                    </div>

                    <!-- Reason -->
                    <div class="form-group">
                        <label class="form-label" for="reason">
                            Lý do nghỉ phép <span class="text-danger">*</span>
                        </label>
                        <textarea class="form-control ${not empty errors.reason ? 'is-invalid' : ''}" 
                                  id="reason" 
                                  name="reason" 
                                  rows="4" 
                                  placeholder="Mô tả chi tiết lý do cần nghỉ phép..."
                                  required maxlength="1000">${param.reason}</textarea>
                        <div class="form-text">Tối đa 1000 ký tự</div>
                        <c:if test="${not empty errors.reason}">
                            <div class="invalid-feedback">${errors.reason}</div>
                        </c:if>
                    </div>

                    <!-- Work Handover -->
                    <div class="form-group">
                        <label class="form-label" for="workHandover">Bàn giao công việc</label>
                        <textarea class="form-control" 
                                  id="workHandover" 
                                  name="workHandover" 
                                  rows="3" 
                                  placeholder="Mô tả việc bàn giao công việc, người thay thế (nếu có)..."
                                  maxlength="500">${param.workHandover}</textarea>
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

        // Half day toggle
        document.getElementById('isHalfDay').addEventListener('change', function() {
            const halfDayPeriod = document.getElementById('halfDayPeriod');
            const endDateInput = document.getElementById('endDate');
            const startDateInput = document.getElementById('startDate');
            
            if (this.checked) {
                halfDayPeriod.style.display = 'block';
                // Set end date same as start date for half day
                if (startDateInput.value) {
                    endDateInput.value = startDateInput.value;
                    endDateInput.readOnly = true;
                }
            } else {
                halfDayPeriod.style.display = 'none';
                endDateInput.readOnly = false;
                // Clear half day period selection
                document.querySelectorAll('input[name="halfDayPeriod"]').forEach(radio => {
                    radio.checked = false;
                });
            }
            calculateTotalDays();
        });

        // Start date change handler
        document.getElementById('startDate').addEventListener('change', function() {
            const startDate = this.value;
            const endDateInput = document.getElementById('endDate');
            const isHalfDay = document.getElementById('isHalfDay').checked;
            
            if (startDate) {
                endDateInput.min = startDate;
                
                if (isHalfDay) {
                    endDateInput.value = startDate;
                } else if (!endDateInput.value || endDateInput.value < startDate) {
                    endDateInput.value = startDate;
                }
            }
            
            calculateTotalDays();
        });

        // End date change handler
        document.getElementById('endDate').addEventListener('change', function() {
            calculateTotalDays();
        });

        // Calculate total days
        function calculateTotalDays() {
            const startDate = document.getElementById('startDate').value;
            const endDate = document.getElementById('endDate').value;
            const isHalfDay = document.getElementById('isHalfDay').checked;
            
            if (startDate && endDate) {
                const start = new Date(startDate);
                const end = new Date(endDate);
                
                if (end < start) {
                    document.getElementById('totalDays').value = '';
                    return;
                }
                
                if (isHalfDay && startDate === endDate) {
                    document.getElementById('totalDays').value = '0.5';
                    return;
                }
                
                // Calculate business days (excluding weekends)
                let totalDays = 0;
                const currentDate = new Date(start);
                
                while (currentDate <= end) {
                    const dayOfWeek = currentDate.getDay();
                    if (dayOfWeek !== 0 && dayOfWeek !== 6) { // Not Sunday (0) or Saturday (6)
                        totalDays++;
                    }
                    currentDate.setDate(currentDate.getDate() + 1);
                }
                
                document.getElementById('totalDays').value = totalDays;
            } else {
                document.getElementById('totalDays').value = '';
            }
        }

        // Leave type information
        const leaveTypeInfo = {
            'ANNUAL': 'Nghỉ phép năm: Sử dụng số ngày phép được cấp hàng năm.',
            'SICK': 'Nghỉ ốm: Cần có giấy tờ y tế chứng minh (nếu nghỉ > 3 ngày).',
            'PERSONAL': 'Nghỉ cá nhân: Các việc riêng tư, gia đình không thuộc các loại khác.',
            'MATERNITY': 'Nghỉ thai sản: Dành cho nhân viên nữ trước và sau khi sinh.',
            'PATERNITY': 'Nghỉ chăm con: Dành cho nhân viên nam khi vợ sinh con.',
            'BEREAVEMENT': 'Nghỉ tang lễ: Khi có người thân qua đời.',
            'UNPAID': 'Nghỉ không lương: Không được trả lương trong thời gian nghỉ.'
        };

        document.getElementById('leaveType').addEventListener('change', function() {
            const infoDiv = document.getElementById('leaveTypeInfo');
            if (this.value && leaveTypeInfo[this.value]) {
                infoDiv.textContent = leaveTypeInfo[this.value];
                infoDiv.style.display = 'block';
            } else {
                infoDiv.style.display = 'none';
            }
        });

        // Set minimum dates
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date();
            const minDate = new Date(today.getTime() + (2 * 24 * 60 * 60 * 1000)); // 2 days from now
            const minDateString = minDate.toISOString().split('T')[0];
            
            document.getElementById('startDate').min = minDateString;
            document.getElementById('endDate').min = minDateString;
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
            setupCharacterCounter('workHandover', 500);
        });

        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const totalDays = parseFloat(document.getElementById('totalDays').value);
            const remaining = parseFloat(document.querySelector('.balance-item .number').textContent);
            
            if (!totalDays || totalDays <= 0) {
                e.preventDefault();
                alert('Vui lòng chọn ngày bắt đầu và kết thúc hợp lệ.');
                return;
            }
            
            if (totalDays > remaining) {
                const confirmSubmit = confirm(
                    `Số ngày nghỉ yêu cầu (${totalDays}) vượt quá số ngày phép còn lại (${remaining}). ` +
                    'Bạn có chắc chắn muốn gửi đơn này không?'
                );
                if (!confirmSubmit) {
                    e.preventDefault();
                }
            }
        });
    </script>
</body>
</html>