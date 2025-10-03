<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

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
        once: true,
        offset: 100
    });

    // Navbar scroll effect
    window.addEventListener('scroll', function() {
        const navbar = document.querySelector('.navbar');
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });

    // Counter animation for stats
    function animateCounters() {
        const counters = document.querySelectorAll('.counter');
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