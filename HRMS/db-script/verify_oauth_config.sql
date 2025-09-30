-- Script để verify Google OAuth configuration đã được cập nhật
USE HRMSv2;

-- Kiểm tra OAuth providers trong database
SELECT 'Current OAuth providers:' as info;

SELECT * FROM oauth_providers;

-- Thêm Google provider nếu chưa có
INSERT IGNORE INTO
    oauth_providers (code, name)
VALUES ('google', 'Google');

-- Hiển thị lại
SELECT 'Updated OAuth providers:' as info;

SELECT * FROM oauth_providers;

/*
Configuration Summary (từ hrms.json mới):
==========================================

Client ID: 439265696099-q370f5g9a6mdksjeh1rsubpecill6eu5.apps.googleusercontent.com
Client Secret: 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
Redirect URI: http://localhost:9999/HRMS/login-google

Các file đã được cập nhật:
- GoogleLoginServlet.java ✅
- application.properties ✅
- hrms.json ✅ (đã có)

Testing:
1. Restart Tomcat server
2. Truy cập: http://localhost:9999/HRMS/auth/login
3. Click "Đăng nhập với Google"
4. Should redirect với Client ID mới
*/