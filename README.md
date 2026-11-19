# Project Template: AI-Native SDLC Framework

Bộ template chuẩn mực dành cho Tech Lead, Kỹ sư phần mềm và AI Agent Harness. Thiết kế để tối ưu hóa toàn bộ vòng đời phát triển phần mềm (SDLC): **Phân tích -> Thiết kế -> Lập trình -> Kiểm thử -> Triển khai -> Bảo trì**, tương thích hoàn toàn với **Antigravity + Gemini** và sẵn sàng mở rộng sang **Claude**.

> 📖 **Bắt đầu nhanh**: Xem ngay [Cẩm Nang Hướng Dẫn Sử Dụng (HUONG-DAN-SU-DUNG.md)](HUONG-DAN-SU-DUNG.md) để nắm bắt quy trình khởi tạo Day 0 và luồng làm việc 6 bước.

---

## 1. Triết Lý Thiết Kế & Quy Chuẩn Cốt Lõi

1. **AI-Native Harness**: Có sẵn cấu trúc chỉ dẫn và ngữ cảnh để AI Agents tự động đọc hiểu và thực thi nhiệm vụ mà không bị ảo giác (hallucination).
2. **Không Quyết Định Thay Người Dùng**: Mọi thông số kiến trúc, ngôn ngữ, công nghệ, thiết kế màu sắc UI đều ở dạng template khảo sát. Người dùng điền thông tin hoặc phê duyệt trước khi AI sinh mã nguồn.
3. **Không Tự Ý Commit Hay Push Lên GitHub**: AI Agent tuyệt đối không tự ý commit hoặc push code. Agent chỉ cung cấp gợi ý câu lệnh Git, template commit và tên commit chuẩn (Conventional Commits) theo [docs/standards/git-workflow-and-commit.md](docs/standards/git-workflow-and-commit.md) để người dùng tự kiểm tra và thực thi.
4. **Quy Chuẩn Chú Thích Mã Nguồn (Code Comments)**: Toàn bộ chú thích trong file code phải viết bằng tiếng Việt, tuyệt đối không dùng dấu ngoặc đơn `()` và không dùng icon/emoji.
5. **Tiết Kiệm Token & Tối Ưu Tự Động Hóa**: Cấu trúc module hóa rõ ràng, tra cứu qua `.codegraph` và tài liệu markdown tinh gọn.

---

## 2. Cấu Trúc Kho Lưu Trữ

```text
├── .agents/                 # Quy chuẩn hành vi & hồ sơ custom agents Antigravity
│   ├── rules/               # Luật vận hành nội bộ của agent (always_on)
│   └── agents/              # Vai trò: architect, developer, qa-tester, devops, security-reviewer, ui-ux-designer
├── .codegraph/              # Cấu hình và hướng dẫn index CodeGraph
├── .github/                 # GitHub workflows & templates
│   ├── ISSUE_TEMPLATE/      # Phiếu giao việc từ Lead: Feature, Bug Fix, Technical Task, Spike
│   ├── workflows/           # CI/CD pipeline & Deployments (Preview/Production)
│   └── pull_request_template.md
├── docs/                    # Tài liệu kỹ thuật dự án theo từng giai đoạn
│   ├── product/             # Tầm nhìn, MVP scope, chỉ số KPI
│   ├── requirements/        # PRD, User Stories & Acceptance Criteria
│   ├── techs/               # Ma trận chọn công nghệ & Checklist quyết định
│   ├── architecture/        # Kiến trúc tổng thể, RBAC, Deployments & Demo links, NFR
│   ├── diagrams/            # Thư viện sơ đồ mẫu Mermaid (C4, ERD, Sequence)
│   ├── database/            # Thiết kế CSDL, Data Dictionary, Migration template
│   ├── api-spec/            # Đặc tả OpenAPI 3.1 & API conventions
│   ├── ui-ux/               # Design Tokens, User Journey & Chuẩn Impeccable UI/UX (DESIGN.md)
│   ├── task/                # Phân rã WBS, Task Contract, Sprint Backlog & Checklist
│   ├── standards/           # Quy chuẩn Clean Code, Security, QA Strategy, Git Commit
│   ├── ai-integration/      # Kiến trúc tích hợp LLM, Model Router, Fallback
│   ├── prompts/             # Danh mục prompt chuẩn cho từng vai trò
│   └── dev-logs/            # Nhật ký phát triển hàng ngày & ADR
├── scripts/                 # Kịch bản tự động hóa khởi tạo repo (PowerShell & Bash)
├── .editorconfig            # Quy chuẩn định dạng mã nguồn nhất quán cho mọi IDE
├── .env.example             # Mẫu biến môi trường
├── .gitleaks.toml           # Cấu hình quét bảo mật Gitleaks loại trừ file mẫu
├── .gitignore               # Universal gitignore đa ngôn ngữ
├── docker-compose.yml       # Khởi chạy hạ tầng dịch vụ cục bộ (PostgreSQL, Redis, Mailpit)
├── AGENTS.md                # Quy ước vận hành trung tâm cho AI Agent
├── HUONG-DAN-SU-DUNG.md     # Cẩm nang hướng dẫn sử dụng nhanh và quy trình 6 bước
├── LICENSE                  # Giấy phép MIT
└── README.md                # Cẩm nang tổng quan của template
```

---

## 3. Hướng Dẫn Khởi Tạo Dự Án Mới (Quickstart)

### Bước 1: Chạy Script Khởi Tạo Bằng GitHub CLI

Template cung cấp 2 script tự động hóa dùng `gh` CLI (không tự ý commit/push mà chỉ tạo repo và gợi ý lệnh commit):

- **Windows (PowerShell)**:
  ```powershell
  .\scripts\init-repo.ps1 -RepoName "my-awesome-app" -Visibility "private"
  ```
- **Linux / macOS (Bash)**:
  ```bash
  chmod +x ./scripts/init-repo.sh
  ./scripts/init-repo.sh -r "my-awesome-app" -v "private"
  ```

### Bước 2: Điền Quyết Định Công Nghệ

Mở và điền vào bảng khảo sát tại [docs/techs/decision-checklist.md](docs/techs/decision-checklist.md):

- Ngôn ngữ & Framework (Frontend / Backend)
- Hệ quản trị CSDL & Caching
- Bảng màu & Design System Tokens tại [docs/ui-ux/design-tokens-template.md](docs/ui-ux/design-tokens-template.md)

### Bước 3: Giao Tác Vụ Cho AI Agent

Kêu gọi AI Agent thực thi từng bước dựa theo [AGENTS.md](AGENTS.md) và các prompt mẫu tại [docs/prompts/system-prompts.md](docs/prompts/system-prompts.md).
