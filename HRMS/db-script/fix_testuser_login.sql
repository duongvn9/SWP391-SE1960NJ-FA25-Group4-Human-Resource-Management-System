-- Script khẩn cấp để fix login testuser
USE HRMSv2;

-- Update password cho testuser với hash đúng
UPDATE accounts
SET
    password_hash = '$2a$12$Bb/HmggjW/F/36sQN2vb4.4b8dKQJruEsoBDozdmYuvcRy683MRU6'
WHERE
    username = 'testuser';

-- Kiểm tra account testuser có tồn tại không
SELECT
    a.id as account_id,
    a.username,
    LEFT(a.password_hash, 30) as password_hash_preview,
    a.is_active,
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

-- Nếu không có testuser, tạo mới
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
        '$2a$12$Bb/HmggjW/F/36sQN2vb4.4b8dKQJruEsoBDozdmYuvcRy683MRU6',
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

-- Đảm bảo testuser có role EMPLOYEE
INSERT IGNORE INTO
    account_roles (account_id, role_id)
VALUES (@test_account_id, 4);
-- EMPLOYEE role

-- Kiểm tra lại kết quả
SELECT
    a.id as account_id,
    a.username,
    LEFT(a.password_hash, 30) as password_hash_preview,
    a.is_active,
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

/*
HƯỚNG DẪN SỬ DỤNG:

1. Chạy script này trong MySQL Workbench hoặc command line
2. Sau đó test login với:
- Username: testuser
- Password: test123

3. Nếu vẫn không được, kiểm tra:
- Database connection trong db.properties
- Servlet có hoạt động không
- Debug authentication service
*/