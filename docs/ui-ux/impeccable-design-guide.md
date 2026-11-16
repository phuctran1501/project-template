# Cẩm Nang Tích Hợp Impeccable UI/UX (Impeccable Design Guide)

Tài liệu này hướng dẫn cách áp dụng hệ thống kỹ năng thiết kế **Impeccable** (tham chiếu từ dự án nguồn mở `pbakaus/impeccable`) để biến AI Agent thành một chuyên gia UI/UX cao cấp, tạo ra các sản phẩm giao diện có chiều sâu, thẩm mỹ cao và bài trừ triệt để hiện tượng "AI Design Slop".

---

## 1. Triết Lý Thiết Kế Của Impeccable
Các mô hình AI khi tạo giao diện web thường mắc phải các "dấu hiệu nhận biết AI" (AI Tells) như:
- Tự động dùng font `Inter` cho mọi dự án bất kể lĩnh vực.
- Sử dụng dải màu gradient tím - xanh dương một cách rập khuôn.
- Sử dụng màu nền be xám hoặc xám nhạt thiếu tương phản.
- Lạm dụng việc lồng các thẻ Card bên trong Card (Card nesting) gây rối mắt.
- Bỏ qua các trạng thái biên như văn bản quá dài, tải chậm hoặc lỗi mạng.

**Impeccable** cung cấp bộ từ vựng thiết kế, quy trình kiểm soát chất lượng và các câu lệnh chuyên biệt để khắc phục hoàn toàn những điểm yếu trên.

---

## 2. Bộ Lệnh Thiết Kế Chuyên Biệt (Impeccable Slash Commands)

Khi làm việc với AI Agent (Antigravity/Gemini/Claude), bạn có thể gọi các lệnh sau:

### 1. `/impeccable craft <tên_màn_hình_hoặc_thành_phần>`
- **Mục đích**: Lên kế hoạch và dựng mới một giao diện người dùng độc bản.
- **Hành vi của Agent**: Đọc file [DESIGN.md](DESIGN.md), xác định cấu trúc bố cục, chọn tỷ lệ kiểu chữ và dựng giao diện bám sát bản sắc thương hiệu.

### 2. `/impeccable critique <tên_thành_phần>`
- **Mục đích**: Đánh giá chuyên sâu về trải nghiệm người dùng (UX Review).
- **Hành vi của Agent**: Phân tích phân cấp thị giác (Visual Hierarchy), độ rõ ràng của thông điệp, nhịp điệu khoảng trắng (Whitespace Rhythm) và đưa ra các điểm cần tinh chỉnh.

### 3. `/impeccable audit <tên_file_hoặc_url>`
- **Mục đích**: Kiểm toán kỹ thuật về khả năng tiếp cận (Accessibility WCAG 2.1 AA) và độ phản hồi trên di động (Responsiveness).
- **Hành vi của Agent**: Kiểm tra tỷ lệ tương phản màu sắc (Contrast Ratio tối thiểu 4.5:1), điều hướng bàn phím, nhãn ARIA và bố cục hiển thị trên màn hình nhỏ.

### 4. `/impeccable polish <tên_thành_phần>`
- **Mục đích**: Tinh chỉnh chi tiết thẩm mỹ ở cấp độ từng pixel.
- **Hành vi của Agent**: Cải thiện micro-interactions, chuyển động mượt mà (transitions), viền tinh tế và chiều sâu ánh sáng.

### 5. `/impeccable harden <tên_thành_phần>`
- **Mục đích**: Gia cố các trạng thái biên và chống lỗi hiển thị.
- **Hành vi của Agent**: Kiểm tra hiện tượng tràn chữ (Text overflow / Truncation), trạng thái tải dữ liệu (Loading Skeleton), trạng thái không có dữ liệu (Empty State) và thông báo lỗi kết nối.

---

## 3. Công Cụ Quét Lỗi Thiết Kế Tự Động (Impeccable Detector)

Dự án hỗ trợ chạy công cụ kiểm tra anti-patterns thiết kế mà không cần API key:

```bash
# Quet toan bo thu muc giao dien de tim loi bo cuc va a11y
npx impeccable detect

# Hoac quet truc tiep mot trang web dang chay
npx impeccable detect http://localhost:3000
```

---

## 4. Quy Chuẩn Mã Nguồn Giao Diện Dành Cho Kỹ Sư
- Khi lập trình các component UI (React, Vue, HTML/CSS), mọi chú thích bên trong code phải viết bằng tiếng Việt, tuyệt đối không dùng dấu ngoặc đơn và không dùng biểu tượng cảm xúc.
- Đảm bảo tách biệt giữa tầng logic nghiệp vụ và tầng giao diện trình diễn (Presentation Layer).
