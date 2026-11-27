# Hướng Dẫn Cấu Hình Deployments & Gắn Link Demo Phỏng Vấn (Live Demo & Deployments Guide)

Tài liệu này hướng dẫn cách kết nối và hiển thị tự động hai môi trường **Preview** và **Production** trên thanh widget **Deployments** của GitHub để phục vụ việc gắn link demo khi đi phỏng vấn.

---

## 1. Mục Đích & Giá Trị Khi Đi Phỏng Vấn
- **Tạo ấn tượng chuyên nghiệp**: Khi nhà tuyển dụng hoặc kỹ sư phỏng vấn truy cập vào kho mã nguồn GitHub của bạn, họ sẽ thấy ngay mục **Deployments** ở góc phải màn hình với 2 môi trường:
  - 🟢 **Production**: Bản chạy thật chính thức (Live Demo).
  - 🟡 **Preview**: Bản xem trước các tính năng mới đang thử nghiệm từ Pull Request.
- **Trải nghiệm sản phẩm tức thì**: Nhà tuyển dụng chỉ cần bấm nút "View deployment" là có thể trải nghiệm sản phẩm trực tiếp mà không cần tải code về máy.

---

## 2. Cách Thức Hoạt Động Của Workflow Deployments

Workflow đăng ký URL HTTPS theo cấu hình tại [Deployments Management](../../.github/workflows/deployments.yml).

| Sự kiện | Môi trường | Nguồn URL |
| --- | --- | --- |
| Push lên `main` | Production | Biến repository `PRODUCTION_URL`. Job được bỏ qua nếu biến trống. |
| Mở, mở lại hoặc cập nhật PR | Preview | Biến repository `PREVIEW_URL`. Job được bỏ qua nếu biến trống. |
| Chạy thủ công từ **Actions → Deployments Management → Run workflow** | Môi trường đã chọn. Production yêu cầu nhánh `main`. | `target_url` nếu có, sau đó đến biến repository của môi trường tương ứng. |

URL phải dùng HTTPS, nằm trên một dòng và không chứa thông tin đăng nhập. Workflow báo lỗi nếu cấu hình thủ công thiếu URL hoặc URL sai. Nếu nhà cung cấp tạo URL riêng cho từng PR, lấy URL đã được cấp từ nhà cung cấp rồi đăng ký thủ công hoặc tích hợp đầu ra triển khai của nhà cung cấp.

Preview của PR dùng script từ commit của nhánh đích. Khi nâng cấp một repo đã có `PREVIEW_URL`, tạm bỏ biến này và bật lại sau khi các nhánh đích cần Preview đã có [script triển khai](../../scripts/deployment.mjs).

---

## 3. Các Cách Cấu Hình Link Demo Thực Tế

### Cách 1: Triển khai trên Vercel (Khuyến nghị cho Frontend / Fullstack)
1. Đăng nhập vào [vercel.com](https://vercel.com) và kết nối với repository GitHub của bạn.
2. Vercel sẽ tự động cấp một tên miền dạng `https://ten-du-an.vercel.app`.
3. Trong GitHub repo: Vào **Settings** -> **Secrets and variables** -> **Actions** -> Tab **Variables**:
   - Tạo biến `PRODUCTION_URL` với giá trị là đường dẫn Vercel của bạn (ví dụ: `https://ten-du-an.vercel.app`).
   - Tạo biến `PREVIEW_URL` nếu muốn chỉ định link preview cố định.

### Cách 2: Triển khai trên Render (Khuyến nghị cho Backend / Fullstack / Docker)
1. Đăng nhập vào [render.com](https://render.com), tạo mới một Web Service liên kết với repo.
2. Trong **Settings** của Web Service trên Render, sao chép Deploy Hook. Lưu dưới tên `RENDER_DEPLOY_HOOK` trong **Settings → Environments → Production → Environment secrets** trên GitHub.
3. Tạo biến `PRODUCTION_URL` ở cấp repository tại **Settings → Secrets and variables → Actions → Variables**. Điền URL web do Render cấp, ví dụ `https://ten-du-an.onrender.com`.
4. Job Production gửi yêu cầu đến Render và chỉ ghi URL vào Deployment khi Render trả HTTP 200 hoặc 202. Các mã này cho biết Render đã nhận yêu cầu. Kiểm tra Dashboard Render để xác nhận bản mới đã chạy. [Tài liệu Deploy Hooks của Render](https://render.com/docs/deploy-hooks)

Giới hạn Environment Production vào nhánh `main` trong GitHub. Deploy chạy độc lập với Template CI trên mỗi lần push. Bật các kiểm tra bắt buộc của Template CI trong quy tắc bảo vệ nhánh để chặn PR chưa đạt trước khi merge.

---

## 4. Mẫu Trình Bày Link Demo Vào CV & Hồ Sơ Phỏng Vấn

Khi viết CV hoặc nộp bài test phỏng vấn, bạn có thể trình bày dự án theo cấu trúc:

```text
Dự Án: Nền Tảng Thương Mại Điện Tử Đa Kênh (SaaS)
- Kho mã nguồn: https://github.com/<tai-khoan>/<ten-repo>
- Bản chạy thử nghiệm (Live Demo): https://ten-du-an.vercel.app
- Trạng thái Deployments: Đã cấu hình CI/CD tự động cập nhật môi trường Preview và Production trực tiếp trên GitHub Deployments.
```
