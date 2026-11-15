# Thư mục Scripts Tự Động Hóa

Thư mục này chứa các kịch bản hỗ trợ tự động hóa toàn bộ thao tác hạ tầng và thiết lập repo.

## Các kịch bản có sẵn:
1. `init-repo.ps1`: Script PowerShell dành cho Windows sử dụng GitHub CLI `gh repo create`.
2. `init-repo.sh`: Script Bash dành cho Linux/macOS sử dụng GitHub CLI `gh repo create`.

## Quy ước bổ sung script mới:
- Mọi script phải có kiểm tra tiền điều kiện (Dependency check).
- Có cờ `-h` hoặc `--help` giải thích tham số.
- Không hardcode bí mật (token, API key, mật khẩu CSDL) trực tiếp trong script.
