<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>Đăng nhập - HRMS</title>

            <!-- Google Fonts -->
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link
                href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Roboto:wght@300;400;500&display=swap"
                rel="stylesheet">

            <!-- Bootstrap 5.3 CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- Font Awesome -->
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

            <style>
                :root {
                    --primary: #6366f1;
                    --primary-dark: #4f46e5;
                    --success: #10b981;
                    --danger: #ef4444;
                    --surface: #ffffff;
                    --surface-variant: #f8fafc;
                    --on-surface: #1e293b;
                    --on-surface-variant: #64748b;
                    --outline: #e2e8f0;
                    --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
                    --shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
                    --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
                    --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
                }

                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                /* Reset input styles để đảm bảo border-radius đồng nhất */
                input[type="text"],
                input[type="password"],
                input[type="email"],
                button,
                .btn,
                .form-control {
                    -webkit-appearance: none;
                    -moz-appearance: none;
                    appearance: none;
                    border-radius: 8px !important;
                    -webkit-border-radius: 8px !important;
                    -moz-border-radius: 8px !important;
                }

                /* Force consistent border-radius on all interactive elements */
                .login-card * {
                    border-radius: inherit;
                }

                .form-control,
                .btn-login,
                .btn-google {
                    border-radius: 8px !important;
                }

                body {
                    font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    min-height: 100vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    padding: 1rem;
                    line-height: 1.6;
                    color: var(--on-surface);
                }

                .login-container {
                    max-width: 420px;
                    width: 100%;
                }

                .login-card {
                    background: var(--surface);
                    border-radius: 16px;
                    box-shadow: var(--shadow-xl);
                    padding: 3rem 2.5rem;
                    text-align: center;
                    border: 1px solid var(--outline);
                }

                .login-header {
                    margin-bottom: 2.5rem;
                }

                .login-header .logo {
                    width: 72px;
                    height: 72px;
                    background: linear-gradient(135deg, var(--primary), var(--primary-dark));
                    border-radius: 16px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    margin: 0 auto 1.5rem;
                    font-size: 1.75rem;
                    color: white;
                    box-shadow: var(--shadow-lg);
                }

                .login-header h1 {
                    font-size: 1.875rem;
                    font-weight: 700;
                    color: var(--on-surface);
                    margin-bottom: 0.5rem;
                    letter-spacing: -0.025em;
                }

                .login-header p {
                    color: var(--on-surface-variant);
                    font-size: 0.95rem;
                    margin: 0;
                }

                .form-group {
                    margin-bottom: 1.5rem;
                    text-align: left;
                }

                .form-label {
                    font-weight: 500;
                    color: var(--on-surface);
                    margin-bottom: 0.5rem;
                    font-size: 0.875rem;
                    letter-spacing: 0.025em;
                }

                .form-control {
                    width: 100%;
                    border-radius: 8px !important;
                    border: 1.5px solid var(--outline);
                    padding: 0.875rem 1rem;
                    font-size: 0.95rem;
                    transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
                    background: var(--surface);
                    box-sizing: border-box;
                    -webkit-appearance: none;
                    -moz-appearance: none;
                    appearance: none;
                }

                .form-control:focus {
                    border-color: var(--primary);
                    box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
                    outline: none;
                }

                .form-control::placeholder {
                    color: var(--on-surface-variant);
                    opacity: 0.7;
                }

                .input-group {
                    position: relative;
                }

                .input-group .form-control {
                    padding-left: 3rem;
                    border-radius: 8px !important;
                }

                .input-group-icon {
                    position: absolute;
                    left: 1rem;
                    top: 50%;
                    transform: translateY(-50%);
                    color: var(--on-surface-variant);
                    z-index: 2;
                    font-size: 1rem;
                    pointer-events: none;
                }

                .password-input-group {
                    position: relative;
                }

                .password-toggle-btn {
                    position: absolute;
                    right: 1rem;
                    top: 50%;
                    transform: translateY(-50%);
                    background: none;
                    border: none;
                    color: var(--on-surface-variant);
                    cursor: pointer;
                    z-index: 2;
                    padding: 0.25rem;
                    font-size: 1rem;
                    transition: all 0.2s ease;
                    border-radius: 4px;
                }

                .password-toggle-btn:hover {
                    color: var(--primary);
                    background: rgba(99, 102, 241, 0.08);
                }

                .password-toggle-btn:focus {
                    outline: none;
                    color: var(--primary);
                }

                .btn-login {
                    background: var(--primary);
                    border: none;
                    border-radius: 8px !important;
                    padding: 0.875rem 1.5rem;
                    font-size: 0.95rem;
                    font-weight: 600;
                    width: 100%;
                    color: white;
                    transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
                    box-shadow: var(--shadow);
                    -webkit-appearance: none;
                    -moz-appearance: none;
                    appearance: none;
                }

                .btn-login:hover {
                    background: var(--primary-dark);
                    transform: translateY(-1px);
                    box-shadow: var(--shadow-lg);
                }

                .btn-login:active {
                    transform: translateY(0);
                    box-shadow: var(--shadow);
                }

                .alert {
                    border-radius: 10px;
                    border: none;
                    padding: 1rem;
                    margin-bottom: 1.5rem;
                }



                .divider {
                    margin: 2rem 0;
                    text-align: center;
                    position: relative;
                }

                .divider::before {
                    content: '';
                    position: absolute;
                    top: 50%;
                    left: 0;
                    right: 0;
                    height: 1px;
                    background: var(--outline);
                }

                .divider span {
                    background: var(--surface);
                    padding: 0 1rem;
                    color: var(--on-surface-variant);
                    font-size: 0.875rem;
                    position: relative;
                    z-index: 1;
                }

                .btn-google {
                    background: #f5f5f5;
                    border: 1px solid #dadce0;
                    border-radius: 8px !important;
                    padding: 0.75rem 1.5rem;
                    font-size: 0.875rem;
                    font-weight: 500;
                    width: 100%;
                    color: #3c4043;
                    text-decoration: none;
                    display: inline-flex;
                    align-items: center;
                    justify-content: center;
                    gap: 0.75rem;
                    transition: all 0.15s ease;
                    box-shadow: 0 1px 1px rgba(0, 0, 0, .04);
                    font-family: 'Roboto', sans-serif;
                    -webkit-appearance: none;
                    -moz-appearance: none;
                    appearance: none;
                }

                .btn-google:hover {
                    background: #f8f9fa;
                    border-color: #dadce0;
                    color: #3c4043;
                    text-decoration: none;
                    box-shadow: 0 1px 2px rgba(0, 0, 0, .1);
                }

                .btn-google:active {
                    background: #f1f3f4;
                    box-shadow: 0 1px 1px rgba(0, 0, 0, .04);
                }

                .google-icon {
                    width: 18px;
                    height: 18px;
                    display: inline-block;
                }

                .back-home {
                    position: absolute;
                    top: 2rem;
                    left: 2rem;
                    color: rgba(255, 255, 255, 0.9);
                    text-decoration: none;
                    font-size: 0.95rem;
                    font-weight: 500;
                    background: rgba(255, 255, 255, 0.15);
                    backdrop-filter: blur(12px);
                    -webkit-backdrop-filter: blur(12px);
                    padding: 0.75rem 1.25rem;
                    border-radius: 50px;
                    border: 1px solid rgba(255, 255, 255, 0.2);
                    transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
                    z-index: 10;
                    display: inline-flex;
                    align-items: center;
                    gap: 0.5rem;
                }

                .back-home:hover {
                    color: white;
                    background: rgba(255, 255, 255, 0.25);
                    transform: translateX(-2px);
                    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
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
                <i class="fas fa-arrow-left"></i>
                Về trang chủ
            </a>

            <div class="login-container">
                <div class="login-card">
                    <div class="login-header">
                        <div class="logo">
                            <i class="fas fa-users-cog"></i>
                        </div>
                        <h1>Đăng nhập HRMS</h1>
                        <p>Hệ thống Quản lý Nhân sự</p>
                    </div>

                    <!-- Hiển thị lỗi nếu có -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">
                            <i class="fas fa-exclamation-circle me-2"></i>${error}
                        </div>
                    </c:if>

                    <form method="post" action="${pageContext.request.contextPath}/auth/login">
                        <!-- CSRF Token -->
                        <input type="hidden" name="_csrf_token" value="${csrfToken}">

                        <div class="form-group">
                            <label class="form-label" for="username">Tên đăng nhập</label>
                            <div class="input-group">
                                <i class="fas fa-user input-group-icon"></i>
                                <input type="text" id="username" name="username" class="form-control"
                                    placeholder="Nhập tên đăng nhập" value="${param.username}" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="password">Mật khẩu</label>
                            <div class="input-group password-input-group">
                                <i class="fas fa-lock input-group-icon"></i>
                                <input type="password" id="password" name="password" class="form-control"
                                    placeholder="Nhập mật khẩu" required>
                                <button type="button" class="password-toggle-btn" onclick="togglePassword()">
                                    <i class="fas fa-eye" id="password-eye"></i>
                                </button>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-login">
                            <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
                        </button>
                    </form>

                    <!-- Divider -->
                    <div class="divider">
                        <span>hoặc</span>
                    </div>

                    <!-- Google Login Button -->
                    <a href="${pageContext.request.contextPath}/login-google" class="btn-google">
                        <svg class="google-icon" viewBox="0 0 24 24">
                            <path fill="#4285F4"
                                d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" />
                            <path fill="#34A853"
                                d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" />
                            <path fill="#FBBC05"
                                d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" />
                            <path fill="#EA4335"
                                d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" />
                        </svg>
                        Đăng nhập với Google
                    </a>
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

                // Toggle password visibility
                function togglePassword() {
                    const passwordField = document.getElementById('password');
                    const passwordEye = document.getElementById('password-eye');

                    if (passwordField.type === 'password') {
                        passwordField.type = 'text';
                        passwordEye.classList.remove('fa-eye');
                        passwordEye.classList.add('fa-eye-slash');
                    } else {
                        passwordField.type = 'password';
                        passwordEye.classList.remove('fa-eye-slash');
                        passwordEye.classList.add('fa-eye');
                    }
                }

                // Enter key support for password toggle
                document.addEventListener('keydown', function (event) {
                    if (event.target.classList.contains('password-toggle-btn') && event.key === 'Enter') {
                        togglePassword();
                    }
                });
            </script>
        </body>

        </html>