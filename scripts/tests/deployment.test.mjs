import assert from 'node:assert/strict';
import { mkdtemp, readFile, rm } from 'node:fs/promises';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import test from 'node:test';
import { parseHttpsUrl, publishDeployment } from '../deployment.mjs';

async function deploymentEnv(context, values = {}) {
  const directory = await mkdtemp(join(tmpdir(), 'template-deploy-'));
  context.after(() => rm(directory, { recursive: true, force: true }));
  return {
    CONFIGURED_URL: 'https://demo.example.com/',
    GITHUB_OUTPUT: join(directory, 'output'),
    ...values,
  };
}

test('URL triển khai phải dùng HTTPS và chỉ có một dòng', () => {
  for (const value of ['', 'http://demo.example.com', 'https:///demo.example.com',
    'https://user:pass@demo.example.com', 'https://demo.example.com/\nother=value',
    'https://demo.example.com\\preview']) {
    assert.throws(() => parseHttpsUrl(value, 'URL'), /URL HTTPS/);
  }
});

test('URL thủ công được ưu tiên và Preview không gọi webhook', async context => {
  const env = await deploymentEnv(context, { REQUESTED_URL: 'https://preview.example.com/path' });
  await publishDeployment(env, () => assert.fail('Preview đã gọi webhook'));
  assert.equal(await readFile(env.GITHUB_OUTPUT, 'utf8'),
    'deploy_url=https://preview.example.com/path\n');
});

test('Render trả 200 hoặc 202 thì ghi URL triển khai', async context => {
  for (const status of [200, 202]) {
    const env = await deploymentEnv(context, {
      RENDER_DEPLOY_HOOK: 'https://api.render.com/deploy/srv-demo?key=example',
    });
    await publishDeployment(env, async (url, options) => {
      assert.equal(url.hostname, 'api.render.com');
      assert.equal(options.method, 'POST');
      assert.equal(options.redirect, 'error');
      assert.ok(options.signal instanceof AbortSignal);
      return { status };
    });
    assert.equal(await readFile(env.GITHUB_OUTPUT, 'utf8'), 'deploy_url=https://demo.example.com/\n');
  }
});

test('Render từ chối hoặc lỗi mạng thì không ghi URL thành công', async context => {
  const env = await deploymentEnv(context, {
    RENDER_DEPLOY_HOOK: 'https://api.render.com/deploy/srv-demo?key=example',
  });
  for (const status of [302, 403, 500]) {
    await assert.rejects(publishDeployment(env, async () => ({ status })), new RegExp(`HTTP ${status}`));
  }
  await assert.rejects(publishDeployment(env, async () => {
    throw new Error('Dữ liệu từ dịch vụ');
  }), /Không gửi được yêu cầu/);
  await assert.rejects(readFile(env.GITHUB_OUTPUT), { code: 'ENOENT' });
});

test('URL sai hoặc hook ngoài Render dừng trước khi gọi mạng', async context => {
  const env = await deploymentEnv(context, {
    RENDER_DEPLOY_HOOK: 'https://other.example.com/deploy/srv-demo',
  });
  const unexpected = () => assert.fail('Đã gọi mạng với cấu hình sai');
  await assert.rejects(publishDeployment(env, unexpected), /api.render.com/);
  await assert.rejects(publishDeployment({ ...env, REQUESTED_URL: 'http://demo.example.com' },
    unexpected), /URL HTTPS/);
  await assert.rejects(readFile(env.GITHUB_OUTPUT), { code: 'ENOENT' });
});
