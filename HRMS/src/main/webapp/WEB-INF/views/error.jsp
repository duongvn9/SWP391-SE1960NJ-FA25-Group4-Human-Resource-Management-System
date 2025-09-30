<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Lỗi hệ thống - HRMS</title>

    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .error-container {
            max-width: 600px;
            margin: 20px;
            padding: 0;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            background: white;
            overflow: hidden;
        }

        .error-header {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            padding: 30px;
            text-align: center;
            color: white;
        }

        .error-icon {
            font-size: 4rem;
            margin-bottom: 20px;
            color: rgba(255, 255, 255, 0.9);
        }

        .error-title {
            font-size: 2rem;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .error-body {
            padding: 40px;
            text-align: center;
        }

        .error-message {
            background: #f8d7da;
            border: 1px solid #f5c6cb;
            border-radius: 8px;
            padding: 20px;
            margin: 20px 0;
            color: #721c24;
        }

        .error-actions {
            margin-top: 30px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            padding: 12px 30px;
            border-radius: 25px;
            font-weight: 500;
            text-decoration: none;
            display: inline-block;
            margin: 5px;
            transition: transform 0.2s;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .btn-secondary {
            background: #6c757d;
            border: none;
            padding: 12px 30px;
            border-radius: 25px;
            font-weight: 500;
            text-decoration: none;
            display: inline-block;
            margin: 5px;
            transition: transform 0.2s;
            color: white;
        }

        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            color: white;
        }

        .help-text {
            margin-top: 20px;
            font-size: 0.9rem;
            color: #6c757d;
            line-height: 1.5;
        }
    </style>
</head>

<body>
    <div class="error-container">
        <div class="error-header">
            <div class="error-icon">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
            <h1 class="error-title">Lỗi hệ thống</h1>
            <p class="mb-0">Đã xảy ra lỗi không mong muốn</p>
        </div>

        <div class="error-body">
            <c:if test="${not empty requestScope.errorMessage}">
                <div class="error-message">
                    <i class="fas fa-info-circle me-2"></i>
                    <c:out value="${requestScope.errorMessage}" />
                </div>
            </c:if>

            <c:if test="${empty requestScope.errorMessage}">
                <div class="error-message">
                    <i class="fas fa-info-circle me-2"></i>
                    Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau hoặc liên hệ quản trị viên nếu vấn đề vẫn tiếp diễn.
                </div>
            </c:if>

            <div class="error-actions">
                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-primary">
                    <i class="fas fa-home me-2"></i>Về Dashboard
                </a>
                <button onclick="history.back()" class="btn btn-secondary">
                    <i class="fas fa-arrow-left me-2"></i>Quay lại
                </button>
            </div>

            <div class="help-text">
                <i class="fas fa-lightbulb me-1"></i>
                Nếu bạn thấy đây là lỗi, vui lòng liên hệ với quản trị viên hệ thống.
            </div>
        </div>
    </div>

    <!-- Bootstrap 5.3 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>