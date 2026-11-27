# Task Contract — Củng cố template và hỗ trợ Codex

- **Ngày** 2026-11-27
- **Mục tiêu** Đưa kiểm tra template vào CI, bảo đảm deploy báo lỗi đúng, khởi tạo repository an toàn và hỗ trợ Codex từ cùng bộ quy trình.
- **Tham chiếu** [DoD](../standards/definition-of-done.md), [quy chuẩn mã](../standards/coding-standards.md) và [hướng dẫn deploy](../architecture/deployments-and-demo-links.md).

| Thứ tự | Phạm vi | Tiêu chí nghiệm thu |
| --- | --- | --- |
| P0 | Workflow CI và deploy, cấu hình Gitleaks, lệnh kiểm tra và kiểm thử tương ứng | CI chạy kiểm tra thực tế. Gitleaks chặn phát hiện. Preview và Production định tuyến riêng. URL sai và lỗi hook trả mã khác 0. |
| P1 | Script Bash và PowerShell, tài liệu, CodeGraph và ignore | Chế độ xem trước không ghi. Tạo repo thất bại giữ remote và nhánh. Kiểm chứng bằng lệnh giả lập. |
| P2 | Hướng dẫn chung, cấu hình và hai vai trò Codex | Tái sử dụng năm skill, khai báo QA và security reviewer, có phương án tra cứu khi thiếu index hoặc MCP. |

Giữ nguyên các lựa chọn kiến trúc, stack và nền tảng triển khai của dự án kế thừa. Không tạo tài nguyên bên ngoài, commit hay push khi thực hiện tác vụ.

Kiểm chứng bằng `actionlint`, Gitleaks, bộ kiểm thử cục bộ, kiểm tra cấu hình Codex và `git diff --check`. Chỉ báo PASS cho lệnh đã chạy.
