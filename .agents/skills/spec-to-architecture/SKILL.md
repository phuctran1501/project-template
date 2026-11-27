---
name: spec-to-architecture
description: >-
  Phân tích yêu cầu nghiệp vụ thành PRD, User Stories chuẩn Gherkin và thiết kế
  đồng bộ Kiến trúc hệ thống, Lược đồ CSDL, Đặc tả OpenAPI 3.1 kèm hồ sơ ADR. Sử
  dụng khi người dùng nêu ý tưởng sản phẩm hoặc tính năng mới, yêu cầu viết PRD,
  thiết kế kiến trúc, database schema hoặc hợp đồng API.
---

# Phân Tích Đặc Tả & Thiết Kế Kiến Trúc Đồng Bộ

Quy trình chuyển hóa ý tưởng sản phẩm hoặc yêu cầu nghiệp vụ thành bộ tài liệu đặc tả nhất quán trước khi lập trình.

## Khi Nào Sử Dụng

- Người dùng mô tả bài toán mới và yêu cầu phân tích nghiệp vụ, viết PRD hoặc User Stories.
- Người dùng yêu cầu thiết kế kiến trúc module, vẽ sơ đồ hệ thống, thiết kế bảng CSDL hoặc định nghĩa REST/GraphQL API.
- Cần ghi nhận quyết định kiến trúc quan trọng hoặc đánh đổi kỹ thuật vào ADR.

## Quy Trình Thực Hiện

### Bước 1: Kiểm tra tiền điều kiện & Quy mô tài liệu
1. Đọc [decision-checklist.md](../../../docs/techs/decision-checklist.md). Nếu người dùng yêu cầu thiết kế vật lý (SQL Schema, hệ thống hạ tầng) nhưng chưa chốt Tech Stack, kích hoạt skill `project-bootstrap` hoặc hỏi người dùng chốt công nghệ trước.
2. Nạp tài liệu theo đúng cấp độ quy mô dự án (không sinh tài liệu thừa cho dự án nhỏ Cấp 1).

### Bước 2: Phân tích Yêu cầu & Tiêu chí Nghiệm thu
1. Cập nhật mục tiêu cốt lõi, phạm vi MVP (`Must-have` so với `Out-of-scope`) vào [prd-template.md](../../../docs/requirements/prd-template.md) (và [01-vision-and-goals.md](../../../docs/product/01-vision-and-goals.md) nếu khởi tạo sản phẩm mới).
2. Phân rã thành các User Stories theo nguyên tắc INVEST kèm Acceptance Criteria chuẩn Gherkin (`Given - When - Then`) tại [user-stories-template.md](../../../docs/requirements/user-stories-template.md).
3. Nếu phát hiện quy tắc nghiệp vụ mâu thuẫn hoặc thiếu luồng ngoại lệ quan trọng, hỏi làm rõ ngay trước khi sang bước thiết kế.

### Bước 3: Thiết kế Kiến trúc, CSDL & Hợp đồng API
*(Có thể ủy quyền cho subagent `architect` qua `invoke_subagent` đối với hệ thống lớn)*

1. **Kiến trúc & Phân quyền**:
   - Xác định ranh giới module (High Cohesion, Loose Coupling) tại [system-architecture.md](../../../docs/architecture/system-architecture.md).
   - Cập nhật ma trận phân quyền tại [rbac-matrix.md](../../../docs/architecture/rbac-matrix.md) nếu hệ thống có nhiều vai trò người dùng.
   - Minh họa bằng sơ đồ Mermaid hợp lệ (C4, Sequence, State, ERD) tham chiếu [mermaid-templates.md](../../../docs/diagrams/mermaid-templates.md).
2. **Cơ sở dữ liệu**:
   - Thiết kế thực thể, chỉ mục (Index) và chiến lược migration tại [database-design.md](../../../docs/database/database-design.md).
   - Cập nhật DDL mẫu tại [schema-template.sql](../../../docs/database/schema-template.sql). Mọi chú thích trong file `.sql` phải viết bằng tiếng Việt, không dùng dấu ngoặc đơn `()` và không dùng icon.
3. **Đặc tả API**:
   - Định nghĩa request/response schema, mã trạng thái HTTP và chuẩn lỗi tại [openapi-template.yaml](../../../docs/api-spec/openapi-template.yaml) theo quy ước [api-conventions.md](../../../docs/api-spec/api-conventions.md).
4. **Hồ sơ Quyết định Kiến trúc (ADR)**:
   - Với mỗi lựa chọn kiến trúc có đánh đổi đáng kể, tạo file mới đánh số tăng dần (`0002-...md`) trong [docs/dev-logs/adr/](../../../docs/dev-logs/adr/) dựa trên [adr-template.md](../../../docs/dev-logs/adr/adr-template.md).

### Bước 4: Kiểm chứng tính đồng bộ
- Đối chiếu chéo tên thực thể, kiểu dữ liệu, phân quyền và mã lỗi giữa `User Stories` <-> `Database Schema` <-> `OpenAPI Spec` đảm bảo khớp nhau 100%.
