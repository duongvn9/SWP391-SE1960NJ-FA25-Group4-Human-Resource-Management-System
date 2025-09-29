# 🏢 HRMS - Human Resource Management System

[![Java](https://img.shields.io/badge/Java-17-orange)](https://www.oracle.com/java/)
[![Jakarta EE](https://img.shields.io/badge/Jakarta%20EE-10-blue)](https://jakarta.ee/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-blue)](https://www.mysql.com/)
[![Maven](https://img.shields.io/badge/Maven-3.9-red)](https://maven.apache.org/)

Hệ thống quản lý nhân sự hiện đại được xây dựng bằng **Jakarta EE 10** với kiến trúc **Layered Architecture**.

## 📋 Tổng quan dự án

### 🎯 Mục tiêu

- Quản lý thông tin nhân viên toàn diện
- Theo dõi chấm công và lương thưởng
- Quản lý nghỉ phép và hợp đồng
- Dashboard báo cáo trực quan

### 👥 Đối tượng sử dụng

- **Admin**: Quản trị hệ thống
- **HR**: Quản lý nhân sự
- **Manager**: Quản lý phòng ban
- **Employee**: Nhân viên

## 🏗️ Kiến trúc hệ thống

### Layered Architecture

```
src/main/java/group4/hrms/
├── config/          # Cấu hình hệ thống
├── controller/      # Presentation Layer (Servlets)
│   └── auth/       # Authentication controllers
├── service/         # Business Logic Layer
│   └── auth/       # Authentication services
├── repository/      # Data Access Layer
│   └── auth/       # User repository
├── entity/          # Domain Models
├── dto/            # Data Transfer Objects
│   ├── request/    # Request DTOs
│   └── response/   # Response DTOs
├── mapper/         # Entity ↔ DTO mapping
├── exception/      # Custom Exceptions
├── filter/         # Servlet Filters
├── util/           # Utilities
└── constants/      # Application constants
```

### Frontend Structure

```
src/main/webapp/
├── assets/         # CSS, JS, Images
├── WEB-INF/
│   ├── views/     # JSP Pages
│   │   ├── auth/  # Login, Register
│   │   ├── dashboard/ # Main dashboard
│   │   └── layout/    # Header, Footer, Sidebar
│   ├── web.xml    # Servlet configuration
│   └── beans.xml  # CDI configuration
└── index.jsp      # Welcome page
```

## 🛠️ Công nghệ sử dụng

### Backend

- **Java 17** - Programming language
- **Jakarta EE 10** - Enterprise platform
- **Servlet 6.0** - Web layer framework
- **JSTL 3.0** - JSP Standard Tag Library
- **HikariCP 5.1** - Connection pooling
- **MySQL 8.0** - Database
- **BCrypt** - Password hashing
- **SLF4J + Logback** - Logging

### Frontend

- **JSP** - Server-side templating
- **Bootstrap 5.3** - CSS framework
- **Chart.js** - Data visualization
- **Font Awesome 6.0** - Icons
- **jQuery** - JavaScript library

### Build & Deploy

- **Maven 3.9** - Build automation
- **Tomcat 10.1+** - Application server
- **Git** - Version control

## 📦 Cài đặt và chạy dự án

### 1. Yêu cầu hệ thống

- JDK 17+
- Maven 3.9+
- MySQL 8.0+
- Tomcat 10.1+
- NetBeans/IntelliJ IDEA

### 2. Clone dự án

```bash
git clone https://github.com/duongvn9/SWP391-SE1960NJ-FA25-Group4-Human-Resource-Management-System.git
cd SWP391-SE1960NJ-FA25-Group4-Human-Resource-Management-System/HRMS
```

### 3. Cấu hình database

```sql
-- Tạo database
CREATE DATABASE hrms_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Tạo bảng users
CREATE TABLE users (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15),
    role ENUM('ADMIN', 'HR', 'MANAGER', 'EMPLOYEE') NOT NULL DEFAULT 'EMPLOYEE',
    status ENUM('ACTIVE', 'INACTIVE', 'LOCKED', 'PENDING') NOT NULL DEFAULT 'PENDING',
    last_login_at DATETIME NULL,
    reset_token VARCHAR(255) NULL,
    reset_token_expires_at DATETIME NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at DATETIME NULL,
    created_by BIGINT NULL,
    updated_by BIGINT NULL,
    INDEX idx_users_email (email),
    INDEX idx_users_status (status),
    INDEX idx_users_role (role)
);

-- Tạo admin user mặc định (password: admin123)
INSERT INTO users (email, password_hash, full_name, role, status) VALUES
('admin@hrms.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewfT1nP4VT5ZmTSm', 'Administrator', 'ADMIN', 'ACTIVE');
```

### 4. Cấu hình kết nối

Cập nhật file `src/main/resources/application.properties`:

```properties
# Database Configuration
db.url=jdbc:mysql://localhost:3306/hrms_db?useSSL=false&serverTimezone=Asia/Ho_Chi_Minh&characterEncoding=utf8mb4
db.username=root
db.password=your_password
db.driver=com.mysql.cj.jdbc.Driver
```

### 5. Build và deploy

```bash
# Build project
mvn clean compile package

# Deploy to Tomcat
cp target/HRMS-1.0-SNAPSHOT.war $TOMCAT_HOME/webapps/

# Hoặc run từ NetBeans
# Right-click project → Run
```

### 6. Truy cập ứng dụng

```
URL: http://localhost:8080/HRMS-1.0-SNAPSHOT/
Login: admin@hrms.com / admin123
```

## 🔧 Cấu hình phát triển

### Database Connection Pool

```java
// HikariCP Configuration
config.setMaximumPoolSize(20);
config.setMinimumIdle(5);
config.setConnectionTimeout(30000);
config.setIdleTimeout(600000);
config.setMaxLifetime(1800000);
```

### Security Configuration

- **Password Hashing**: BCrypt với 12 rounds
- **CSRF Protection**: Token per session
- **XSS Prevention**: Input sanitization
- **SQL Injection**: PreparedStatement only

### Logging Configuration

```xml
<!-- logback.xml -->
<configuration>
    <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>%d{HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>

    <logger name="group4.hrms" level="DEBUG"/>
    <root level="INFO">
        <appender-ref ref="STDOUT"/>
    </root>
</configuration>
```

## 📝 Quy tắc phát triển

### 1. Coding Conventions

- **Package**: lowercase, dot-separated
- **Class**: PascalCase với suffix theo layer
- **Method**: camelCase, verb-first
- **Constants**: SCREAMING_SNAKE_CASE

### 2. Git Workflow

```bash
# Feature branch
git checkout -b feature/user-management
git commit -m "feat: add user CRUD operations"
git push origin feature/user-management

# Pull request
# Code review
# Merge to main
```

### 3. Database Naming

- **Tables**: `snake_case` (VD: `employee_contracts`)
- **Columns**: `snake_case` (VD: `full_name`)
- **Foreign Keys**: `<table>_id` (VD: `user_id`)
- **Indexes**: `idx_<table>_<column>`

## 🧪 Testing

### Unit Tests

```java
@Test
void testUserAuthentication() {
    // Given
    LoginRequest request = new LoginRequest("admin@hrms.com", "admin123");

    // When
    LoginResponse response = authService.login(request);

    // Then
    assertTrue(response.isSuccess());
    assertNotNull(response.getUser());
}
```

### Integration Tests

```java
@Test
void testDatabaseConnection() {
    try (Connection conn = DatabaseConfig.getDataSource().getConnection()) {
        assertTrue(conn.isValid(5));
    }
}
```

## 📊 Database Schema

### Core Tables

- **users**: Thông tin user và authentication
- **employees**: Thông tin chi tiết nhân viên
- **departments**: Phòng ban
- **positions**: Chức vụ
- **attendance**: Chấm công
- **payroll**: Bảng lương
- **leave_requests**: Đơn xin nghỉ

### Audit Fields

Tất cả bảng đều có:

- `id`: BIGINT PRIMARY KEY AUTO_INCREMENT
- `created_at`: DATETIME DEFAULT CURRENT_TIMESTAMP
- `updated_at`: DATETIME ON UPDATE CURRENT_TIMESTAMP
- `deleted_at`: DATETIME NULL (soft delete)
- `created_by`: BIGINT NULL
- `updated_by`: BIGINT NULL

## 🚀 Deployment

### Production Checklist

- [ ] Environment variables configured
- [ ] Database connection secured
- [ ] SSL certificate installed
- [ ] Backup strategy implemented
- [ ] Monitoring setup
- [ ] Error tracking enabled

### Environment Variables

```bash
# Database
export DB_URL="jdbc:mysql://prod-db:3306/hrms_db"
export DB_USERNAME="hrms_user"
export DB_PASSWORD="secure_password"

# Application
export APP_ENV="production"
export LOG_LEVEL="WARN"
```

## 📚 API Documentation

### Authentication Endpoints

```
POST /auth/login
POST /auth/logout
GET  /auth/profile
```

### Employee Management

```
GET    /employees
POST   /employees
GET    /employees/{id}
PUT    /employees/{id}
DELETE /employees/{id}
```

## 🤝 Đóng góp

### Team Members

- **Dương Văn Ngọc** - Team Lead & Backend Developer
- **[Member 2]** - Frontend Developer
- **[Member 3]** - Database Designer
- **[Member 4]** - QA Tester

### Contributing Guidelines

1. Fork repository
2. Create feature branch
3. Write tests
4. Submit pull request
5. Code review
6. Merge to main

## 📄 License

Dự án được phát triển cho môn **SWP391** - **SE1960NJ** - **FA25** - **FPT University**.

---

## 🆘 Hỗ trợ

### Common Issues

1. **Database Connection Failed**

   - Kiểm tra MySQL service
   - Verify connection string
   - Check firewall settings

2. **Build Failed**

   - Clean Maven cache: `mvn clean`
   - Update dependencies: `mvn dependency:resolve`

3. **Deployment Issues**
   - Check Tomcat version (10.1+)
   - Verify Java version (17+)
   - Check port conflicts

### Contact

- **Email**: [team-email@fpt.edu.vn]
- **GitHub Issues**: [Repository Issues](https://github.com/duongvn9/SWP391-SE1960NJ-FA25-Group4-Human-Resource-Management-System/issues)

---

**© 2025 HRMS Team - FPT University**
