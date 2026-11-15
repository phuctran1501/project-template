# Tài Liệu Kiến Trúc Hệ Thống (System Architecture Document)

*Tài liệu này mô tả cấu trúc kỹ thuật tổng thể của hệ thống. Hãy cập nhật sau khi đã chốt Tech Stack tại `docs/techs/decision-checklist.md`.*

---

## 1. Phong Cách Kiến Trúc Đã Chọn (Architectural Style)
- **Kiến trúc áp dụng**: `[Modular Monolith / Clean Architecture / Microservices / Event-Driven]`
- **Lý do lựa chọn**: `[Giải thích ngắn gọn lý do phù hợp với bài toán]`

---

## 2. Mô Hình Phân Tầng (Layered Architecture Breakdown)

Nếu áp dụng Clean / Onion Architecture:
```text
┌─────────────────────────────────────────────────────────┐
│ 1. Presentation / API Layer (Controllers, Middlewares)  │
├─────────────────────────────────────────────────────────┤
│ 2. Application / Use Case Layer (Commands, Queries, DTO)│
├─────────────────────────────────────────────────────────┤
│ 3. Domain Core Layer (Entities, Value Objects, Logic)   │
├─────────────────────────────────────────────────────────┤
│ 4. Infrastructure Layer (DB Repositories, Third-parties)│
└─────────────────────────────────────────────────────────┘
```

### Nguyên tắc phụ thuộc (Dependency Rule):
- Tầng Domain Core là trung tâm, **tuyệt đối không phụ thuộc** vào framework, ORM hay cơ sở dữ liệu bên ngoài.
- Tầng ngoài cùng (Infrastructure & Presentation) giao tiếp với Domain thông qua các Interfaces/Ports.

---

## 3. Ranh Giới Module & Miền Nghiệp Vụ (Module Boundaries)

| Module / Bounded Context | Trách Nhiệm Nghiệp Vụ | Dữ Liệu Sở Hữu | Cách Giao Tiếp Liên Module |
| :--- | :--- | :--- | :--- |
| `Auth & Identity` | Xác thực, phân quyền, token management | `Users`, `Roles`, `Permissions` | Direct Service Call / JWT Claims |
| `Core Business` | Nghiệp vụ cốt lõi của ứng dụng | Các bảng nghiệp vụ chính | In-memory Bus / Domain Events |
| `Notification` | Gửi Email, SMS, Push notifications | `NotificationLogs`, `Templates` | Event Queue (Async) |
| `AI / Analytics` | Xử lý dữ liệu thông minh, gọi LLM | Cache kết quả, Audit prompt | Background Job / Worker |

---

## 4. Cơ Chế Bảo Mật & Xác Thực (Security & Auth Architecture)
- **Xác thực**: JWT (JSON Web Tokens) với Access Token (ngắn hạn: 15 phút) và Refresh Token (dài hạn: 7-30 ngày lưu httpOnly cookie).
- **Phân quyền**: Role-Based Access Control (RBAC) hoặc Attribute-Based Access Control (ABAC).
- **Mã hóa**: TLS 1.3 cho truyền tải, AES-256 cho dữ liệu nhạy cảm lưu trong CSDL, Bcrypt/Argon2id cho mật khẩu.
