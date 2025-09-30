-- Script để update password hashes trong database hiện tại
-- Chạy script này nếu đã có data trong database và muốn update password

USE HRMSv2;

-- Update admin account với password: admin123 (hash mới từ PasswordHashGenerator)
UPDATE accounts
SET
    password_hash = '$2a$12$Vo0/G3CwvAdgNG/7p5l4XeMxegfXqtR8XXbV2rdqy6Ez7dNlCyJZm'
WHERE
    username = 'admin';

-- Update vduong2709 account với password: vduong123 (hash mới từ PasswordHashGenerator)
UPDATE accounts
SET
    password_hash = '$2a$12$wbOB2CGdY9Usd3tLjLYuT.MDt/VMtEU.HJ.2VCVAWUY7BSLSOG6vK'
WHERE
    username = 'vduong2709';

-- Update testuser account với password: test123 (hash mới từ PasswordHashGenerator)
UPDATE accounts
SET
    password_hash = '$2a$12$Bb/HmggjW/F/36sQN2vb4.4b8dKQJruEsoBDozdmYuvcRy683MRU6'
WHERE
    username = 'testuser';

-- Update test accounts với password: test123
UPDATE accounts
SET
    password_hash = '$2a$12$YF.zpzWxBzM5OWNIGcZDGejFO0BSsWzwFqDyXBN/l3/TzDKr7BwWC'
WHERE
    username IN ('usera', 'userb', 'userc');

-- Tạo OAuth provider cho Google
INSERT IGNORE INTO
    oauth_providers (code, name)
VALUES ('google', 'Google');

-- Hiển thị kết quả
SELECT
    a.id,
    a.username,
    LEFT(a.password_hash, 20) as password_hash_preview,
    a.is_active,
    u.full_name,
    u.email
FROM accounts a
    JOIN users u ON a.user_id = u.id
ORDER BY a.id;

-- Hiển thị OAuth providers
SELECT * FROM oauth_providers;

-- Kiểm tra roles
SELECT a.username, GROUP_CONCAT(r.name SEPARATOR ', ') as roles
FROM
    accounts a
    LEFT JOIN account_roles ar ON a.id = ar.account_id
    LEFT JOIN roles r ON ar.role_id = r.id
GROUP BY
    a.id,
    a.username
ORDER BY a.id;