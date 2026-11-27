# AGENTS.md - Quy ước vận hành AI Agent Harness

Tài liệu này là "Hiến pháp" vận hành dành cho AI Agents (Antigravity + Gemini, sẵn sàng mở rộng cho Claude Code/Anthropic) khi làm việc trên kho mã nguồn này.

---

## 1. Nguyên Tắc Cốt Lõi (Core Principles)

1. **Không Tự Tiện Quyết Định Thay Người Dùng**:
   - KHÔNG tự ý chốt kiến trúc (Monolith vs Microservices), ngôn ngữ lập trình, framework, hệ quản trị CSDL, bảng màu UI-UX... nếu tài liệu tại `docs/` chưa ghi nhận hoặc người dùng chưa xác nhận.
   - Khi khởi tạo dự án mới hoặc gặp điểm quyết định kỹ thuật: Kích hoạt khảo sát tại [docs/techs/decision-checklist.md](docs/techs/decision-checklist.md) để người dùng chọn trước, sau đó mới cập nhật vào hệ thống.

2. **Không Tự Ý Commit Hay Push Lên GitHub**:
   - AI Agent TUYỆT ĐỐI KHÔNG tự tiện chạy lệnh `git commit` hoặc `git push` lên GitHub.
   - Sau khi hoàn thành tác vụ mã nguồn, Agent CHỈ ĐƯỢC PHÉP gợi ý template commit và tên commit chuẩn (Conventional Commits) để người dùng tự kiểm tra, xác nhận và thực thi.
   - Tham khảo hướng dẫn và mẫu commit tại [docs/standards/git-workflow-and-commit.md](docs/standards/git-workflow-and-commit.md).

3. **Quy Chuẩn Chú Thích Trong Mã Nguồn (Code Comments)**:
   - Toàn bộ ghi chú, chú thích (comment) bên trong mã nguồn phải viết hoàn toàn bằng tiếng Việt.
   - TUYỆT ĐỐI KHÔNG sử dụng dấu ngoặc đơn `()` trong câu chú thích.
   - TUYỆT ĐỐI KHÔNG sử dụng biểu tượng cảm xúc hoặc icon trong câu chú thích.

4. **Quy Trình Chuẩn 6 Bước (SDLC Driven)**:
   - **Bước 1 - Phân tích (Analysis)**: Đọc & làm rõ yêu cầu tại [docs/product/](docs/product/) và [docs/requirements/](docs/requirements/).
   - **Bước 2 - Thiết kế (Design)**: Lập tài liệu kiến trúc tại [docs/architecture/](docs/architecture/), lược đồ CSDL tại [docs/database/](docs/database/), đặc tả API tại [docs/api-spec/](docs/api-spec/), và Design Tokens & Impeccable Design Spec tại [docs/ui-ux/](docs/ui-ux/).
   - **Bước 3 - Lập kế hoạch (Task Planning)**: Chia nhỏ task WBS và lập Task Contract tại [docs/task/](docs/task/) trước khi viết code.
   - **Bước 4 - Lập trình (Coding)**: Tuân thủ quy chuẩn [docs/standards/coding-standards.md](docs/standards/coding-standards.md). Tận dụng `.codegraph` để tra cứu ký hiệu trước khi grep/find.
   - **Bước 5 - Kiểm thử (Testing)**: Viết test (Unit, Integration, E2E) bám sát Acceptance Criteria; đạt chuẩn DoD tại [docs/standards/definition-of-done.md](docs/standards/definition-of-done.md).
   - **Bước 6 - Triển khai & Bảo trì (Deploy & Maintenance)**: Ghi chép nhật ký phát triển tại [docs/dev-logs/](docs/dev-logs/) và lưu vết quyết định qua ADR.

5. **Ngữ Cảnh & Tra Cứu (Context Retrieval First)**:
   - Nếu tồn tại thư mục `.codegraph/`: Dùng công cụ CodeGraph hoặc lệnh `codegraph explore` để hiểu cấu trúc symbol/call-path trước khi sửa đổi file.
   - Luôn đọc file đích trước khi gọi lệnh edit/write.

6. **Nghiệm Thu Dựa Trên Bằng Chứng Thực Tế (Evidence-Based Completion)**:
   - TUYỆT ĐỐI KHÔNG tự tuyên bố hoàn thành hoặc khẳng định kiểm thử thành công nếu chưa chạy lệnh kiểm chứng thực tế.
   - Báo cáo kết quả phải phân định rõ ràng các trạng thái: PASS (đã chạy và vượt qua), FAIL (đã chạy và thất bại), NOT RUN (chưa chạy). Tuyệt đối không ngầm hiểu bài test chưa chạy là PASS.
   - Mọi kết luận hoàn thành phải đính kèm bằng chứng thực thi bao gồm log đầu ra của lệnh build, linter, test hoặc mã lỗi cụ thể.

---

## 2. Bản Đồ Thư Mục Ngữ Cảnh (Context Map)

| Thư mục                | Mục đích sử dụng cho AI Agent                                                                                                                     |
| :--------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------ |
| `.agents/`             | Chứa luật cốt lõi (`rules/`), 6 vai trò Custom Agents (`agents/`) và 5 quy trình thực thi Skills (`skills/`). |
| `.codegraph/`          | Chỉ mục đồ thị mã nguồn hỗ trợ phân tích phụ thuộc chính xác.                                                                                     |
| `.github/`             | Quản lý quy chuẩn đóng góp mã (Issue Templates, PR Template, CI/CD Actions, Deployments).                                                         |
| `docs/product/`        | Tầm nhìn, MVP scope, chỉ số KPI/OKR của sản phẩm.                                                                                                 |
| `docs/requirements/`   | PRD, User Stories (INVEST + Gherkin format).                                                                                                      |
| `docs/techs/`          | Ma trận đánh giá công nghệ và bảng chốt tech stack do người dùng phê duyệt.                                                                       |
| `docs/architecture/`   | Kiến trúc hệ thống, phân rã module, ma trận phân quyền RBAC, Deployments & link demo phỏng vấn, NFR.                                              |
| `docs/diagrams/`       | Sơ đồ Mermaid (C4, ERD, Sequence, Flowchart).                                                                                                     |
| `docs/database/`       | Thiết kế schema, từ điển dữ liệu (Data Dictionary), chiến lược migration.                                                                         |
| `docs/api-spec/`       | Đặc tả OpenAPI 3.1 và quy chuẩn API REST/GraphQL.                                                                                                 |
| `docs/ui-ux/`          | Design Tokens, User Journey và Thiết kế UI/UX Impeccable (DESIGN.md, chống AI tells).                                                             |
| `docs/task/`           | Danh sách WBS, Task Contract, Sprint Backlog và Task Tracker.                                                                                     |
| `docs/standards/`      | Quy chuẩn code sạch, bảo mật OWASP, DoD, chiến lược kiểm thử QA, Git commit templates.                                                            |
| `docs/ai-integration/` | Cấu hình LLM Harness, định tuyến Model Router (Gemini/Claude), xử lý fallback & rate limit.                                                       |
| `docs/dev-logs/`       | Nhật ký dev hàng ngày và hồ sơ quyết định kiến trúc (ADR).                                                                                        |
| `scripts/`             | Kịch bản tự động hóa (khởi tạo repo GitHub CLI, setup môi trường).                                                                                |

---

## 3. Phân Công Sub-Agents & Quy Trình Skills

### 3.1. Vai Trò Custom Sub-Agents (`.agents/agents/`)
Khi tác vụ phức tạp, chia nhỏ và ủy quyền qua `invoke_subagent` theo các hồ sơ:
1. **Architect Agent** ([.agents/agents/architect.md](.agents/agents/architect.md)): Phân tích yêu cầu, thiết kế kiến trúc, mô hình CSDL và API contract.
2. **Developer Agent** ([.agents/agents/developer.md](.agents/agents/developer.md)): Viết mã nguồn nghiệp vụ, bám sát coding standards, xử lý lỗi chi tiết.
3. **Tester Agent** ([.agents/agents/qa-tester.md](.agents/agents/qa-tester.md)): Viết test cases, kiểm tra coverage, tìm edge cases và kiểm thử hồi quy.
4. **DevOps Agent** ([.agents/agents/devops.md](.agents/agents/devops.md)): Xây dựng CI/CD pipeline, container hóa (Docker), thiết lập biến môi trường và script deploy.
5. **Reviewer Agent** ([.agents/agents/security-reviewer.md](.agents/agents/security-reviewer.md)): Rà soát code độc lập, kiểm tra lỗ hổng bảo mật OWASP, đối chiếu PR checklist.
6. **UI/UX Designer Agent** ([.agents/agents/ui-ux-designer.md](.agents/agents/ui-ux-designer.md)): Thiết kế giao diện độc bản, tinh chỉnh micro-interactions và audit theo chuẩn Impeccable (`pbakaus/impeccable`).

### 3.2. Bộ 5 Skills Cốt Lõi Theo Giai Đoạn (`.agents/skills/`)
Người dùng có thể gọi trực tiếp bằng lệnh `/<tên-skill>` trên ô chat, hoặc Agent tự động kích hoạt `SKILL.md` tương ứng theo ngữ cảnh nhiệm vụ (Progressive Disclosure):
1. **`/project-bootstrap`** ([.agents/skills/project-bootstrap/SKILL.md](.agents/skills/project-bootstrap/SKILL.md)): Khảo sát quy mô dự án & Tech Stack Day 0, cập nhật `decision-checklist.md`, `DESIGN.md` và cấu hình CI/CD.
2. **`/spec-to-architecture`** ([.agents/skills/spec-to-architecture/SKILL.md](.agents/skills/spec-to-architecture/SKILL.md)): Chuyển hóa ý tưởng thành PRD, User Stories Gherkin, sơ đồ kiến trúc, DB Schema, OpenAPI và ADR.
3. **`/issue-driven-dev`** ([.agents/skills/issue-driven-dev/SKILL.md](.agents/skills/issue-driven-dev/SKILL.md)): Tạo hoặc đọc GitHub Issues (`gh issue view`), khóa phạm vi Task Contract, tra cứu `.codegraph` và lập trình kèm test.
4. **`/impeccable-ui-workflow`** ([.agents/skills/impeccable-ui-workflow/SKILL.md](.agents/skills/impeccable-ui-workflow/SKILL.md)): Thực thi quy trình `craft -> audit -> polish -> harden` cho giao diện chống AI tells, đạt chuẩn WCAG 2.1 AA.
5. **`/verify-dod-and-pr`** ([.agents/skills/verify-dod-and-pr/SKILL.md](.agents/skills/verify-dod-and-pr/SKILL.md)): Kiểm tra quy chuẩn chú thích trên `git diff`, chạy build/lint/test lấy bằng chứng thực tế và gợi ý lệnh Git commit / PR.

---

## 4. Tương Thích Mô Hình Đa Nền Tảng (Gemini + Claude)

- **Gemini (Google Antigravity)**: Tận dụng context window lớn để nạp toàn bộ tài liệu đặc tả, kiểm tra code với CodeGraph.
- **Claude (Anthropic)**: Khi mở rộng sang Claude, áp dụng nguyên tắc tương tự thông qua CLAUDE.md hoặc trỏ liên kết trực tiếp về `AGENTS.md` này.
- **Định dạng giao tiếp**: Luôn trả lời ngắn gọn, chính xác bằng tiếng Việt, dẫn liên kết markdown cho mọi file được tham chiếu.
