import assert from 'node:assert/strict';
import { execFileSync, spawnSync } from 'node:child_process';
import { existsSync, mkdtempSync, readFileSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join, resolve } from 'node:path';
import test from 'node:test';
import { fileURLToPath } from 'node:url';

const gitPath = execFileSync('git', ['--exec-path'], { encoding: 'utf8' }).trim();
const bashPath = process.platform === 'win32'
  ? resolve(gitPath, '../../../bin/bash.exe')
  : 'bash';
const oldUrl = 'https://old.example.com/repo.git';
const oldPushUrl = 'ssh://old.example.com/repo.git';
const newUrl = 'https://new.example.com/repo.git';

const bashRunner = `
git() {
  if [[ "$*" == 'remote rename template-init-target origin' && "$MOCK_MODE" == rename-fails ]]; then
    return 43
  fi
  command git "$@"
}
gh() {
  printf '%s\\n' "$*" >> "$MOCK_LOG"
  if [[ "$*" == 'auth status' ]]; then return 0; fi
  if [[ "$MOCK_MODE" == create-fails ]]; then return 42; fi
  if [[ "$MOCK_MODE" == remote-missing ]]; then return 0; fi
  command git remote add template-init-target "$MOCK_NEW_URL"
}
source "$MOCK_INIT_SCRIPT" "$@"
`;

const powershellRunner = `
param (
    [string]$RepoName,
    [string]$Org,
    [string]$Visibility,
    [switch]$DryRun,
    [switch]$ReplaceOrigin
)
$ErrorActionPreference = 'Stop'
$gitCommand = Get-Command git -CommandType Application -TotalCount 1
function git {
    if (($args -join ' ') -eq 'remote rename template-init-target origin' -and $env:MOCK_MODE -eq 'rename-fails') {
        $global:LASTEXITCODE = 43
        return
    }
    & $gitCommand.Source @args
}
function gh {
    Add-Content -LiteralPath $env:MOCK_LOG -Value ($args -join ' ')
    if (($args -join ' ') -eq 'auth status') { $global:LASTEXITCODE = 0; return }
    if ($env:MOCK_MODE -eq 'create-fails') { $global:LASTEXITCODE = 42; return }
    if ($env:MOCK_MODE -eq 'remote-missing') { $global:LASTEXITCODE = 0; return }
    git remote add template-init-target $env:MOCK_NEW_URL
}
function Read-Host { '' }
& $env:MOCK_INIT_SCRIPT @PSBoundParameters
exit $LASTEXITCODE
`;

const shells = [
  {
    name: 'Bash', binary: bashPath, extension: 'sh', runner: bashRunner,
    options: ['-r', 'demo', '-o', 'group', '-v', 'public'],
    dryRun: '--dry-run', confirm: '--replace-origin',
  },
  {
    name: 'PowerShell', binary: 'pwsh', extension: 'ps1', runner: powershellRunner,
    options: ['-RepoName', 'demo', '-Org', 'group', '-Visibility', 'public'],
    dryRun: '-DryRun', confirm: '-ReplaceOrigin',
  },
];

function fixture(context, shell, withOrigin = true) {
  const directory = mkdtempSync(join(tmpdir(), 'template init-'));
  context.after(() => rmSync(directory, { recursive: true, force: true }));
  const git = (...args) => execFileSync('git', args, { cwd: directory, encoding: 'utf8' })
    .replaceAll('\r\n', '\n').trim();
  git('init', '--quiet', '--initial-branch=feature');
  if (withOrigin) {
    git('remote', 'add', 'origin', oldUrl);
    git('remote', 'set-url', '--push', 'origin', oldPushUrl);
    git('config', 'branch.feature.remote', 'origin');
    git('config', 'branch.feature.merge', 'refs/heads/main');
  }
  const runnerPath = join(directory, `runner.${shell.extension}`);
  const scriptPath = fileURLToPath(new URL(`../init-repo.${shell.extension}`, import.meta.url));
  const log = join(directory, 'gh.log');
  writeFileSync(runnerPath, shell.runner);
  return {
    git,
    log,
    run(mode, args) {
      const shellArgs = shell.extension === 'ps1' ? ['-NoProfile', '-File', runnerPath] : [runnerPath];
      const result = spawnSync(shell.binary, [...shellArgs, ...args], {
        cwd: directory,
        input: '\n',
        encoding: 'utf8',
        env: { ...process.env, MOCK_MODE: mode, MOCK_LOG: log, MOCK_NEW_URL: newUrl,
          MOCK_INIT_SCRIPT: scriptPath.replaceAll('\\', '/') },
      });
      assert.ifError(result.error);
      return result;
    },
  };
}

for (const shell of shells) {
  test(`${shell.name} xem trước và từ chối xác nhận không gọi GitHub`, context => {
    const { git, log, run } = fixture(context, shell);
    for (const args of [[...shell.options, shell.dryRun], shell.options]) {
      const result = run('create-fails', args);
      assert.equal(result.status, 0, result.stderr);
      assert.equal(git('remote', 'get-url', 'origin'), oldUrl);
      assert.equal(git('remote'), 'origin');
    }
    assert.equal(existsSync(log), false);
  });

  test(`${shell.name} giữ remote và nhánh khi GitHub trả lỗi`, context => {
    const { git, run } = fixture(context, shell);
    const result = run('create-fails', [...shell.options, shell.confirm]);
    assert.equal(result.status, 42, result.stdout + result.stderr);
    assert.equal(git('remote'), 'origin');
    assert.equal(git('remote', 'get-url', 'origin'), oldUrl);
    assert.equal(git('remote', 'get-url', '--push', 'origin'), oldPushUrl);
    assert.equal(git('symbolic-ref', '--short', 'HEAD'), 'feature');
  });

  test(`${shell.name} giữ origin nếu GitHub CLI không gắn remote mới`, context => {
    const { git, run } = fixture(context, shell);
    const result = run('remote-missing', [...shell.options, shell.confirm]);
    assert.notEqual(result.status, 0);
    assert.match(result.stderr, /GitHub CLI không gắn remote/);
    assert.equal(git('remote'), 'origin');
    assert.equal(git('remote', 'get-url', 'origin'), oldUrl);
  });

  test(`${shell.name} giữ cấu hình remote cũ và gắn origin mới sau khi tạo thành công`, context => {
    const { git, log, run } = fixture(context, shell);
    const result = run('ok', [...shell.options, shell.confirm]);
    assert.equal(result.status, 0, result.stdout + result.stderr);
    assert.equal(git('remote'), 'origin\ntemplate-origin-backup');
    assert.equal(git('remote', 'get-url', 'origin'), newUrl);
    assert.equal(git('remote', 'get-url', '--push', 'template-origin-backup'), oldPushUrl);
    assert.equal(git('config', 'branch.feature.remote'), 'template-origin-backup');
    assert.equal(git('symbolic-ref', '--short', 'HEAD'), 'feature');
    const calls = readFileSync(log, 'utf8');
    assert.match(calls, /repo create group\/demo --public --source=/);
    assert.doesNotMatch(calls, /--push/);
  });

  test(`${shell.name} gắn origin khi repo chưa có remote`, context => {
    const { git, run } = fixture(context, shell, false);
    const result = run('ok', shell.options);
    assert.equal(result.status, 0, result.stdout + result.stderr);
    assert.equal(git('remote'), 'origin');
    assert.equal(git('remote', 'get-url', 'origin'), newUrl);
  });

  test(`${shell.name} khôi phục origin nếu đổi tên remote mới thất bại`, context => {
    const { git, run } = fixture(context, shell);
    const result = run('rename-fails', [...shell.options, shell.confirm]);
    assert.notEqual(result.status, 0);
    assert.match(result.stderr, /Không gắn được origin mới/);
    assert.equal(git('remote', 'get-url', 'origin'), oldUrl);
    assert.equal(git('remote', 'get-url', 'template-init-target'), newUrl);
    assert.equal(git('config', 'branch.feature.remote'), 'origin');
  });

  test(`${shell.name} dừng trước GitHub khi tên remote dự phòng đã được dùng`, context => {
    const { git, log, run } = fixture(context, shell);
    git('remote', 'add', 'template-origin-backup', newUrl);
    const result = run('ok', [...shell.options, shell.confirm]);
    assert.notEqual(result.status, 0);
    assert.match(result.stderr, /đã tồn tại/);
    assert.equal(git('remote', 'get-url', 'origin'), oldUrl);
    assert.equal(existsSync(log), false);
  });
}
