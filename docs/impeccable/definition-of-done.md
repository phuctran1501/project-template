# Tiêu Chuẩn Hoàn Thành (Definition of Done - DoD)

Một Task hoặc Pull Request chỉ được tính là **DONE** khi đáp ứng đầy đủ tất cả các điều kiện sau:

---

## 1. Về Mặt Mã Nguồn (Code Quality)
- [ ] Mã nguồn bám sát [docs/impeccable/coding-standards.md](file:///docs/impeccable/coding-standards.md).
- [ ] Đã chạy linter và formatter (vd: ESLint/Prettier, Ruff, Golangci-lint) không còn cảnh báo hoặc lỗi.
- [ ] Không có "Code Smells", không có hardcoded URLs, secret keys hoặc Magic Numbers.
- [ ] Kiểm tra tĩnh (Static Type Check) không có lỗi (`tsc --noEmit`, `mypy`, v.v.).

---

## 2. Về Mặt Kiểm Thử (Testing & Verification)
- [ ] Tất cả Unit Test và Integration Test hiện có đều vượt qua (100% Green).
- [ ] Đã bổ sung test cases mới cho tính năng/bugfix vừa hiện thực.
- [ ] Độ bao phủ mã nguồn (Code Coverage) đạt tối thiểu `80%` trên tầng Domain/Business Logic.
- [ ] Đã kiểm thử các kịch bản biên (Edge cases, Null/Empty values, Boundary numbers).

---

## 3. Về Mặt Bảo Mật & Hiệu Năng (Security & Performance)
- [ ] Đã rà soát theo [docs/impeccable/security-checklist.md](file:///docs/impeccable/security-checklist.md).
- [ ] Không có truy vấn CSDL gây nghẽn (N+1 query problem).
- [ ] Đã thêm đánh chỉ mục (Index) nếu bổ sung trường tìm kiếm hoặc foreign key mới.

---

## 4. Về Mặt Tài Liệu (Documentation)
- [ ] Cập nhật đặc tả API tại `docs/api-spec/openapi-template.yaml` nếu có endpoint mới hoặc đổi schema.
- [ ] Cập nhật tài liệu CSDL tại `docs/database/` nếu có migration.
- [ ] Ghi lại quyết định kiến trúc tại `docs/dev-logs/adr/` nếu có thay đổi kỹ thuật quan trọng.
- [ ] Ghi nhật ký công việc vào `docs/dev-logs/daily-log-template.md`.
