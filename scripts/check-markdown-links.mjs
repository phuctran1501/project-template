import { execFileSync } from 'node:child_process';
import { existsSync, readFileSync } from 'node:fs';
import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

const root = fileURLToPath(new URL('../', import.meta.url));
const markdownFiles = execFileSync('git', ['ls-files', '-z', '--cached', '--others', '--exclude-standard'], {
  cwd: root,
  encoding: 'utf8',
}).split('\0').filter(file => file.endsWith('.md') && existsSync(resolve(root, file)));

let checked = 0;
for (const file of new Set(markdownFiles)) {
  const content = readFileSync(resolve(root, file), 'utf8')
    .replace(/^(`{3,}|~{3,})[^\n]*\n[\s\S]*?^\1[^\S\r\n]*\r?$/gm, '');
  const links = content.matchAll(/!?\[[^\]\r\n]+\]\(\s*(?:<([^<>\r\n]+)>|([^\s)]+))/g);
  for (const [, angleTarget, bareTarget] of links) {
    const target = angleTarget ?? bareTarget;
    if (/^(?:[\w+.-]+:|#|\/\/)/.test(target)) continue;
    checked += 1;
    const location = target.split(/[?#]/, 1)[0];
    let destination;
    try {
      destination = location.startsWith('/')
        ? resolve(root, decodeURIComponent(location.slice(1)))
        : resolve(root, dirname(file), decodeURIComponent(location));
    } catch {
      console.error(`${file} -> ${target}: mã hóa URL không hợp lệ`);
      process.exitCode = 1;
      continue;
    }
    if (!existsSync(destination)) {
      console.error(`${file} -> ${target}: không tìm thấy đích`);
      process.exitCode = 1;
    }
  }
}
console.log(`Đã kiểm tra ${checked} liên kết Markdown nội bộ.`);
