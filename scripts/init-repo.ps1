<#
.SYNOPSIS
    Khoi tao repository GitHub moi tu template nay su dung GitHub CLI gh.
.DESCRIPTION
    Kich ban tu dong kiem tra cai dat gh cli, xac thuc tai khoan, xu ly remote git hien tai,
    tao repository moi tren GitHub va dua ra goi y commit cho nguoi dung.
.PARAMETER RepoName
    Ten repository can tao tren GitHub.
.PARAMETER Visibility
    Che do hien thi: private mac dinh hoac public hoac internal.
.PARAMETER Org
    Tuy chon ten GitHub Organization neu tao trong Org.
.EXAMPLE
    .\scripts\init-repo.ps1 -RepoName "ecommerce-api" -Visibility "private"
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory = $false)]
    [string]$RepoName,

    [Parameter(Mandatory = $false)]
    [ValidateSet("private", "public", "internal")]
    [string]$Visibility = "private",

    [Parameter(Mandatory = $false)]
    [string]$Org = ""
)

$ErrorActionPreference = "Stop"

Write-Host "=== [1/4] KIEM TRA MOI TRUONG ===" -ForegroundColor Cyan

if (-not (Get-Command "gh" -ErrorAction SilentlyContinue)) {
    Write-Error "LOI: GitHub CLI gh chua duoc cai dat. Vui long cai dat tai https://cli.github.com/ hoac chay winget install GitHub.cli"
    exit 1
}

$authStatus = gh auth status 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Warning "Canh bao: Ban chua dang nhap GitHub CLI. Dang mo luong dang nhap..."
    gh auth login
}

Write-Host "=== [2/4] THU THAP THONG TIN DU AN ===" -ForegroundColor Cyan
if ([string]::IsNullOrWhiteSpace($RepoName)) {
    $RepoName = Read-Host "Nhap ten repository moi - vi du: my-awesome-project"
    if ([string]::IsNullOrWhiteSpace($RepoName)) {
        Write-Error "LOI: Ten repository khong duoc de trong."
        exit 1
    }
}

$repoTarget = if ([string]::IsNullOrWhiteSpace($Org)) { $RepoName } else { "$Org/$RepoName" }

# Xu ly remote origin neu da ton tai tu template ban dau
$existingRemote = git remote get-url origin 2>$null
if ($existingRemote) {
    Write-Host "Phat hien remote origin hien tai: $existingRemote" -ForegroundColor Yellow
    $confirm = Read-Host "Ban co muon thay the remote origin bang repository moi $repoTarget khong? Y tren n"
    if ([string]::IsNullOrWhiteSpace($confirm) -or $confirm -eq "y" -or $confirm -eq "Y") {
        git remote remove origin
        Write-Host "Da go bo remote cu thanh cong." -ForegroundColor Green
    } else {
        Write-Host "Huy thao tac tao repo theo yeu cau nguoi dung." -ForegroundColor Gray
        exit 0
    }
}

Write-Host "=== [3/4] TAO REPOSITORY TREN GITHUB ===" -ForegroundColor Cyan
Write-Host "Dang tao repository $repoTarget voi che do $Visibility..." -ForegroundColor Yellow

$ghArgs = @("repo", "create", $repoTarget, "--$Visibility", "--source=.", "--remote=origin")
gh @ghArgs

if ($LASTEXITCODE -eq 0) {
    Write-Host "Khoi tao repo tren GitHub thanh cong!" -ForegroundColor Green
    
    # Thiet lap ten nhanh chinh la main, khong tu y commit hoac push ma de nguoi dung tu thuc hien
    git branch -M main 2>$null
    
    Write-Host "=== [4/4] GOI Y LENH GIT COMMIT VA BUOC TIEP THEO ===" -ForegroundColor Cyan
    Write-Host "Theo quy uoc, he thong khong tu y commit hoac push ma dua ra goi y de ban kiem tra:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  git add ." -ForegroundColor White
    Write-Host "  git commit -m `"chore: khoi tao du an tu project-template chuan SDLC`"" -ForegroundColor White
    Write-Host "  git push -u origin main" -ForegroundColor White
    Write-Host ""
    Write-Host "Cac buoc thiet lap du an tiep theo:" -ForegroundColor Cyan
    Write-Host "1. Mo file docs/techs/decision-checklist.md de chon Tech Stack." -ForegroundColor White
    Write-Host "2. Mo file docs/ui-ux/design-tokens-template.md de xac dinh mau sac va phong chu." -ForegroundColor White
    Write-Host "3. Goi AI Agent thuc hien phan tich yeu cau tai docs/requirements/prd-template.md." -ForegroundColor White
    Write-Host "Link kho ma nguon: https://github.com/$repoTarget" -ForegroundColor Green
} else {
    Write-Error "LOI: Khong the tao repo tren GitHub. Vui long kiem tra quyen han hoac ten repo da ton tai."
}
