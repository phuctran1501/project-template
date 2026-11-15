# Quy Chuẩn Git Workflow & Mẫu Gợi Ý Commit (Git Commit Guidelines)

Tài liệu này quy định chuẩn mực quản lý mã nguồn Git dành cho nhóm phát triển và AI Agent Harness.

---

## 1. Nguyên Tắc Cốt Lõi Dành Cho AI Agent
- **AI Agent tuyệt đối không tự ý commit hoặc push lên GitHub**.
- Sau khi tạo hoặc sửa đổi mã nguồn, Agent chỉ đưa ra **gợi ý câu lệnh Git, template commit và tên commit** để người dùng tự xem xét và thực thi.

---

## 2. Quy Chuẩn Đặt Tên Commit (Conventional Commits)

Cấu trúc chuẩn:
```text
<loại_thay_đổi>[phạm_vi_nếu_có]: <mô tả ngắn bằng tiếng Việt hoặc tiếng Anh không dấu>

[Mô tả chi tiết nội dung thay đổi nếu cần thiết]

[Liên kết issue nếu có, ví dụ: Closes #123]
```

### Các loại thay đổi (Commit Types):
- `feat`: Tính năng mới cho người dùng.
- `fix`: Sửa lỗi kỹ thuật hoặc sự cố hệ thống.
- `docs`: Cập nhật tài liệu kỹ thuật hoặc hướng dẫn.
- `style`: Thay đổi định dạng mã nguồn như khoảng trắng, thụt đầu dòng, không ảnh hưởng logic.
- `refactor`: Tái cấu trúc mã nguồn, không thêm tính năng mới và không sửa lỗi.
- `perf`: Tối ưu hiệu năng và tốc độ xử lý.
- `test`: Bổ sung hoặc chỉnh sửa các bài kiểm thử tự động.
- `build`: Thay đổi hệ thống build hoặc các gói phụ thuộc bên ngoài.
- `ci`: Thay đổi cấu hình quy trình tích hợp liên tục như GitHub Actions.
- `chore`: Các công việc bảo trì định kỳ, cập nhật cấu hình repo.

---

## 3. Mẫu Gợi Ý Commit Của AI Agent (Commit Suggestion Template)

Khi Agent hoàn thành tác vụ, Agent phải xuất ra gợi ý định dạng như sau:

```text
Gợi ý lệnh Git cho bạn:

git add <danh sách file>
git commit -m "feat(auth): them endpoint dang nhap nguoi dung bang email va mat khau"
git push origin <ten-branch>
```

---

## 4. Quy Chuẩn Chú Thích Mã Nguồn (Code Comments)
Mọi đoạn chú thích trong mã nguồn phải tuân thủ nghiêm ngặt 3 điều kiện:
1. Viết hoàn toàn bằng tiếng Việt.
2. Tuyệt đối không sử dụng dấu ngoặc đơn. Thay vì viết `(vd: a, b)`, hãy viết `, ví dụ a, b,` hoặc `- ví dụ a, b -`.
3. Tuyệt đối không sử dụng icon hoặc biểu tượng cảm xúc.
