<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>HRMS - Hệ thống Quản lý Nhân sự</title>

            <!-- Bootstrap CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- Font Awesome -->
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
            <!-- AOS Animation -->
            <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

            <style>
                :root {
                    --primary-color: #2c5aa0;
                    --secondary-color: #f8f9fa;
                    --accent-color: #667eea;
                    --success-color: #28a745;
                    --text-dark: #333;
                    --text-light: #666;
                }

                body {
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    line-height: 1.6;
                    color: var(--text-dark);
                }

                /* Navigation */
                .navbar {
                    background: rgba(255, 255, 255, 0.95);
                    backdrop-filter: blur(10px);
                    box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
                    padding: 1rem 0;
                    transition: all 0.3s ease;
                }

                .navbar.scrolled {
                    background: white;
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.15);
                }

                .navbar-brand {
                    font-size: 1.8rem;
                    font-weight: bold;
                    color: var(--primary-color) !important;
                }

                .navbar-nav .nav-link {
                    color: var(--text-dark) !important;
                    font-weight: 500;
                    margin: 0 1rem;
                    transition: color 0.3s ease;
                    position: relative;
                }

                .navbar-nav .nav-link:hover,
                .navbar-nav .nav-link.active {
                    color: var(--primary-color) !important;
                }

                .navbar-nav .nav-link::after {
                    content: '';
                    position: absolute;
                    width: 0;
                    height: 2px;
                    bottom: -5px;
                    left: 50%;
                    background: var(--accent-color);
                    transition: all 0.3s ease;
                }

                .navbar-nav .nav-link:hover::after,
                .navbar-nav .nav-link.active::after {
                    width: 100%;
                    left: 0;
                }

                /* Hero Section */
                .hero-section {
                    background: linear-gradient(135deg, var(--primary-color) 0%, var(--accent-color) 100%);
                    color: white;
                    padding: 150px 0 100px;
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
                    background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 100" fill="white" opacity="0.1"><polygon points="1000,100 1000,0 0,100"/></svg>');
                    background-size: cover;
                }

                .hero-content {
                    position: relative;
                    z-index: 2;
                }

                .hero-section h1 {
                    font-size: 3.5rem;
                    font-weight: bold;
                    margin-bottom: 1.5rem;
                    line-height: 1.2;
                }

                .hero-section p {
                    font-size: 1.3rem;
                    opacity: 0.9;
                    margin-bottom: 2rem;
                    max-width: 600px;
                }

                .btn-hero {
                    background: white;
                    color: var(--primary-color);
                    border: 2px solid white;
                    border-radius: 50px;
                    padding: 15px 40px;
                    font-weight: 600;
                    font-size: 1.1rem;
                    transition: all 0.3s ease;
                    margin: 0 10px 10px 0;
                }

                .btn-hero:hover {
                    background: transparent;
                    color: white;
                    transform: translateY(-2px);
                    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
                }

                .btn-hero-outline {
                    background: transparent;
                    color: white;
                    border: 2px solid white;
                    border-radius: 50px;
                    padding: 15px 40px;
                    font-weight: 600;
                    font-size: 1.1rem;
                    transition: all 0.3s ease;
                    margin: 0 10px 10px 0;
                }

                .btn-hero-outline:hover {
                    background: white;
                    color: var(--primary-color);
                    transform: translateY(-2px);
                    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
                }

                /* Features Section */
                .features-section {
                    padding: 100px 0;
                    background: var(--secondary-color);
                }

                .section-title {
                    text-align: center;
                    margin-bottom: 4rem;
                }

                .section-title h2 {
                    font-size: 2.5rem;
                    font-weight: bold;
                    color: var(--primary-color);
                    margin-bottom: 1rem;
                }

                .section-title p {
                    font-size: 1.2rem;
                    color: var(--text-light);
                    max-width: 600px;
                    margin: 0 auto;
                }

                .feature-card {
                    background: white;
                    border-radius: 20px;
                    padding: 3rem 2rem;
                    text-align: center;
                    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                    transition: all 0.3s ease;
                    height: 100%;
                    border: 1px solid #f0f0f0;
                }

                .feature-card:hover {
                    transform: translateY(-10px);
                    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
                }

                .feature-icon {
                    width: 80px;
                    height: 80px;
                    background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    color: white;
                    font-size: 2rem;
                    margin: 0 auto 1.5rem;
                }

                .feature-card h4 {
                    color: var(--primary-color);
                    margin-bottom: 1rem;
                    font-weight: 600;
                }

                .feature-card p {
                    color: var(--text-light);
                    line-height: 1.7;
                }

                /* Stats Section */
                .stats-section {
                    background: linear-gradient(135deg, var(--primary-color) 0%, var(--accent-color) 100%);
                    color: white;
                    padding: 80px 0;
                }

                .stat-item {
                    text-align: center;
                    padding: 2rem 1rem;
                }

                .stat-number {
                    font-size: 3rem;
                    font-weight: bold;
                    margin-bottom: 0.5rem;
                    display: block;
                }

                .stat-label {
                    font-size: 1.1rem;
                    opacity: 0.9;
                }

                /* Services Section */
                .services-section {
                    padding: 100px 0;
                }

                .service-item {
                    display: flex;
                    align-items: center;
                    margin-bottom: 3rem;
                    padding: 2rem 0;
                }

                .service-icon {
                    width: 100px;
                    height: 100px;
                    background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
                    border-radius: 20px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    color: white;
                    font-size: 2.5rem;
                    margin-right: 2rem;
                    flex-shrink: 0;
                }

                .service-content h4 {
                    color: var(--primary-color);
                    margin-bottom: 1rem;
                    font-weight: 600;
                }

                .service-content p {
                    color: var(--text-light);
                    line-height: 1.7;
                    margin: 0;
                }

                /* CTA Section */
                .cta-section {
                    background: var(--secondary-color);
                    padding: 80px 0;
                    text-align: center;
                }

                .cta-section h2 {
                    color: var(--primary-color);
                    margin-bottom: 1rem;
                    font-weight: bold;
                }

                .cta-section p {
                    color: var(--text-light);
                    font-size: 1.2rem;
                    margin-bottom: 2rem;
                }

                /* Footer */
                .footer {
                    background: var(--text-dark);
                    color: white;
                    padding: 4rem 0 2rem;
                }

                .footer h5 {
                    color: var(--accent-color);
                    margin-bottom: 1.5rem;
                    font-weight: 600;
                }

                .footer a {
                    color: #ccc;
                    text-decoration: none;
                    transition: color 0.3s ease;
                    display: block;
                    padding: 0.25rem 0;
                }

                .footer a:hover {
                    color: var(--accent-color);
                }

                .footer-bottom {
                    border-top: 1px solid #444;
                    padding-top: 2rem;
                    margin-top: 3rem;
                    text-align: center;
                    color: #999;
                }

                .social-links a {
                    display: inline-block;
                    width: 40px;
                    height: 40px;
                    background: #444;
                    border-radius: 50%;
                    text-align: center;
                    line-height: 40px;
                    margin: 0 5px;
                    transition: all 0.3s ease;
                }

                .social-links a:hover {
                    background: var(--accent-color);
                    transform: translateY(-2px);
                }

                /* Responsive */
                @media (max-width: 768px) {
                    .hero-section h1 {
                        font-size: 2.5rem;
                    }

                    .hero-section p {
                        font-size: 1.1rem;
                    }

                    .service-item {
                        flex-direction: column;
                        text-align: center;
                    }

                    .service-icon {
                        margin-right: 0;
                        margin-bottom: 1rem;
                    }

                    .stat-number {
                        font-size: 2rem;
                    }
                }
            </style>
        </head>

        <body>
            <!-- Navigation -->
            <nav class="navbar navbar-expand-lg navbar-light fixed-top">
                <div class="container">
                    <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                        <i class="fas fa-users-cog me-2"></i>HRMS
                    </a>

                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav ms-auto">
                            <li class="nav-item">
                                <a class="nav-link active" href="${pageContext.request.contextPath}/">Trang chủ</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#features">Tính năng</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/about">Giới thiệu</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/contact">Liên hệ</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/faqs">FAQs</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/auth/login">Đăng nhập</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>

            <!-- Hero Section -->
            <section class="hero-section">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-lg-6">
                            <div class="hero-content" data-aos="fade-right">
                                <h1>Quản lý Nhân sự <br>Thông minh & Hiệu quả</h1>
                                <p>Hệ thống HRMS hiện đại giúp doanh nghiệp tối ưu hóa quy trình quản lý nhân sự, từ
                                    tuyển dụng đến phát triển nghề nghiệp.</p>
                                <div class="hero-buttons">
                                    <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-hero">
                                        <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập ngay
                                    </a>
                                    <a href="${pageContext.request.contextPath}/about" class="btn btn-hero-outline">
                                        <i class="fas fa-info-circle me-2"></i>Tìm hiểu thêm
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="text-center" data-aos="fade-left">
                                <i class="fas fa-chart-line" style="font-size: 20rem; opacity: 0.1;"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Features Section -->
            <section class="features-section" id="features">
                <div class="container">
                    <div class="section-title" data-aos="fade-up">
                        <h2>Tính năng nổi bật</h2>
                        <p>Khám phá những tính năng mạnh mẽ giúp doanh nghiệp quản lý nhân sự hiệu quả</p>
                    </div>

                    <div class="row">
                        <div class="col-lg-4 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="100">
                            <div class="feature-card">
                                <div class="feature-icon">
                                    <i class="fas fa-users"></i>
                                </div>
                                <h4>Quản lý Nhân viên</h4>
                                <p>Quản lý thông tin nhân viên toàn diện, từ hồ sơ cá nhân đến lịch sử công việc và đánh
                                    giá hiệu suất.</p>
                            </div>
                        </div>

                        <div class="col-lg-4 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="200">
                            <div class="feature-card">
                                <div class="feature-icon">
                                    <i class="fas fa-clock"></i>
                                </div>
                                <h4>Chấm công Thông minh</h4>
                                <p>Hệ thống chấm công tự động với nhiều phương thức: web, mobile app, và tích hợp máy
                                    chấm công.</p>
                            </div>
                        </div>

                        <div class="col-lg-4 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="300">
                            <div class="feature-card">
                                <div class="feature-icon">
                                    <i class="fas fa-money-bill-wave"></i>
                                </div>
                                <h4>Tính lương Tự động</h4>
                                <p>Tính toán lương chính xác dựa trên chấm công, phụ cấp, thưởng và các khoản khấu trừ
                                    theo quy định.</p>
                            </div>
                        </div>

                        <div class="col-lg-4 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="400">
                            <div class="feature-card">
                                <div class="feature-icon">
                                    <i class="fas fa-calendar-alt"></i>
                                </div>
                                <h4>Quản lý Nghỉ phép</h4>
                                <p>Đăng ký, phê duyệt và theo dõi nghỉ phép trực tuyến với workflow tự động và thông báo
                                    real-time.</p>
                            </div>
                        </div>

                        <div class="col-lg-4 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="500">
                            <div class="feature-card">
                                <div class="feature-icon">
                                    <i class="fas fa-chart-bar"></i>
                                </div>
                                <h4>Báo cáo & Phân tích</h4>
                                <p>Dashboard trực quan với các báo cáo chi tiết về nhân sự, hiệu suất và xu hướng phát
                                    triển.</p>
                            </div>
                        </div>

                        <div class="col-lg-4 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="600">
                            <div class="feature-card">
                                <div class="feature-icon">
                                    <i class="fas fa-shield-alt"></i>
                                </div>
                                <h4>Bảo mật Cao cấp</h4>
                                <p>Bảo vệ dữ liệu nhân sự với mã hóa cao cấp, phân quyền chi tiết và tuân thủ các chuẩn
                                    bảo mật.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Stats Section -->
            <section class="stats-section">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-3 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="100">
                            <div class="stat-item">
                                <span class="stat-number" data-count="1000">0</span>
                                <div class="stat-label">Doanh nghiệp tin tùng</div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="200">
                            <div class="stat-item">
                                <span class="stat-number" data-count="50000">0</span>
                                <div class="stat-label">Nhân viên được quản lý</div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="300">
                            <div class="stat-item">
                                <span class="stat-number" data-count="99">0</span>
                                <div class="stat-label">% Uptime hệ thống</div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="400">
                            <div class="stat-item">
                                <span class="stat-number" data-count="24">0</span>
                                <div class="stat-label">Hỗ trợ 24/7</div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Services Section -->
            <section class="services-section">
                <div class="container">
                    <div class="section-title" data-aos="fade-up">
                        <h2>Dịch vụ toàn diện</h2>
                        <p>Giải pháp HR từ A đến Z cho mọi quy mô doanh nghiệp</p>
                    </div>

                    <div class="row">
                        <div class="col-lg-6 mb-4" data-aos="fade-right" data-aos-delay="100">
                            <div class="service-item">
                                <div class="service-icon">
                                    <i class="fas fa-user-plus"></i>
                                </div>
                                <div class="service-content">
                                    <h4>Tuyển dụng & Tuyển chọn</h4>
                                    <p>Quản lý toàn bộ quy trình tuyển dụng từ đăng tin, sàng lọc hồ sơ, phỏng vấn đến
                                        quyết định tuyển dụng.</p>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-6 mb-4" data-aos="fade-left" data-aos-delay="200">
                            <div class="service-item">
                                <div class="service-icon">
                                    <i class="fas fa-graduation-cap"></i>
                                </div>
                                <div class="service-content">
                                    <h4>Đào tạo & Phát triển</h4>
                                    <p>Lập kế hoạch đào tạo, theo dõi tiến độ học tập và đánh giá hiệu quả chương trình
                                        phát triển nhân viên.</p>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-6 mb-4" data-aos="fade-right" data-aos-delay="300">
                            <div class="service-item">
                                <div class="service-icon">
                                    <i class="fas fa-star"></i>
                                </div>
                                <div class="service-content">
                                    <h4>Đánh giá Hiệu suất</h4>
                                    <p>Hệ thống đánh giá KPI, 360 feedback và theo dõi mục tiêu cá nhân để nâng cao hiệu
                                        quả làm việc.</p>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-6 mb-4" data-aos="fade-left" data-aos-delay="400">
                            <div class="service-item">
                                <div class="service-icon">
                                    <i class="fas fa-cogs"></i>
                                </div>
                                <div class="service-content">
                                    <h4>Tự động hóa Quy trình</h4>
                                    <p>Workflow tự động cho các quy trình HR, giảm thiểu công việc thủ công và tăng hiệu
                                        quả vận hành.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- CTA Section -->
            <section class="cta-section">
                <div class="container text-center" data-aos="fade-up">
                    <h2>Sẵn sàng chuyển đổi số HR?</h2>
                    <p>Bắt đầu hành trình số hóa quản lý nhân sự cùng HRMS ngay hôm nay</p>
                    <a href="${pageContext.request.contextPath}/contact" class="btn btn-hero">
                        <i class="fas fa-rocket me-2"></i>Liên hệ tư vấn
                    </a>
                </div>
            </section>

            <!-- Footer -->
            <footer class="footer">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-4 col-md-6 mb-4">
                            <h5>HRMS</h5>
                            <p>Hệ thống quản lý nhân sự hiện đại, giúp doanh nghiệp tối ưu hóa quy trình quản lý và phát
                                triển nguồn nhân lực hiệu quả.</p>
                            <div class="social-links">
                                <a href="#"><i class="fab fa-facebook-f"></i></a>
                                <a href="#"><i class="fab fa-twitter"></i></a>
                                <a href="#"><i class="fab fa-linkedin-in"></i></a>
                                <a href="#"><i class="fab fa-instagram"></i></a>
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-6 mb-4">
                            <h5>Liên kết</h5>
                            <a href="${pageContext.request.contextPath}/">Trang chủ</a>
                            <a href="${pageContext.request.contextPath}/about">Về chúng tôi</a>
                            <a href="${pageContext.request.contextPath}/contact">Liên hệ</a>
                            <a href="${pageContext.request.contextPath}/faqs">FAQs</a>
                        </div>
                        <div class="col-lg-3 col-md-6 mb-4">
                            <h5>Tính năng</h5>
                            <a href="#">Quản lý nhân viên</a>
                            <a href="#">Chấm công</a>
                            <a href="#">Tính lương</a>
                            <a href="#">Nghỉ phép</a>
                            <a href="#">Báo cáo</a>
                        </div>
                        <div class="col-lg-3 col-md-6 mb-4">
                            <h5>Liên hệ</h5>
                            <a href="mailto:support@hrms.com"><i class="fas fa-envelope me-2"></i>support@hrms.com</a>
                            <a href="tel:+84123456789"><i class="fas fa-phone me-2"></i>+84 123 456 789</a>
                            <a href="#"><i class="fas fa-map-marker-alt me-2"></i>Hà Nội, Việt Nam</a>
                        </div>
                    </div>
                    <div class="footer-bottom">
                        <p>&copy; 2025 HRMS. Phát triển bởi nhóm SWP391-SE1960NJ-FA25-Group4. All rights reserved.</p>
                    </div>
                </div>
            </footer>

            <!-- Bootstrap JS -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <!-- AOS Animation JS -->
            <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>

            <!-- Custom JavaScript -->
            <script>
                // Initialize AOS
                AOS.init({
                    duration: 1000,
                    easing: 'ease-in-out',
                    once: true
                });

                // Navbar scroll effect
                window.addEventListener('scroll', function () {
                    const navbar = document.querySelector('.navbar');
                    if (window.scrollY > 50) {
                        navbar.classList.add('scrolled');
                    } else {
                        navbar.classList.remove('scrolled');
                    }
                });

                // Counter animation
                function animateCounters() {
                    const counters = document.querySelectorAll('.stat-number');

                    counters.forEach(counter => {
                        const target = parseInt(counter.getAttribute('data-count'));
                        const increment = target / 200;
                        let current = 0;

                        const timer = setInterval(() => {
                            current += increment;
                            if (current >= target) {
                                counter.textContent = target;
                                clearInterval(timer);
                            } else {
                                counter.textContent = Math.floor(current);
                            }
                        }, 10);
                    });
                }

                // Trigger counter animation when stats section is visible
                const observer = new IntersectionObserver((entries) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            animateCounters();
                            observer.unobserve(entry.target);
                        }
                    });
                });

                const statsSection = document.querySelector('.stats-section');
                if (statsSection) {
                    observer.observe(statsSection);
                }

                // Smooth scroll for anchor links
                document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                    anchor.addEventListener('click', function (e) {
                        e.preventDefault();
                        const target = document.querySelector(this.getAttribute('href'));
                        if (target) {
                            target.scrollIntoView({
                                behavior: 'smooth',
                                block: 'start'
                            });
                        }
                    });
                });
            </script>
        </body>

        </html>