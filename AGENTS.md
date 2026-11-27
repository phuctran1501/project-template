# AGENTS.md

Quy ước của repo dành cho người thực hiện tác vụ và trợ lý AI. Đọc [quy trình chung](README.md#quy-trình-chung) và Task Contract hoặc Issue liên quan trước khi làm việc.

## Quy tắc bắt buộc

- Chỉ chốt kiến trúc, stack, CSDL và bản sắc UI khi đã có lựa chọn được người dùng duyệt. Khi cần quyết định mới, dùng [checklist công nghệ](docs/techs/decision-checklist.md) và [DESIGN.md](docs/ui-ux/DESIGN.md) nếu dự án có UI.
- Agent chỉ gợi ý commit theo [quy chuẩn Git](docs/standards/git-workflow-and-commit.md). Không chạy `git commit` hoặc `git push`.
- Chú thích mã nguồn viết hoàn toàn bằng tiếng Việt, không dùng dấu ngoặc đơn hay icon. Xem [quy chuẩn mã nguồn](docs/standards/coding-standards.md).
- Đọc file đích và các phụ thuộc liên quan trước khi sửa. Đối chiếu chữ ký hàm với định nghĩa thực tế và kiểm tra manifest trước khi dùng thư viện ngoài.
- Bám phạm vi và tiêu chí nghiệm thu. Với tác vụ phức tạp, lập Task Contract trước khi viết mã và phân công phần việc độc lập cho các vai trò phù hợp nếu nền tảng hỗ trợ.
- Chạy linter và kiểm thử phù hợp, xử lý lỗi do thay đổi gây ra và báo `PASS`, `FAIL` hoặc `NOT RUN` kèm bằng chứng. Căn cứ nhận định về hiệu năng và bảo mật vào phép đo, mã nguồn hoặc tài liệu chính thức. [Definition of Done](docs/standards/definition-of-done.md)
- Trả lời ngắn gọn bằng tiếng Việt và dùng liên kết Markdown khi tham chiếu file.

## Tra cứu và quy trình

- Nếu có index CodeGraph, dùng MCP `codegraph_explore` hoặc CLI `codegraph explore` trước khi tìm bằng `rg`. Khi chưa có index, thiếu công cụ hoặc tra cứu lỗi, tiếp tục bằng `rg` và đọc file. Người dùng quyết định việc lập index. [Hướng dẫn CodeGraph](.codegraph/README.md)
- Đọc [tầm nhìn sản phẩm](docs/product/) và [yêu cầu](docs/requirements/) liên quan. Cập nhật [kiến trúc](docs/architecture/), [CSDL](docs/database/), [API](docs/api-spec/) hoặc [UI/UX](docs/ui-ux/) theo phạm vi.
- Ghi công việc tại [docs/task/](docs/task/), kiểm thử theo tiêu chí nghiệm thu và ghi nhật ký hoặc ADR tại [docs/dev-logs/](docs/dev-logs/) khi phù hợp.
- Dùng [hướng dẫn kiểm chứng template](scripts/README.md#kiểm-chứng-template) khi sửa CI, deploy hoặc script của template. Dự án kế thừa dùng thêm CI theo stack đã duyệt.

## Quy trình Markdown và hồ sơ vai trò

Đọc trực tiếp quy trình phù hợp với tác vụ.

- [project-bootstrap](.agents/skills/project-bootstrap/SKILL.md) cho khởi tạo dự án và chốt công nghệ.
- [spec-to-architecture](.agents/skills/spec-to-architecture/SKILL.md) cho yêu cầu, kiến trúc, CSDL và API.
- [issue-driven-dev](.agents/skills/issue-driven-dev/SKILL.md) cho triển khai từ Issue hoặc Task Contract.
- [impeccable-ui-workflow](.agents/skills/impeccable-ui-workflow/SKILL.md) cho thiết kế và kiểm toán giao diện.
- [verify-dod-and-pr](.agents/skills/verify-dod-and-pr/SKILL.md) cho kiểm chứng và bàn giao.

Dùng [hồ sơ vai trò](.agents/agents/) khi cần phân công hoặc rà soát độc lập.
