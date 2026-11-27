---
name: project-bootstrap
description: >-
  Khởi tạo dự án mới Day 0 từ project-template, khảo sát người dùng để chốt cấp
  độ quy mô dự án, Tech Stack và bản sắc UI/UX, sau đó đồng bộ vào
  decision-checklist, DESIGN.md, CI/CD và CodeGraph. Sử dụng khi bắt đầu dự án
  mới, thiết lập công nghệ ban đầu, hoặc khi docs/techs/decision-checklist.md
  chưa được điền.
---

# Khởi Tạo Dự Án & Đồng Bộ Công Nghệ Day 0

Quy trình thiết lập nền tảng ban đầu cho dự án kế thừa từ `project-template`, đảm bảo AI không bao giờ tự ý áp đặt kiến trúc, ngôn ngữ hay bảng màu thay người dùng.

## Khi Nào Sử Dụng

- Người dùng vừa tạo repository mới từ template và yêu cầu bắt đầu dự án.
- Người dùng yêu cầu chọn hoặc thay đổi Tech Stack, cơ sở dữ liệu, hoặc định hướng giao diện.
- Một tác vụ thiết kế/lập trình được yêu cầu nhưng [decision-checklist.md](../../../docs/techs/decision-checklist.md) vẫn còn để trống.

## Quy Trình Thực Hiện

### Bước 1: Kiểm tra trạng thái cấu hình hiện có
1. Đọc [decision-checklist.md](../../../docs/techs/decision-checklist.md) và [DESIGN.md](../../../docs/ui-ux/DESIGN.md).
2. Nếu các lựa chọn đã được người dùng phê duyệt trước đó, giữ nguyên các mục đã chốt và chỉ hỏi những điểm chưa rõ hoặc cần thay đổi.

### Bước 2: Khảo sát quyết định của người dùng
Sử dụng công cụ `ask_question` (hoặc đặt câu hỏi trắc nghiệm ngắn gọn) để người dùng xác nhận:
1. **Cấp độ quy mô dự án (Tailoring Tier)**:
   - **Cấp 1 — Cá nhân / Hackathon (1–2 tuần)**: Chỉ dùng `decision-checklist.md`, `prd-template.md`, `task-contract-template.md`.
   - **Cấp 2 — Đồ án nhóm / MVP (1–3 tháng)**: Bổ sung `system-architecture.md`, `database-design.md`, `openapi-template.yaml`, `DESIGN.md`, GitHub Issues và DoD.
   - **Cấp 3 — Doanh nghiệp / Sản phẩm lớn**: Kích hoạt đầy đủ ADR, RBAC Matrix, NFR, QA Strategy và Security Checklist.
2. **Kiến trúc & Tech Stack**: Kiến trúc tổng thể (Modular Monolith / Microservices / Serverless), Backend, Frontend/Mobile, CSDL & Cache, nền tảng triển khai.
3. **Định hướng UI/UX** *(chỉ hỏi khi dự án có giao diện người dùng)*: Phong cách thương hiệu, cặp font chữ, tông màu chủ đạo Light/Dark Mode.

### Bước 3: Đồng bộ hóa tài liệu và hạ tầng
Sau khi người dùng xác nhận:
1. Ghi nhận đầy đủ lựa chọn, người phê duyệt và ngày phê duyệt vào [decision-checklist.md](../../../docs/techs/decision-checklist.md) (cập nhật thêm [tech-selection-matrix.md](../../../docs/techs/tech-selection-matrix.md) nếu dự án Cấp 2/3 cần giải trình lý do chọn công nghệ).
2. Nếu có Frontend, cập nhật thông số thương hiệu vào [DESIGN.md](../../../docs/ui-ux/DESIGN.md) và mã màu/typography vào [design-tokens-template.md](../../../docs/ui-ux/design-tokens-template.md).
3. Cập nhật [.github/workflows/ci.yml](../../../.github/workflows/ci.yml): Mở ghi chú khối ngôn ngữ tương ứng với stack đã chọn khi bắt đầu khởi tạo khung mã nguồn thực tế, đảm bảo chú thích trong YAML viết bằng tiếng Việt không có dấu ngoặc đơn `()` và không có icon.
4. Kiểm tra [docker-compose.yml](../../../docker-compose.yml), [.env.example](../../../.env.example) và [.codegraph/config.json](../../../.codegraph/config.json) để khớp các dịch vụ CSDL/Cache và đường dẫn thư mục mã nguồn dự kiến (`src/`, `apps/`, `packages/`...).

### Bước 4: Kiểm chứng bàn giao
- Đảm bảo không có bất kỳ lựa chọn công nghệ nào do AI tự điền khi chưa hỏi người dùng.
- Nhắc người dùng sao chép `.env.example` sang `.env` để điền biến bí mật cục bộ.
- Chuyển sang skill `spec-to-architecture` nếu cần viết PRD/kiến trúc, hoặc `issue-driven-dev` nếu bắt đầu chia task.
