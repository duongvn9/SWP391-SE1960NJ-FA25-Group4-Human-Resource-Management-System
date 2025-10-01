-- Test script để kiểm tra tính năng login
-- Chạy script này để tạo thêm test accounts

USE HRMSv2;

-- Test với admin account (từ seed data)
-- Username: admin, Password: admin123 (đã hash)
SELECT
    a.id as account_id,
    a.username,
    a.is_active,
    u.id as user_id,
    u.full_name,
    u.email,
    GROUP_CONCAT(r.name SEPARATOR ', ') as roles
FROM
    accounts a
    JOIN users u ON a.user_id = u.id
    LEFT JOIN account_roles ar ON a.id = ar.account_id
    LEFT JOIN roles r ON ar.role_id = r.id
WHERE
    a.username = 'admin'
GROUP BY
    a.id,
    a.username,
    a.is_active,
    u.id,
    u.full_name,
    u.email;

-- Test với manager account
SELECT
    a.id as account_id,
    a.username,
    a.is_active,
    u.id as user_id,
    u.full_name,
    u.email,
    GROUP_CONCAT(r.name SEPARATOR ', ') as roles
FROM
    accounts a
    JOIN users u ON a.user_id = u.id
    LEFT JOIN account_roles ar ON a.id = ar.account_id
    LEFT JOIN roles r ON ar.role_id = r.id
WHERE
    a.username = 'vduong2709'
GROUP BY
    a.id,
    a.username,
    a.is_active,
    u.id,
    u.full_name,
    u.email;

-- Kiểm tra OAuth providers
SELECT * FROM oauth_providers;

-- Tạo thêm test account với password đơn giản cho testing
-- Password: test123 (BCrypt hash with cost 12)
INSERT IGNORE INTO
    users (
        full_name,
        email,
        phone,
        created_at
    )
VALUES (
        'Test User',
        'test@example.com',
        '+84123456789',
        NOW()
    );

SET
    @test_user_id = (
        SELECT id
        FROM users
        WHERE
            email = 'test@example.com'
    );

INSERT IGNORE INTO
    accounts (
        user_id,
        username,
        password_hash,
        is_active,
        created_at
    )
VALUES (
        @test_user_id,
        'testuser',
        '$2b$12$LNc4zNIcTIf8FGHNLzGwCON6UG1OV8GqgQCuVGKJGrVdQ8rVpAhSC',
        TRUE,
        NOW()
    );

SET
    @test_account_id = (
        SELECT id
        FROM accounts
        WHERE
            username = 'testuser'
    );

INSERT IGNORE INTO
    account_roles (account_id, role_id)
VALUES (@test_account_id, 4);
-- EMPLOYEE role

-- Hiển thị account vừa tạo
SELECT
    a.id as account_id,
    a.username,
    a.is_active,
    u.id as user_id,
    u.full_name,
    u.email,
    GROUP_CONCAT(r.name SEPARATOR ', ') as roles
FROM
    accounts a
    JOIN users u ON a.user_id = u.id
    LEFT JOIN account_roles ar ON a.id = ar.account_id
    LEFT JOIN roles r ON ar.role_id = r.id
WHERE
    a.username = 'testuser'
GROUP BY
    a.id,
    a.username,
    a.is_active,
    u.id,
    u.full_name,
    u.email;

-- Script để test password verification (chạy trong Java application)
/*
Test cases for login:

1. Admin Login:
Username: admin
Password: admin123
Expected: Success, role = ADMIN

2. Manager Login:
Username: vduong2709
Password: vduong123  
Expected: Success, role = MANAGER

3. Employee Login:
Username: testuser
Password: test123
Expected: Success, role = EMPLOYEE

4. Google OAuth Login:
- Truy cập: /login-google
- Sẽ redirect đến Google OAuth
- Sau khi authorize, sẽ tạo account mới hoặc link với account hiện có

5. Invalid Login:
Username: invalid
Password: wrong
Expected: Failed with error message
*/