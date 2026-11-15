# Hướng Dẫn Thiết Kế Cơ Sở Dữ Liệu (Database Design Guide)

*Tài liệu quy chuẩn thiết kế lược đồ dữ liệu, chiến lược đánh chỉ mục và quy trình migration.*

---

## 1. Quy Chuẩn Đặt Tên Bảng & Cột (Naming Conventions)
- **Tên bảng**: Danh từ số nhiều, chữ thường dạng snake_case (vd: `users`, `orders`, `order_items`).
- **Khóa chính (Primary Key)**: Luôn đặt tên là `id` (khuyến nghị dùng `UUIDv7` hoặc `BIGINT / ULID` cho hệ thống phân tán).
- **Khóa ngoại (Foreign Key)**: Dạng `<tên_bảng_số_ít>_id` (vd: `user_id`, `order_id`).
- **Cột Audit Bắt Buộc (Audit Columns)**:
  - `created_at`: Thời điểm tạo bản ghi (TIMESTAMP WITH TIME ZONE, DEFAULT NOW()).
  - `updated_at`: Thời điểm cập nhật cuối cùng.
  - `deleted_at`: Hỗ trợ Soft Delete (NULL nếu chưa xóa).
  - `version`: Số nguyên dùng cho Optimistic Locking chống xung đột ghi đè.

---

## 2. Từ Điển Dữ Liệu Mẫu (Data Dictionary Template)

### Bảng: `users` (Quản lý tài khoản)
| Tên Cột | Kiểu Dữ Liệu | Ràng Buộc (Constraints) | Mô Tả Ý Nghĩa |
| :--- | :--- | :--- | :--- |
| `id` | UUID | PK, NOT NULL | Khóa chính duy nhất |
| `email` | VARCHAR(255) | UNIQUE, NOT NULL | Địa chỉ email đăng nhập |
| `password_hash`| VARCHAR(255) | NOT NULL | Mật khẩu băm (Argon2id/Bcrypt) |
| `full_name` | VARCHAR(128) | NULL | Họ và tên hiển thị |
| `role` | VARCHAR(32) | NOT NULL, DEFAULT 'user' | Phân quyền (admin, user, manager) |
| `status` | VARCHAR(32) | NOT NULL, DEFAULT 'active'| Trạng thái (active, suspended, pending) |
| `created_at` | TIMESTAMPTZ | NOT NULL, DEFAULT NOW() | Thời gian tạo |
| `updated_at` | TIMESTAMPTZ | NOT NULL, DEFAULT NOW() | Thời gian sửa đổi |
| `deleted_at` | TIMESTAMPTZ | NULL | Thời gian xóa mềm |

---

## 3. Chiến Lược Đánh Chỉ Mục (Indexing Strategy)
1. **Chỉ mục B-Tree chuẩn**:
   - Đánh trên tất cả các khóa ngoại (`user_id`, `category_id`).
   - Đánh trên các trường tìm kiếm thường xuyên (`email`, `slug`, `phone_number`).
2. **Chỉ mục kết hợp (Composite Indexes)**:
   - Đặt cột có tính lọc cao (high cardinality) lên trước, theo quy tắc Left-to-Right.
   - Ví dụ: `CREATE INDEX idx_orders_user_status ON orders (user_id, status);`
3. **Chỉ mục một phần (Partial Indexes)**:
   - Chỉ index các bản ghi chưa bị xóa: `WHERE deleted_at IS NULL`.

---

## 4. Chiến Lược Di Trú Dữ Liệu (Migration Guidelines)
- **Nguyên tắc không downtime (Zero-Downtime Migration)**:
  - Thêm cột mới: Cho phép `NULL` hoặc có giá trị `DEFAULT`.
  - Đổi tên cột: Không đổi trực tiếp mà thực hiện qua 3 bước (Thêm cột mới -> Đồng bộ dữ liệu -> Xóa cột cũ ở release sau).
  - Mọi migration script phải có hàm `Up` (thực thi) và hàm `Down` (rollback).
