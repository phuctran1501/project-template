# Tiêu Chuẩn Hoàn Thành (Definition of Done - DoD)

Một Task hoặc Pull Request đạt **DONE** khi đáp ứng các tiêu chí nghiệm thu và các mục DoD áp dụng cho thay đổi. Dùng Task Contract hoặc Issue để ghi rõ phạm vi kiểm chứng.

---

## 1. Về Mặt Mã Nguồn (Code Quality)
- [ ] Mã nguồn bám sát [coding-standards.md](coding-standards.md).
- [ ] Đã chạy linter và formatter (vd: ESLint/Prettier, Ruff, Golangci-lint) không còn cảnh báo hoặc lỗi.
- [ ] Không có "Code Smells", không có hardcoded URLs, secret keys hoặc Magic Numbers.
- [ ] Kiểm tra tĩnh (Static Type Check) không có lỗi (`tsc --noEmit`, `mypy`, v.v.).

---

## 2. Về Mặt Kiểm Thử (Testing & Verification)
- [ ] Tất cả Unit Test và Integration Test hiện có đều vượt qua (100% Green).
- [ ] Đã bổ sung test cases mới cho tính năng/bugfix vừa hiện thực.
- [ ] Khi thay đổi tầng Domain/Business Logic, độ bao phủ kiểm thử đạt tối thiểu `80%`.
- [ ] Đã kiểm thử các kịch bản biên (Edge cases, Null/Empty values, Boundary numbers).

---

## 3. Về Mặt Bảo Mật & Hiệu Năng (Security & Performance)
- [ ] Đã rà soát theo [security-checklist.md](security-checklist.md).
- [ ] Không có truy vấn CSDL gây nghẽn (N+1 query problem).
- [ ] Đã thêm đánh chỉ mục (Index) nếu bổ sung trường tìm kiếm hoặc foreign key mới.

---

## 4. Về Mặt Tài Liệu (Documentation)
- [ ] Cập nhật đặc tả API tại `docs/api-spec/openapi-template.yaml` nếu có endpoint mới hoặc đổi schema.
- [ ] Cập nhật tài liệu CSDL tại `docs/database/` nếu có migration.
- [ ] Ghi lại quyết định kiến trúc tại `docs/dev-logs/adr/` nếu có thay đổi kỹ thuật quan trọng.
- [ ] Khi cần lưu dấu công việc, tạo nhật ký tại `docs/dev-logs/` theo [mẫu nhật ký](../dev-logs/daily-log-template.md).

---

## 5. Về Mặt Bằng Chứng Nghiệm Thu (Evidence-Based Verification)
- [ ] Chạy build, lint, typecheck, test hoặc xác nhận thủ công theo các yêu cầu áp dụng.
- [ ] Ghi `PASS` hoặc `FAIL` kèm đầu ra thực tế và ghi `NOT RUN` kèm lý do cho bước chưa chạy hoặc không áp dụng.
- [ ] Mọi kiểm tra bắt buộc theo tiêu chí nghiệm thu có kết quả `PASS`. Ví dụ, khi đổi liên kết tài liệu, chạy kiểm tra liên kết. Nếu tác vụ chưa có mã ứng dụng để build, ghi lý do ở mục build.
