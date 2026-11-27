import { spawnSync } from 'node:child_process';
import { existsSync } from 'node:fs';
import { fileURLToPath } from 'node:url';

const cwd = fileURLToPath(new URL('../', import.meta.url));
const run = (command, ...args) => spawnSync(command, args, { cwd, encoding: 'utf8', timeout: 5000 });

const nodeReady = Number(process.versions.node.split('.')[0]) >= 22;
const gitReady = run('git', 'rev-parse', '--is-inside-work-tree').stdout?.trim() === 'true';
console.log(`${nodeReady ? 'PASS' : 'FAIL'} Node.js ${process.versions.node}, yêu cầu từ 22`);
console.log(`${gitReady ? 'PASS' : 'FAIL'} Git working tree`);
const githubCli = run('gh', '--version');
console.log(githubCli.status === 0
  ? `PASS ${githubCli.stdout.trim().split(/\r?\n/, 1)[0]}`
  : 'NOT RUN gh: không gọi được CLI tùy chọn');

if (!existsSync(new URL('../.codegraph/codegraph.db', import.meta.url))) {
  console.log('NOT RUN CodeGraph: chưa có index. Tra cứu bằng rg hoặc đọc file.');
} else if (run('codegraph', 'status').status === 0) {
  console.log('PASS CodeGraph: CLI đọc được index.');
} else {
  console.log('NOT RUN CodeGraph: CLI chưa đọc được index. Thử MCP hoặc tra cứu bằng rg.');
}

if (!nodeReady || !gitReady) process.exitCode = 1;
