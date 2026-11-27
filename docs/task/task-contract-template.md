# Bản khế ước tác vụ

Trước khi triển khai tác vụ phức tạp, ghi mục tiêu, phạm vi và cách nghiệm thu để người thực hiện và người duyệt dùng chung.

---

## 1. Thông Tin Chung (General Information)

- **Mã tác vụ (Task ID)**: `TASK-001`
- **Tên tác vụ (Task Title)**: `[Tên ngắn gọn của tính năng hoặc bản sửa lỗi]`
- **Người phụ trách** `[Tên hoặc vai trò]`
- **Độ ưu tiên (Priority)**: `P0 (Khẩn cấp) / P1 (Quan trọng) / P2 (Bình thường)`
- **Thời điểm khởi tạo**: `YYYY-MM-DD`

---

## 2. Mục Tiêu Tác Vụ (Objective)

Mô tả rõ ràng, ngắn gọn kết quả cần đạt được sau khi hoàn thành tác vụ này trong 1 đến 3 câu:
- *Ví dụ: Hiện thực hóa API xác thực người dùng bao gồm đăng ký, đăng nhập và cấp phát JWT token.*

---

## 3. Ngữ Cảnh & Tài Liệu Tham Chiếu (Context & References)

Liệt kê tài liệu liên quan mà người thực hiện cần đọc trước khi bắt đầu.
- Yêu cầu nghiệp vụ: `docs/requirements/user-stories-template.md`
- Thiết kế kiến trúc: `docs/architecture/system-architecture.md`
- Thiết kế CSDL: `docs/database/database-design.md`
- Đặc tả API: `docs/api-spec/openapi-template.yaml`
- Tiêu chuẩn mã nguồn: `docs/standards/coding-standards.md`

---

## 4. Phạm Vi Cho Phép (In Scope)

Liệt kê các file và module được phép sửa. Thay các ví dụ dưới đây bằng phạm vi thực tế.
- `src/modules/auth/...`
- `tests/unit/auth/...`
- `docs/api-spec/openapi-template.yaml`

---

## 5. Phạm Vi Nghiêm Cấm Can Thiệp (Out of Scope)

Điền các giới hạn áp dụng cho tác vụ dựa trên những ví dụ dưới đây.
- Không chỉnh sửa cấu hình hạ tầng CI/CD tại `.github/workflows/`
- Không thay đổi cấu trúc bảng cơ sở dữ liệu đã chốt khi chưa có xác nhận
- Không tự ý thêm thư viện ngoài (dependencies) khi chưa được người dùng phê duyệt

---

## 6. Ràng Buộc Kỹ Thuật (Technical Constraints)

1. **Quy chuẩn Git**. Người phụ trách rà diff và bàn giao theo [quy trình Git](../standards/git-workflow-and-commit.md). Khi có trợ lý, người dùng thực hiện commit và push.
2. **Quy chuẩn chú thích**: Mọi ghi chú trong mã nguồn phải viết hoàn toàn bằng tiếng Việt, không dùng dấu ngoặc đơn `()` và không dùng icon trong chú thích.
3. **Quy chuẩn kiểu dữ liệu**: Bắt buộc định kiểu tĩnh nghiêm ngặt, không dùng kiểu `any` hoặc bỏ qua kiểm tra kiểu.
4. **Xử lý ngoại lệ**: Xử lý đầy đủ trường hợp biên, giá trị rỗng và lỗi kết nối mạng.

---

## 7. Tiêu Chí Nghiệm Thu (Acceptance Criteria)

- [ ] AC-01: `[Mô tả tiêu chí cụ thể 1]`
- [ ] AC-02: `[Mô tả tiêu chí cụ thể 2]`
- [ ] AC-03: `[Mô tả tiêu chí cụ thể 3]`
- [ ] AC-04: Tất cả bài kiểm thử mới và cũ đều vượt qua thành công

---

## 8. Lệnh Kiểm Chứng Thực Tế (Verification Commands)

Liệt kê các lệnh và thao tác phù hợp với stack và phạm vi. Chạy kiểm chứng trong môi trường đã thống nhất và ghi kết quả.
- Kiểm tra kiểu dữ liệu: `[npm run typecheck / tsc --noEmit / mypy / go vet]`
- Kiểm tra linter: `[npm run lint / ruff check . / golangci-lint run]`
- Chạy kiểm thử: `[npm test / pytest / go test ./...]`
- Build hoặc xác nhận thủ công: `[Lệnh hoặc các bước kiểm tra nếu áp dụng]`

---

## 9. Báo Cáo Nghiệm Thu Dựa Trên Bằng Chứng (Evidence-Based Completion Report)

Dùng bảng sau khi bàn giao. Điền kết quả thực tế và bằng chứng cho từng hạng mục.

| Hạng mục kiểm tra | Trạng thái (PASS / FAIL / NOT RUN) | Bằng chứng thực thi |
| :--- | :--- | :--- |
| Build, lint hoặc typecheck | `[Trạng thái]` | `[Lệnh và kết quả, hoặc lý do chưa chạy]` |
| Kiểm thử hoặc xác nhận thủ công | `[Trạng thái]` | `[Bộ kiểm thử, số ca hoặc các bước đã xác nhận]` |
| Rà soát bảo mật và tài liệu nếu áp dụng | `[Trạng thái]` | `[Phạm vi đã rà và kết quả]` |

> **Quy định bắt buộc**:
> - Dùng `NOT RUN` kèm lý do cho bước chưa chạy hoặc không áp dụng. Một kiểm tra bắt buộc theo tiêu chí nghiệm thu cần kết quả `PASS` trước khi hoàn thành tác vụ.
> - Ghi nhận rõ ràng danh sách vấn đề còn tồn đọng (nếu có) để người dùng nắm bắt trước khi merge.
