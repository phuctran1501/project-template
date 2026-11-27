# Trợ lý lập trình Codex

Bắt đầu với [quy trình chung](../../README.md#quy-trình-chung). Mở thư mục gốc trong Codex Desktop, CLI hoặc IDE. Codex lấy quy ước từ [AGENTS.md](../../AGENTS.md) và dùng năm skill trong [.agents/skills/](../../.agents/skills/). Khi Codex hỏi về mức độ tin cậy, chỉ tin cậy checkout mà bạn đã xem qua để nạp [cấu hình dự án](../../.codex/config.toml).

## Làm việc theo Task Contract

Nếu dùng CLI, chạy `codex --version` để xác nhận CLI có trên PATH.

1. Trong Codex CLI hoặc IDE, mở `/skills` hoặc gõ `$` để chọn skill. Trong Desktop, dùng bộ chọn skill hoặc yêu cầu bằng ngôn ngữ tự nhiên. Ví dụ, yêu cầu “Dùng issue-driven-dev để làm Task Contract này và chạy các kiểm tra nghiệm thu”.
2. Với thay đổi cần kiểm thử độc lập, yêu cầu Codex giao tiêu chí nghiệm thu cho [qa-tester](../../.codex/agents/qa-tester.toml). Với diff nhạy cảm, giao cho [security-reviewer](../../.codex/agents/security-reviewer.toml). Hai vai trò gọi lại hồ sơ chung trong [.agents/agents/](../../.agents/agents/) và kế thừa quyền của phiên chính. Dùng phiên chỉ đọc nếu cần cưỡng chế giới hạn ghi của lượt review.

Ví dụ kiểm tra sau khi đã tin cậy repo và đăng nhập Codex CLI.

```text
codex exec --sandbox read-only "Giao cho security-reviewer xem diff hiện tại và báo kết quả. Chỉ đọc repo, bỏ qua kiểm tra cần ghi tệp."
```

Tài liệu tham khảo [AGENTS.md trong Codex](https://learn.chatgpt.com/docs/agent-configuration/agents-md) · [Skills](https://learn.chatgpt.com/docs/build-skills) · [Subagents](https://learn.chatgpt.com/docs/agent-configuration/subagents) · [Codex CLI không tương tác](https://learn.chatgpt.com/docs/non-interactive-mode).

## CodeGraph tùy chọn

Nếu nhóm đã chọn CodeGraph và đã lập index, dùng MCP có sẵn trong phiên hoặc bật mục mẫu trong [cấu hình dự án](../../.codex/config.toml) khi mọi người cần sử dụng đều có CLI trên PATH. Kiểm tra cấu hình bằng `codex mcp list`. Dùng `codegraph status` để kiểm tra index độc lập với Codex. Khi chưa có index hoặc công cụ, tra cứu bằng `rg` và đọc file. [Hướng dẫn CodeGraph](../../.codegraph/README.md)
