# Ma Trận Phân Quyền Chi Tiết (Role-Based Access Control - RBAC Matrix)

Tài liệu này xác định các vai trò người dùng trong hệ thống và ma trận quyền hạn tương ứng trên từng nhóm tài nguyên nghiệp vụ.

---

## 1. Định Nghĩa Các Vai Trò Trong Hệ Thống (System Roles)

| Mã Vai Trò | Tên Vai Trò | Cấp Độ (Level) | Mô Tả Trách Nhiệm |
| :--- | :--- | :--- | :--- |
| `ROLE_SUPER_ADMIN` | Quản Trị Viên Tối Cao | Level 1 (Cao nhất) | Toàn quyền kiểm soát cấu hình hệ thống, quản lý cơ sở dữ liệu và phân quyền |
| `ROLE_ADMIN` | Quản Trị Viên Vận Hành | Level 2 | Quản lý người dùng, duyệt nội dung và xem toàn bộ báo cáo doanh thu |
| `ROLE_MANAGER` | Quản Lý Nghiệp Vụ | Level 3 | Quản lý sản phẩm, đơn hàng và danh mục trong phạm vi chi nhánh được giao |
| `ROLE_USER` | Người Dùng Chuẩn | Level 4 | Người dùng thông thường đã đăng nhập, chỉ thao tác trên dữ liệu của chính mình |
| `ROLE_GUEST` | Khách Vãng Lai | Level 5 (Thấp nhất) | Khách chưa đăng nhập, chỉ xem các tài nguyên công khai |

---

## 2. Bảng Ma Trận Phân Quyền Tài Nguyên (Resource Permission Matrix)

*Ký hiệu quyền hạn*:
- `C` (Create): Tạo mới
- `R` (Read): Xem / Truy vấn
- `U` (Update): Sửa đổi
- `D` (Delete): Xóa
- `E` (Export): Xuất file Excel/CSV
- `-`: Không có quyền truy cập

| Nhóm Tài Nguyên | Super Admin | Admin | Manager | User (Thành Viên) | Guest (Khách) | Ghi Chú Ràng Buộc |
| :--- | :---: | :---: | :---: | :---: | :---: | :--- |
| **Tài khoản Người Dùng (Users)** | C, R, U, D, E | C, R, U, E | R | R*, U* | - | User chỉ xem và sửa hồ sơ cá nhân của chính mình (*) |
| **Phân Quyền & Vai Trò (Roles)** | C, R, U, D | R | - | - | - | Chỉ Super Admin được đổi quyền của Admin khác |
| **Mục Dữ Liệu / Sản Phẩm (Items)** | C, R, U, D, E | C, R, U, D, E | C, R, U, E | R, C, U*, D* | R | Khách chỉ xem hàng active, User chỉ sửa hàng của mình (*) |
| **Đơn Hàng (Orders)** | C, R, U, D, E | C, R, U, E | R, U | C, R*, U* | - | User chỉ xem đơn của mình (*), chỉ hủy đơn khi chưa duyệt |
| **Báo Cáo Doanh Thu (Reports)** | R, E | R, E | R | - | - | Phân quyền bảo mật tài chính |
| **Nhật Ký Hệ Thống (Audit Logs)** | R, E | R | - | - | - | Dữ liệu kiểm toán chỉ đọc, không được xóa |
| **Cấu Hình Hệ Thống (Settings)** | C, R, U, D | - | - | - | - | Biến môi trường, khóa API, cổng thanh toán |

---

## 3. Quy Tắc Kiểm Soát Cấp Độ Đối Tượng (Object-Level Ownership Rule)

Bên cạnh vai trò tổng quát (Role-level), hệ thống bắt buộc phải kiểm tra quyền sở hữu đối tượng (Ownership) ở tầng Middleware/Service:

```text
Nếu vai trò là ADMIN hoặc SUPER_ADMIN:
    Cho phép thực hiện hành động trên mọi bản ghi

Nếu vai trò là USER:
    Nếu hành động là CREATE:
        Tự động gán user_id của bản ghi mới bằng current_user.id
    Nếu hành động là READ / UPDATE / DELETE trên bản ghi cá nhân:
        Kiểm tra: resource.user_id == current_user.id
        Nếu KHÔNG khớp -> Trả về mã lỗi HTTP 403 Forbidden
```

---

## 4. Tích Hợp Kiểm Tra Quyền Vào Kiến Trúc Mã Nguồn

```typescript
// Mau khai bao Guard kiem tra quyen truy cap endpoint
@UseGuards(JwtAuthGuard, RolesGuard)
@Roles('ROLE_ADMIN', 'ROLE_SUPER_ADMIN')
@Delete('/api/v1/users/:id')
async deleteUserAccount(@Param('id') id: string) {
  // Logic xu ly xoa tai khoan nguoi dung
}
```
*(Ghi chú: Mọi chú thích bên trong mã nguồn kiểm tra quyền phải viết bằng tiếng Việt, không dùng dấu ngoặc đơn và không dùng biểu tượng cảm xúc).*
