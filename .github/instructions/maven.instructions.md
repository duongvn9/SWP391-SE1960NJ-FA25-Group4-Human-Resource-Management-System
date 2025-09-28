# Hướng dẫn Maven/Build

## Đặt cấu hình mặc định
- Packaging: `war`
- Encoding: UTF-8
- Java: 17

## Phụ thuộc cốt lõi (Jakarta/ Tomcat 10+)
- `jakarta.servlet:jakarta.servlet-api` (scope `provided`)
- `jakarta.servlet.jsp.jstl:jakarta.servlet.jsp.jstl-api` + impl `org.glassfish.web:jakarta.servlet.jsp.jstl`
- `mysql:mysql-connector-j`
- `com.zaxxer:HikariCP`
- `org.mindrot:jbcrypt`
- `org.slf4j:slf4j-api` + `org.slf4j:slf4j-simple` (hoặc Logback)
