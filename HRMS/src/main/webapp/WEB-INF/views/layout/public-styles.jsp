<!-- Bootstrap 5.3 CSS -->
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

    /* Alert Messages */
    .alert {
        border-radius: 10px;
        border: none;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        margin-bottom: 2rem;
    }

    .alert-success {
        background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
        color: #155724;
    }

    .alert-danger {
        background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
        color: #721c24;
    }

    .alert-info {
        background: linear-gradient(135deg, #d1ecf1 0%, #bee5eb 100%);
        color: #0c5460;
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
        background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 100" fill="white" opacity="0.1"><polygon points="0,100 1000,0 1000,100"/></svg>');
        background-size: cover;
        background-repeat: no-repeat;
    }

    .hero-section h1 {
        font-size: 3.5rem;
        font-weight: bold;
        margin-bottom: 1rem;
    }

    .hero-section p {
        font-size: 1.2rem;
        margin-bottom: 2rem;
        opacity: 0.9;
    }

    /* Breadcrumb */
    .breadcrumb-section {
        background: var(--secondary-color);
        padding: 2rem 0;
    }

    .breadcrumb {
        background: none;
        padding: 0;
        margin: 0;
    }

    .breadcrumb-item + .breadcrumb-item::before {
        content: "›";
        color: var(--text-light);
    }

    .breadcrumb-item a {
        color: var(--primary-color);
        text-decoration: none;
    }

    .breadcrumb-item.active {
        color: var(--text-light);
    }

    /* Content Sections */
    .content-section {
        padding: 5rem 0;
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
        font-size: 1.1rem;
        color: var(--text-light);
        max-width: 600px;
        margin: 0 auto;
    }

    /* Cards */
    .feature-card, .service-card, .info-card {
        background: white;
        border-radius: 15px;
        padding: 2rem;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
        height: 100%;
        border: 1px solid rgba(0, 0, 0, 0.05);
    }

    .feature-card:hover, .service-card:hover, .info-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
    }

    .feature-icon, .service-icon {
        width: 80px;
        height: 80px;
        background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
        border-radius: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 2rem;
        margin-bottom: 1.5rem;
    }

    /* Buttons */
    .btn-primary {
        background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
        border: none;
        border-radius: 25px;
        padding: 12px 30px;
        font-weight: 600;
        transition: all 0.3s ease;
    }

    .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 25px rgba(44, 90, 160, 0.3);
    }

    .btn-hero {
        background: white;
        color: var(--primary-color);
        border: none;
        border-radius: 50px;
        padding: 15px 40px;
        font-weight: 600;
        font-size: 1.1rem;
        transition: all 0.3s ease;
    }

    .btn-hero:hover {
        background: var(--secondary-color);
        transform: translateY(-3px);
        box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
    }

    /* Forms */
    .form-control, .form-select {
        border: 2px solid #e9ecef;
        border-radius: 10px;
        padding: 12px 15px;
        transition: all 0.3s ease;
    }

    .form-control:focus, .form-select:focus {
        border-color: var(--primary-color);
        box-shadow: 0 0 0 0.2rem rgba(44, 90, 160, 0.25);
    }

    .form-label {
        font-weight: 600;
        color: var(--text-dark);
        margin-bottom: 0.5rem;
    }

    /* Footer */
    .footer {
        background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
        color: white;
        padding: 4rem 0 2rem;
    }

    .footer h5 {
        color: var(--accent-color);
        margin-bottom: 1.5rem;
        font-weight: bold;
    }

    .footer a {
        color: #ccc;
        text-decoration: none;
        display: block;
        margin-bottom: 0.5rem;
        transition: color 0.3s ease;
    }

    .footer a:hover {
        color: var(--accent-color);
    }

    .social-links {
        display: flex;
        gap: 1rem;
        margin-top: 1rem;
    }

    .social-links a {
        width: 40px;
        height: 40px;
        background: rgba(255, 255, 255, 0.1);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: all 0.3s ease;
    }

    .social-links a:hover {
        background: var(--accent-color);
        transform: translateY(-3px);
    }

    .footer-bottom {
        border-top: 1px solid #444;
        padding-top: 2rem;
        margin-top: 3rem;
        text-align: center;
        color: #999;
    }

    /* Stats Section */
    .stats-section {
        background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
        padding: 5rem 0;
        color: white;
    }

    .stat-item {
        text-align: center;
        padding: 2rem;
    }

    .stat-number {
        font-size: 3rem;
        font-weight: bold;
        display: block;
        margin-bottom: 0.5rem;
    }

    .stat-label {
        font-size: 1.1rem;
        opacity: 0.9;
    }

    /* Contact Section */
    .contact-section {
        padding: 5rem 0;
        background: var(--secondary-color);
    }

    .contact-info {
        background: white;
        border-radius: 15px;
        padding: 2rem;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        height: 100%;
    }

    .contact-item {
        display: flex;
        align-items: center;
        margin-bottom: 2rem;
    }

    .contact-icon {
        width: 50px;
        height: 50px;
        background: var(--primary-color);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        margin-right: 1rem;
        flex-shrink: 0;
    }

    /* FAQ Section */
    .faq-section {
        padding: 5rem 0;
    }

    .accordion-button {
        background: white;
        border: none;
        font-weight: 600;
        color: var(--text-dark);
    }

    .accordion-button:not(.collapsed) {
        background: var(--primary-color);
        color: white;
    }

    .accordion-button:focus {
        box-shadow: 0 0 0 0.25rem rgba(44, 90, 160, 0.25);
    }

    /* CTA Section */
    .cta-section {
        background: linear-gradient(135deg, var(--accent-color), var(--primary-color));
        color: white;
        padding: 5rem 0;
        text-align: center;
    }

    .cta-section h2 {
        font-size: 2.5rem;
        margin-bottom: 1rem;
    }

    .cta-section p {
        font-size: 1.2rem;
        margin-bottom: 2rem;
        opacity: 0.9;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .hero-section h1 {
            font-size: 2.5rem;
        }

        .section-title h2 {
            font-size: 2rem;
        }

        .navbar-nav .nav-link {
            margin: 0 0.5rem;
        }

        .navbar-nav .nav-link::after {
            display: none;
        }
    }
</style>