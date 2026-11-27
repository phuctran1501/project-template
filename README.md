# Project Template

Mẫu quy trình phát triển phần mềm từ yêu cầu đến bàn giao. Người làm trực tiếp và người có trợ lý AI dùng chung tài liệu, tiêu chí nghiệm thu và lệnh kiểm chứng.

## Quy trình chung

1. **Tạo repository và kiểm tra môi trường.** Chọn [tạo trên GitHub hoặc dùng script](HUONG-DAN-SU-DUNG.md#khởi-tạo-dự-án). Chạy `node scripts/doctor.mjs` từ thư mục gốc.
2. **Chốt quy mô và công nghệ.** Chọn mức tài liệu phù hợp, ghi các quyết định và người phê duyệt vào [checklist công nghệ](docs/techs/decision-checklist.md). Điền [DESIGN.md](docs/ui-ux/DESIGN.md) nếu dự án có giao diện.
3. **Đặc tả yêu cầu và thiết kế.** Dùng [mẫu PRD](docs/requirements/prd-template.md) và các mẫu kiến trúc, CSDL hoặc API cần thiết cho phạm vi. [Hướng dẫn theo quy mô](HUONG-DAN-SU-DUNG.md#chọn-mức-tài-liệu)
4. **Giao việc.** Điền [Task Contract](docs/task/task-contract-template.md) hoặc [GitHub Issue](.github/ISSUE_TEMPLATE/) với mục tiêu, phạm vi, tiêu chí nghiệm thu và lệnh kiểm tra.
5. **Triển khai và kiểm thử.** Đọc tài liệu được dẫn trong tác vụ, sửa trong phạm vi và viết kiểm thử bám tiêu chí nghiệm thu. [Quy chuẩn mã nguồn](docs/standards/coding-standards.md)
6. **Kiểm chứng và bàn giao.** Chạy các lệnh đã ghi trong tác vụ. Ghi `PASS`, `FAIL` hoặc `NOT RUN` kèm bằng chứng, rồi rà diff theo [Definition of Done](docs/standards/definition-of-done.md) trước khi bàn giao. [Mẫu pull request](.github/pull_request_template.md)

### Kiểm tra chính template

Chạy tại thư mục gốc bằng Node.js 22 trở lên. Xem các yêu cầu Bash, PowerShell, `actionlint` và Gitleaks trong [hướng dẫn kiểm chứng](scripts/README.md#kiểm-chứng-template).

```text
node scripts/doctor.mjs
node scripts/check-markdown-links.mjs
node --test scripts/tests/*.test.mjs
```

Khi dự án đã có mã ứng dụng, bổ sung [CI theo stack đã duyệt](scripts/README.md#ci-cho-dự-án-kế-thừa). Tài liệu triển khai ở [hướng dẫn Deployments](docs/architecture/deployments-and-demo-links.md).

Nếu sản phẩm có tính năng dùng LLM, bổ sung thiết kế theo [hướng dẫn tích hợp AI vào sản phẩm](docs/ai-integration/llm-harness-guidelines.md).

## Trợ lý AI tùy chọn

Dùng cùng [AGENTS.md](AGENTS.md) và Task Contract hoặc Issue khi giao việc. Nếu trợ lý thiếu quyền đọc repo, cung cấp nội dung hướng dẫn và các tệp liên quan. Nếu trợ lý thiếu môi trường chạy lệnh, người thực hiện chạy kiểm chứng và ghi kết quả.

> Đọc `AGENTS.md` và Task Contract hoặc Issue tôi gửi. Làm trong phạm vi đã ghi, chạy các lệnh kiểm chứng có thể chạy và báo kết quả kèm bằng chứng.

Các [skill Markdown](.agents/skills/) có thể mở trực tiếp để theo từng bước. Cách nạp tự động, gọi skill và dùng cấu hình riêng được trình bày tại [Codex](docs/tooling/codex-workflow.md), [Antigravity](docs/tooling/antigravity-workflow.md) và [Claude Code](docs/tooling/claude-code-workflow.md).
