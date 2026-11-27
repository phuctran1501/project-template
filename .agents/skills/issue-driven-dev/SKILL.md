---
name: issue-driven-dev
description: >-
  Điều phối luồng giao việc và phát triển tính năng dựa trên GitHub Issues hoặc
  Task Contract: tách PRD thành Issues cho nhóm, hoặc đọc Issue hiện có qua
  GitHub CLI để khóa phạm vi, tra cứu CodeGraph và hiện thực mã nguồn kèm kiểm
  thử. Sử dụng khi tạo GitHub Issues giao việc, thực hiện một Issue cụ thể, hoặc
  lập trình tính năng và sửa lỗi theo Task Contract.
---

# Phát Triển Tính Năng Theo GitHub Issue & Task Contract

Quy trình biến yêu cầu thành phiếu giao việc chuẩn hóa và thực thi mã nguồn an toàn, chống mở rộng phạm vi ngoài ý muốn (Scope Creep) và chống ảo giác mã nguồn.

## Khi Nào Sử Dụng

- Trưởng nhóm yêu cầu tách PRD / Sprint Backlog thành các GitHub Issues để giao cho thành viên hoặc AI.
- Người dùng giao việc dạng *"Đọc Issue #12 và thực hiện"*, *"Giải quyết lỗi ở Issue #5"*.
- Triển khai tính năng mới, sửa lỗi hoặc refactor dựa trên [task-contract-template.md](../../../docs/task/task-contract-template.md).

## Quy Trình Thực Hiện

### Chế độ A: Trưởng Nhóm Tạo GitHub Issues Giao Việc
1. Đọc tài liệu yêu cầu tại [docs/requirements/](../../../docs/requirements/) và phân rã công việc tại [task-breakdown-wbs.md](../../../docs/task/task-breakdown-wbs.md).
2. Chọn đúng biểu mẫu tương ứng trong [.github/ISSUE_TEMPLATE/](../../../.github/ISSUE_TEMPLATE/):
   - Tính năng / User Story: `01_feature_request.yml`
   - Sửa lỗi phần mềm: `02_bug_report.yml`
   - Hạ tầng / Refactor / Tối ưu: `03_task_work.yml`
   - Nghiên cứu giải pháp / ADR: `04_architecture_decision.yml`
3. Liệt kê danh sách các thẻ Issue dự kiến (Tiêu đề, Vai trò nhận việc, Mức ưu tiên, Phạm vi, Tiêu chí nghiệm thu) để người dùng duyệt trước.
4. Khi người dùng đồng ý, dùng `gh issue create` để tạo thẻ trên GitHub (Fallback: nếu máy chưa đăng nhập `gh auth status`, xuất nội dung Markdown chuẩn theo form để người dùng dán nhanh).

### Chế độ B: Tiếp Nhận Issue / Task Contract & Hiện Thực Mã Nguồn

#### Bước 1: Nạp khế ước và khóa phạm vi (Just-In-Time Context)
1. Nếu có mã Issue `#N`, chạy `gh issue view <N>` để trích xuất Mục tiêu, `References`, `Scope & Boundaries`, `Acceptance Criteria` và `Verification Commands`. (Fallback: nếu `gh` không khả dụng, đọc [task-contract-template.md](../../../docs/task/task-contract-template.md) hoặc nhờ người dùng cung cấp nội dung Issue).
2. **Chỉ đọc các tài liệu được chỉ định trong `References`** — không nạp toàn bộ thư mục `docs/` gây lãng phí context token.
3. Xác lập danh sách file `In-Scope` được phép sửa và vùng cấm `Out-of-Scope`. Với tác vụ từ 3 bước trở lên, cập nhật tiến độ qua `update_steps`.

#### Bước 2: Tra cứu CodeGraph & Kiểm tra gói phụ thuộc
1. Nếu tồn tại `.codegraph/`, ưu tiên dùng công cụ MCP `codegraph_explore` hoặc chạy `codegraph explore "<tên_symbol hoặc luồng nghiệp vụ>"` trước khi grep/find để nắm chính xác chữ ký hàm và luồng gọi (Fallback: đọc trực tiếp file đích nếu dự án mới chưa có chỉ mục).
2. Trước khi import bất kỳ thư viện nào, bắt buộc kiểm tra file quản lý gói hiện hữu (`package.json`, `requirements.txt`, `pyproject.toml`, `go.mod`, `*.csproj`, `Cargo.toml`). Không tự ý cài thêm thư viện ngoài khi chưa được người dùng đồng ý.

#### Bước 3: Lập trình & Viết kiểm thử
*(Có thể thực hiện trực tiếp hoặc ủy quyền qua `invoke_subagent` cho `developer`, `devops`, `ui-ux-designer` và `qa-tester`)*
1. Hiện thực mã nguồn tuân thủ [coding-standards.md](../../../docs/standards/coding-standards.md):
   - Định kiểu tĩnh nghiêm ngặt, xử lý đầy đủ ngoại lệ và trường hợp biên.
   - Toàn bộ chú thích trong mã nguồn viết hoàn toàn bằng tiếng Việt, **tuyệt đối không dùng dấu ngoặc đơn `()`** và **không dùng icon/emoji**.
2. Viết hoặc cập nhật Unit / Integration Test bám sát từng mục `Acceptance Criteria` và chiến lược tại [qa-strategy-and-test-plan.md](../../../docs/standards/qa-strategy-and-test-plan.md). Đối với tác vụ sửa lỗi (`fix`), bắt buộc có bài kiểm thử hồi quy tái hiện lỗi đó.
3. Nếu tạo thêm module hoặc nhiều file mã nguồn mới và môi trường có sẵn CLI `codegraph`, chạy `codegraph index .` để đồng bộ lại chỉ mục.

#### Bước 4: Bàn giao sang cổng kiểm định DoD
- Không tự tuyên bố hoàn thành ngay sau khi viết xong code. Chuyển tiếp sang quy trình của skill [verify-dod-and-pr](../verify-dod-and-pr/SKILL.md) để chạy kiểm chứng thực tế.
