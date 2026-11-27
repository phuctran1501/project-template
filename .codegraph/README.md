# CodeGraph

CodeGraph dùng cấu hình mặc định khi lập chỉ mục. Nếu cần tùy chỉnh phạm vi, dùng `.gitignore` hoặc `codegraph.json` tại thư mục gốc theo [tài liệu CodeGraph](https://github.com/colbymchenry/codegraph/blob/v1.6.2/README.md#configuration). Git bỏ qua cơ sở dữ liệu chỉ mục cục bộ.

1. Khi nhóm quyết định dùng CodeGraph, cài [CodeGraph](https://github.com/colbymchenry/codegraph), chạy `codegraph init` tại root rồi kiểm tra bằng `codegraph status`.
2. Với index đã sẵn sàng, ưu tiên `codegraph_explore`. Nếu tool có tham số `projectPath`, truyền đường dẫn tuyệt đối đến root repo. Khi chỉ có CLI, dùng `codegraph explore "<symbol hoặc luồng cần tìm>"`.
3. Khi MCP báo chưa có index và CLI cũng không dùng được, tìm bằng `rg` rồi đọc file liên quan. Chạy `node scripts/doctor.mjs` ở root để xem điều kiện cục bộ.
4. Với index đã tạo, dùng `codegraph sync` để cập nhật hoặc `codegraph index` khi cần lập lại toàn bộ.

Nếu dùng CodeGraph qua MCP, xem [hướng dẫn dành cho trợ lý đang dùng](../README.md#trợ-lý-ai-tùy-chọn).
