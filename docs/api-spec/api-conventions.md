# Quy Chuẩn Thiết Kế API (RESTful API Conventions)

---

## 1. Cấu Trúc Định Tuyến (URL Conventions)
- Sử dụng danh từ số nhiều, chữ thường dạng kebab-case:
  - `GET /api/v1/users` (Lấy danh sách)
  - `POST /api/v1/users` (Tạo mới)
  - `GET /api/v1/users/{id}` (Xem chi tiết)
  - `PUT /api/v1/users/{id}` (Cập nhật toàn bộ)
  - `PATCH /api/v1/users/{id}` (Cập nhật từng phần)
  - `DELETE /api/v1/users/{id}` (Xóa mềm)
- Tài nguyên con (Nested Resources) tối đa 2 cấp:
  - `GET /api/v1/orders/{order_id}/items`

---

## 2. Chuẩn Hóa Phản Hồi (Response Envelope Format)

### Khi Thành Công (HTTP 200 / 201)
```json
{
  "success": true,
  "data": {
    "id": "e4587c6b-9c71-4876-96a9-8084a7e93dc4",
    "title": "MacBook Pro M3",
    "price": 1999.00
  },
  "meta": {
    "timestamp": "2026-11-15T15:00:00Z"
  }
}
```

### Khi Thất Bại (HTTP 4xx / 5xx)
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_FAILED",
    "message": "Dữ liệu gửi lên không đúng định dạng",
    "details": [
      {
        "field": "email",
        "issue": "Email không hợp lệ"
      }
    ]
  }
}
```

---

## 3. Quy Ước Mã Trạng Thái HTTP (Status Codes)
- `200 OK`: Truy vấn hoặc cập nhật thành công.
- `201 Created`: Tạo mới tài nguyên thành công.
- `204 No Content`: Xóa thành công, không trả nội dung.
- `400 Bad Request`: Lỗi cú pháp request.
- `401 Unauthorized`: Chưa đăng nhập hoặc token hết hạn.
- `403 Forbidden`: Đã đăng nhập nhưng không đủ quyền truy cập.
- `404 Not Found`: Không tìm thấy tài nguyên.
- `409 Conflict`: Xung đột tài nguyên (vd: trùng email).
- `422 Unprocessable Entity`: Dữ liệu vi phạm validation nghiệp vụ.
- `429 Too Many Requests`: Vượt quá giới hạn Rate Limit.
- `500 Internal Server Error`: Lỗi máy chủ chưa được bắt.
