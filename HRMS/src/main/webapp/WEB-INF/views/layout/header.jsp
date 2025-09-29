<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!-- Bootstrap 5.3 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <!-- Custom CSS -->
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
            }

            .sidebar.collapsed {
                width: 70px;
            }

            .sidebar-header {
                padding: 1.5rem;
                text-align: center;
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            }

            .sidebar-header h4 {
                margin: 0;
                font-weight: bold;
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
            }

            .main-content {
                margin-left: var(--sidebar-width);
                min-height: 100vh;
                transition: all 0.3s ease;
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
            }
        </style>