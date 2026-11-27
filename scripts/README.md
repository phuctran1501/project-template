# Script của template

## Khởi tạo repository

Chạy từ Git working tree. Cần Git và Bash hoặc PowerShell 5.1 trở lên. Thao tác tạo repo thật yêu cầu GitHub CLI và tài khoản đã đăng nhập qua `gh auth login`. Dùng chế độ xem trước chỉ với Git.

```powershell
.\scripts\init-repo.ps1 -RepoName "my-app" -DryRun
.\scripts\init-repo.ps1 -RepoName "my-app" -ReplaceOrigin
```

```bash
bash scripts/init-repo.sh -r my-app --dry-run
bash scripts/init-repo.sh -r my-app --replace-origin
```

Nếu có `origin`, chạy thật sẽ hỏi xác nhận, mặc định hủy. Các cờ `-ReplaceOrigin` và `--replace-origin` xác nhận trước. Sau khi GitHub CLI tạo repo và gắn `template-init-target`, script chuyển `origin` cũ sang `template-origin-backup` rồi gắn repo mới vào `origin`. Nhánh hiện tại được giữ nguyên. Chọn nhánh `main` khi muốn dùng mặc định trigger Production của template.

Nhánh đang theo dõi remote cũ sẽ tiếp tục theo dõi `template-origin-backup`. Khi sẵn sàng đưa mã lên repo mới, chỉ định đích bằng `git push -u origin HEAD` để cập nhật upstream cho nhánh.

Khi có lỗi, kiểm tra repo đích trên GitHub và `git remote -v` trước khi thử lại. Nếu repo mới đã được tạo và còn ở `template-init-target`, bạn có thể xử lý tiếp từ remote đó. Script giữ các remote đã tồn tại và dừng nếu tên tạm hoặc tên dự phòng cần dùng bị trùng.

## Kiểm chứng template

Cần Node.js 22 trở lên, Git, Bash và PowerShell 7 với lệnh `pwsh` để chạy trọn bộ kiểm thử. Trên Windows, bộ kiểm thử dùng Bash đi cùng Git for Windows.

```text
node scripts/doctor.mjs
node scripts/check-markdown-links.mjs
node --test scripts/tests/*.test.mjs
actionlint
gitleaks git --config .gitleaks.toml --redact --no-banner .
```

Template CI chạy các kiểm tra liên kết nội bộ, hồi quy deploy và khởi tạo, cú pháp workflow và bí mật trong lịch sử Git. Đặt `Secret scan`, `Workflow lint` và cả hai job `Template checks` thành kiểm tra bắt buộc trong ruleset GitHub sau khi chúng chạy lần đầu. Gitleaks dùng tập quy tắc mặc định. Ngoại lệ hiện tại chỉ khớp dấu vết của giá trị JWT giữ chỗ trong lịch sử của `.env.example`.

## CI cho dự án kế thừa

Khi [stack đã được duyệt](../docs/techs/decision-checklist.md) và có mã ứng dụng, thêm workflow `.github/workflows/application-ci.yml`. Ghim phiên bản runtime theo dự án, cài từ lockfile nếu stack hỗ trợ, rồi chạy lint, typecheck, test và build theo lệnh thực tế. Thêm các job ứng dụng vào danh sách kiểm tra bắt buộc sau lần chạy đầu. Tài liệu bàn giao ghi `NOT RUN` cho bước chưa có lệnh hoặc chưa được chạy.
