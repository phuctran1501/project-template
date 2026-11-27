---
name: verify-dod-and-pr
description: >-
  Cổng kiểm định chất lượng cuối cùng theo Definition of Done (DoD) và
  Evidence-Based Completion: kiểm tra phạm vi Git diff và quy chuẩn chú thích
  tiếng Việt không dấu ngoặc đơn và không icon, thực thi build/lint/test lấy log
  thực tế, rà soát bảo mật và xuất gợi ý Git commit cùng nội dung Pull Request.
  Sử dụng sau khi hoàn tất lập trình/sửa lỗi, trước khi báo cáo hoàn thành, hoặc
  khi người dùng yêu cầu kiểm tra DoD, review code, chuẩn bị commit/PR.
---

# Kiểm Chứng DoD, Bằng Chứng Thực Thi & Bàn Giao PR

Quy trình bắt buộc trước khi kết thúc mọi tác vụ thay đổi mã nguồn hoặc cấu hình, đảm bảo không có báo cáo hoàn thành giả định và không vi phạm hiến pháp tại `AGENTS.md`.

## Khi Nào Sử Dụng

- Ngay sau khi viết xong mã nguồn tính năng, bản sửa lỗi, cấu hình hạ tầng hoặc bài kiểm thử.
- Người dùng gọi `/verify-dod-and-pr` hoặc yêu cầu *"kiểm tra DoD"*, *"review lại những gì vừa làm"*, *"gợi ý commit"*, *"chuẩn bị mở Pull Request"*.

## Quy Trình Thực Hiện

### Bước 1: Kiểm tra phạm vi Git & Quy chuẩn chú thích mã nguồn
1. Chạy `git status --short` và `git diff` để kiểm tra toàn bộ tệp thay đổi:
   - Không sửa nhầm tệp thuộc vùng `Out-of-Scope`.
   - Không có tệp `.env` nhạy cảm hoặc khóa bí mật cứng vô tình nằm trong vùng thay đổi.
2. Rà soát toàn bộ dòng chú thích mới/chỉnh sửa trong mã nguồn: bắt buộc viết hoàn toàn bằng tiếng Việt, **không chứa dấu ngoặc đơn `()`** và **không chứa biểu tượng cảm xúc/icon**. Nếu phát hiện vi phạm, sửa ngay trước khi sang bước tiếp theo.

### Bước 2: Thực thi Build, Linter, Typecheck & Test thực tế
1. Dựa vào tệp quản lý dự án hiện hữu (`package.json`, `pyproject.toml`, `requirements.txt`, `go.mod`, `*.sln`, `Cargo.toml`), chạy thực tế các lệnh kiểm tra kiểu tĩnh, linter, build và test suite.
2. Nếu phát hiện lỗi biên dịch, cảnh báo linter mới hoặc bài test thất bại, sửa triệt để và chạy lại trước khi báo cáo.
3. Khi sửa template, dùng các lệnh kiểm chứng trong [hướng dẫn script](../../../scripts/README.md#kiểm-chứng-template). Nếu dự án chưa có trình chạy hoặc chưa có mã ứng dụng, báo `NOT RUN` kèm lý do cho các kiểm tra ứng dụng tương ứng.

### Bước 3: Đối chiếu DoD & Rà soát Bảo mật Độc lập
1. Rà soát danh mục tại [definition-of-done.md](../../../docs/standards/definition-of-done.md) và [security-checklist.md](../../../docs/standards/security-checklist.md); cập nhật tài liệu liên quan tại `docs/` nếu thay đổi API, Database Schema hoặc kiến trúc.
2. Với thay đổi về xác thực, phân quyền, SQL, tải tệp hoặc CI/CD, giao cho vai trò `security-reviewer` mà nền tảng đã nạp để rà soát độc lập. Nếu phiên thiếu subagent, tự rà soát và ghi rõ giới hạn của lượt rà.

### Bước 4: Xuất Báo cáo Bằng chứng & Gợi ý Commit / PR
1. Trình bày bảng tổng kết nghiệm thu rõ ràng:

| Hạng mục kiểm chứng | Trạng thái (`PASS` / `FAIL` / `NOT RUN`) | Bằng chứng thực thi |
| :--- | :--- | :--- |
| Quét quy chuẩn chú thích & `.env` | `...` | Kết quả rà soát `git status` và `git diff` |
| Linter & Static Typecheck | `...` | Lệnh đã chạy và kết quả đầu ra |
| Build mã nguồn | `...` | Lệnh đã chạy và kết quả đầu ra |
| Unit / Integration Tests | `...` | Số bài test vượt qua / lý do chưa chạy |
| Rà soát bảo mật & Tài liệu `docs/` | `...` | Tóm tắt đối chiếu checklist |

2. Đưa ra **gợi ý câu lệnh `git add` và `git commit`** chuẩn Conventional Commits bám sát [git-workflow-and-commit.md](../../../docs/standards/git-workflow-and-commit.md), kèm khung nội dung PR theo [pull_request_template.md](../../../.github/pull_request_template.md) (có `Closes #<số_issue>` nếu thực hiện theo Issue).
3. **Quy tắc bất khả xâm phạm**: TUYỆT ĐỐI KHÔNG tự ý chạy lệnh `git commit` hoặc `git push`.
