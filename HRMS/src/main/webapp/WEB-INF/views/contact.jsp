<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Liên hệ - HRMS</title>

            <!-- Common Styles -->
            <jsp:include page="/WEB-INF/views/layout/public-styles.jsp" />

            <style>
                :root {
                    --primary-color: #2c5aa0;
                    --secondary-color: #f8f9fa;
                    --accent-color: #667eea;
                    --success-color: #28a745;
                    --danger-color: #dc3545;
                    --text-dark: #333;
                }

                body {
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    line-height: 1.6;
                    color: var(--text-dark);
                }

                /* Navigation */
                .navbar {
                    background: white;
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                    padding: 1rem 0;
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
                }

                .navbar-nav .nav-link:hover,
                .navbar-nav .nav-link.active {
                    color: var(--primary-color) !important;
                }



                /* Hero Section */
                .hero-section {
                    background: linear-gradient(135deg, var(--primary-color) 0%, var(--accent-color) 100%);
                    color: white;
                    padding: 100px 0 80px;
                    text-align: center;
                }

                .hero-section h1 {
                    font-size: 3rem;
                    font-weight: bold;
                    margin-bottom: 1rem;
                }

                .hero-section p {
                    font-size: 1.2rem;
                    opacity: 0.9;
                }

                /* Contact Section */
                .contact-section {
                    padding: 80px 0;
                }

                .contact-info {
                    background: var(--secondary-color);
                    border-radius: 15px;
                    padding: 3rem;
                    height: 100%;
                }

                .contact-item {
                    display: flex;
                    align-items: center;
                    margin-bottom: 2rem;
                    padding: 1.5rem;
                    background: white;
                    border-radius: 10px;
                    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
                    transition: transform 0.3s ease;
                }

                .contact-item:hover {
                    transform: translateY(-5px);
                }

                .contact-icon {
                    width: 60px;
                    height: 60px;
                    background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    color: white;
                    font-size: 1.5rem;
                    margin-right: 1.5rem;
                }

                .contact-details h5 {
                    color: var(--primary-color);
                    margin-bottom: 0.5rem;
                    font-weight: 600;
                }

                .contact-details p {
                    margin: 0;
                    color: #666;
                }

                /* Contact Form */
                .contact-form {
                    background: white;
                    border-radius: 15px;
                    padding: 3rem;
                    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                }

                .contact-form h3 {
                    color: var(--primary-color);
                    margin-bottom: 2rem;
                    font-weight: bold;
                }

                .form-group {
                    margin-bottom: 1.5rem;
                }

                .form-group label {
                    color: var(--text-dark);
                    font-weight: 500;
                    margin-bottom: 0.5rem;
                    display: block;
                }

                .form-control {
                    border: 2px solid #e9ecef;
                    border-radius: 8px;
                    padding: 12px 15px;
                    font-size: 1rem;
                    transition: border-color 0.3s ease, box-shadow 0.3s ease;
                }

                .form-control:focus {
                    border-color: var(--accent-color);
                    box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
                }

                .btn-primary {
                    background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
                    border: none;
                    border-radius: 8px;
                    padding: 12px 30px;
                    font-weight: 600;
                    font-size: 1rem;
                    transition: transform 0.3s ease;
                }

                .btn-primary:hover {
                    transform: translateY(-2px);
                    background: linear-gradient(135deg, var(--accent-color), var(--primary-color));
                }

                /* Alert Messages */
                .alert {
                    border-radius: 8px;
                    border: none;
                    padding: 1rem 1.5rem;
                }

                .alert-success {
                    background: linear-gradient(135deg, var(--success-color), #34ce57);
                    color: white;
                }

                .alert-danger {
                    background: linear-gradient(135deg, var(--danger-color), #e74c3c);
                    color: white;
                }

                /* Map Section */
                .map-section {
                    background: var(--secondary-color);
                    padding: 60px 0;
                }

                .map-container {
                    border-radius: 15px;
                    overflow: hidden;
                    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                }

                .map-placeholder {
                    height: 400px;
                    background: linear-gradient(45deg, #f8f9fa, #e9ecef);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    color: #666;
                    font-size: 1.2rem;
                }

                /* Footer */
                .footer {
                    background: var(--text-dark);
                    color: white;
                    padding: 3rem 0 1rem;
                    margin-top: 5rem;
                }

                .footer h5 {
                    color: var(--accent-color);
                    margin-bottom: 1rem;
                }

                .footer a {
                    color: #ccc;
                    text-decoration: none;
                    transition: color 0.3s ease;
                }

                .footer a:hover {
                    color: var(--accent-color);
                }

                .footer-bottom {
                    border-top: 1px solid #444;
                    padding-top: 1rem;
                    margin-top: 2rem;
                    text-align: center;
                    color: #999;
                }
            </style>
        </head>

        <body>
            <!-- Navigation -->
            <jsp:include page="/WEB-INF/views/layout/public-header.jsp" />

            <!-- Hero Section -->
            <section class="hero-section">
                <div class="container">
                    <h1>Liên hệ với chúng tôi</h1>
                    <p>Chúng tôi luôn sẵn sàng hỗ trợ bạn</p>
                </div>
            </section>

            <!-- Contact Section -->
            <section class="contact-section">
                <div class="container">
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

                    <div class="row">
                        <!-- Contact Information -->
                        <div class="col-lg-5 col-md-6 mb-5">
                            <div class="contact-info">
                                <h3 class="mb-4" style="color: var(--primary-color); font-weight: bold;">Thông tin liên
                                    hệ</h3>

                                <div class="contact-item">
                                    <div class="contact-icon">
                                        <i class="fas fa-map-marker-alt"></i>
                                    </div>
                                    <div class="contact-details">
                                        <h5>Địa chỉ</h5>
                                        <p>Đại học FPT Hà Nội<br>Khu Công nghệ cao Hòa Lạc<br>Thạch Thất, Hà Nội</p>
                                    </div>
                                </div>

                                <div class="contact-item">
                                    <div class="contact-icon">
                                        <i class="fas fa-phone"></i>
                                    </div>
                                    <div class="contact-details">
                                        <h5>Điện thoại</h5>
                                        <p>Hotline: +84 123 456 789<br>Support: +84 987 654 321</p>
                                    </div>
                                </div>

                                <div class="contact-item">
                                    <div class="contact-icon">
                                        <i class="fas fa-envelope"></i>
                                    </div>
                                    <div class="contact-details">
                                        <h5>Email</h5>
                                        <p>support@hrms.com<br>info@hrms.com</p>
                                    </div>
                                </div>

                                <div class="contact-item">
                                    <div class="contact-icon">
                                        <i class="fas fa-clock"></i>
                                    </div>
                                    <div class="contact-details">
                                        <h5>Giờ làm việc</h5>
                                        <p>Thứ 2 - Thứ 6: 8:00 - 17:30<br>Thứ 7: 8:00 - 12:00</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Contact Form -->
                        <div class="col-lg-7 col-md-6">
                            <div class="contact-form">
                                <h3><i class="fas fa-paper-plane me-2"></i>Gửi tin nhắn</h3>
                                <p class="mb-4">Hãy để lại thông tin, chúng tôi sẽ liên hệ với bạn trong thời gian sớm
                                    nhất.</p>

                                <form action="${pageContext.request.contextPath}/contact" method="post">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="name">Họ và tên <span class="text-danger">*</span></label>
                                                <input type="text" class="form-control" id="name" name="name"
                                                    placeholder="Nhập họ và tên của bạn" required>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="email">Email <span class="text-danger">*</span></label>
                                                <input type="email" class="form-control" id="email" name="email"
                                                    placeholder="Nhập địa chỉ email" required>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="phone">Số điện thoại</label>
                                                <input type="tel" class="form-control" id="phone" name="phone"
                                                    placeholder="Nhập số điện thoại">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="subject">Chủ đề</label>
                                                <input type="text" class="form-control" id="subject" name="subject"
                                                    placeholder="Chủ đề tin nhắn">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="message">Nội dung <span class="text-danger">*</span></label>
                                        <textarea class="form-control" id="message" name="message" rows="6"
                                            placeholder="Nhập nội dung tin nhắn của bạn..." required></textarea>
                                    </div>

                                    <div class="text-center">
                                        <button type="submit" class="btn btn-primary btn-lg">
                                            <i class="fas fa-paper-plane me-2"></i>Gửi tin nhắn
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Map Section -->
            <section class="map-section">
                <div class="container">
                    <h3 class="text-center mb-5" style="color: var(--primary-color); font-weight: bold;">
                        <i class="fas fa-map-marked-alt me-2"></i>Vị trí của chúng tôi
                    </h3>
                    <div class="map-container">
                        <div class="map-placeholder">
                            <div class="text-center">
                                <i class="fas fa-map-marker-alt fa-3x mb-3" style="color: var(--accent-color);"></i>
                                <h5>Bản đồ sẽ được tích hợp tại đây</h5>
                                <p>Đại học FPT Hà Nội - Khu Công nghệ cao Hòa Lạc</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Footer -->
            <jsp:include page="/WEB-INF/views/layout/public-footer.jsp" />
        </body>

        </html>