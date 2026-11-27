# Trợ lý lập trình Claude Code

Mở phiên tại thư mục gốc, rồi giao một Issue hoặc Task Contract theo [quy trình chung](../../README.md#quy-trình-chung). Các hướng dẫn của repo nằm trong [AGENTS.md](../../AGENTS.md).

Claude Code có thể đọc trực tiếp `AGENTS.md` tùy phiên bản và cấu hình Project instructions. Nếu repo kế thừa có `CLAUDE.md` hoặc phiên đang dùng chỉ nạp file đó, thêm một dòng import vào `CLAUDE.md` ở cùng thư mục để dùng chung quy ước. [Tài liệu Project instructions](https://code.claude.com/docs/en/memory)

```text
@AGENTS.md
```

Khi cần một quy trình cụ thể, yêu cầu Claude đọc [SKILL.md xử lý Issue](../../.agents/skills/issue-driven-dev/SKILL.md) hoặc [SKILL.md kiểm chứng](../../.agents/skills/verify-dod-and-pr/SKILL.md) như tài liệu Markdown. Dùng chính các lệnh trong Task Contract để kiểm chứng.
