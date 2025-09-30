# Account Management (Quản lý tài khoản)

## Tổng quan

Chức năng Account Management cho phép admin tạo, chỉnh sửa, xóa và gán quyền cho các tài khoản người dùng trong hệ thống HRMS.

## Chức năng chính

### 1. Danh sách tài khoản (`/admin/accounts`)
- Hiển thị tất cả accounts với thông tin chi tiết
- Bao gồm: ID, Username, Họ tên, Email, Roles, Trạng thái, Ngày tạo
- Các thao tác: Chỉnh sửa, Bật/tắt, Xóa

### 2. Tạo tài khoản mới (`/admin/accounts/create`)
- Chọn user từ danh sách những người chưa có account
- Đặt username và password
- Gán roles cho account
- Thiết lập trạng thái hoạt động

### 3. Chỉnh sửa tài khoản (`/admin/accounts/edit`)
- Cập nhật username
- Thay đổi password (tùy chọn)
- Cập nhật roles
- Bật/tắt trạng thái account

### 4. Xóa tài khoản (`/admin/accounts/delete`)
- Soft delete (đặt `is_active = false`)
- Xóa tất cả roles liên quan

### 5. Bật/tắt trạng thái (`/admin/accounts/toggle-status`)
- Toggle trạng thái `is_active`
- Ngăn chặn/cho phép đăng nhập

## Cấu trúc code

### Backend Components

#### 1. DTOs
- `CreateAccountRequestDTO` - Yêu cầu tạo account mới
- `UpdateAccountRequestDTO` - Yêu cầu cập nhật account
- `AccountResponseDTO` - Response chứa thông tin account đầy đủ

#### 2. Entities
- `Role` - Entity cho roles
- `Account` - Entity cho accounts (đã có sẵn)

#### 3. Repositories
- `RoleRepository` - CRUD operations cho roles
- `AccountRepository` - Đã mở rộng với các method cần thiết
- `UserRepository` - Đã thêm method `findAll()`

#### 4. Services
- `AccountManagementService` - Business logic cho account management

#### 5. Controllers
- `AccountManagementController` - Xử lý HTTP requests

#### 6. Filters
- `AdminAuthorizationFilter` - Kiểm tra quyền truy cập admin

### Frontend Components

#### 1. JSP Views
- `list.jsp` - Danh sách accounts
- `create.jsp` - Form tạo account mới
- `edit.jsp` - Form chỉnh sửa account
- `403.jsp` - Trang lỗi không có quyền

#### 2. Features
- Bootstrap 5.3 UI
- Form validation (client & server side)
- AJAX operations cho toggle status và delete
- Responsive design
- Password toggle visibility

## Database Schema

### Bảng liên quan:
```sql
-- accounts (đã có)
accounts (id, user_id, username, password_hash, is_active, created_at)

-- roles (đã có)
roles (id, code, name)

-- account_roles (đã có)
account_roles (account_id, role_id)

-- users (đã có)
users (id, full_name, email, phone, ...)
```

## Quyền truy cập

### Authorization
- Chỉ users có role `ADMIN` mới có thể truy cập
- Filter `AdminAuthorizationFilter` kiểm tra quyền tự động
- Redirect đến trang 403 nếu không có quyền

### URL Patterns được bảo vệ:
- `/admin/*` - Tất cả URLs admin

## Validation & Security

### Server-side Validation
- Username: 3-50 ký tự, chỉ chứa [a-zA-Z0-9._@-]
- Password: tối thiểu 6 ký tự
- Password confirmation must match
- Username uniqueness check

### Client-side Validation
- HTML5 form validation
- JavaScript password matching
- Bootstrap validation styles

### Security Features
- Password hashing với BCrypt
- CSRF protection (qua session)
- SQL injection prevention (PreparedStatement)
- XSS protection (c:out tags)

## Navigation & Access Points

Chức năng Account Management có thể được truy cập từ **3 điểm chính**:

### 1. 🏠 Dashboard - Quick Actions (Thao tác nhanh)
- URL: `/dashboard`
- Vị trí: Section "Thao tác quản trị nhanh" (chỉ hiển thị cho Admin)
- Card "Quản lý tài khoản" với icon 🛡️
- **Nổi bật nhất** - Admin có thể truy cập nhanh ngay từ trang chính

### 2. 📋 Sidebar Menu
- Vị trí: Menu sidebar bên trái
- Item "Quản lý tài khoản" với icon 🛡️
- Hiển thị trên tất cả các trang (chỉ Admin thấy)
- **Tiện lợi nhất** - Luôn có sẵn khi duyệt web

### 3. 🔗 Direct URL
- URL trực tiếp: `/admin/accounts`
- Có thể bookmark hoặc share link
- **Nhanh nhất** - Truy cập trực tiếp

## Cách sử dụng

### Để admin có thể truy cập:

#### Cách 1: Từ Dashboard (Khuyến nghị)
1. Đăng nhập với tài khoản admin
2. Vào Dashboard (`/dashboard`)
3. Tìm section "Thao tác quản trị nhanh"
4. Click vào card "Quản lý tài khoản"

#### Cách 2: Từ Sidebar Menu
1. Đăng nhập với tài khoản admin
2. Tìm menu "Quản lý tài khoản" trong sidebar (icon 🛡️)
3. Click để truy cập

#### Cách 3: URL trực tiếp
1. Đăng nhập với tài khoản admin
2. Truy cập: `http://localhost:8080/HRMS/admin/accounts`

### Tạo account mới:
1. Click "Tạo tài khoản mới"
2. Chọn user từ dropdown
3. Đặt username và password
4. Chọn roles phù hợp
5. Submit form

### Chỉnh sửa account:
1. Click nút "Chỉnh sửa" trong danh sách
2. Cập nhật thông tin cần thiết
3. Thay đổi password nếu cần
4. Cập nhật roles
5. Submit form

## Testing

### Manual Testing:
1. Chạy script `test_account_management.sql` để tạo test data
2. Đăng nhập với admin account
3. Test từng chức năng qua UI

### Unit Testing:
- Test các method trong `AccountManagementService`
- Test validation logic
- Test authorization filter

## Dependencies

### Maven Dependencies:
```xml
<!-- Đã có trong pom.xml -->
<dependency>
    <groupId>jakarta.servlet</groupId>
    <artifactId>jakarta.servlet-api</artifactId>
    <version>6.0.0</version>
</dependency>

<dependency>
    <groupId>org.mindrot</groupId>
    <artifactId>jbcrypt</artifactId>
    <version>0.4</version>
</dependency>
```

### Frontend Libraries:
- Bootstrap 5.3.0
- Bootstrap Icons 1.11.0

## Notes & Best Practices

### Code Standards:
- Tuân thủ Java naming conventions
- Sử dụng PreparedStatement cho tất cả SQL queries
- Validate input ở cả client và server side
- Log errors appropriately (không log passwords)

### Security Considerations:
- Không bao giờ log plain text passwords
- Hash passwords với BCrypt
- Validate và sanitize tất cả inputs
- Implement proper session management

### Performance:
- Sử dụng connection pooling
- Minimize database calls
- Proper index trên các cột search thường xuyên

## Troubleshooting

### Common Issues:

1. **404 Error khi truy cập /admin/accounts**
   - Kiểm tra `@WebServlet` annotation trong controller
   - Verify deployment và URL mapping

2. **403 Forbidden**
   - Kiểm tra user role trong session
   - Verify `AdminAuthorizationFilter` hoạt động

3. **Database Connection Error**
   - Kiểm tra `DatabaseUtil` configuration
   - Verify connection string và credentials

4. **Password Hashing Issues**
   - Ensure `PasswordUtil.hashPassword()` sử dụng BCrypt
   - Verify password validation logic

## Future Enhancements

### Có thể thêm:
1. **Audit Log** - Track tất cả changes của accounts
2. **Bulk Operations** - Tạo/cập nhật nhiều accounts cùng lúc
3. **Advanced Filtering** - Filter accounts theo role, status, etc.
4. **Export/Import** - Xuất danh sách accounts ra Excel
5. **Account Expiry** - Tự động disable accounts sau thời gian
6. **Two-Factor Authentication** - Bảo mật cao hơn
7. **Password Policy** - Enforce strong password rules
8. **Account Templates** - Pre-defined role combinations