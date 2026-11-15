# Danh Mục Rà Soát Bảo Mật Ứng Dụng (Application Security Checklist)

*Dựa trên tiêu chuẩn OWASP Top 10 và các quy chuẩn an toàn dữ liệu công nghiệp.*

---

## 1. Xác Thực & Phân Quyền (Authentication & Authorization)
- [ ] Mật khẩu người dùng được băm bằng thuật toán an toàn (Argon2id, Bcrypt với cost factor >= 12).
- [ ] JWT Secret Key có độ dài tối thiểu 256-bit, được lưu an toàn trong biến môi trường, không commit vào Git.
- [ ] Triển khai cơ chế kiểm tra quyền truy cập ở cấp độ đối tượng (Chống lỗ hổng IDOR - BOLA): Kiểm tra xem `current_user.id == resource.user_id` trước khi trả dữ liệu hoặc cho phép chỉnh sửa.
- [ ] Đặt cờ bảo mật cho Session Cookies: `HttpOnly; Secure; SameSite=Strict / Lax`.

---

## 2. Kiểm Soát Dữ Liệu Đầu Vào & Chống Tấn Công (Input Validation & Injection Prevention)
- [ ] **SQL Injection**: 100% truy vấn CSDL phải dùng Parameterized Queries hoặc ORM chuẩn, tuyệt đối không nối chuỗi thô (`raw string concatenation`).
- [ ] **Cross-Site Scripting (XSS)**: Dữ liệu do người dùng nhập được sanitize hoặc escape trước khi hiển thị trên giao diện; thiết lập Header `Content-Security-Policy (CSP)`.
- [ ] **Cross-Site Request Forgery (CSRF)**: Sử dụng CSRF Token cho các endpoint dùng Cookie-based Authentication.
- [ ] **Input Sanitization**: Sử dụng thư viện validation schema mạnh (Zod, Pydantic, FluentValidation) để ép kiểu chặt chẽ dữ liệu request body.

---

## 3. Quản Lý Bí Mật & Hạ Tầng (Secrets & Infrastructure Security)
- [ ] Không có API Key, Database Credentials, Token hoặc chứng chỉ SSL/TLS nào nằm trong mã nguồn.
- [ ] Sử dụng công cụ tự động quét secret (`git-secrets`, `trufflehog`, `gitleaks`) trong pipeline CI.
- [ ] Giới hạn tần suất gọi API (Rate Limiting) trên tất cả các public endpoints (đặc biệt là `/auth/login`, `/auth/forgot-password`).
- [ ] Cấu hình các HTTP Security Headers thiết yếu:
  - `X-Frame-Options: DENY`
  - `X-Content-Type-Options: nosniff`
  - `Strict-Transport-Security: max-age=31536000; includeSubDomains`
