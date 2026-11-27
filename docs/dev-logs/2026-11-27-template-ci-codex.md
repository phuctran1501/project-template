# Nhật ký 2026-11-27

Hoàn thành ba nhóm thay đổi theo [Task Contract](../task/template-ci-codex.md).

- **CI và deploy**. Template CI kiểm tra workflow, Markdown, hồi quy và bí mật. Production và Preview dùng URL cấu hình. Chỉ Production được gọi Render hook. [Hướng dẫn deploy](../architecture/deployments-and-demo-links.md)
- **Khởi tạo**. Bash và PowerShell có chế độ xem trước. Origin cũ được giữ cho đến khi tạo repo và gắn remote tạm thành công. Nếu đổi tên remote mới thất bại, script thử khôi phục origin. [Hướng dẫn script](../../scripts/README.md)
- **Codex**. Dùng chung năm skill, thêm vai trò QA và security reviewer, bổ sung doctor và phương án tra cứu khi chưa có CodeGraph. [Hướng dẫn Codex](../tooling/codex-workflow.md)

| Kiểm chứng | Kết quả |
| --- | --- |
| `node --test scripts/tests/*.test.mjs` | PASS 19 ca. Gồm 5 ca deploy và 14 ca khởi tạo với Git trong thư mục tạm và GitHub CLI giả lập. |
| `actionlint` | PASS cho hai workflow. |
| Gitleaks 8.30.1 | PASS khi quét 10 commit và working tree. Mẫu bí mật giả lập trả mã 1 như mong đợi. Ngoại lệ chỉ áp dụng cho một giá trị giữ chỗ trong lịch sử. |
| `codex debug prompt-input` và đọc TOML | PASS khi nạp AGENTS.md và năm skill, phân tích cấu hình và hai hồ sơ vai trò. |
| GitHub Actions, GitHub CLI và Render thật | NOT RUN. Kiểm chứng thao tác GitHub và Render bằng mô phỏng cục bộ. |
| Gọi hai vai trò Codex trong checkout và tra cứu CodeGraph | NOT RUN. Checkout chưa được tin cậy trong Codex CLI và CodeGraph chưa có index. |

## Rà soát và tinh gọn

Bỏ cấu hình CodeGraph theo đường dẫn cũ. Dùng [AGENTS.md](../../AGENTS.md) làm nguồn quy ước chung với một [điểm vào cho Antigravity](../../.agents/rules/01-agent-behavior.md). Gộp hướng dẫn định tuyến và dự phòng vào [hướng dẫn tích hợp LLM](../ai-integration/llm-harness-guidelines.md). Các mẫu roadmap, NFR, backlog và hành trình người dùng vẫn phục vụ các đầu ra riêng của dự án kế thừa.

## Quy trình dùng chung

Đưa [quy trình chung](../../README.md#quy-trình-chung) lên đầu README và đặt hướng dẫn theo từng công cụ trong [mục trợ lý tùy chọn](../../README.md#trợ-lý-ai-tùy-chọn). Người làm trực tiếp và các trợ lý dùng chung Task Contract, lệnh kiểm chứng và tiêu chí bàn giao.

Rà toàn bộ luồng thủ công, từ khởi tạo đến [bàn giao Git](../standards/git-workflow-and-commit.md#1-quy-trình-bàn-giao). Chuẩn hóa các mẫu giao việc và nghiệm thu, sửa ID trùng trong mẫu Issue kiến trúc. Dùng [docs/tooling/](../tooling/) cho trợ lý lập trình và [docs/ai-integration/](../ai-integration/) cho thiết kế tích hợp AI vào sản phẩm.
