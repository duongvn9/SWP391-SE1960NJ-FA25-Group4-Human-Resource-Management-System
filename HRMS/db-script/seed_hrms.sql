-- Seed file generated on 2025-09-29 18:25:09 UTC
-- Purpose: seed departments, roles, users (vduong as Manager IT, admin as system admin, 3 employees),
-- accounts with bcrypt hashes, and role mappings.
-- NOTE: Admin user has department_id = NULL (system-wide account).
-- NOTE: Employee users share password 'sa123' (bcrypt hashed).
-- NOTE: Using NOW() instead of UTC_TIMESTAMP() to store local server time (ensure time_zone = '+07:00').

SET FOREIGN_KEY_CHECKS = 0;

-- 1) Departments (manager_id NULL initially)
INSERT INTO
    departments (id, name, manager_id)
VALUES (
        1,
        'Phòng Công nghệ thông tin',
        NULL
    ),
    (2, 'Phòng kế toán', NULL),
    (3, 'Phòng nhân sự', NULL),
    (
        4,
        'Phòng Nghiên cứu và phát triển Sản phẩm',
        NULL
    ),
    (5, 'Phòng kinh doanh', NULL);

-- 2) Roles
INSERT INTO
    roles (id, code, name)
VALUES (
        1,
        'ADMIN',
        'Quản trị hệ thống'
    ),
    (2, 'HR', 'Quản lý nhân sự'),
    (3, 'MANAGER', 'Trưởng phòng'),
    (4, 'EMPLOYEE', 'Nhân viên'),
    (
        5,
        'HR_MANAGER',
        'Trưởng phòng nhân sự'
    );

-- 3) Users
INSERT INTO
    users (
        id,
        full_name,
        email,
        phone,
        department_id,
        position_id,
        start_date,
        created_at
    )
VALUES (
        1,
        'V Duong',
        'vduong2709@gmail.com',
        NULL,
        1,
        NULL,
        '2025-09-01',
        NOW()
    ),
    (
        2,
        'System Administrator',
        'admin@local',
        NULL,
        NULL,
        NULL,
        '2025-09-01',
        NOW()
    ),
    (
        3,
        'User A',
        'usera@example.com',
        NULL,
        2,
        NULL,
        '2025-09-01',
        NOW()
    ),
    (
        4,
        'User B',
        'userb@example.com',
        NULL,
        3,
        NULL,
        '2025-09-01',
        NOW()
    ),
    (
        5,
        'User C',
        'userc@example.com',
        NULL,
        5,
        NULL,
        '2025-09-01',
        NOW()
    );

-- 4) Update departments to set manager_id where appropriate
UPDATE departments SET manager_id = 1 WHERE id = 1;
-- Phòng CNTT manager -> user id 1

-- 5) Accounts (Updated với BCrypt hashes tương thích Java)
INSERT INTO
    accounts (
        id,
        user_id,
        username,
        password_hash,
        is_active,
        created_at
    )
VALUES (
        1,
        1,
        'vduong2709',
        '$2a$12$akHEgE7yZMtXj0Mqdz/Euu9iCfEoLdpFJIHo4b9d9VqYJzkhO1kJO',
        TRUE,
        NOW()
    ), -- vduong123
    (
        2,
        2,
        'admin',
        '$2a$12$Uq/ZQS9K9I/uQ7wQXfsr7O.NiBrYcp5vM.ElYMpgXt8OXHyYrkIrW',
        TRUE,
        NOW()
    ), -- admin123
    (
        3,
        3,
        'usera',
        '$2a$12$YF.zpzWxBzM5OWNIGcZDGejFO0BSsWzwFqDyXBN/l3/TzDKr7BwWC',
        TRUE,
        NOW()
    ), -- test123
    (
        4,
        4,
        'userb',
        '$2a$12$YF.zpzWxBzM5OWNIGcZDGejFO0BSsWzwFqDyXBN/l3/TzDKr7BwWC',
        TRUE,
        NOW()
    ), -- test123
    (
        5,
        5,
        'userc',
        '$2a$12$YF.zpzWxBzM5OWNIGcZDGejFO0BSsWzwFqDyXBN/l3/TzDKr7BwWC',
        TRUE,
        NOW()
    );
-- test123

-- 6) Account -> Role mapping
INSERT INTO
    account_roles (account_id, role_id)
VALUES (1, 3), -- vduong -> MANAGER
    (2, 1), -- admin -> ADMIN
    (3, 4), -- usera -> EMPLOYEE
    (4, 4), -- userb -> EMPLOYEE
    (5, 4);
-- userc -> EMPLOYEE

-- 7) OAuth Providers
INSERT INTO
    oauth_providers (id, code, name)
VALUES (1, 'google', 'Google'),
    (2, 'facebook', 'Facebook'),
    (3, 'github', 'GitHub');

SET FOREIGN_KEY_CHECKS = 1;

-- End of seed file.