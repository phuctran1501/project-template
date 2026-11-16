# Bản Khế Ước Tác Vụ Dành Cho AI Agent (Task Contract Template)

Tài liệu này là hợp đồng giao việc chuẩn mực giữa Người Dùng hoặc Tech Lead và AI Agent. Mọi tác vụ phức tạp trước khi lập trình phải được định nghĩa theo mẫu khế ước này để giới hạn phạm vi, tránh việc AI tự suy diễn hoặc can thiệp vượt thẩm quyền.

---

## 1. Thông Tin Chung (General Information)

- **Mã tác vụ (Task ID)**: `TASK-001`
- **Tên tác vụ (Task Title)**: `[Tên ngắn gọn của tính năng hoặc bản sửa lỗi]`
- **Subagent đảm nhiệm (Assigned Agent)**: `Developer / Architect / QA-Tester / DevOps / UI-UX-Designer`
- **Độ ưu tiên (Priority)**: `P0 (Khẩn cấp) / P1 (Quan trọng) / P2 (Bình thường)`
- **Thời điểm khởi tạo**: `YYYY-MM-DD`

---

## 2. Mục Tiêu Tác Vụ (Objective)

Mô tả rõ ràng, ngắn gọn kết quả cần đạt được sau khi hoàn thành tác vụ này trong 1 đến 3 câu:
- *Ví dụ: Hiện thực hóa API xác thực người dùng bao gồm đăng ký, đăng nhập và cấp phát JWT token.*

---

## 3. Ngữ Cảnh & Tài Liệu Tham Chiếu (Context & References)

Trước khi thực hiện, Agent bắt buộc phải đọc và tham chiếu các tài liệu sau:
- Yêu cầu nghiệp vụ: `docs/requirements/user-stories-template.md`
- Thiết kế kiến trúc: `docs/architecture/system-architecture.md`
- Thiết kế CSDL: `docs/database/database-design.md`
- Đặc tả API: `docs/api-spec/openapi-template.yaml`
- Tiêu chuẩn mã nguồn: `docs/standards/coding-standards.md`

---

## 4. Phạm Vi Cho Phép (In Scope)

Chỉ những file và module được liệt kê dưới đây mới được phép tạo mới hoặc chỉnh sửa:
- `src/modules/auth/...`
- `tests/unit/auth/...`
- `docs/api-spec/openapi-template.yaml`

---

## 5. Phạm Vi Nghiêm Cấm Can Thiệp (Out of Scope)

Agent TUYỆT ĐỐI KHÔNG được phép chỉnh sửa hoặc gây ảnh hưởng tới các thành phần sau:
- Không chỉnh sửa cấu hình hạ tầng CI/CD tại `.github/workflows/`
- Không thay đổi cấu trúc bảng cơ sở dữ liệu đã chốt khi chưa có xác nhận
- Không tự ý thêm thư viện ngoài (dependencies) khi chưa được người dùng phê duyệt

---

## 6. Ràng Buộc Kỹ Thuật (Technical Constraints)

1. **Quy chuẩn Git**: Tuyệt đối không tự ý chạy lệnh `git commit` hoặc `git push`. Chỉ cung cấp gợi ý câu lệnh Git và template commit.
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

Agent phải chạy thực tế các lệnh sau trong môi trường sandbox và ghi nhận kết quả:
- Kiểm tra kiểu dữ liệu: `[npm run typecheck / tsc --noEmit / mypy / go vet]`
- Kiểm tra linter: `[npm run lint / ruff check . / golangci-lint run]`
- Chạy kiểm thử: `[npm test / pytest / go test ./...]`

---

## 9. Báo Cáo Nghiệm Thu Dựa Trên Bằng Chứng (Evidence-Based Completion Report)

Mọi báo cáo bàn giao của Agent bắt buộc phải có bảng tổng kết sau:

| Hạng mục kiểm tra | Trạng thái (PASS / FAIL / NOT RUN) | Bằng chứng thực thi |
| :--- | :--- | :--- |
| Build mã nguồn | `PASS` | `Exit code 0, 0 errors` |
| Linter & Format | `PASS` | `0 warnings, 0 errors` |
| Unit Tests | `PASS` | `24 passed, 0 failed` |
| Integration Tests | `NOT RUN` | `Chưa có môi trường CSDL thử nghiệm` |
| Rà soát bảo mật | `PASS` | `Không phát hiện rò rỉ secret hoặc SQLi` |

> **Quy định bắt buộc**:
> - Nếu một bài test chưa được chạy, Agent PHẢI ghi rõ là `NOT RUN`, tuyệt đối không được tự ý ghi `PASS`.
> - Ghi nhận rõ ràng danh sách vấn đề còn tồn đọng (nếu có) để người dùng nắm bắt trước khi merge.
