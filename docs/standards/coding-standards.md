# Quy Chuẩn Viết Mã Nguồn (Engineering Coding Standards)

_Bộ quy tắc đảm bảo mã nguồn luôn duy trì ở tiêu chuẩn kỹ thuật cao nhất (Craftsmanship)._

---

## 1. Nguyên Tắc Thiết Kế Cốt Lõi

- **KISS (Keep It Simple, Stupid)**: Ưu tiên sự đơn giản, trực quan hơn là kỹ thuật phức tạp không cần thiết.
- **DRY (Don't Repeat Yourself)**: Đóng gói logic lặp lại vào hàm/utility, nhưng không trừu tượng hóa quá sớm (Rule of Three).
- **SOLID**:
  - `S` - Single Responsibility: Mỗi hàm, mỗi class chỉ làm duy nhất một việc.
  - `O` - Open/Closed: Mở rộng tính năng bằng kế thừa/composition, không sửa đổi code đang chạy ổn định.
  - `L` - Liskov Substitution: Lớp con có thể thay thế hoàn toàn lớp cha.
  - `I` - Interface Segregation: Chia nhỏ interface, không ép client phụ thuộc phương thức không dùng.
  - `D` - Dependency Inversion: Tầng cấp cao phụ thuộc vào trừu tượng (Interface), không phụ thuộc chi tiết tầng dưới.

---

## 2. Quy Ước Đặt Tên & Cấu Trúc Mã

- **Biến & Hàm**: `camelCase` (ví dụ: `getUserById`, `totalPrice`) mô tả chính xác hành động hoặc giá trị, không viết tắt vô nghĩa.
- **Class, Interface, Type**: `PascalCase` (ví dụ: `UserProfile`, `IOrderRepository`).
- **Hằng số (Constants)**: `UPPER_SNAKE_CASE` (ví dụ: `MAX_RETRY_COUNT`, `DEFAULT_PAGE_SIZE`).
- **Độ dài hàm**: Khuyến nghị dưới 30 dòng. Nếu vượt quá 50 dòng, bắt buộc phải tách hàm con.

---

## 3. Quy Chuẩn Chú Thích Mã Nguồn (Code Comments)

Mọi ghi chú hoặc chú thích bên trong file mã nguồn bắt buộc tuân thủ 3 điều kiện:

1. **Ngôn ngữ**: Viết hoàn toàn bằng tiếng Việt.
2. **Không dùng dấu ngoặc đơn**: Tuyệt đối không sử dụng ký tự `(` hoặc `)` trong dòng chú thích code. Dùng dấu phẩy hoặc dấu gạch ngang để ngăn cách ý.
3. **Không dùng icon**: Tuyệt đối không sử dụng biểu tượng cảm xúc hoặc icon trong chú thích code.

Ví dụ đúng:

```typescript
// Lấy thông tin người dùng theo mã định danh duy nhất từ cơ sở dữ liệu
const user = await userRepository.findById(userId);

// Kiểm tra trạng thái tài khoản, chỉ cho phép tài khoản đang hoạt động
if (!user.isActive) {
  throw new UnauthorizedException();
}
```

Ví dụ sai:

```typescript
// 🚀 Lấy thông tin user (theo id) từ database -> SAI vì có icon và dấu ngoặc đơn
```

---

## 4. Xử Lý Ngoại Lệ & Nhật Ký (Error Handling & Logging)

- **Không nuốt lỗi âm thầm (Never swallow errors)**: Tuyệt đối không dùng `catch (e) {}` trống rỗng.
- **Fail Fast**: Kiểm tra tiền điều kiện (Guard Clauses) ở đầu hàm; trả về sớm (Early Return) thay vì lồng nhiều tầng `if-else`.
- **Structured Logging**: Mọi log ghi ra phải ở dạng JSON hoặc định dạng có cấu trúc kèm thông tin ngữ cảnh (`timestamp`, `level`, `requestId`, `message`, `error.stack`). Không log mật khẩu hoặc token người dùng.

---

## 5. Quy Chuẩn Git Commit Của AI Agent

- AI Agent tuyệt đối không tự ý chạy lệnh commit hoặc push lên GitHub.
- AI Agent chỉ đưa ra gợi ý câu lệnh Git, tên commit và template commit chuẩn mực theo [git-workflow-and-commit.md](git-workflow-and-commit.md) để người dùng tự xem xét và quyết định.
