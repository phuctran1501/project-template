# Mẫu Prompt Chuyển Giao Ngữ Cảnh Giữa Các Subagents (Agent Handoff Protocol)

Khi một Subagent hoàn tất nhiệm vụ và chuyển giao cho Subagent tiếp theo, hãy sử dụng các cấu trúc prompt sau để tránh đứt gãy ngữ cảnh.

---

## 1. Chuyển Giao: Architect -> Developer
```text
[CHUYỂN GIAO: ARCHITECT -> DEVELOPER]
- Tác vụ vừa hoàn thành: Đã thiết kế hoàn tất kiến trúc và schema CSDL cho Task [TASK-ID].
- Vị trí tài liệu:
  + CSDL: [docs/database/database-design.md](../database/database-design.md)
  + Đặc tả API: [docs/api-spec/openapi-template.yaml](../api-spec/openapi-template.yaml)
- Công việc của Developer: Hiện thực hóa mã nguồn tầng Controller, Service và Repository dựa trên spec đã duyệt. Không tự ý thay đổi tên trường hoặc kiểu dữ liệu trong schema.
```

---

## 2. Chuyển Giao: Developer -> QA Tester
```text
[CHUYỂN GIAO: DEVELOPER -> QA TESTER]
- Tác vụ vừa hoàn thành: Đã viết xong mã nguồn cho chức năng [TÊN CHỨC NĂNG] tại các file: [DANH SÁCH FILE].
- Tiêu chí nghiệm thu gốc: Tham chiếu User Story tại [docs/requirements/user-stories-template.md](../requirements/user-stories-template.md).
- Công việc của QA: Viết bộ Unit Test & Integration Test kiểm tra tính đúng đắn, bao phủ các trường hợp biên và đảm bảo test suite chạy pass 100%.
```

---

## 3. Chuyển Giao: Developer / QA -> Security Reviewer
```text
[CHUYỂN GIAO: DEVELOPER -> SECURITY REVIEWER]
- Tác vụ vừa hoàn thành: Toàn bộ code và test cho PR #[SỐ PR] đã sẵn sàng để kiểm tra độc lập.
- Danh sách file can thiệp: [LIỆT KÊ FILE].
- Công việc của Reviewer: Rà soát bảo mật theo [docs/standards/security-checklist.md](../standards/security-checklist.md) và xác nhận Definition of Done trước khi merge.
```

---

## 4. Chuyển Giao: Team -> DevOps
```text
[CHUYỂN GIAO: LEAD -> DEVOPS]
- Trạng thái hiện tại: Các module nghiệp vụ chính đã hoàn tất kiểm thử và review.
- Công việc của DevOps:
  + Cập nhật Dockerfile và docker-compose.yml.
  + Kiểm tra pipeline GitHub Actions tại .github/workflows/ci.yml.
  + Chuẩn bị kịch bản deployment staging/production.
```
