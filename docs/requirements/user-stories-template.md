# Danh Sách User Stories & Tiêu Chí Chấp Nhận (Acceptance Criteria)

Tài liệu này quản lý danh sách User Stories theo chuẩn **INVEST** (Independent, Negotiable, Valuable, Estimable, Small, Testable) và tiêu chí nghiệm thu theo cú pháp **Gherkin (Given - When - Then)**.

---

## 1. Mẫu User Story (Story Template)

### `US-001`: [Tiêu đề User Story - vd: Đăng nhập tài khoản bằng Email]
- **Là (As a)**: `[Người dùng đã đăng ký / Quản trị viên / Khách hàng]`
- **Tôi muốn (I want to)**: `[Đăng nhập vào hệ thống bằng Email và Mật khẩu]`
- **Để (So that)**: `[Tôi có thể truy cập trang quản lý đơn hàng của mình]`
- **Mức ưu tiên**: P0 | **Story Points ước tính**: 3

#### Tiêu chí chấp nhận (Acceptance Criteria - Gherkin):
```gherkin
Kịch bản 1: Đăng nhập thành công với thông tin hợp lệ
  Cho rằng: Người dùng đã có tài khoản hoạt động trong hệ thống
  Khi: Người dùng nhập đúng email "user@example.com" và mật khẩu chính xác
  Và: Bấm nút "Đăng nhập"
  Thì: Hệ thống trả về mã xác thực JWT token
  Và: Chuyển hướng người dùng tới trang Dashboard trong vòng dưới 1 giây

Kịch bản 2: Báo lỗi khi sai mật khẩu
  Cho rằng: Người dùng nhập đúng email nhưng sai mật khẩu
  Khi: Bấm nút "Đăng nhập"
  Thì: Hệ thống hiển thị thông báo "Email hoặc mật khẩu không chính xác"
  Và: Giữ nguyên địa chỉ email trong ô nhập liệu, xóa trường mật khẩu
  Và: Khóa tài khoản tạm thời 15 phút nếu thử sai liên tiếp quá 5 lần
```

---

### `US-002`: [Tiêu đề User Story tiếp theo]
- **Là**: `[...]`
- **Tôi muốn**: `[...]`
- **Để**: `[...]`
- **Mức ưu tiên**: `[P0 / P1 / P2]` | **Story Points**: `[...]`

#### Tiêu chí chấp nhận:
- [ ] AC 1: `...`
- [ ] AC 2: `...`
