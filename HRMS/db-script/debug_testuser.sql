-- Script debug để kiểm tra tài khoản testuser
USE HRMSv2;

-- 1. Kiểm tra account testuser có tồn tại không
SELECT 'Checking if testuser exists...' as debug_step;

SELECT a.id, a.username, a.password_hash, a.is_active, u.full_name, u.email
FROM accounts a
    LEFT JOIN users u ON a.user_id = u.id
WHERE
    a.username = 'testuser';

-- 2. Nếu không có, tạo từ đầu
SELECT 'Creating testuser if not exists...' as debug_step;

-- Tạo user record (chỉ với các cột tồn tại)
INSERT IGNORE INTO
    users (
        full_name,
        email,
        phone,
        created_at
    )
VALUES (
        'Test User',
        'testuser@example.com',
        '+84987654321',
        NOW()
    );

-- Lấy user_id
SET
    @test_user_id = (
        SELECT id
        FROM users
        WHERE
            email = 'testuser@example.com'
    );

-- Tạo account với password hash đúng (chỉ với các cột tồn tại)
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

-- Nếu đã có thì update password
UPDATE accounts
SET
    password_hash = '$2a$12$Bb/HmggjW/F/36sQN2vb4.4b8dKQJruEsoBDozdmYuvcRy683MRU6'
WHERE
    username = 'testuser';

-- Lấy account_id
SET
    @test_account_id = (
        SELECT id
        FROM accounts
        WHERE
            username = 'testuser'
    );

-- Đảm bảo có role EMPLOYEE
INSERT IGNORE INTO
    account_roles (account_id, role_id)
VALUES (@test_account_id, 4);
-- EMPLOYEE role (từ seed data)

-- 3. Kiểm tra kết quả cuối cùng
SELECT 'Final verification...' as debug_step;

SELECT
    a.id as account_id,
    a.username,
    a.password_hash,
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
    a.id;

-- 4. Kiểm tra tất cả accounts có sẵn
SELECT 'All available accounts...' as debug_step;

SELECT a.username, LEFT(a.password_hash, 20) as hash_preview, a.is_active, u.full_name
FROM accounts a
    JOIN users u ON a.user_id = u.id
ORDER BY a.id;

/*
SAU KHI CHẠY SCRIPT NÀY:

Test login với:
- Username: testuser
- Password: test123

Nếu vẫn không được, check:
1. Server có restart chưa?
2. Database connection có đúng không?
3. Application logs có error gì không?
*/