<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>Đăng nhập - HRMS</title>

            <!-- Bootstrap 5.3 CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- Font Awesome -->
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

            <style>
                :root {
                    --primary-color: #2c5aa0;
                    --gradient-primary: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                }

                body {
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    background: var(--gradient-primary);
                    min-height: 100vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }

                .login-container {
                    max-width: 400px;
                    width: 100%;
                    padding: 2rem;
                }

                .login-card {
                    background: white;
                    border-radius: 20px;
                    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2);
                    padding: 3rem 2rem;
                    text-align: center;
                }

                .login-header {
                    margin-bottom: 2rem;
                }

                .login-header .icon {
                    font-size: 4rem;
                    color: var(--primary-color);
                    margin-bottom: 1rem;
                }

                .login-header h2 {
                    color: var(--primary-color);
                    font-weight: bold;
                    margin-bottom: 0.5rem;
                }

                .login-header p {
                    color: #6c757d;
                    margin: 0;
                }

                .form-group {
                    margin-bottom: 1.5rem;
                    text-align: left;
                }

                .form-label {
                    font-weight: 600;
                    color: #333;
                    margin-bottom: 0.5rem;
                }

                .form-control {
                    border-radius: 10px;
                    border: 2px solid #e9ecef;
                    padding: 12px 15px;
                    font-size: 1rem;
                    transition: all 0.3s ease;
                }

                .form-control:focus {
                    border-color: var(--primary-color);
                    box-shadow: 0 0 0 0.2rem rgba(44, 90, 160, 0.25);
                }

                .input-group {
                    position: relative;
                }

                .input-group .form-control {
                    padding-left: 45px;
                }

                .input-group-icon {
                    position: absolute;
                    left: 15px;
                    top: 50%;
                    transform: translateY(-50%);
                    color: #6c757d;
                    z-index: 10;
                }

                .btn-login {
                    background: var(--primary-color);
                    border: none;
                    border-radius: 10px;
                    padding: 12px;
                    font-size: 1rem;
                    font-weight: 600;
                    width: 100%;
                    color: white;
                    transition: all 0.3s ease;
                }

                .btn-login:hover {
                    background: #1e3d6f;
                    transform: translateY(-2px);
                    box-shadow: 0 5px 15px rgba(44, 90, 160, 0.4);
                }

                .alert {
                    border-radius: 10px;
                    border: none;
                    padding: 1rem;
                    margin-bottom: 1.5rem;
                }

                .demo-info {
                    background: #f8f9fa;
                    border-radius: 10px;
                    padding: 1rem;
                    margin-top: 1.5rem;
                    font-size: 0.9rem;
                    color: #6c757d;
                }

                .demo-info strong {
                    color: var(--primary-color);
                }

                .back-home {
                    position: absolute;
                    top: 2rem;
                    left: 2rem;
                    color: white;
                    text-decoration: none;
                    font-size: 1.1rem;
                    transition: all 0.3s ease;
                }

                .back-home:hover {
                    color: #fff;
                    transform: translateX(-5px);
                }

                @media (max-width: 576px) {
                    .login-container {
                        padding: 1rem;
                    }

                    .login-card {
                        padding: 2rem 1.5rem;
                    }

                    .back-home {
                        position: static;
                        display: block;
                        text-align: center;
                        margin-bottom: 2rem;
                    }
                }
            </style>
        </head>

        <body>
            <a href="${pageContext.request.contextPath}/" class="back-home">
                <i class="fas fa-arrow-left me-2"></i>Về trang chủ
            </a>

            <div class="login-container">
                <div class="login-card">
                    <div class="login-header">
                        <div class="icon">
                            <i class="fas fa-users-cog"></i>
                        </div>
                        <h2>Đăng nhập HRMS</h2>
                        <p>Hệ thống Quản lý Nhân sự</p>
                    </div>

                    <!-- Hiển thị lỗi nếu có -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">
                            <i class="fas fa-exclamation-circle me-2"></i>${error}
                        </div>
                    </c:if>

                    <form method="post" action="${pageContext.request.contextPath}/auth/login">
                        <div class="form-group">
                            <label class="form-label">Tên đăng nhập</label>
                            <div class="input-group">
                                <i class="fas fa-user input-group-icon"></i>
                                <input type="text" name="username" class="form-control" placeholder="Nhập tên đăng nhập"
                                    value="${param.username}" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Mật khẩu</label>
                            <div class="input-group">
                                <i class="fas fa-lock input-group-icon"></i>
                                <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu"
                                    required>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-login">
                            <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
                        </button>
                    </form>

                    <!-- Demo info -->
                    <div class="demo-info">
                        <strong>Tài khoản demo:</strong><br>
                        <i class="fas fa-user-shield me-2"></i>Admin: <code>admin/admin</code><br>
                        <i class="fas fa-user me-2"></i>User: <code>user/user</code>
                    </div>
                </div>
            </div>

            <!-- Bootstrap JS -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

            <script>
                // Auto focus vào username field
                document.addEventListener('DOMContentLoaded', function () {
                    const usernameField = document.querySelector('input[name="username"]');
                    if (usernameField) {
                        usernameField.focus();
                    }
                });

                // Xử lý form submit với loading state
                document.querySelector('form').addEventListener('submit', function () {
                    const submitBtn = document.querySelector('.btn-login');
                    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang xử lý...';
                    submitBtn.disabled = true;
                });
            </script>
        </body>

        </html>