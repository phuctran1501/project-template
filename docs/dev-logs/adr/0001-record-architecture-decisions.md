# ADR-0001: Sử Dụng Kiến Trúc ADR Để Quản Lý Mọi Quyết Định Kỹ Thuật

**Mã ADR**: `ADR-0001`  
**Tiêu đề**: Áp dụng Architecture Decision Records (ADR) trong toàn bộ vòng đời dự án  
**Trạng thái**: Chấp thuận (Accepted)  
**Ngày quyết định**: 2026-11-15  
**Người quyết định**: Tech Lead & AI Agent Harness  

---

## 1. Bối Cảnh (Context)
Trong quá trình phát triển dự án với sự tham gia của cả con người và các AI Agents (Antigravity/Gemini/Claude), các quyết định kỹ thuật quan trọng (lựa chọn ngôn ngữ, kiến trúc CSDL, giải pháp caching, mô hình AI) thường dễ bị lãng quên hoặc thiếu lý do giải thích rõ ràng nếu chỉ trao đổi qua chat hoặc commit message ngắn.

---

## 2. Quyết Định Được Chọn (Decision)
Mọi quyết định kỹ thuật có tầm ảnh hưởng lớn (kiến trúc, thư viện cốt lõi, thay đổi mô hình dữ liệu) bắt buộc phải được ghi nhận dưới dạng file markdown tuần tự (`0002-...`, `0003-...`) trong thư mục `docs/dev-logs/adr/` dựa theo mẫu `adr-template.md`.

---

## 3. Hệ Quả (Consequences)
- **Tích cực**:
  - Minh bạch hóa toàn bộ lịch sử tư duy kiến trúc của dự án.
  - Các AI Agent mới khi gia nhập dự án có thể đọc thư mục `adr/` để hiểu ngay các nguyên tắc không được vi phạm.
- **Tiêu cực**:
  - Tốn thêm một bước viết tài liệu ngắn (khoảng 3-5 phút) khi đưa ra quyết định mới.
