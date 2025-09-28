# Hướng dẫn Maven/Build

## Đặt cấu hình mặc định

- Packaging: `war`
- Encoding: UTF-8
- Java: 11 (theo `HRMS/pom.xml` hiện tại)

## Phụ thuộc cốt lõi (Jakarta EE 10 / Tomcat 10.1+)

- `jakarta.platform:jakarta.jakartaee-api:10.0.0` (scope `provided`) hoặc tách riêng servlet/jsp tùy nhu cầu
- `jakarta.servlet.jsp.jstl:jakarta.servlet.jsp.jstl-api` + impl `org.glassfish.web:jakarta.servlet.jsp.jstl`
- `mysql:mysql-connector-j`
- `com.zaxxer:HikariCP`
- `org.mindrot:jbcrypt`
- `org.slf4j:slf4j-api` + binding (Logback khuyến nghị)
