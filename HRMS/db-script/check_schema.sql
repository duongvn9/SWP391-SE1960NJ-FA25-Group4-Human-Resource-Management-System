-- Script kiểm tra schema của các bảng quan trọng
USE HRMSv2;

-- Kiểm tra cấu trúc bảng users
SELECT 'USERS table structure:' as info;

DESCRIBE users;

-- Kiểm tra cấu trúc bảng accounts
SELECT 'ACCOUNTS table structure:' as info;

DESCRIBE accounts;

-- Kiểm tra cấu trúc bảng roles
SELECT 'ROLES table structure:' as info;

DESCRIBE roles;

-- Kiểm tra dữ liệu roles có sẵn
SELECT 'Available roles:' as info;

SELECT * FROM roles;

-- Kiểm tra account hiện có
SELECT 'Existing accounts:' as info;

SELECT a.id, a.username, LEFT(a.password_hash, 20) as hash_preview, a.is_active, u.full_name, u.email
FROM accounts a
    LEFT JOIN users u ON a.user_id = u.id
ORDER BY a.id;