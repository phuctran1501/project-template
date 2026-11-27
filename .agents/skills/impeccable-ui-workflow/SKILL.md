---
name: impeccable-ui-workflow
description: >-
  Thiết kế, xây dựng và kiểm toán giao diện người dùng độc bản theo tiêu chuẩn
  Impeccable (pbakaus/impeccable), chống các lối mòn thiết kế AI rập khuôn và
  đảm bảo chuẩn tiếp cận WCAG 2.1 AA. Sử dụng khi tạo mới hoặc chỉnh sửa trang
  web, màn hình ứng dụng, component UI, CSS/Design Tokens, hoặc khi thực hiện
  craft, critique, audit, polish, harden giao diện.
---

# Thiết Kế & Kiểm Toán Giao Diện Chuẩn Impeccable

Quy trình đảm bảo mọi giao diện Frontend được tạo ra đều mang bản sắc riêng của dự án, có chiều sâu thị giác và trải nghiệm tương tác hoàn chỉnh.

## Khi Nào Sử Dụng

- Tạo mới hoặc nâng cấp màn hình, trang đích, bảng điều khiển, biểu mẫu hoặc hệ thống component UI.
- Thiết lập hoặc chỉnh sửa Design Tokens, bảng màu, hệ thống kiểu chữ, responsive layout.
- Người dùng yêu cầu đánh giá UX (`critique`), kiểm toán khả năng tiếp cận (`audit`), trau chuốt chi tiết (`polish`) hoặc kiểm thử sức chịu đựng giao diện (`harden`).

## Quy Trình Thực Hiện

### Bước 1: Xác thực Bản sắc Thiết kế (Design Context Check)
1. Đọc [DESIGN.md](../../../docs/ui-ux/DESIGN.md), [design-tokens-template.md](../../../docs/ui-ux/design-tokens-template.md) và [impeccable-design-guide.md](../../../docs/ui-ux/impeccable-design-guide.md).
2. Nếu các mục cốt lõi trong `DESIGN.md` (tính cách thương hiệu, font chữ, bảng màu) vẫn còn là chuỗi giữ chỗ `[...]`, **dừng lại hỏi người dùng xác nhận trước** — không tự ý chọn bảng màu hay kiểu chữ mặc định.

### Bước 2: Dựng Giao diện Độc bản (`craft`)
*(Có thể thực hiện trực tiếp hoặc ủy quyền cho subagent `ui-ux-designer`)*
1. **Triệt tiêu dấu hiệu AI rập khuôn (Anti-AI Tells)**:
   - Không dùng dải màu gradient tím-xanh sáo rỗng, bóng đổ neon lòe loẹt hoặc bố cục 3 cột icon lặp đi lặp lại không phục vụ nội dung.
   - Không lồng khung thẻ (`card` trong `card`) quá 2 cấp; ưu tiên phân tách bằng khoảng trắng có nhịp điệu và đường viền mảnh tinh tế.
   - Mọi mã màu, khoảng cách, cỡ chữ và bo góc phải tham chiếu qua biến CSS / Design Tokens đã khai báo.
2. **Hoàn thiện đủ 5 trạng thái giao diện**:
   - `Loading`: Khung xương (Skeleton) đồng bộ bố cục, tránh giật khung hình (CLS).
   - `Empty`: Trạng thái trống rõ ràng kèm nút hành động gợi ý bước tiếp theo.
   - `Error`: Thông báo lỗi cụ thể bằng ngôn ngữ người dùng kèm hướng khắc phục/thử lại.
   - `Default` & `Ideal / Overflow`: Hiển thị tốt cả khi ít dữ liệu lẫn khi tên dài, danh sách nhiều phần tử (`text-ellipsis`, phân trang hoặc cuộn mượt).
3. **Quy chuẩn chú thích mã nguồn giao diện**:
   - Mọi chú thích trong HTML, CSS, SCSS, TSX, JSX, Vue, Svelte phải viết hoàn toàn bằng tiếng Việt, không dùng dấu ngoặc đơn `()` và không dùng icon.

### Bước 3: Kiểm toán Kỹ thuật & Tinh chỉnh (`critique` -> `audit` -> `polish` -> `harden`)
1. **Chuẩn tiếp cận (WCAG 2.1 AA)**:
   - Độ tương phản chữ thường tối thiểu `4.5:1`, chữ lớn tối thiểu `3:1`.
   - Hỗ trợ điều hướng bàn phím hoàn chỉnh (`Tab`, `Shift+Tab`, `Enter`, `Escape`), trạng thái `:focus-visible` rõ nét, đầy đủ thẻ HTML ngữ nghĩa và thuộc tính `aria-*` cho nút chỉ có biểu tượng.
2. **Đa kích thước màn hình (Responsive)**:
   - Đảm bảo không tràn ngang và thao tác chạm tối thiểu `44x44px` trên di động (`375px`), máy tính bảng (`768px`) và máy tính để bàn (`1280px+`).
3. **Kiểm chứng thực tế**:
   - Nếu dự án có môi trường Node.js và cài đặt gói kiểm tra, chạy `npx impeccable detect` để quét tự động các lỗi bố cục/tiếp cận (nếu chưa cài đặt hoặc sandbox không có mạng, ghi nhận `Impeccable CLI: NOT RUN`).
   - Nếu máy chủ phát triển Frontend đang chạy, ủy quyền cho subagent `browser` mở URL cục bộ để kiểm tra trực quan trên trình duyệt thật.
