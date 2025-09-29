<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>HRMS - Hệ thống Quản lý Nhân sự</title>

            <!-- Bootstrap 5.3 CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- Font Awesome -->
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
            <!-- Custom CSS -->
            <style>
                :root {
                    --primary-color: #2c5aa0;
                    --secondary-color: #f8f9fa;
                    --accent-color: #28a745;
                    --text-dark: #2c3e50;
                    --gradient-primary: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                }

                body {
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    line-height: 1.6;
                }

                .hero-section {
                    background: var(--gradient-primary);
                    min-height: 100vh;
                    display: flex;
                    align-items: center;
                    color: white;
                    position: relative;
                    overflow: hidden;
                }

                .hero-section::before {
                    content: '';
                    position: absolute;
                    top: 0;
                    left: 0;
                    right: 0;
                    bottom: 0;
                    background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 300"><path fill="rgba(255,255,255,0.05)" d="M0,96L48,112C96,128,192,160,288,160C384,160,480,128,576,133.3C672,139,768,181,864,186.7C960,192,1056,160,1152,138.7C1248,117,1344,107,1392,101.3L1440,96L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>') no-repeat bottom;
                    background-size: cover;
                }

                .navbar {
                    background: rgba(255, 255, 255, 0.95) !important;
                    backdrop-filter: blur(10px);
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                }

                .navbar-brand {
                    font-weight: bold;
                    color: var(--primary-color) !important;
                    font-size: 1.5rem;
                }

                .nav-link {
                    color: var(--text-dark) !important;
                    font-weight: 500;
                    transition: color 0.3s ease;
                }

                .nav-link:hover {
                    color: var(--primary-color) !important;
                }

                .btn-primary-custom {
                    background: var(--primary-color);
                    border: none;
                    padding: 12px 30px;
                    border-radius: 25px;
                    transition: all 0.3s ease;
                }

                .btn-primary-custom:hover {
                    background: #1e3d6f;
                    transform: translateY(-2px);
                    box-shadow: 0 5px 15px rgba(44, 90, 160, 0.4);
                }

                .feature-card {
                    background: white;
                    border-radius: 15px;
                    padding: 2rem;
                    text-align: center;
                    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                    transition: all 0.3s ease;
                    border: none;
                    height: 100%;
                }

                .feature-card:hover {
                    transform: translateY(-10px);
                    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
                }

                .feature-icon {
                    font-size: 3rem;
                    color: var(--primary-color);
                    margin-bottom: 1rem;
                }

                .stats-section {
                    background: var(--secondary-color);
                    padding: 5rem 0;
                }

                .stat-item {
                    text-align: center;
                    padding: 2rem;
                }

                .stat-number {
                    font-size: 3rem;
                    font-weight: bold;
                    color: var(--primary-color);
                    display: block;
                }

                .section-title {
                    text-align: center;
                    margin-bottom: 3rem;
                }

                .section-title h2 {
                    font-size: 2.5rem;
                    font-weight: bold;
                    color: var(--text-dark);
                    margin-bottom: 1rem;
                }

                .section-title p {
                    font-size: 1.1rem;
                    color: #6c757d;
                }

                .footer {
                    background: var(--text-dark);
                    color: white;
                    padding: 3rem 0 1rem;
                }

                .hero-content h1 {
                    font-size: 3.5rem;
                    font-weight: bold;
                    margin-bottom: 1.5rem;
                    animation: fadeInUp 1s ease;
                }

                .hero-content p {
                    font-size: 1.3rem;
                    margin-bottom: 2rem;
                    opacity: 0.9;
                    animation: fadeInUp 1s ease 0.2s both;
                }

                @keyframes fadeInUp {
                    from {
                        opacity: 0;
                        transform: translateY(30px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                .login-btn {
                    background: rgba(255, 255, 255, 0.2);
                    border: 2px solid white;
                    color: white;
                    padding: 10px 25px;
                    border-radius: 25px;
                    text-decoration: none;
                    transition: all 0.3s ease;
                }

                .login-btn:hover {
                    background: white;
                    color: var(--primary-color);
                }
            </style>
        </head>

        <body>
            <!-- Navigation -->
            <nav class="navbar navbar-expand-lg fixed-top">
                <div class="container">
                    <a class="navbar-brand" href="#">
                        <i class="fas fa-users-cog me-2"></i>HRMS
                    </a>

                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav ms-auto">
                            <li class="nav-item">
                                <a class="nav-link" href="#home">Trang chủ</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#features">Tính năng</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#about">Giới thiệu</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#contact">Liên hệ</a>
                            </li>
                            <li class="nav-item ms-3">
                                <a href="${pageContext.request.contextPath}/auth/login" class="login-btn">
                                    <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>

            <!-- Hero Section -->
            <section id="home" class="hero-section">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-lg-6">
                            <div class="hero-content">
                                <h1>Hệ thống Quản lý Nhân sự Hiện đại</h1>
                                <p>Giải pháp toàn diện cho việc quản lý nhân sự, chấm công, bảng lương và phát triển
                                    nhân viên trong doanh nghiệp của bạn.</p>
                                <div class="d-flex gap-3 flex-wrap">
                                    <a href="${pageContext.request.contextPath}/auth/login"
                                        class="btn btn-light btn-lg px-4">
                                        <i class="fas fa-rocket me-2"></i>Bắt đầu ngay
                                    </a>
                                    <a href="#features" class="btn btn-outline-light btn-lg px-4">
                                        <i class="fas fa-info-circle me-2"></i>Tìm hiểu thêm
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="text-center">
                                <i class="fas fa-chart-line" style="font-size: 15rem; opacity: 0.3;"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Features Section -->
            <section id="features" class="py-5">
                <div class="container">
                    <div class="section-title">
                        <h2>Tính năng chính</h2>
                        <p>Hệ thống HRMS cung cấp đầy đủ các tính năng cần thiết cho quản lý nhân sự hiệu quả</p>
                    </div>

                    <div class="row g-4">
                        <div class="col-lg-4 col-md-6">
                            <div class="feature-card">
                                <div class="feature-icon">
                                    <i class="fas fa-users"></i>
                                </div>
                                <h4>Quản lý Nhân viên</h4>
                                <p>Quản lý thông tin cá nhân, hồ sơ và lịch sử công việc của nhân viên một cách chi tiết
                                    và chính xác.</p>
                            </div>
                        </div>

                        <div class="col-lg-4 col-md-6">
                            <div class="feature-card">
                                <div class="feature-icon">
                                    <i class="fas fa-clock"></i>
                                </div>
                                <h4>Chấm công</h4>
                                <p>Hệ thống chấm công tự động, theo dõi giờ làm việc, overtime và quản lý ca làm việc
                                    linh hoạt.</p>
                            </div>
                        </div>

                        <div class="col-lg-4 col-md-6">
                            <div class="feature-card">
                                <div class="feature-icon">
                                    <i class="fas fa-money-bill-wave"></i>
                                </div>
                                <h4>Tính lương</h4>
                                <p>Tự động tính toán lương, thưởng, khấu trừ và tạo bảng lương chính xác theo quy định.
                                </p>
                            </div>
                        </div>

                        <div class="col-lg-4 col-md-6">
                            <div class="feature-card">
                                <div class="feature-icon">
                                    <i class="fas fa-calendar-alt"></i>
                                </div>
                                <h4>Quản lý nghỉ phép</h4>
                                <p>Xử lý đơn xin nghỉ phép, theo dõi ngày phép còn lại và lập kế hoạch công việc hợp lý.
                                </p>
                            </div>
                        </div>

                        <div class="col-lg-4 col-md-6">
                            <div class="feature-card">
                                <div class="feature-icon">
                                    <i class="fas fa-user-tie"></i>
                                </div>
                                <h4>Tuyển dụng</h4>
                                <p>Quản lý quy trình tuyển dụng từ đăng tin, nhận hồ sơ đến phỏng vấn và tuyển chọn.</p>
                            </div>
                        </div>

                        <div class="col-lg-4 col-md-6">
                            <div class="feature-card">
                                <div class="feature-icon">
                                    <i class="fas fa-chart-bar"></i>
                                </div>
                                <h4>Báo cáo & Thống kê</h4>
                                <p>Tạo các báo cáo chi tiết về nhân sự, hiệu suất và xu hướng phát triển của công ty.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Stats Section -->
            <section class="stats-section">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-3 col-md-6">
                            <div class="stat-item">
                                <span class="stat-number counter">1000+</span>
                                <h5>Nhân viên quản lý</h5>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="stat-item">
                                <span class="stat-number counter">50+</span>
                                <h5>Doanh nghiệp tin dùng</h5>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="stat-item">
                                <span class="stat-number counter">99%</span>
                                <h5>Độ chính xác</h5>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="stat-item">
                                <span class="stat-number counter">24/7</span>
                                <h5>Hỗ trợ</h5>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Footer -->
            <footer class="footer">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-6">
                            <h5><i class="fas fa-users-cog me-2"></i>HRMS</h5>
                            <p>Hệ thống quản lý nhân sự hiện đại, giúp doanh nghiệp tối ưu hóa quy trình HR và nâng cao
                                hiệu quả làm việc.</p>
                        </div>
                        <div class="col-lg-3">
                            <h6>Liên kết nhanh</h6>
                            <ul class="list-unstyled">
                                <li><a href="#" class="text-light text-decoration-none">Trang chủ</a></li>
                                <li><a href="#" class="text-light text-decoration-none">Tính năng</a></li>
                                <li><a href="#" class="text-light text-decoration-none">Hướng dẫn</a></li>
                                <li><a href="#" class="text-light text-decoration-none">Hỗ trợ</a></li>
                            </ul>
                        </div>
                        <div class="col-lg-3">
                            <h6>Liên hệ</h6>
                            <p><i class="fas fa-envelope me-2"></i>support@hrms.com</p>
                            <p><i class="fas fa-phone me-2"></i>+84 123 456 789</p>
                        </div>
                    </div>
                    <hr class="my-4">
                    <div class="text-center">
                        <p>&copy; 2025 HRMS. All rights reserved. Developed by Group 4.</p>
                    </div>
                </div>
            </footer>

            <!-- Bootstrap 5 JS -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

            <!-- Counter Animation -->
            <script>
                // Simple counter animation
                document.addEventListener('DOMContentLoaded', function () {
                    const counters = document.querySelectorAll('.counter');
                    const animateCounter = (counter) => {
                        const target = parseInt(counter.textContent.replace(/\D/g, ''));
                        const increment = target / 100;
                        let current = 0;
                        const timer = setInterval(() => {
                            current += increment;
                            if (current >= target) {
                                current = target;
                                clearInterval(timer);
                            }
                            counter.textContent = counter.textContent.replace(/\d+/, Math.floor(current));
                        }, 20);
                    };

                    // Animate counters when they come into view
                    const observer = new IntersectionObserver((entries) => {
                        entries.forEach((entry) => {
                            if (entry.isIntersecting) {
                                animateCounter(entry.target);
                                observer.unobserve(entry.target);
                            }
                        });
                    });

                    counters.forEach(counter => observer.observe(counter));
                });
            </script>
        </body>

        </html>