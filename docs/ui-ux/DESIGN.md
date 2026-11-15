# Bản Đặc Tả Ngôn Ngữ Thiết Kế (Impeccable DESIGN.md)

*Bản đặc tả ngôn ngữ thiết kế theo chuẩn Impeccable (pbakaus/impeccable) giúp AI Agent duy trì bản sắc thương hiệu nhất quán qua các phiên làm việc và chống lại các lỗi thiết kế AI rập khuôn (AI slop).*

---

## 1. Bản Sắc & Tính Cách Thương Hiệu (Brand Personality & Tone)
- **Tên dự án**: `[Điền tên sản phẩm]`
- **Ngữ điệu & Cảm xúc (Voice & Tone)**: `[Ví dụ: Chuyên nghiệp, Tối giản, Đậm chất kỹ thuật, Hiện đại, Thân thiện]`
- **Nguyên tắc thẩm mỹ**:
  - Không sử dụng các mẫu thiết kế AI sáo rỗng: Tránh nền màu be xám nhợt nhạt, tránh gradient tím xanh xuất hiện tràn lan, tránh lồng card bên trong card không cần thiết.
  - Tạo điểm nhấn thị giác độc bản: Chọn một màu nhấn (Accent) khác biệt, tạo tương phản sắc nét giữa tiêu đề và văn bản nội dung.

---

## 2. Thang Đo Kiểu Chữ (Typographic Hierarchy)
- **Phông chữ tiêu đề (Heading Font)**: `[Ví dụ: Plus Jakarta Sans / Cabinet Grotesk / Syne / Manrope - tránh dùng Inter mặc định cho mọi vị trí]`
- **Phông chữ nội dung (Body Font)**: `[Ví dụ: Outfit / Satoshi / DM Sans / Geist]`
- **Phông chữ mã nguồn (Code Font)**: `[Ví dụ: JetBrains Mono / Fira Code]`
- **Tỷ lệ bước nhảy kích cỡ (Scale)**:
  - Display: `3rem / 48px - Đậm nét, khoảng cách dòng chặt`
  - H1: `2.25rem / 36px - Điểm nhấn chính trang`
  - H2: `1.5rem / 24px - Phân đoạn nội dung`
  - Body: `1rem / 16px - Khoảng cách dòng 1.6 để dễ đọc`
  - Caption: `0.75rem / 12px - Chữ chú thích phụ trợ`

---

## 3. Ý Đồ Bảng Màu & Ánh Sáng (Palette Intent & Elevation)
*Tham chiếu mã màu cụ thể tại [docs/ui-ux/design-tokens-template.md](file:///docs/ui-ux/design-tokens-template.md)*
- **Màu nền chủ đạo**: `[Xác định Light Mode và Dark Mode tương phản rõ ràng]`
- **Độ sâu thị giác (Elevation & Shadow)**:
  - Thay vì dùng bóng đổ mờ nhạt trải rộng, sử dụng viền mỏng 1px tinh tế kết hợp bóng đổ khuếch tán nhẹ.
  - Phân tầng bề mặt rõ ràng: Nền trang -> Nền thẻ bề mặt -> Lớp nổi Modal.

---

## 4. Chữ Ký Thành Phần Giao Diện (Component Signatures)
- **Nút bấm chính (Primary Button)**:
  - Bo góc vừa phải (6px hoặc 8px).
  - Có hiệu ứng viền sáng nhẹ hoặc micro-interaction khi di chuột (hover scale 1.02 hoặc biến đổi độ sáng).
- **Thẻ nội dung (Cards)**:
  - Tránh lồng quá nhiều card con bên trong card cha.
  - Dùng khoảng trắng (White space) và vách ngăn mỏng thay cho các khối hộp dày đặc.
- **Biểu mẫu nhập liệu (Input Fields)**:
  - Trạng thái Focus có viền sáng rõ ràng chuẩn trợ năng WCAG.
  - Thông báo lỗi hiển thị ngay dưới ô nhập liệu với màu sắc và thông điệp cụ thể.
