# HRMS – Repository Custom Instructions

## Vai trò & Ngôn ngữ

- Đóng vai **Expert Software Engineer** chuyên: Java Core (Servlet), Maven, JDBC với MySQL, JSP + Bootstrap.
- **Luôn phản hồi, chú thích và sinh nội dung bằng tiếng Việt.**

## Tài liệu ràng buộc

- **TUÂN THỦ NGHIÊM NGẶT** tài liệu thiết kế chi tiết tại `docs/detailed-design.md`.
- Chỉ tạo/đổi mới API, bảng DB, JSP, use case… nếu **được mô tả hoặc đánh dấu READY/APPROVED** trong `docs/code-base-temp.md`. Nếu không thấy, **đừng suy đoán**.

## Ngăn xếp & Phiên bản

- JDK **17 LTS** (mặc định).
- Servlet API: **Jakarta Servlet 5** (Tomcat 10+). Nếu repo hiện đang dùng `javax.*`, **giữ nguyên nhất quán `javax`/Tomcat 9**.
- MySQL **8.x**, charset **utf8mb4**, **InnoDB**.
- Đóng gói **WAR** bằng Maven.

## Kiến trúc & Tổ chức mã

- Mô hình 3 lớp:
  - **Controller**: `…controller` (Servlet, chỉ điều phối).
  - **Service**: `…service` (nghiệp vụ, kiểm tra ràng buộc).
  - **DAO/Repository**: `…dao` (JDBC, PreparedStatement, mapping).
- **Model/Entity/DTO**: `…model` (POJO).
- **Filter**: `…filter` (auth, encoding, csrf).
- **Utils**: `…util` (DB, pagination, validators, hashing).
- **Views (JSP)**: `src/main/webapp/WEB-INF/views`.

## Quy ước code

- Tên package: `vn.fpt.hrms.*` (có thể đổi theo org).
- Không dùng scriptlet trong JSP. **Chỉ EL + JSTL**.
- Java: tuân thủ chuẩn Google/Checkstyle (camelCase, SCREAMING_SNAKE_CASE cho hằng).
- **Null-safety**: kiểm tra null input/DAO trả về rỗng; không ném NPE.
- **Log** bằng SLF4J; không log dữ liệu nhạy cảm (mật khẩu, token, CCCD).

## JDBC & Kết nối CSDL

- Dùng **PreparedStatement** 100% (chống SQL Injection).
- Ưu tiên **connection pool (HikariCP)**, cấu hình ở `src/main/resources/db.properties`.
- Giao dịch (transaction) ở Service cho các thao tác nhiều bước.
- Mapping ResultSet → DTO rõ ràng; **không** trả ResultSet ra ngoài DAO.

## JSP + Bootstrap

- Giao diện theo **Bootstrap 5.3+**, responsive.
- Tổ chức layout: `WEB-INF/views/layout/header.jsp`, `footer.jsp`, `sidebar.jsp`; trang con include từ layout.
- Form: có **CSRF token** (ẩn), **server-side validation** là bắt buộc; client-side chỉ hỗ trợ UX.

## Bảo mật

- **XSS**: dùng `<c:out>` hoặc escape đầu ra.
- **CSRF**: token per-session; kiểm tra ở Filter.
- **Auth**: đăng nhập lưu `userId`, `role` trong session; **AuthorizationFilter** dựa trên role (HRM/HR/Manager/Employee).
- **Password**: hash bằng **BCrypt**; **không bao giờ** lưu plain text.
- **Rate limiting** cho endpoint nhạy cảm (đăng nhập).

## Chuẩn DB

- Bảng snake_case; PK: `id BIGINT AUTO_INCREMENT`.
- Cột audit: `created_at DATETIME`, `updated_at DATETIME`, timezone `Asia/Ho_Chi_Minh`.
- Script schema ở `src/main/resources/db/schema.sql`, seed ở `seed.sql`.

## Test & Chất lượng

- Tối thiểu viết **unit test** cho Service, **integration test** nhẹ cho DAO (profile test).
- Bật **Checkstyle/SpotBugs**; build fail nếu vi phạm lỗi nghiêm trọng.

## I18N & UX

- Mặc định **vi-VN**; file message ở `WEB-INF/i18n`.
- Viết label, placeholder, thông báo lỗi **ngắn gọn, dễ hiểu**.

## Do / Don’t

- ✅ Sinh mã bám sát thiết kế, nhỏ gọn, dễ đọc, có log ở mức INFO/ERROR hợp lý.
- ✅ Ưu tiên cấu hình qua `.properties`.
- ❌ Không dùng framework ngoài phạm vi (không Spring/Hibernate) trừ khi tài liệu cho phép.
- ❌ Không hard-code chuỗi kết nối, mật khẩu; dùng biến môi trường hoặc `db.properties`.
