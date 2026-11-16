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

Quy trình được tự động hóa tại file [.github/workflows/deployments.yml](../../.github/workflows/deployments.yml):
1. **Khi push code vào nhánh `main`**:
   - Tự động kích hoạt job `deploy-production`.
   - Đăng ký môi trường `Production` trên GitHub.
   - Gắn kèm đường dẫn URL chính thức của sản phẩm.
2. **Khi mở hoặc cập nhật một Pull Request**:
   - Tự động kích hoạt job `deploy-preview`.
   - Đăng ký môi trường `Preview` trên GitHub kèm đường dẫn xem trước theo số PR.
3. **Kích hoạt thủ công (Workflow Dispatch)**:
   - Bạn có thể vào tab **Actions** -> Chọn **Deployments Management** -> Bấm **Run workflow** -> Dán link demo bất kỳ từ Vercel hoặc Render để cập nhật URL ngay lập tức.

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
2. Vào phần **Settings** của Web Service trên Render -> Kéo xuống mục **Deploy Hook**:
   - Sao chép đường dẫn Deploy Hook (dạng `https://api.render.com/deploy/srv-xxx?key=yyy`).
3. Trong GitHub repo: Vào **Settings** -> **Secrets and variables** -> **Actions** -> Tab **Secrets**:
   - Tạo Secret có tên `RENDER_DEPLOY_HOOK` và dán đường dẫn Deploy Hook vào.
   - Tạo Variable có tên `PRODUCTION_URL` với link web Render (ví dụ: `https://ten-du-an.onrender.com`).
4. Khi push code lên `main`, GitHub Action sẽ tự động gửi tín hiệu kích hoạt Render build và cập nhật trạng thái deployment trên GitHub.

---

## 4. Mẫu Trình Bày Link Demo Vào CV & Hồ Sơ Phỏng Vấn

Khi viết CV hoặc nộp bài test phỏng vấn, bạn có thể trình bày dự án theo cấu trúc:

```text
Dự Án: Nền Tảng Thương Mại Điện Tử Đa Kênh (SaaS)
- Kho mã nguồn: https://github.com/<tai-khoan>/<ten-repo>
- Bản chạy thử nghiệm (Live Demo): https://ten-du-an.vercel.app
- Trạng thái Deployments: Đã cấu hình CI/CD tự động cập nhật môi trường Preview và Production trực tiếp trên GitHub Deployments.
```
