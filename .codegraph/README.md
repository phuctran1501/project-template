# Hướng Dẫn Sử Dụng CodeGraph

Thư mục `.codegraph/` là nơi lưu trữ chỉ mục (index) và cấu hình đồ thị mã nguồn (CodeGraph) của dự án.

## 1. Mục Đích Cho AI Agent
- Giúp AI Agent hiểu chính xác mối quan hệ giữa các hàm, lớp, module và các bước nhảy dispatch động (dynamic dispatch) mà lệnh `grep` hay `find` thông thường không thể nhận biết.
- Giảm thiểu việc đọc toàn bộ file không cần thiết, tiết kiệm token context window.

## 2. Cách Tra Cứu

### Cách 1: Sử dụng Công cụ MCP (Ưu tiên)
Khi MCP `codegraph` được kích hoạt, Agent gọi trực tiếp tool `codegraph_explore`:
```json
{
  "query": "Tìm hàm xử lý thanh toán và các hàm gọi đến nó"
}
```

### Cách 2: Sử dụng Dòng Lệnh Terminal
Chạy lệnh shell bất kỳ lúc nào:
```bash
codegraph explore "<tên_symbol hoặc câu hỏi tra cứu>"
```

## 3. Tạo / Cập Nhật Lại Chỉ Mục (Re-indexing)
Khi dự án có nhiều file mã nguồn mới được thêm vào, chạy:
```bash
codegraph index .
```
Lưu ý: Chỉ mục được sinh tự động và cấu hình qua `config.json`.
