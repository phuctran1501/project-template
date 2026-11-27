#Requires -Version 5.1

<#
.SYNOPSIS
    Tạo repository GitHub và gắn origin mới.
.PARAMETER RepoName
    Tên repository cần tạo.
.PARAMETER Visibility
    Chế độ hiển thị là private, public hoặc internal.
.PARAMETER Org
    Tổ chức nhận repository.
.PARAMETER DryRun
    In kế hoạch mà không gọi GitHub hoặc sửa Git.
.PARAMETER ReplaceOrigin
    Đồng ý giữ origin cũ dưới tên template-origin-backup.
.PARAMETER Help
    Hiện hướng dẫn.
#>

[CmdletBinding()]
param (
    [string]$RepoName,
    [ValidateSet('private', 'public', 'internal')]
    [string]$Visibility = 'private',
    [string]$Org = '',
    [switch]$DryRun,
    [switch]$ReplaceOrigin,
    [Alias('h')]
    [switch]$Help
)

$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $false
$targetRemote = 'template-init-target'
$backupRemote = 'template-origin-backup'

if ($Help) {
    Get-Help $PSCommandPath -Detailed
    return
}
if ([string]::IsNullOrWhiteSpace($RepoName)) {
    if ($DryRun) { throw 'Cần -RepoName cho chế độ xem trước.' }
    $RepoName = Read-Host 'Nhập tên repository mới'
}
$target = if ($Org) { "$Org/$RepoName" } else { $RepoName }
if ($target -cnotmatch '^([A-Za-z0-9][A-Za-z0-9-]*/)?[A-Za-z0-9_.][A-Za-z0-9_.-]*$' -or
    $target -match '(^|/)\.{1,2}$') {
    throw 'Tên repository không hợp lệ.'
}

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw 'Cần cài Git.' }
$repoRoot = git rev-parse --show-toplevel
if ($LASTEXITCODE -ne 0) { throw 'Hãy chạy trong Git working tree.' }
$remoteNames = git remote
if ($LASTEXITCODE -ne 0) { throw 'Không đọc được danh sách remote.' }
$hasOrigin = $remoteNames -ccontains 'origin'
if ($DryRun) {
    Write-Host "Xem trước: tạo $target ở chế độ $Visibility rồi gắn vào origin."
    if ($hasOrigin) { Write-Host "Thao tác thật cần xác nhận để lưu origin cũ thành $backupRemote." }
    return
}

if ($hasOrigin -and -not $ReplaceOrigin) {
    $answer = Read-Host "Lưu origin cũ thành $backupRemote và nối origin với ${target}? [y/N]"
    if ($answer -ne 'y') {
        Write-Host 'Đã hủy tạo repository.'
        return
    }
}
if ($remoteNames -ccontains $targetRemote -or ($hasOrigin -and $remoteNames -ccontains $backupRemote)) {
    throw "Remote $targetRemote hoặc $backupRemote đã tồn tại. Kiểm tra git remote trước khi thử lại."
}

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) { throw 'Cần cài GitHub CLI.' }
gh auth status *> $null
if ($LASTEXITCODE -ne 0) { throw 'Hãy đăng nhập bằng gh auth login trước.' }
gh repo create $target "--$($Visibility.ToLowerInvariant())" "--source=$repoRoot" "--remote=$targetRemote"
if ($LASTEXITCODE -ne 0) {
    $status = $LASTEXITCODE
    Write-Host "GitHub CLI báo lỗi. Hãy kiểm tra repository trên GitHub và remote $targetRemote trước khi thử lại."
    exit $status
}
git remote get-url $targetRemote > $null
if ($LASTEXITCODE -ne 0) { throw "GitHub CLI không gắn remote $targetRemote. Kiểm tra repository mới trên GitHub." }
if ($hasOrigin) {
    git remote rename origin $backupRemote
    if ($LASTEXITCODE -ne 0) { throw "Không lưu được origin cũ. Repository mới được gắn tại $targetRemote." }
}
git remote rename $targetRemote origin
if ($LASTEXITCODE -ne 0) {
    if ($hasOrigin) {
        git remote rename $backupRemote origin
        if ($LASTEXITCODE -ne 0) { throw "Không khôi phục được origin. Kiểm tra các remote $backupRemote và $targetRemote." }
    }
    throw "Không gắn được origin mới. Repository mới được gắn tại $targetRemote."
}

Write-Host 'Đã tạo repository và gắn origin mới. Branch hiện tại được giữ nguyên.'
Write-Host 'Sau khi kiểm tra thay đổi và tạo commit nếu cần, dùng git push -u origin HEAD.'
