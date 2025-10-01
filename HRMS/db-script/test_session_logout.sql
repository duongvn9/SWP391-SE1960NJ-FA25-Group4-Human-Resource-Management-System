-- Script để test session và logout functionality
USE HRMSv2;

-- 1. Chạy update passwords từ script trước
-- Update admin account với password: admin123
UPDATE accounts
SET
    password_hash = '$2a$12$Uq/ZQS9K9I/uQ7wQXfsr7O.NiBrYcp5vM.ElYMpgXt8OXHyYrkIrW'
WHERE
    username = 'admin';

-- Update vduong2709 account với password: vduong123
UPDATE accounts
SET
    password_hash = '$2a$12$akHEgE7yZMtXj0Mqdz/Euu9iCfEoLdpFJIHo4b9d9VqYJzkhO1kJO'
WHERE
    username = 'vduong2709';

-- Tạo OAuth provider cho Google
INSERT IGNORE INTO
    oauth_providers (code, name)
VALUES ('google', 'Google');

-- Hiển thị kết quả để verify
SELECT
    a.id,
    a.username,
    LEFT(a.password_hash, 30) as password_hash_preview,
    a.is_active,
    u.full_name,
    u.email
FROM accounts a
    JOIN users u ON a.user_id = u.id
WHERE
    a.username IN ('admin', 'vduong2709')
ORDER BY a.id;

/*
Testing Steps:

1. SESSION & LOGOUT TEST:
- Login với admin/admin123
- Navigate đến dashboard
- Logout
- Press back button -> Should redirect to login page
- Try to access dashboard directly -> Should redirect to login

2. HOME PAGE TEST:
- Access homepage without login -> Should show "Đăng nhập ngay" button
- Login với admin/admin123  
- Navigate back to homepage -> Should show "Vào Dashboard" button and user dropdown

3. PASSWORD TOGGLE TEST:
- Go to login page
- Click eye icon in password field
- Password should toggle between hidden/visible

4. NAVIGATION TEST:
- Login as admin
- Check navigation shows user name and dropdown
- Dropdown should have Dashboard and Logout options

5. CSRF PROTECTION:
- Login should work with CSRF token
- Forms should include hidden _csrf_token field

Expected Results:
- ✅ Back button after logout should not allow access to protected pages
- ✅ Home page should adapt based on login status  
- ✅ Password field should have working toggle
- ✅ Navigation should show user info when logged in
- ✅ Logout should clear session completely
*/