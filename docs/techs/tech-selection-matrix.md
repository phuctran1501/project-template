# Ma Trận Đánh Giá & So Sánh Công Nghệ (Tech Selection Matrix)

Tài liệu này cung cấp khung so sánh ưu và nhược điểm của các phương án theo nhu cầu dự án.

---

## 1. So Sánh Backend Frameworks

| Tiêu Chí | Node.js (NestJS / Fastify) | Python (FastAPI) | Golang (Gin / Fiber) | .NET 8 (Web API) |
| :--- | :--- | :--- | :--- | :--- |
| **Tốc độ phát triển (Time-to-Market)** | Rất nhanh (Dùng chung TS với FE) | Cực nhanh, cú pháp gọn | Nhanh, cú pháp đơn giản | Trung bình (cần setup boilerplate) |
| **Hiệu năng & Thông lượng (Throughput)** | Tốt (Asynchronous event-loop) | Khá (Asynchronous qua asyncio) | Cực cao, tiêu tốn rất ít RAM | Rất cao, tối ưu runtime JIT |
| **Tích hợp AI / Data Science** | Tốt qua SDKs | Xuất sắc (Thư viện AI gốc) | Khá (gọi API ngoài) | Khá (Semantic Kernel) |
| **Hệ sinh thái thư viện** | Đồ sộ nhất (npm) | Rất phong phú (PyPI) | Vừa đủ, tập trung chuẩn | Rất mạnh mảng doanh nghiệp (NuGet) |
| **Phù hợp nhất cho** | Web App đa chức năng, MVP | AI-Native apps, Data Pipeline | Microservices chịu tải cao | Ứng dụng doanh nghiệp lớn |

---

## 2. So Sánh Frontend Frameworks

| Tiêu Chí | Next.js (React) | Nuxt.js (Vue 3) | SvelteKit |
| :--- | :--- | :--- | :--- |
| **Độ phổ biến & Tuyển dụng** | Số 1 thị trường | Rất phổ biến, cộng đồng mạnh | Đang tăng trưởng nhanh |
| **Trải nghiệm lập trình (DX)** | Phong phú nhưng App Router phức tạp | Cực kỳ mượt mà, cấu trúc trực quan | Code ngắn nhất, không virtual DOM |
| **Hỗ trợ SSR / SSG / SEO** | Toàn diện | Toàn diện | Toàn diện |
| **Hệ thống UI Component có sẵn** | Phong phú nhất (shadcn/ui, Radix) | Rất tốt (Nuxt UI, Vuetify) | Khá (shadcn-svelte, Melt UI) |

---

## 3. So Sánh Cơ Sở Dữ Liệu (Databases)

| Tiêu Chí | PostgreSQL | MySQL | MongoDB |
| :--- | :--- | :--- | :--- |
| **Loại hình** | Quan hệ (RDBMS) + Hỗ trợ JSONB & Vector | Quan hệ (RDBMS) | Tài liệu phi quan hệ (Document NoSQL) |
| **Tính toàn vẹn (ACID)** | Rất nghiêm ngặt | Tốt (InnoDB) | Tốt ở cấp độ Document, hỗ trợ multi-doc |
| **Độ linh hoạt dữ liệu** | Rất cao (Hybrid SQL + NoSQL + pgvector) | Trung bình | Cực cao (Schema-less) |
| **Tìm kiếm ngữ nghĩa (AI Embeddings)** | Hỗ trợ qua `pgvector` cực mạnh | Chưa hỗ trợ sâu | Hỗ trợ qua Atlas Vector Search |
