# Bảng Khảo Sát & Chốt Quyết Định Công Nghệ (Tech Stack Decision Checklist)

> **DÀNH CHO NGƯỜI DÙNG & TECH LEAD**:  
> Ghi lựa chọn đã được phê duyệt và dùng bảng này làm căn cứ để triển khai mã, CI/CD và kiểm thử.

---

## 1. Kiến Trúc Tổng Thể (Overall Architecture)
- [ ] **Monolithic**: Đơn khối (Modular Monolith) - Đơn giản, dễ deploy, phù hợp MVP.
- [ ] **Microservices**: Đa dịch vụ độc lập - Thích hợp khi chia tách nhiều team.
- [ ] **Serverless / Edge**: AWS Lambda, Cloudflare Workers, Vercel Serverless.
- [ ] Khác: `[Ghi rõ nếu có]`

---

## 2. Lựa Chọn Backend & Ngôn Ngữ
- [ ] **TypeScript / Node.js**: (NestJS / Express / Fastify / Hono) -> Đã chọn: `[Điền framework]`
- [ ] **Python**: (FastAPI / Django / Flask) -> Đã chọn: `[Điền framework]`
- [ ] **Golang**: (Gin / Fiber / Echo) -> Đã chọn: `[Điền framework]`
- [ ] **C# / .NET**: (.NET 8 Web API / Clean Architecture)
- [ ] **Rust**: (Axum / Actix-web)
- [ ] Khác: `[Điền nếu có]`

---

## 3. Lựa Chọn Frontend & Mobile
- [ ] **React / Next.js**: (App Router / Pages Router)
- [ ] **Vue / Nuxt.js**: (Vue 3 Composition API)
- [ ] **Svelte / SvelteKit**
- [ ] **Mobile**: (Flutter / React Native / Native Swift/Kotlin)
- [ ] **Chỉ làm API/Backend** (Không có Frontend Web)

---

## 4. Lựa Chọn Cơ Sở Dữ Liệu & Lưu Trữ (Database & Storage)
- [ ] **Relational DB (SQL)**: PostgreSQL / MySQL / SQLite / SQL Server -> Đã chọn: `[...]`
- [ ] **NoSQL / Document**: MongoDB / DynamoDB -> Đã chọn: `[...]`
- [ ] **Caching & In-memory**: Redis / Valkey / Memcached -> Đã chọn: `[...]`
- [ ] **Object Storage**: S3 / Cloudflare R2 / MinIO -> Đã chọn: `[...]`
- [ ] **Message Queue / Event Stream**: RabbitMQ / Kafka / Redis Streams / SQS -> Đã chọn: `[...]`

---

## 5. Môi Trường Triển Khai & DevOps (Deployment & Hosting)
- [ ] **Containerization**: Docker & Docker Compose
- [ ] **Cloud Provider**: AWS / GCP / Azure / DigitalOcean / Hetzner
- [ ] **PaaS / Serverless**: Vercel / Railway / Render / Fly.io
- [ ] **CI/CD Platform**: GitHub Actions (Mặc định có template) / GitLab CI

---

## 6. Xác Nhận Của Tech Lead
- **Ngày phê duyệt**: `[YYYY-MM-DD]`
- **Người phê duyệt**: `[Tên người dùng / Tech Lead]`
- **Ghi chú bổ sung**: `[Những ràng buộc đặc thù khác nếu có]`
