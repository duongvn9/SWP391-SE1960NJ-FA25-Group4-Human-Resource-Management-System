-- Script đơn giản để tạo testuser account
USE HRMSv2;

-- 1. Kiểm tra account hiện có
SELECT 'Current testuser status:' as step;

SELECT * FROM accounts WHERE username = 'testuser';

-- 2. Xóa testuser cũ nếu có (để tạo lại từ đầu)
DELETE FROM account_roles
WHERE
    account_id IN (
        SELECT id
        FROM accounts
        WHERE
            username = 'testuser'
    );

DELETE FROM accounts WHERE username = 'testuser';

DELETE FROM users WHERE email = 'testuser@example.com';

-- 3. Tạo user mới
INSERT INTO
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

-- 4. Lấy user_id vừa tạo
SET @user_id = LAST_INSERT_ID();

-- 5. Tạo account với password hash đúng
INSERT INTO
    accounts (
        user_id,
        username,
        password_hash,
        is_active,
        created_at
    )
VALUES (
        @user_id,
        'testuser',
        '$2a$12$Bb/HmggjW/F/36sQN2vb4.4b8dKQJruEsoBDozdmYuvcRy683MRU6',
        TRUE,
        NOW()
    );

-- 6. Lấy account_id vừa tạo
SET @account_id = LAST_INSERT_ID();

-- 7. Gán role EMPLOYEE (id = 4 từ seed data)
INSERT INTO
    account_roles (account_id, role_id)
VALUES (@account_id, 4);

-- 8. Verify kết quả
SELECT 'Final result:' as step;

SELECT
    a.id as account_id,
    a.username,
    LEFT(a.password_hash, 30) as password_hash_preview,
    a.is_active,
    u.id as user_id,
    u.full_name,
    u.email,
    r.name as role
FROM
    accounts a
    JOIN users u ON a.user_id = u.id
    JOIN account_roles ar ON a.id = ar.account_id
    JOIN roles r ON ar.role_id = r.id
WHERE
    a.username = 'testuser';

/*
Sau khi chạy script này thành công:

Test login với:
Username: testuser
Password: test123

Hash được sử dụng: $2a$12$Bb/HmggjW/F/36sQN2vb4.4b8dKQJruEsoBDozdmYuvcRy683MRU6
(đã verify với PasswordHashGenerator)
*/