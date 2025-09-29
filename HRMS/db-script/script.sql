-- =====================================================================
-- HRMS v2 (Reworked Minimal) - MySQL 8.0+
-- Implements user's adjustments (2025-09-25):
--  * users.start_date
--  * Roles attach to ACCOUNTS (account_roles), not users
--  * user (1) -> (n) requests; user (1) -> (n) accounts
--  * Remove overtime_entries (+ preview view) and attendance imports
--  * Headcount details added to recruitment_request & job_postings
--  * Policies dynamic by position (position_policies)
--  * Employment contracts: contract_url; Applications: offer_contract_url
--  * Keep ONLY payroll_items (add period_code, description); remove payroll_runs & bank_transfers
--  * Remove application_status_history
--  * Attendance simplified: keep timesheet_periods & attendance_logs only
--  * Leave policy: base 12 days/year, +1 day per 5 service years (function provided)
-- =====================================================================

SET NAMES utf8mb4;
SET time_zone = '+07:00';

-- ---------------------------------------------------------------------
-- 0) Force drop & recreate database
-- ---------------------------------------------------------------------
DROP DATABASE IF EXISTS `HRMSv2`;
CREATE DATABASE `HRMSv2` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `HRMSv2`;

-- =====================================================================
-- 1) MASTER DATA & ACCOUNTS
-- =====================================================================

-- departments
CREATE TABLE `departments` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(150) NOT NULL,
    `manager_id` BIGINT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- positions
CREATE TABLE `positions` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `code` VARCHAR(50) NOT NULL UNIQUE,
    `name` VARCHAR(150) NOT NULL,
    `level` VARCHAR(50) NULL,
    `created_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    `updated_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DELIMITER $$
CREATE TRIGGER `tr_positions_set_updated_at`
BEFORE UPDATE ON `positions`
FOR EACH ROW
BEGIN
    SET NEW.`updated_at` = UTC_TIMESTAMP(6);
END$$
DELIMITER ;

-- users (start_date added)
CREATE TABLE `users` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `full_name` VARCHAR(150) NOT NULL,
    `email` VARCHAR(255) NOT NULL UNIQUE,
    `phone` VARCHAR(50) NULL,
    `department_id` BIGINT NULL,
    `position_id` BIGINT NULL,
    `start_date` DATE NULL,
    `bank_account_no` VARCHAR(50) NULL,
    `bank_account_name` VARCHAR(150) NULL,
    `bank_code` VARCHAR(30) NULL,
    `created_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    PRIMARY KEY (`id`),
    KEY `idx_users_position` (`position_id`),
    CONSTRAINT `fk_users_dept` FOREIGN KEY (`department_id`) REFERENCES `departments`(`id`),
    CONSTRAINT `fk_users_position` FOREIGN KEY (`position_id`) REFERENCES `positions`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- link department.manager_id -> users.id AFTER users exists
ALTER TABLE `departments`
  ADD CONSTRAINT `fk_dept_manager` FOREIGN KEY (`manager_id`) REFERENCES `users`(`id`),
  ADD KEY `idx_departments_manager` (`manager_id`);

-- accounts (user can have many accounts)
CREATE TABLE `accounts` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT NOT NULL,
    `username` VARCHAR(100) NOT NULL UNIQUE,
    `password_hash` VARCHAR(200) NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
    `created_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_accounts_user` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- roles & account_roles (RBAC at account level)
CREATE TABLE `roles` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `code` VARCHAR(50) NOT NULL UNIQUE,
    `name` VARCHAR(150) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `account_roles` (
    `account_id` BIGINT NOT NULL,
    `role_id` BIGINT NOT NULL,
    PRIMARY KEY (`account_id`, `role_id`),
    CONSTRAINT `fk_ar_account` FOREIGN KEY (`account_id`) REFERENCES `accounts`(`id`),
    CONSTRAINT `fk_ar_role`    FOREIGN KEY (`role_id`)    REFERENCES `roles`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- features & role mapping
CREATE TABLE `features` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `code` VARCHAR(100) NOT NULL UNIQUE,
    `name` VARCHAR(200) NOT NULL,
    `enabled` BOOLEAN NOT NULL DEFAULT TRUE,
    `created_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `feature_roles` (
    `feature_id` BIGINT NOT NULL,
    `role_id` BIGINT NOT NULL,
    `can_view` BOOLEAN NOT NULL DEFAULT FALSE,
    `can_edit` BOOLEAN NOT NULL DEFAULT FALSE,
    `can_approve` BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (`feature_id`, `role_id`),
    CONSTRAINT `fk_fr_feature` FOREIGN KEY (`feature_id`) REFERENCES `features`(`id`),
    CONSTRAINT `fk_fr_role`    FOREIGN KEY (`role_id`)    REFERENCES `roles`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- OAuth (optional)
CREATE TABLE `oauth_providers` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `code` VARCHAR(50) NOT NULL UNIQUE,
    `name` VARCHAR(150) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `oauth_accounts` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `account_id` BIGINT NOT NULL,
    `provider_id` BIGINT NOT NULL,
    `provider_uid` VARCHAR(255) NOT NULL,
    `created_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    UNIQUE KEY `uq_provider_uid` (`provider_id`, `provider_uid`),
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_oauth_account`  FOREIGN KEY (`account_id`)  REFERENCES `accounts`(`id`),
    CONSTRAINT `fk_oauth_provider` FOREIGN KEY (`provider_id`) REFERENCES `oauth_providers`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- holidays
CREATE TABLE `holidays` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `holiday_date` DATE NOT NULL,
    `name` VARCHAR(150) NOT NULL,
    `is_public` BOOLEAN NOT NULL DEFAULT TRUE,
    `created_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    UNIQUE KEY `uq_holiday_date` (`holiday_date`),
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================================
-- 2) POSITION POLICIES (dynamic policy per position)
-- =====================================================================
CREATE TABLE `position_policies` (
    `position_id` BIGINT NOT NULL,
    `annual_leave_base_days` INT NOT NULL DEFAULT 12, -- base 12 days/year
    `extra_days_per_5y` INT NOT NULL DEFAULT 1,       -- +1 day per 5 service years
    PRIMARY KEY (`position_id`),
    CONSTRAINT `fk_pp_position` FOREIGN KEY (`position_id`) REFERENCES `positions`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================================
-- 3) CONTRACTS
-- =====================================================================

-- contract templates (text body still optional)
CREATE TABLE `contract_templates` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `code` VARCHAR(50) NOT NULL UNIQUE,
    `name` VARCHAR(150) NOT NULL,
    `content` LONGTEXT NULL,
    `version` INT NOT NULL DEFAULT 1,
    `status` VARCHAR(30) NOT NULL DEFAULT 'ACTIVE',
    `created_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    `updated_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DELIMITER $$
CREATE TRIGGER `tr_contract_templates_set_updated_at`
BEFORE UPDATE ON `contract_templates`
FOR EACH ROW
BEGIN
    SET NEW.`updated_at` = UTC_TIMESTAMP(6);
END$$
DELIMITER ;

-- employment contracts (add contract_url)
CREATE TABLE `employment_contracts` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT NOT NULL,
    `template_id` BIGINT NULL,
    `contract_no` VARCHAR(50) NULL,
    `base_salary` DECIMAL(14,2) NOT NULL,
    `currency` VARCHAR(10) NOT NULL DEFAULT 'VND',
    `effective_from` DATE NOT NULL,
    `effective_to` DATE NULL,
    `status` VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    `contract_url` VARCHAR(500) NULL, -- link to actual PDF contract
    `created_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    PRIMARY KEY (`id`),
    KEY `idx_contract_user` (`user_id`),
    CONSTRAINT `fk_contract_user`     FOREIGN KEY (`user_id`)     REFERENCES `users`(`id`),
    CONSTRAINT `fk_contract_template` FOREIGN KEY (`template_id`) REFERENCES `contract_templates`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Prevent overlapping periods for same user
DELIMITER $$
CREATE TRIGGER `tr_contract_no_overlap`
BEFORE INSERT ON `employment_contracts`
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 FROM `employment_contracts` e
        WHERE e.`user_id` = NEW.`user_id`
          AND (NEW.`effective_to` IS NULL OR e.`effective_from` <= NEW.`effective_to`)
          AND (e.`effective_to` IS NULL OR NEW.`effective_from` <= e.`effective_to`)
    ) THEN
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = "Employment contract dates overlap for this user.";
    END IF;
END$$
DELIMITER ;

-- attachments (generic)
CREATE TABLE `attachments` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `entity_type` VARCHAR(50) NOT NULL,
    `entity_id` BIGINT NOT NULL,
    `file_path` VARCHAR(255) NOT NULL,
    `uploaded_by_id` BIGINT NULL,
    `uploaded_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    PRIMARY KEY (`id`),
    KEY `idx_attach_entity` (`entity_type`, `entity_id`),
    CONSTRAINT `fk_attachments_uploader` FOREIGN KEY (`uploaded_by_id`) REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================================
-- 4) REQUESTS & TASKS
-- =====================================================================

-- request types
CREATE TABLE `request_types` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `code` VARCHAR(50) NOT NULL UNIQUE,
    `name` VARCHAR(150) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- requests (user m:1)
CREATE TABLE `requests` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `request_type_id` BIGINT NOT NULL,
    `user_id` BIGINT NOT NULL,
    `title` VARCHAR(200) NULL,
    `details` LONGTEXT NULL,
    `status` VARCHAR(30) NOT NULL DEFAULT 'PENDING',
    `created_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    PRIMARY KEY (`id`),
    KEY `idx_requests_status` (`status`),
    KEY `idx_requests_type_user` (`request_type_id`, `user_id`),
    CONSTRAINT `fk_requests_type` FOREIGN KEY (`request_type_id`) REFERENCES `request_types`(`id`),
    CONSTRAINT `fk_requests_user` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- request comments
CREATE TABLE `request_comments` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `request_id` BIGINT NOT NULL,
    `commenter_id` BIGINT NOT NULL,
    `content` VARCHAR(1000) NOT NULL,
    `created_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    PRIMARY KEY (`id`),
    KEY `idx_req_comments_req` (`request_id`),
    CONSTRAINT `fk_req_comments_req`  FOREIGN KEY (`request_id`)   REFERENCES `requests`(`id`),
    CONSTRAINT `fk_req_comments_user` FOREIGN KEY (`commenter_id`) REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- tasks
CREATE TABLE `tasks` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(200) NOT NULL,
    `description` LONGTEXT NULL,
    `priority` INT NOT NULL DEFAULT 3,
    `status` VARCHAR(20) NOT NULL DEFAULT 'TODO',
    `created_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    PRIMARY KEY (`id`),
    KEY `idx_tasks_priority` (`priority`),
    KEY `idx_tasks_status` (`status`),
    CONSTRAINT `ck_tasks_status` CHECK (`status` IN ('TODO','IN_PROGRESS','DONE','BLOCKED','CANCELED'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `task_comments` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `task_id` BIGINT NOT NULL,
    `commenter_id` BIGINT NOT NULL,
    `content` VARCHAR(1000) NOT NULL,
    `created_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    PRIMARY KEY (`id`),
    KEY `idx_task_comments_task` (`task_id`),
    CONSTRAINT `fk_task_comments_task` FOREIGN KEY (`task_id`) REFERENCES `tasks`(`id`),
    CONSTRAINT `fk_task_comments_user` FOREIGN KEY (`commenter_id`) REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `task_assignments` (
    `task_id` BIGINT NOT NULL,
    `user_id` BIGINT NOT NULL,
    `assigned_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    `deadline` DATETIME(6) NULL,
    PRIMARY KEY (`task_id`, `user_id`),
    KEY `idx_task_assign_deadline` (`deadline`),
    CONSTRAINT `fk_task_assign_task` FOREIGN KEY (`task_id`) REFERENCES `tasks`(`id`),
    CONSTRAINT `fk_task_assign_user` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================================
-- 5) RECRUITMENT (Application + headcount details)
-- =====================================================================

CREATE TABLE `applications` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT NULL,
    `full_name` VARCHAR(150) NULL,
    `email` VARCHAR(255) NULL,
    `phone` VARCHAR(50) NULL,
    `cv_path` VARCHAR(255) NULL,
    `status` VARCHAR(30) NOT NULL DEFAULT 'NEW',
    `created_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    `cccd_front_attachment_id` BIGINT NULL,
    `cccd_back_attachment_id` BIGINT NULL,
    `cccd_id_number` VARCHAR(30) NULL,
    `cccd_expiry_date` DATE NULL,
    `cccd_data_json` JSON NULL,
    `job_posting_id` BIGINT NULL,
    `offer_contract_url` VARCHAR(500) NULL, -- optional URL to offer/contract PDF for hiring
    PRIMARY KEY (`id`),
    KEY `idx_app_status` (`status`),
    KEY `ix_app_cccd_id_number` (`cccd_id_number`),
    CONSTRAINT `fk_app_user`  FOREIGN KEY (`user_id`)  REFERENCES `users`(`id`),
    CONSTRAINT `fk_app_cccd_front_attachment` FOREIGN KEY (`cccd_front_attachment_id`) REFERENCES `attachments`(`id`),
    CONSTRAINT `fk_app_cccd_back_attachment`  FOREIGN KEY (`cccd_back_attachment_id`)  REFERENCES `attachments`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `recruitment_requests` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `requester_id` BIGINT NOT NULL,
    `department_id` BIGINT NULL,
    `job_title` VARCHAR(150) NOT NULL,
    `headcount` INT NOT NULL,
    `headcount_detail` JSON NULL, -- extra breakdown per seniority/skill if needed
    `budget` DECIMAL(12,2) NULL,
    `description` LONGTEXT NULL,
    `status` VARCHAR(30) NOT NULL DEFAULT 'PENDING',
    `created_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    `updated_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    PRIMARY KEY (`id`),
    KEY `idx_recruit_req_status` (`status`),
    CONSTRAINT `fk_recruit_req_requester` FOREIGN KEY (`requester_id`) REFERENCES `users`(`id`),
    CONSTRAINT `fk_recruit_req_department` FOREIGN KEY (`department_id`) REFERENCES `departments`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DELIMITER $$
CREATE TRIGGER `tr_recruitment_requests_set_updated_at`
BEFORE UPDATE ON `recruitment_requests`
FOR EACH ROW
BEGIN
    SET NEW.`updated_at` = UTC_TIMESTAMP(6);
END$$
DELIMITER ;

CREATE TABLE `job_postings` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `request_id` BIGINT NULL,
    `title` VARCHAR(255) NOT NULL,
    `description` LONGTEXT NULL,
    `criteria` JSON NULL,
    `channel` VARCHAR(100) NULL,
    `status` VARCHAR(30) NOT NULL DEFAULT 'DRAFT',
    `published_at` DATETIME(6) NULL,
    `headcount` INT NULL, -- planned hiring quota for this posting
    `created_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    `updated_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    PRIMARY KEY (`id`),
    KEY `idx_job_post_status` (`status`),
    CONSTRAINT `fk_job_post_request` FOREIGN KEY (`request_id`) REFERENCES `recruitment_requests`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DELIMITER $$
CREATE TRIGGER `tr_job_postings_set_updated_at`
BEFORE UPDATE ON `job_postings`
FOR EACH ROW
BEGIN
    SET NEW.`updated_at` = UTC_TIMESTAMP(6);
END$$
DELIMITER ;

-- link applications -> job_postings
ALTER TABLE `applications`
  ADD CONSTRAINT `fk_app_job_posting` FOREIGN KEY (`job_posting_id`) REFERENCES `job_postings`(`id`);

-- interviews
CREATE TABLE `interview_schedules` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `application_id` BIGINT NOT NULL,
    `scheduled_start` DATETIME(6) NOT NULL,
    `scheduled_end` DATETIME(6) NOT NULL,
    `location` VARCHAR(255) NULL,
    `mode` VARCHAR(15) NOT NULL,
    `status` VARCHAR(30) NOT NULL DEFAULT 'SCHEDULED',
    `created_by_id` BIGINT NULL,
    `created_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    PRIMARY KEY (`id`),
    KEY `idx_interview_app` (`application_id`),
    CONSTRAINT `ck_interview_mode` CHECK (`mode` IN ('IN_PERSON','ONLINE')),
    CONSTRAINT `ck_interview_status` CHECK (`status` IN ('SCHEDULED','COMPLETED','CANCELED','RESCHEDULED')),
    CONSTRAINT `fk_interview_app`       FOREIGN KEY (`application_id`) REFERENCES `applications`(`id`),
    CONSTRAINT `fk_interview_created_by` FOREIGN KEY (`created_by_id`)  REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `interview_participants` (
    `interview_id` BIGINT NOT NULL,
    `user_id` BIGINT NOT NULL,
    `role` VARCHAR(50) NULL,
    PRIMARY KEY (`interview_id`, `user_id`),
    CONSTRAINT `fk_int_part_interview` FOREIGN KEY (`interview_id`) REFERENCES `interview_schedules`(`id`),
    CONSTRAINT `fk_int_part_user`      FOREIGN KEY (`user_id`)      REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `interview_feedback` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `interview_id` BIGINT NOT NULL,
    `reviewer_id` BIGINT NOT NULL,
    `rating` TINYINT NULL,
    `summary` VARCHAR(500) NULL,
    `notes` LONGTEXT NULL,
    `created_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    UNIQUE KEY `uq_feedback_reviewer` (`interview_id`, `reviewer_id`),
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_int_feedback_interview` FOREIGN KEY (`interview_id`) REFERENCES `interview_schedules`(`id`),
    CONSTRAINT `fk_int_feedback_reviewer`  FOREIGN KEY (`reviewer_id`)  REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- NOTE: application_status_history REMOVED as requested

-- =====================================================================
-- 6) ATTENDANCE (Simplified)
-- =====================================================================

CREATE TABLE `timesheet_periods` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `period_code` VARCHAR(20) NOT NULL UNIQUE, -- e.g., 2025-09
    `start_date` DATE NOT NULL,
    `end_date` DATE NOT NULL,
    `status` VARCHAR(20) NOT NULL DEFAULT 'OPEN',
    `locked_by_id` BIGINT NULL,
    `locked_at` DATETIME(6) NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `ck_timesheet_status` CHECK (`status` IN ('OPEN','LOCKED')),
    CONSTRAINT `fk_timesheet_locked_by` FOREIGN KEY (`locked_by_id`) REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `attendance_logs` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT NOT NULL,
    `check_type` VARCHAR(3) NOT NULL, -- IN/OUT
    `checked_at` DATETIME(6) NOT NULL,
    `source` VARCHAR(50) NULL,
    `note` VARCHAR(255) NULL,
    `period_id` BIGINT NULL, -- optional direct link if known
    `created_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    PRIMARY KEY (`id`),
    KEY `idx_attlog_user_time` (`user_id`, `checked_at`),
    CONSTRAINT `ck_attlog_type` CHECK (`check_type` IN ('IN','OUT')),
    CONSTRAINT `fk_attlog_user` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
    CONSTRAINT `fk_attlog_period` FOREIGN KEY (`period_id`) REFERENCES `timesheet_periods`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Import batches removed per simplification

-- =====================================================================
-- 7) LEAVE MANAGEMENT (base 12 days/y, +1 day per 5y)
-- =====================================================================

CREATE TABLE `leave_types` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `code` VARCHAR(30) NOT NULL UNIQUE,
    `name` VARCHAR(150) NOT NULL,
    `default_quota_days` DECIMAL(6,2) NOT NULL DEFAULT 12.00,
    `carry_forward_max_days` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
    `created_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `leave_balances` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT NOT NULL,
    `leave_type_id` BIGINT NOT NULL,
    `year` INT NOT NULL,
    `allocated_days` DECIMAL(6,2) NOT NULL DEFAULT 0,
    `used_days` DECIMAL(6,2) NOT NULL DEFAULT 0,
    `remaining_days` DECIMAL(6,2) NOT NULL DEFAULT 0,
    `updated_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    UNIQUE KEY `uq_leave_balance` (`user_id`, `leave_type_id`, `year`),
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_lb_user` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
    CONSTRAINT `fk_lb_type` FOREIGN KEY (`leave_type_id`) REFERENCES `leave_types`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DELIMITER $$
CREATE TRIGGER `tr_leave_balances_set_updated_at`
BEFORE UPDATE ON `leave_balances`
FOR EACH ROW
BEGIN
    SET NEW.`updated_at` = UTC_TIMESTAMP(6);
END$$
DELIMITER ;

CREATE TABLE `leave_ledger` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `balance_id` BIGINT NOT NULL,
    `request_id` BIGINT NULL,
    `change_days` DECIMAL(6,2) NOT NULL,
    `reason` VARCHAR(255) NULL,
    `created_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    PRIMARY KEY (`id`),
    KEY `idx_leave_ledger_balance` (`balance_id`),
    CONSTRAINT `ck_ll_whole_days` CHECK (`change_days` = ROUND(`change_days`, 0)),
    CONSTRAINT `fk_ll_balance` FOREIGN KEY (`balance_id`) REFERENCES `leave_balances`(`id`),
    CONSTRAINT `fk_ll_request` FOREIGN KEY (`request_id`) REFERENCES `requests`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Function: annual leave quota based on position policy & service years
DELIMITER $$
CREATE FUNCTION `fn_annual_leave_quota`(`p_user_id` BIGINT, `p_year` INT)
RETURNS DECIMAL(6,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_base INT DEFAULT 12;
    DECLARE v_extra INT DEFAULT 1;
    DECLARE v_pos BIGINT;
    DECLARE v_start DATE;
    DECLARE v_service_years INT DEFAULT 0;

    SELECT u.`position_id`, u.`start_date`
      INTO v_pos, v_start
      FROM `users` u WHERE u.`id` = p_user_id;

    IF v_pos IS NOT NULL THEN
        SELECT `annual_leave_base_days`, `extra_days_per_5y`
          INTO v_base, v_extra
          FROM `position_policies` pp
          WHERE pp.`position_id` = v_pos;
    END IF;

    IF v_start IS NOT NULL THEN
        -- service years as of Dec-31 of the given year
        SET v_service_years = TIMESTAMPDIFF(YEAR, v_start, STR_TO_DATE(CONCAT(p_year,'-12-31'), '%Y-%m-%d'));
    END IF;

    RETURN CAST(v_base + FLOOR(v_service_years / 5) * v_extra AS DECIMAL(6,2));
END$$
DELIMITER ;

-- =====================================================================
-- 8) PAYROLL (only payroll_items remaining)
-- =====================================================================

CREATE TABLE `payroll_items` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT NOT NULL,
    `period_code` VARCHAR(20) NOT NULL, -- e.g., 2025-09
    `amount` DECIMAL(14,2) NOT NULL,
    `status` VARCHAR(20) NOT NULL DEFAULT 'NEW',
    `description` VARCHAR(500) NULL, -- extra note for this item
    `created_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    PRIMARY KEY (`id`),
    KEY `idx_pi_user_period` (`user_id`, `period_code`),
    CONSTRAINT `fk_pi_user` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Removed: payroll_runs, bank_transfers, overtime_features and related functions/views

-- =====================================================================
-- 9) REPORTS, SYSTEM PARAMETERS, AI FEEDBACK
-- =====================================================================

CREATE TABLE `reports` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(255) NOT NULL,
    `description` VARCHAR(1000) NULL,
    `content` VARCHAR(1000) NULL,
    `type` VARCHAR(50) NULL,
    `created_by_id` BIGINT NULL,
    `created_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_reports_created_by` FOREIGN KEY (`created_by_id`) REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `system_parameters` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `feature_code` VARCHAR(100) NOT NULL UNIQUE,
    `status` VARCHAR(20) NOT NULL,
    `value` JSON NULL,
    `changed_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ai_feedback` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `rating` TINYINT NOT NULL,
    `satisfaction` VARCHAR(50) NULL,
    `comment` VARCHAR(1000) NULL,
    `created_at` DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)),
    PRIMARY KEY (`id`),
    CONSTRAINT `ck_ai_rating` CHECK (`rating` BETWEEN 1 AND 5)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================================
-- DONE
-- =====================================================================
SELECT '[OK] HRMSv2 (reworked) schema created per new requirements.' AS info;
