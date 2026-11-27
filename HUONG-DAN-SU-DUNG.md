# Hướng dẫn sử dụng project-template

Bắt đầu tại [quy trình chung trong README](README.md#quy-trình-chung). Tài liệu này giải thích cách chọn bộ tài liệu và thực hiện từng bước bằng trình soạn thảo, Git và các lệnh kiểm tra của dự án.

## Chọn mức tài liệu

| Quy mô | Tài liệu phù hợp |
| --- | --- |
| **Cá nhân hoặc hackathon** | [Checklist công nghệ](docs/techs/decision-checklist.md), [PRD](docs/requirements/prd-template.md) và [Task Contract](docs/task/task-contract-template.md). |
| **Đồ án nhóm hoặc MVP** | Bổ sung [kiến trúc](docs/architecture/system-architecture.md) và [User Stories](docs/requirements/user-stories-template.md). Dùng [thiết kế CSDL](docs/database/database-design.md), [OpenAPI](docs/api-spec/openapi-template.yaml) và [DESIGN.md](docs/ui-ux/DESIGN.md) khi có các phần tương ứng. Theo dõi việc bằng [GitHub Issues](.github/ISSUE_TEMPLATE/) hoặc Task Contract. |
| **Sản phẩm lớn** | Bổ sung [NFR](docs/architecture/non-functional-requirements.md), [ma trận phân quyền](docs/architecture/rbac-matrix.md), [ADR](docs/dev-logs/adr/adr-template.md), [kế hoạch QA](docs/standards/qa-strategy-and-test-plan.md), [checklist bảo mật](docs/standards/security-checklist.md) và [kế hoạch triển khai](docs/architecture/deployments-and-demo-links.md) theo phạm vi. |

## Khởi tạo dự án

Trên GitHub, chọn **Use this template** nếu nút này có sẵn, rồi clone repo mới về máy. Có thể clone repo mẫu và dùng script GitHub CLI để tạo và gắn repo mới. Chạy chế độ xem trước từ Git working tree trước khi xác nhận. [Hướng dẫn script](scripts/README.md#khởi-tạo-repository)

```powershell
.\scripts\init-repo.ps1 -RepoName "ten-du-an-moi" -DryRun
```

```bash
bash scripts/init-repo.sh -r "ten-du-an-moi" --dry-run
```

Ghi quyết định đã duyệt vào [checklist công nghệ](docs/techs/decision-checklist.md). Với giao diện, ghi đặc tả và bảng mã thiết kế trong [thư mục UI/UX](docs/ui-ux/). Dùng [.env.example](.env.example) làm mẫu cho biến môi trường cục bộ khi cần các dịch vụ tương ứng.

## Thực hiện tác vụ

1. **Phân tích.** Ghi mục tiêu và phạm vi MVP trong [PRD](docs/requirements/prd-template.md). Dùng [User Stories](docs/requirements/user-stories-template.md) khi cần mô tả tiêu chí chấp nhận theo Gherkin.
2. **Thiết kế.** Chọn các tài liệu phù hợp với thay đổi. Bổ sung [sơ đồ](docs/diagrams/mermaid-templates.md), [lược đồ CSDL](docs/database/schema-template.sql), [giao diện](docs/ui-ux/user-journey-and-wireframes.md) hoặc [quy ước API](docs/api-spec/api-conventions.md) khi có yêu cầu tương ứng. Với chức năng dùng mô hình, áp dụng [hướng dẫn tích hợp LLM vào sản phẩm](docs/ai-integration/llm-harness-guidelines.md).
3. **Lập kế hoạch.** Với hạng mục lớn, dùng [WBS](docs/task/task-breakdown-wbs.md) để chia tác vụ và [Sprint Backlog](docs/task/sprint-backlog-template.md) để theo dõi. Ghi phạm vi, tiêu chí và lệnh kiểm tra trong [mẫu Issue](.github/ISSUE_TEMPLATE/) hoặc [Task Contract](docs/task/task-contract-template.md).
4. **Triển khai.** Đọc file đích và các phần liên quan trước khi sửa. Tra cứu bằng `rg` và đọc mã nguồn, hoặc dùng [CodeGraph](.codegraph/README.md) khi có index. Viết mã và kiểm thử theo [quy chuẩn](docs/standards/coding-standards.md).
5. **Kiểm chứng.** Chạy các bước lint, typecheck, test và build đã được xác định trong tác vụ. Ghi `PASS` hoặc `FAIL` kèm đầu ra, và `NOT RUN` kèm lý do cho mỗi bước chưa chạy. [Definition of Done](docs/standards/definition-of-done.md)
6. **Bàn giao.** Rà diff, ghi thay đổi đáng chú ý trong [nhật ký](docs/dev-logs/daily-log-template.md), rồi thực hiện [quy trình Git](docs/standards/git-workflow-and-commit.md#1-quy-trình-bàn-giao) để mở PR. Nếu PR hoàn thành một Issue, ghi `Closes #N`. [Mẫu pull request](.github/pull_request_template.md)

[Template CI](.github/workflows/ci.yml) kiểm tra workflow, liên kết, hồi quy và bí mật. Bổ sung [CI ứng dụng](scripts/README.md#ci-cho-dự-án-kế-thừa) khi đã có mã và các lệnh phù hợp với stack. Dùng [hướng dẫn Deployments](docs/architecture/deployments-and-demo-links.md) khi đã có môi trường triển khai.

## Tài liệu dành cho trợ lý AI

[AGENTS.md](AGENTS.md) chứa quy ước chung. Các [quy trình Markdown](.agents/skills/) có thể được đọc trực tiếp theo loại tác vụ. Xem [hướng dẫn theo công cụ](README.md#trợ-lý-ai-tùy-chọn) khi cần nạp quy tắc, gọi skill hoặc phân công vai trò.
