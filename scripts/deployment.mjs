import { appendFile } from 'node:fs/promises';
import { pathToFileURL } from 'node:url';

export function parseHttpsUrl(value, label) {
  if (typeof value !== 'string' || !/^https:\/\/[^/]/i.test(value)
      || /[\s\p{Cc}\\]/u.test(value)) {
    throw new Error(`${label} phải là URL HTTPS hợp lệ.`);
  }

  let url;
  try {
    url = new URL(value);
  } catch {
    throw new Error(`${label} phải là URL HTTPS hợp lệ.`);
  }
  if (!url.hostname || url.username || url.password) {
    throw new Error(`${label} phải là URL HTTPS không chứa thông tin đăng nhập.`);
  }
  return url;
}

export async function publishDeployment(env, sendRequest = fetch) {
  const url = parseHttpsUrl(env.REQUESTED_URL || env.CONFIGURED_URL, 'URL triển khai');
  if (!env.GITHUB_OUTPUT) {
    throw new Error('Thiếu GITHUB_OUTPUT.');
  }
  if (env.RENDER_DEPLOY_HOOK) {
    const hook = parseHttpsUrl(env.RENDER_DEPLOY_HOOK, 'Render Deploy Hook');
    if (hook.origin !== 'https://api.render.com' || !hook.pathname.startsWith('/deploy/')) {
      throw new Error('Render Deploy Hook phải trỏ đến api.render.com/deploy/.');
    }
    let response;
    try {
      response = await sendRequest(hook, {
        method: 'POST',
        redirect: 'error',
        signal: AbortSignal.timeout(30_000),
      });
    } catch {
      throw new Error('Không gửi được yêu cầu triển khai đến Render.');
    }
    if (response.status !== 200 && response.status !== 202) {
      throw new Error(`Render từ chối yêu cầu triển khai với mã HTTP ${response.status}.`);
    }
  }
  await appendFile(env.GITHUB_OUTPUT, `deploy_url=${url.href}\n`, 'utf8');
}

if (process.argv[1] && import.meta.url === pathToFileURL(process.argv[1]).href) {
  try {
    await publishDeployment(process.env);
  } catch (error) {
    console.error(error.message);
    process.exitCode = 1;
  }
}
