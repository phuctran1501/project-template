# Quy Chuẩn Git Workflow & Mẫu Gợi Ý Commit (Git Commit Guidelines)

Tài liệu này hướng dẫn người thực hiện rà thay đổi, tạo commit và mở pull request.

---

## 1. Quy trình bàn giao

1. Kiểm tra `git status --short` và `git diff`. Mở các file mới chưa được theo dõi để rà nội dung và phạm vi.
2. Chạy các bước kiểm chứng trong Task Contract hoặc Issue. Ghi lệnh, kết quả và lý do của bước chưa chạy theo [Definition of Done](definition-of-done.md).
3. Dùng `git add -- <tệp>` cho từng tệp thuộc phạm vi. Rà lại nội dung sẽ lên commit bằng `git diff --cached`.
4. Tạo commit theo quy ước bên dưới. Với nhánh làm việc mới, dùng `git push -u origin HEAD` để đẩy nhánh và thiết lập upstream.
5. Mở pull request trên GitHub. Chọn đúng nhánh đích và điền phạm vi, bằng chứng kiểm chứng và Issue liên quan theo [mẫu pull request](../../.github/pull_request_template.md).

Khi có trợ lý AI, trợ lý có thể gợi ý tên commit sau khi rà diff. Commit và push do người dùng thực hiện.

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

## 3. Ví dụ commit

```text
feat(auth): them endpoint dang nhap nguoi dung bang email va mat khau
```

---

## 4. Quy Chuẩn Chú Thích Mã Nguồn (Code Comments)
Mọi đoạn chú thích trong mã nguồn phải tuân thủ nghiêm ngặt 3 điều kiện:
1. Viết hoàn toàn bằng tiếng Việt.
2. Tuyệt đối không sử dụng dấu ngoặc đơn. Thay vì viết `(vd: a, b)`, hãy viết `, ví dụ a, b,` hoặc `- ví dụ a, b -`.
3. Tuyệt đối không sử dụng icon hoặc biểu tượng cảm xúc.
