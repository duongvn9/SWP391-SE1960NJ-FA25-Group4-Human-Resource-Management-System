<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!-- Sidebar -->
        <nav class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <i class="fas fa-users-cog fs-2 mb-2"></i>
                <h4>HRMS</h4>
                <small>Human Resource Management</small>
            </div>

            <ul class="sidebar-nav nav flex-column">
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/dashboard"
                        class="nav-link ${pageContext.request.requestURI.contains('/dashboard') ? 'active' : ''}">
                        <i class="fas fa-tachometer-alt"></i>
                        <span>Dashboard</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/identity/employees"
                        class="nav-link ${pageContext.request.requestURI.contains('/identity') ? 'active' : ''}">
                        <i class="fas fa-users"></i>
                        <span>Quản lý Nhân viên</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/attendance"
                        class="nav-link ${pageContext.request.requestURI.contains('/attendance') ? 'active' : ''}">
                        <i class="fas fa-clock"></i>
                        <span>Chấm công</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/payroll"
                        class="nav-link ${pageContext.request.requestURI.contains('/payroll') ? 'active' : ''}">
                        <i class="fas fa-money-bill-wave"></i>
                        <span>Bảng lương</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/leave"
                        class="nav-link ${pageContext.request.requestURI.contains('/leave') ? 'active' : ''}">
                        <i class="fas fa-calendar-alt"></i>
                        <span>Nghỉ phép</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/recruitment"
                        class="nav-link ${pageContext.request.requestURI.contains('/recruitment') ? 'active' : ''}">
                        <i class="fas fa-user-tie"></i>
                        <span>Tuyển dụng</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/contracts"
                        class="nav-link ${pageContext.request.requestURI.contains('/contracts') ? 'active' : ''}">
                        <i class="fas fa-file-contract"></i>
                        <span>Hợp đồng</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/reports"
                        class="nav-link ${pageContext.request.requestURI.contains('/reports') ? 'active' : ''}">
                        <i class="fas fa-chart-bar"></i>
                        <span>Báo cáo</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/system/settings"
                        class="nav-link ${pageContext.request.requestURI.contains('/system') ? 'active' : ''}">
                        <i class="fas fa-cog"></i>
                        <span>Cài đặt</span>
                    </a>
                </li>
            </ul>
        </nav>