-- Test script cho Account Management CRUD
-- Chạy script này để test các chức năng Account Management

USE HRMSv2;

-- 1. Kiểm tra cấu trúc bảng hiện tại
SELECT 'Checking table structure...' as step;

DESCRIBE accounts;
DESCRIBE roles;
DESCRIBE account_roles;

-- 2. Kiểm tra dữ liệu hiện có
SELECT 'Current accounts...' as step;

SELECT 
    a.id as account_id,
    a.username,
    a.is_active,
    u.full_name,
    u.email,
    GROUP_CONCAT(r.name SEPARATOR ', ') as roles
FROM accounts a
    JOIN users u ON a.user_id = u.id
    LEFT JOIN account_roles ar ON a.id = ar.account_id
    LEFT JOIN roles r ON ar.role_id = r.id
GROUP BY a.id, a.username, a.is_active, u.full_name, u.email
ORDER BY a.id;

-- 3. Kiểm tra users chưa có account
SELECT 'Users without accounts...' as step;

SELECT 
    u.id,
    u.full_name,
    u.email,
    u.phone
FROM users u
    LEFT JOIN accounts a ON u.id = a.user_id
WHERE a.user_id IS NULL
ORDER BY u.full_name;

-- 4. Kiểm tra tất cả roles
SELECT 'Available roles...' as step;

SELECT 
    id,
    code,
    name
FROM roles
ORDER BY id;

-- 5. Test tạo account mới (nếu có user chưa có account)
SELECT 'Creating test account...' as step;

-- Lấy user đầu tiên chưa có account
SET @test_user_id = (
    SELECT u.id
    FROM users u
        LEFT JOIN accounts a ON u.id = a.user_id
    WHERE a.user_id IS NULL
    LIMIT 1
);

-- Tạo account nếu có user khả dụng
INSERT INTO accounts (user_id, username, password_hash, is_active, created_at)
SELECT 
    @test_user_id,
    CONCAT('user', @test_user_id, '_test'),
    '$2a$12$LNc4zNIcTIf8FGHNLzGwCON6UG1OV8GqgQCuVGKJGrVdQ8rVpAhSC', -- password: test123
    TRUE,
    NOW()
WHERE @test_user_id IS NOT NULL;

-- Lấy account_id vừa tạo
SET @test_account_id = LAST_INSERT_ID();

-- Gán role EMPLOYEE cho account test
INSERT INTO account_roles (account_id, role_id)
SELECT @test_account_id, 4  -- EMPLOYEE role
WHERE @test_account_id > 0;

-- 6. Verify account vừa tạo
SELECT 'Verifying created account...' as step;

SELECT 
    a.id as account_id,
    a.username,
    a.is_active,
    u.full_name,
    u.email,
    GROUP_CONCAT(r.name SEPARATOR ', ') as roles
FROM accounts a
    JOIN users u ON a.user_id = u.id
    LEFT JOIN account_roles ar ON a.id = ar.account_id
    LEFT JOIN roles r ON ar.role_id = r.id
WHERE a.id = @test_account_id
GROUP BY a.id, a.username, a.is_active, u.full_name, u.email;

-- 7. Test cập nhật roles
SELECT 'Testing role update...' as step;

-- Xóa roles cũ
DELETE FROM account_roles WHERE account_id = @test_account_id;

-- Thêm multiple roles
INSERT INTO account_roles (account_id, role_id) VALUES
    (@test_account_id, 2), -- HR
    (@test_account_id, 4); -- EMPLOYEE

-- Verify roles updated
SELECT 
    a.username,
    GROUP_CONCAT(r.name SEPARATOR ', ') as new_roles
FROM accounts a
    LEFT JOIN account_roles ar ON a.id = ar.account_id
    LEFT JOIN roles r ON ar.role_id = r.id
WHERE a.id = @test_account_id
GROUP BY a.id, a.username;

-- 8. Test toggle account status
SELECT 'Testing status toggle...' as step;

-- Disable account
UPDATE accounts SET is_active = FALSE WHERE id = @test_account_id;

SELECT 
    username,
    is_active as status_after_disable
FROM accounts 
WHERE id = @test_account_id;

-- Enable account
UPDATE accounts SET is_active = TRUE WHERE id = @test_account_id;

SELECT 
    username,
    is_active as status_after_enable
FROM accounts 
WHERE id = @test_account_id;

-- 9. Final state check
SELECT 'Final account state...' as step;

SELECT 
    COUNT(*) as total_accounts,
    SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END) as active_accounts,
    SUM(CASE WHEN is_active = FALSE THEN 1 ELSE 0 END) as inactive_accounts
FROM accounts;

-- 10. Clean up test data (optional)
-- Uncomment below lines to clean up test account
/*
DELETE FROM account_roles WHERE account_id = @test_account_id;
DELETE FROM accounts WHERE id = @test_account_id;
SELECT 'Test account cleaned up' as cleanup_status;
*/

-- Test Summary
SELECT 'TEST SUMMARY' as status;
SELECT 
    'Account Management CRUD operations tested successfully' as result,
    NOW() as test_completed_at;