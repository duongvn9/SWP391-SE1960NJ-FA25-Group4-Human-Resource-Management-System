<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>Dashboard - HRMS</title>

            <!-- Bootstrap 5.3 CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- Font Awesome -->
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
            <!-- Chart.js -->
            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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

                /* Sidebar logo link styling */
                .sidebar-logo {
                    color: white !important;
                    text-decoration: none !important;
                    display: block;
                    text-align: center;
                    padding: 10px;
                    border-radius: 8px;
                    margin: 0 15px;
                    transition: all 0.3s ease;
                }

                .sidebar-logo:hover {
                    background: rgba(255, 255, 255, 0.1);
                    transform: translateY(-2px);
                }

                .sidebar-logo h4,
                .sidebar-logo small {
                    margin: 0;
                }

                .sidebar.collapsed {
                    width: 70px;
                }

                .sidebar.collapsed .sidebar-header h4,
                .sidebar.collapsed .sidebar-header small {
                    display: none;
                }

                .sidebar.collapsed .sidebar-logo {
                    margin: 0 10px;
                    padding: 10px 5px;
                }

                .sidebar.collapsed .nav-link span {
                    display: none;
                }

                .sidebar.collapsed .nav-link {
                    justify-content: center;
                    padding: 12px;
                    position: relative;
                }

                .sidebar.collapsed .nav-link:hover::after {
                    content: attr(data-tooltip);
                    position: absolute;
                    left: 100%;
                    top: 50%;
                    transform: translateY(-50%);
                    background: rgba(0, 0, 0, 0.8);
                    color: white;
                    padding: 8px 12px;
                    border-radius: 6px;
                    white-space: nowrap;
                    font-size: 0.875rem;
                    z-index: 1001;
                    margin-left: 10px;
                }

                .sidebar.collapsed .nav-link:hover::before {
                    content: '';
                    position: absolute;
                    left: 100%;
                    top: 50%;
                    transform: translateY(-50%);
                    border: 6px solid transparent;
                    border-right-color: rgba(0, 0, 0, 0.8);
                    z-index: 1001;
                    margin-left: 4px;
                }

                /* Sidebar Dropdown Styles */
                .sidebar-submenu {
                    list-style: none;
                    padding: 0;
                    margin: 0;
                    max-height: 0;
                    overflow: hidden;
                    transition: max-height 0.3s ease;
                    background: rgba(0, 0, 0, 0.1);
                }

                .sidebar-submenu.show {
                    max-height: 200px;
                }

                .sidebar-submenu .nav-link {
                    color: rgba(255, 255, 255, 0.7) !important;
                    padding: 10px 20px 10px 40px;
                    font-size: 0.9rem;
                    border-left: 3px solid transparent;
                }

                .sidebar-submenu .nav-link:hover,
                .sidebar-submenu .nav-link.active {
                    background: rgba(255, 255, 255, 0.15) !important;
                    color: white !important;
                    border-left-color: white;
                    transform: translateX(3px);
                }

                .sidebar-submenu .nav-link i {
                    width: 16px;
                    margin-right: 8px;
                    font-size: 0.9rem;
                }

                .dropdown-arrow {
                    transition: transform 0.3s ease;
                    font-size: 0.8rem;
                }

                .sidebar-dropdown-toggle[aria-expanded="true"] .dropdown-arrow {
                    transform: rotate(90deg);
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

                .sidebar.collapsed .nav-link i {
                    margin-right: 0;
                    font-size: 1.2rem;
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
                    justify-content: between;
                    align-items: center;
                }

                .toggle-sidebar {
                    background: none;
                    border: none;
                    font-size: 1.2rem;
                    color: var(--primary-color);
                    cursor: pointer;
                }

                .home-btn {
                    display: flex;
                    align-items: center;
                    margin-left: 20px;
                    padding: 8px 16px;
                    color: var(--primary-color);
                    text-decoration: none;
                    border-radius: 6px;
                    transition: all 0.3s ease;
                    font-weight: 500;
                }

                .home-btn:hover {
                    background: var(--primary-color);
                    color: white;
                    transform: translateY(-1px);
                }

                .home-btn i {
                    margin-right: 8px;
                    font-size: 1.1rem;
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

                .content-area {
                    padding: 2rem;
                    flex: 1;
                }

                .dashboard-card {
                    background: white;
                    border-radius: 15px;
                    box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
                    padding: 1.5rem;
                    margin-bottom: 2rem;
                    border: none;
                    transition: all 0.3s ease;
                }

                .dashboard-card:hover {
                    transform: translateY(-5px);
                    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
                }

                .stat-card {
                    text-align: center;
                    padding: 2rem 1rem;
                }

                .stat-card .icon {
                    font-size: 3rem;
                    margin-bottom: 1rem;
                }

                .stat-card.primary .icon {
                    color: var(--primary-color);
                }

                .stat-card.success .icon {
                    color: var(--success-color);
                }

                .stat-card.warning .icon {
                    color: var(--warning-color);
                }

                .stat-card.danger .icon {
                    color: var(--danger-color);
                }

                .stat-number {
                    font-size: 2.5rem;
                    font-weight: bold;
                    margin-bottom: 0.5rem;
                    display: block;
                }

                .stat-label {
                    color: #6c757d;
                    font-size: 0.9rem;
                }

                .table-card {
                    background: white;
                    border-radius: 15px;
                    overflow: hidden;
                    box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
                }

                .table-card .card-header {
                    background: var(--primary-color);
                    color: white;
                    padding: 1rem 1.5rem;
                    border: none;
                }

                .table {
                    margin-bottom: 0;
                }

                .table th {
                    border-top: none;
                    font-weight: 600;
                    color: var(--primary-color);
                }

                .badge-status {
                    padding: 0.4rem 0.8rem;
                    border-radius: 20px;
                    font-size: 0.8rem;
                }

                .chart-container {
                    position: relative;
                    height: 300px;
                }

                .notification-item {
                    display: flex;
                    align-items: center;
                    padding: 1rem;
                    border-bottom: 1px solid #eee;
                    transition: background 0.3s ease;
                }

                .notification-item:hover {
                    background: #f8f9fa;
                }

                .notification-icon {
                    width: 40px;
                    height: 40px;
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    margin-right: 1rem;
                    font-size: 1.2rem;
                }

                .notification-icon.info {
                    background: rgba(23, 162, 184, 0.1);
                    color: var(--info-color);
                }

                .notification-icon.success {
                    background: rgba(40, 167, 69, 0.1);
                    color: var(--success-color);
                }

                .notification-icon.warning {
                    background: rgba(255, 193, 7, 0.1);
                    color: var(--warning-color);
                }

                .dashboard-footer {
                    background: white;
                    border-top: 1px solid #e9ecef;
                    padding: 1.5rem 2rem;
                    margin-top: 2rem;
                    color: #6c757d;
                }

                .dashboard-footer p {
                    margin-bottom: 0.25rem;
                }

                .dashboard-footer .text-muted {
                    font-size: 0.875rem;
                }

                #lastUpdate {
                    color: var(--primary-color);
                    font-weight: 500;
                }

                /* Custom scrollbar for sidebar */
                .sidebar::-webkit-scrollbar {
                    width: 4px;
                }

                .sidebar::-webkit-scrollbar-track {
                    background: rgba(255, 255, 255, 0.1);
                }

                .sidebar::-webkit-scrollbar-thumb {
                    background: rgba(255, 255, 255, 0.3);
                    border-radius: 2px;
                }

                .sidebar::-webkit-scrollbar-thumb:hover {
                    background: rgba(255, 255, 255, 0.5);
                }

                /* Hide horizontal scrollbar completely */
                .sidebar::-webkit-scrollbar-horizontal {
                    display: none;
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

                    .home-btn span {
                        display: none;
                    }

                    .home-btn {
                        margin-left: 10px;
                        padding: 8px 12px;
                    }
                }
            </style>
        </head>

        <body>
            <!-- Sidebar -->
            <nav class="sidebar" id="sidebar">
                <div class="sidebar-header">
                    <a href="${pageContext.request.contextPath}/" class="sidebar-logo" title="Về trang chủ">
                        <i class="fas fa-users-cog fs-2 mb-2"></i>
                        <h4>HRMS</h4>
                        <small>Human Resource Management</small>
                    </a>
                </div>

                <ul class="sidebar-nav nav flex-column">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/dashboard" class="nav-link active"
                            data-tooltip="Dashboard">
                            <i class="fas fa-tachometer-alt"></i>
                            <span>Dashboard</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/identity/employees" class="nav-link"
                            data-tooltip="Quản lý Nhân viên">
                            <i class="fas fa-users"></i>
                            <span>Quản lý Nhân viên</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/attendance" class="nav-link"
                            data-tooltip="Chấm công">
                            <i class="fas fa-clock"></i>
                            <span>Chấm công</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/payroll" class="nav-link" data-tooltip="Bảng lương">
                            <i class="fas fa-money-bill-wave"></i>
                            <span>Bảng lương</span>
                        </a>
                    </li>
                    <!-- Dropdown: Đơn từ -->
                    <li class="nav-item">
                        <a href="#" class="nav-link sidebar-dropdown-toggle" data-target="requests-submenu" data-tooltip="Đơn từ">
                            <i class="fas fa-clipboard-list"></i>
                            <span>Đơn từ</span>
                            <i class="fas fa-chevron-right dropdown-arrow ms-auto"></i>
                        </a>
                        <ul class="sidebar-submenu" id="requests-submenu">
                            <li>
                                <a href="${pageContext.request.contextPath}/requests/leave/create" 
                                   class="nav-link submenu-link">
                                    <i class="fas fa-calendar-times"></i>
                                    <span>Leave Request</span>
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/requests/overtime/create" 
                                   class="nav-link submenu-link">
                                    <i class="fas fa-clock"></i>
                                    <span>OT Request</span>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/recruitment" class="nav-link"
                            data-tooltip="Tuyển dụng">
                            <i class="fas fa-user-tie"></i>
                            <span>Tuyển dụng</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/contracts" class="nav-link" data-tooltip="Hợp đồng">
                            <i class="fas fa-file-contract"></i>
                            <span>Hợp đồng</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/reports" class="nav-link" data-tooltip="Báo cáo">
                            <i class="fas fa-chart-bar"></i>
                            <span>Báo cáo</span>
                        </a>
                    </li>
                    <!-- Admin Only Menu -->
                    <c:if test="${sessionScope.userRole == 'ADMIN' || sessionScope.userRole == 'Admin'}">
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/admin/accounts" class="nav-link"
                                data-tooltip="Quản lý tài khoản">
                                <i class="fas fa-user-shield"></i>
                                <span>Quản lý tài khoản</span>
                            </a>
                        </li>
                    </c:if>
                    
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/system/settings" class="nav-link"
                            data-tooltip="Cài đặt">
                            <i class="fas fa-cog"></i>
                            <span>Cài đặt</span>
                        </a>
                    </li>
                </ul>
            </nav>

            <!-- Main Content -->
            <div class="main-content" id="main-content">
                <!-- Top Navigation -->
                <div class="top-navbar">
                    <button class="toggle-sidebar" id="toggle-sidebar">
                        <i class="fas fa-bars"></i>
                    </button>

                    <a href="${pageContext.request.contextPath}/" class="home-btn" title="Về trang chủ">
                        <i class="fas fa-home"></i>
                        <span>Trang chủ</span>
                    </a>

                    <div class="user-info">
                        <div class="user-avatar">
                            <i class="fas fa-user"></i>
                        </div>
                        <div>
                            <strong>${sessionScope.userFullName != null ? sessionScope.userFullName : 'Admin
                                User'}</strong>
                            <br>
                            <small class="text-muted">${sessionScope.userRole != null ? sessionScope.userRole :
                                'Administrator'}</small>
                        </div>
                        <div class="dropdown ms-3">
                            <button class="btn btn-outline-primary btn-sm dropdown-toggle" type="button"
                                data-bs-toggle="dropdown">
                                <i class="fas fa-user-circle"></i>
                            </button>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile"><i
                                            class="fas fa-user me-2"></i>Hồ sơ</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/settings"><i
                                            class="fas fa-cog me-2"></i>Cài đặt</a></li>
                                <li>
                                    <hr class="dropdown-divider">
                                </li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/auth/logout"><i
                                            class="fas fa-sign-out-alt me-2"></i>Đăng xuất</a></li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- Content Area -->
                <div class="content-area">
                    <!-- Welcome Section -->
                    <div class="row mb-4">
                        <div class="col-12">
                            <h2>Chào mừng trở lại, ${sessionScope.userFullName != null ? sessionScope.userFullName :
                                'Admin'}!</h2>
                            <p class="text-muted">Dashboard tổng quan hệ thống quản lý nhân sự</p>
                        </div>
                    </div>

                    <!-- Statistics Cards -->
                    <div class="row mb-4">
                        <div class="col-lg-3 col-md-6 mb-3">
                            <div class="dashboard-card">
                                <div class="stat-card primary">
                                    <div class="icon">
                                        <i class="fas fa-users"></i>
                                    </div>
                                    <span class="stat-number counter">${totalEmployees != null ? totalEmployees :
                                        156}</span>
                                    <div class="stat-label">Tổng số nhân viên</div>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-6 mb-3">
                            <div class="dashboard-card">
                                <div class="stat-card success">
                                    <div class="icon">
                                        <i class="fas fa-user-check"></i>
                                    </div>
                                    <span class="stat-number counter">${presentToday != null ? presentToday :
                                        142}</span>
                                    <div class="stat-label">Có mặt hôm nay</div>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-6 mb-3">
                            <div class="dashboard-card">
                                <div class="stat-card warning">
                                    <div class="icon">
                                        <i class="fas fa-calendar-times"></i>
                                    </div>
                                    <span class="stat-number counter">${onLeaveToday != null ? onLeaveToday : 8}</span>
                                    <div class="stat-label">Nghỉ phép hôm nay</div>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-6 mb-3">
                            <div class="dashboard-card">
                                <div class="stat-card danger">
                                    <div class="icon">
                                        <i class="fas fa-user-times"></i>
                                    </div>
                                    <span class="stat-number counter">${absentToday != null ? absentToday : 6}</span>
                                    <div class="stat-label">Vắng mặt hôm nay</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Quick Actions for Admin -->
                    <c:if test="${sessionScope.userRole == 'ADMIN' || sessionScope.userRole == 'Admin'}">
                        <div class="row mb-4">
                            <div class="col-12">
                                <div class="dashboard-card">
                                    <h5 class="mb-3">
                                        <i class="fas fa-bolt me-2 text-warning"></i>Thao tác quản trị nhanh
                                    </h5>
                                    <div class="row">
                                        <div class="col-lg-3 col-md-6 mb-3">
                                            <a href="${pageContext.request.contextPath}/admin/accounts" 
                                               class="btn btn-outline-primary w-100 py-3 text-decoration-none">
                                                <i class="fas fa-user-shield fs-2 d-block mb-2"></i>
                                                <strong>Quản lý tài khoản</strong>
                                                <br>
                                                <small class="text-muted">Tạo, sửa, xóa accounts</small>
                                            </a>
                                        </div>
                                        <div class="col-lg-3 col-md-6 mb-3">
                                            <a href="${pageContext.request.contextPath}/system/settings" 
                                               class="btn btn-outline-secondary w-100 py-3 text-decoration-none">
                                                <i class="fas fa-cogs fs-2 d-block mb-2"></i>
                                                <strong>Cài đặt hệ thống</strong>
                                                <br>
                                                <small class="text-muted">Cấu hình hệ thống</small>
                                            </a>
                                        </div>
                                        <div class="col-lg-3 col-md-6 mb-3">
                                            <a href="${pageContext.request.contextPath}/reports" 
                                               class="btn btn-outline-info w-100 py-3 text-decoration-none">
                                                <i class="fas fa-chart-bar fs-2 d-block mb-2"></i>
                                                <strong>Báo cáo tổng hợp</strong>
                                                <br>
                                                <small class="text-muted">Xem báo cáo chi tiết</small>
                                            </a>
                                        </div>
                                        <div class="col-lg-3 col-md-6 mb-3">
                                            <a href="${pageContext.request.contextPath}/identity/employees" 
                                               class="btn btn-outline-success w-100 py-3 text-decoration-none">
                                                <i class="fas fa-users-cog fs-2 d-block mb-2"></i>
                                                <strong>Quản lý nhân viên</strong>
                                                <br>
                                                <small class="text-muted">Thêm, sửa thông tin</small>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Charts and Recent Activities -->
                    <div class="row">
                        <!-- Attendance Chart -->
                        <div class="col-lg-8 mb-4">
                            <div class="dashboard-card">
                                <h5 class="mb-3"><i class="fas fa-chart-line me-2"></i>Thống kê chấm công 7 ngày gần đây
                                </h5>
                                <div class="chart-container">
                                    <canvas id="attendanceChart"></canvas>
                                </div>
                            </div>
                        </div>

                        <!-- Recent Notifications -->
                        <div class="col-lg-4 mb-4">
                            <div class="dashboard-card">
                                <h5 class="mb-3"><i class="fas fa-bell me-2"></i>Thông báo gần đây</h5>
                                <div class="notification-list">
                                    <div class="notification-item">
                                        <div class="notification-icon info">
                                            <i class="fas fa-info"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <strong>Đơn xin nghỉ phép mới</strong>
                                            <p class="mb-1 small">Nguyễn Văn A xin nghỉ phép từ 15/10 - 17/10</p>
                                            <small class="text-muted">2 giờ trước</small>
                                        </div>
                                    </div>

                                    <div class="notification-item">
                                        <div class="notification-icon success">
                                            <i class="fas fa-check"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <strong>Bảng lương đã được tạo</strong>
                                            <p class="mb-1 small">Bảng lương tháng 9 đã sẵn sàng</p>
                                            <small class="text-muted">1 ngày trước</small>
                                        </div>
                                    </div>

                                    <div class="notification-item">
                                        <div class="notification-icon warning">
                                            <i class="fas fa-exclamation"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <strong>Nhân viên mới cần duyệt</strong>
                                            <p class="mb-1 small">3 hồ sơ tuyển dụng cần xét duyệt</p>
                                            <small class="text-muted">2 ngày trước</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Recent Activities Table -->
                    <div class="row">
                        <div class="col-12">
                            <div class="table-card">
                                <div class="card-header">
                                    <h5 class="mb-0"><i class="fas fa-history me-2"></i>Hoạt động gần đây</h5>
                                </div>
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Thời gian</th>
                                                <th>Nhân viên</th>
                                                <th>Hoạt động</th>
                                                <th>Trạng thái</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>08:30 - Hôm nay</td>
                                                <td>Nguyễn Văn A</td>
                                                <td>Chấm công vào</td>
                                                <td><span class="badge badge-status bg-success">Thành công</span></td>
                                            </tr>
                                            <tr>
                                                <td>08:45 - Hôm nay</td>
                                                <td>Trần Thị B</td>
                                                <td>Gửi đơn xin nghỉ phép</td>
                                                <td><span class="badge badge-status bg-warning">Chờ duyệt</span></td>
                                            </tr>
                                            <tr>
                                                <td>09:00 - Hôm nay</td>
                                                <td>Lê Văn C</td>
                                                <td>Cập nhật thông tin cá nhân</td>
                                                <td><span class="badge badge-status bg-info">Hoàn thành</span></td>
                                            </tr>
                                            <tr>
                                                <td>17:30 - Hôm qua</td>
                                                <td>Phạm Thị D</td>
                                                <td>Chấm công ra</td>
                                                <td><span class="badge badge-status bg-success">Thành công</span></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Footer -->
                <footer class="dashboard-footer">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-6">
                                <p class="mb-0">
                                    <i class="fas fa-users-cog me-2"></i>
                                    <strong>HRMS</strong> - Hệ thống Quản lý Nhân sự
                                </p>
                                <small class="text-muted">Phiên bản 1.0.0 | Developed by Group 4</small>
                            </div>
                            <div class="col-md-6 text-md-end">
                                <p class="mb-0">
                                    <small class="text-muted">
                                        <i class="fas fa-clock me-1"></i>
                                        Cập nhật lần cuối: <span id="lastUpdate">29/09/2025 - 10:30</span>
                                    </small>
                                </p>
                                <small class="text-muted">
                                    © 2025 SWP391 - SE1960-NJ-FA25 - All rights reserved
                                </small>
                            </div>
                        </div>
                    </div>
                </footer>
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

                // Sidebar dropdown toggle
                document.querySelectorAll('.sidebar-dropdown-toggle').forEach(function(toggle) {
                    toggle.addEventListener('click', function(e) {
                        e.preventDefault();
                        const targetId = this.getAttribute('data-target');
                        const submenu = document.getElementById(targetId);
                        const arrow = this.querySelector('.dropdown-arrow');
                        
                        if (submenu) {
                            if (submenu.classList.contains('show')) {
                                submenu.classList.remove('show');
                                this.setAttribute('aria-expanded', 'false');
                                arrow.style.transform = 'rotate(0deg)';
                            } else {
                                // Close other submenus
                                document.querySelectorAll('.sidebar-submenu').forEach(function(menu) {
                                    menu.classList.remove('show');
                                });
                                document.querySelectorAll('.sidebar-dropdown-toggle').forEach(function(otherToggle) {
                                    otherToggle.setAttribute('aria-expanded', 'false');
                                    const otherArrow = otherToggle.querySelector('.dropdown-arrow');
                                    if (otherArrow) otherArrow.style.transform = 'rotate(0deg)';
                                });
                                
                                // Open current submenu
                                submenu.classList.add('show');
                                this.setAttribute('aria-expanded', 'true');
                                arrow.style.transform = 'rotate(90deg)';
                            }
                        }
                    });
                });

                // Counter animation
                document.addEventListener('DOMContentLoaded', function () {
                    const counters = document.querySelectorAll('.counter');
                    counters.forEach(counter => {
                        const target = parseInt(counter.textContent);
                        const increment = target / 50;
                        let current = 0;

                        const timer = setInterval(() => {
                            current += increment;
                            if (current >= target) {
                                current = target;
                                clearInterval(timer);
                            }
                            counter.textContent = Math.floor(current);
                        }, 30);
                    });
                });

                // Attendance Chart
                const ctx = document.getElementById('attendanceChart').getContext('2d');
                new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'],
                        datasets: [{
                            label: 'Có mặt',
                            data: [142, 148, 156, 151, 147, 98, 45],
                            borderColor: '#2c5aa0',
                            backgroundColor: 'rgba(44, 90, 160, 0.1)',
                            tension: 0.4,
                            fill: true
                        }, {
                            label: 'Vắng mặt',
                            data: [14, 8, 0, 5, 9, 12, 8],
                            borderColor: '#dc3545',
                            backgroundColor: 'rgba(220, 53, 69, 0.1)',
                            tension: 0.4,
                            fill: true
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        },
                        plugins: {
                            legend: {
                                position: 'top'
                            }
                        }
                    }
                });

                // Mobile sidebar toggle
                if (window.innerWidth <= 768) {
                    document.getElementById('toggle-sidebar').addEventListener('click', function () {
                        document.getElementById('sidebar').classList.toggle('show');
                    });
                }

                // Update last update time
                function updateLastUpdateTime() {
                    const now = new Date();
                    const day = String(now.getDate()).padStart(2, '0');
                    const month = String(now.getMonth() + 1).padStart(2, '0');
                    const year = now.getFullYear();
                    const hours = String(now.getHours()).padStart(2, '0');
                    const minutes = String(now.getMinutes()).padStart(2, '0');

                    const formattedTime = `${day}/${month}/${year} - ${hours}:${minutes}`;
                    const lastUpdateElement = document.getElementById('lastUpdate');
                    if (lastUpdateElement) {
                        lastUpdateElement.textContent = formattedTime;
                    }
                }

                // Update time every minute
                updateLastUpdateTime();
                setInterval(updateLastUpdateTime, 60000);
            </script>
        </body>

        </html>