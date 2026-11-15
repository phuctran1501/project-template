#!/usr/bin/env bash
# ==============================================================================
# Script: init-repo.sh
# Muc dich: Tu dong khoi tao GitHub repo moi tu template bang GitHub CLI gh
# Su dung: ./scripts/init-repo.sh -r "my-repo" -v "private"
# ==============================================================================

set -euo pipefail

REPO_NAME=""
VISIBILITY="private"
ORG=""

while getopts "r:v:o:h" opt; do
  case ${opt} in
    r ) REPO_NAME="$OPTARG" ;;
    v ) VISIBILITY="$OPTARG" ;;
    o ) ORG="$OPTARG" ;;
    h )
      echo "Cach dung: $0 -r <repo-name> [-v <private|public>] [-o <org-name>]"
      exit 0
      ;;
    \? )
      echo "Tham so khong hop le. Dung -h de xem huong dan."
      exit 1
      ;;
  esac
done

echo -e "\033[0;36m=== [1/4] KIEM TRA MOI TRUONG ===\033[0m"
if ! command -v gh &> /dev/null; then
    echo -e "\033[0;31mLOI: GitHub CLI gh chua duoc cai dat. Vui long cai dat tu https://cli.github.com/\033[0m"
    exit 1
fi

if ! gh auth status &> /dev/null; then
    echo -e "\033[0;33mChua dang nhap GitHub. Bat dau phien dang nhap...\033[0m"
    gh auth login
fi

echo -e "\033[0;36m=== [2/4] THU THAP THONG TIN DU AN ===\033[0m"
if [ -z "$REPO_NAME" ]; then
    read -rp "Nhap ten repository moi: " REPO_NAME
    if [ -z "$REPO_NAME" ]; then
        echo -e "\033[0;31mLOI: Ten repository khong duoc de trong.\033[0m"
        exit 1
    fi
fi

TARGET="$REPO_NAME"
if [ -n "$ORG" ]; then
    TARGET="$ORG/$REPO_NAME"
fi

# Xu ly remote origin neu da ton tai tu template ban dau
if git remote get-url origin &> /dev/null; then
    OLD_REMOTE=$(git remote get-url origin)
    echo -e "\033[0;33mPhat hien remote origin hien tai: $OLD_REMOTE\033[0m"
    read -rp "Ban co muon thay the remote origin bang $TARGET khong? Y tren n: " CONFIRM
    CONFIRM=${CONFIRM:-"Y"}
    if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
        git remote remove origin
        echo -e "\033[0;32mDa go bo remote cu thanh cong.\033[0m"
    else
        echo "Huy thao tac tao repo."
        exit 0
    fi
fi

echo -e "\033[0;36m=== [3/4] TAO REPOSITORY TREN GITHUB ===\033[0m"
gh repo create "$TARGET" "--$VISIBILITY" --source=. --remote=origin

# Thiet lap ten nhanh mac dinh la main, khong tu y commit hoac push
git branch -M main 2>/dev/null || true

echo -e "\033[0;32m=== KHOI TAO REPO THANH CONG ===\033[0m"
echo -e "\033[0;33mTheo quy uoc, he thong khong tu y commit hoac push ma dua ra goi y de ban kiem tra:\033[0m"
echo ""
echo "  git add ."
echo "  git commit -m \"chore: khoi tao du an tu project-template chuan SDLC\""
echo "  git push -u origin main"
echo ""
echo "Cac buoc tiep theo:"
echo "1. Cap nhat quyet dinh cong nghe: docs/techs/decision-checklist.md"
echo "2. Khai bao Design Tokens: docs/ui-ux/design-tokens-template.md"
echo "3. Phan tich yeu cau cung AI: docs/requirements/prd-template.md"
echo "Repo URL: https://github.com/$TARGET"
