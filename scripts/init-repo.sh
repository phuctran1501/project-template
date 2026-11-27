#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<'HELP'
Cách dùng: bash scripts/init-repo.sh -r TEN_REPO [-v private|public|internal] [-o TO_CHUC]
  -n, --dry-run         In kế hoạch mà không gọi GitHub hoặc sửa Git
  -y, --replace-origin Đồng ý giữ origin cũ dưới tên template-origin-backup
  -h, --help           Hiện hướng dẫn
HELP
}

fail() {
  printf '%s\n' "$*" >&2
  exit 1
}

repo_name=''
visibility=private
org=''
dry_run=false
replace_origin=false
target_remote=template-init-target
backup_remote=template-origin-backup

while getopts ':r:v:o:nyh-:' option; do
  case "$option" in
    r) repo_name="$OPTARG" ;;
    v) visibility="$OPTARG" ;;
    o) org="$OPTARG" ;;
    n) dry_run=true ;;
    y) replace_origin=true ;;
    h) usage; exit 0 ;;
    -)
      case "$OPTARG" in
        dry-run) dry_run=true ;;
        replace-origin) replace_origin=true ;;
        help) usage; exit 0 ;;
        *) fail 'Tham số không hợp lệ. Dùng --help để xem hướng dẫn.' ;;
      esac ;;
    *) fail 'Tham số không hợp lệ. Dùng --help để xem hướng dẫn.' ;;
  esac
done
shift "$((OPTIND - 1))"
[[ $# -eq 0 ]] || fail 'Tham số không hợp lệ. Dùng --help để xem hướng dẫn.'

case "$visibility" in
  private|public|internal) ;;
  *) fail 'Chế độ hiển thị phải là private, public hoặc internal.' ;;
esac
if [[ -z "$repo_name" ]]; then
  if "$dry_run"; then fail 'Cần -r cho chế độ xem trước.'; fi
  read -rp 'Nhập tên repository mới: ' repo_name || fail 'Thiếu tên repository.'
fi
target="$repo_name"
if [[ -n "$org" ]]; then target="$org/$repo_name"; fi
valid_target='^([A-Za-z0-9][A-Za-z0-9-]*/)?[A-Za-z0-9_.][A-Za-z0-9_.-]*$'
if ! [[ "$target" =~ $valid_target ]] || [[ "$target" == '.' || "$target" == '..' || "$target" == */. || "$target" == */.. ]]; then
  fail 'Tên repository không hợp lệ.'
fi

command -v git >/dev/null || fail 'Cần cài Git.'
repo_root=$(git rev-parse --show-toplevel) || fail 'Hãy chạy trong Git working tree.'
remote_names=$(git remote) || fail 'Không đọc được danh sách remote.'
has_origin=false
if grep -Fxq origin <<< "$remote_names"; then has_origin=true; fi
if "$dry_run"; then
  printf 'Xem trước: tạo %s ở chế độ %s rồi gắn vào origin.\n' "$target" "$visibility"
  if "$has_origin"; then printf 'Thao tác thật cần xác nhận để lưu origin cũ thành %s.\n' "$backup_remote"; fi
  exit 0
fi

if "$has_origin" && ! "$replace_origin"; then
  read -rp "Lưu origin cũ thành $backup_remote và nối origin với $target? [y/N] " answer || answer=''
  if [[ "$answer" != [Yy] ]]; then
    printf '%s\n' 'Đã hủy tạo repository.'
    exit 0
  fi
fi
if grep -Fxq "$target_remote" <<< "$remote_names" ||
   { "$has_origin" && grep -Fxq "$backup_remote" <<< "$remote_names"; }; then
  fail "Remote $target_remote hoặc $backup_remote đã tồn tại. Kiểm tra git remote trước khi thử lại."
fi

command -v gh >/dev/null || fail 'Cần cài GitHub CLI.'
gh auth status >/dev/null 2>&1 || fail 'Hãy đăng nhập bằng gh auth login trước.'
gh repo create "$target" "--$visibility" "--source=$repo_root" "--remote=$target_remote" || {
  status=$?
  printf 'GitHub CLI báo lỗi. Hãy kiểm tra repository trên GitHub và remote %s trước khi thử lại.\n' "$target_remote" >&2
  exit "$status"
}
git remote get-url "$target_remote" >/dev/null ||
  fail "GitHub CLI không gắn remote $target_remote. Kiểm tra repository mới trên GitHub."
if "$has_origin"; then
  git remote rename origin "$backup_remote" ||
    fail "Không lưu được origin cũ. Repository mới được gắn tại $target_remote."
fi
if ! git remote rename "$target_remote" origin; then
  if "$has_origin" && ! git remote rename "$backup_remote" origin; then
    fail "Không khôi phục được origin. Kiểm tra các remote $backup_remote và $target_remote."
  fi
  fail "Không gắn được origin mới. Repository mới được gắn tại $target_remote."
fi

printf '%s\n' 'Đã tạo repository và gắn origin mới. Branch hiện tại được giữ nguyên.'
printf '%s\n' 'Sau khi kiểm tra thay đổi và tạo commit nếu cần, dùng git push -u origin HEAD.'
