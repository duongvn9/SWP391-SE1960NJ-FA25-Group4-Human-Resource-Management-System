<!-- filepath: d:\SWPCode\HRMS\src\main\webapp\WEB-INF\views\profile\profile.jsp -->
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ cá nhân</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            min-height: 100vh;
            background: linear-gradient(160deg, #7b8dfb 0%, #7b5ffb 100%);
        }
        .profile-card {
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.07);
            padding: 36px 32px 24px 32px;
            max-width: 500px;
            margin: 48px auto 0 auto;
            position: relative;
        }
        .hrms-logo {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 12px;
        }
        .hrms-logo-icon {
            font-size: 2.5rem;
            color: #7b8dfb;
        }
        .hrms-logo-text {
            font-weight: 700;
            font-size: 1.2rem;
            color: #7b8dfb;
            margin-top: 4px;
            letter-spacing: 1px;
        }
        .profile-header-title {
            text-align: center;
            font-size: 1.4rem;
            font-weight: 600;
            margin-bottom: 24px;
            color: #222;
        }
        .profile-title {
            font-weight: 700;
            font-size: 1.5rem;
            margin-bottom: 8px;
            text-align: center;
        }
        .profile-email {
            color: #888;
            font-size: 1rem;
            margin-bottom: 18px;
            text-align: center;
        }
        .form-label {
            font-weight: 500;
            color: #222;
        }
        .form-control[readonly] {
            background: #f6f7fa;
            border: none;
            color: #222;
            font-weight: 500;
        }
        .btn-success, .btn-primary {
            border-radius: 8px;
            font-weight: 500;
            min-width: 110px;
        }
        .action-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 32px;
            margin-bottom: 0;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<div class="profile-card">
    <div class="hrms-logo">
        <i class="fa-solid fa-users-gear hrms-logo-icon"></i>
        <div class="hrms-logo-text">HRMS</div>
    </div>
    <div class="profile-header-title">Hồ sơ cá nhân</div>
    <div class="profile-title">${user.fullName}</div>
    <div class="profile-email">${user.email}</div>
    <form>
        <div class="mb-3">
            <label class="form-label">Họ và tên</label>
            <input type="text" class="form-control" value="${user.fullName}" readonly>
        </div>
        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" class="form-control" value="${user.email}" readonly>
        </div>
        <div class="mb-3">
            <label class="form-label">Số điện thoại</label>
            <input type="text" class="form-control" value="${user.phone}" readonly>
        </div>
        <div class="mb-3">
            <label class="form-label">Phòng ban</label>
            <input type="text" class="form-control" value="${user.department}" readonly>
        </div>
        <div class="mb-3">
            <label class="form-label">Chức vụ</label>
            <input type="text" class="form-control" value="${user.position}" readonly>
        </div>
        <div class="mb-3">
            <label class="form-label">Thông tin ngân hàng</label>
            <input type="text" class="form-control" value="${user.bankInfo}" readonly>
        </div>
        <div class="action-row">
            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-primary">Dashboard</a>
            <button type="button" class="btn btn-success">Cập nhật</button>
        </div>
    </form>
</div>
</body>
</html>