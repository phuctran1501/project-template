# Khai Báo Bảng Mã Thiết Kế (Design Tokens Template)

> **DÀNH CHO DESIGNER / USER / TECH LEAD**:  
> Vui lòng điền mã màu, phông chữ và thông số UI mong muốn cho dự án của bạn tại đây. AI Agent sẽ dựa vào bảng này để sinh CSS/Tailwind config, tuyệt đối không tự bịa bảng màu khác.

---

## 1. Bảng Màu Thương Hiệu & Giao Diện (Color Palette)

| Loại Màu | Tên Token | Mã Hex / HSL Mẫu | Giá Trị Dự Án Chọn | Mục Đích Sử Dụng |
| :--- | :--- | :--- | :--- | :--- |
| **Primary** | `--color-primary` | `#2563EB` (Blue 600) | `[Điền mã màu]` | Nút chính, CTA, liên kết nổi bật |
| **Primary Hover** | `--color-primary-hover`| `#1D4ED8` (Blue 700) | `[Điền mã màu]` | Trạng thái hover của nút chính |
| **Secondary** | `--color-secondary` | `#475569` (Slate 600)| `[Điền mã màu]` | Nút phụ, badge, thành phần thứ cấp |
| **Background** | `--color-bg-base` | `#FFFFFF` | `[Điền mã màu]` | Nền trang tổng thể (Light Mode) |
| **Surface** | `--color-bg-surface` | `#F8FAFC` | `[Điền mã màu]` | Nền card, modal, sidebar |
| **Text Primary**| `--color-text-main` | `#0F172A` | `[Điền mã màu]` | Văn bản chính, tiêu đề |
| **Text Muted** | `--color-text-muted` | `#64748B` | `[Điền mã màu]` | Chữ phụ, placeholder, chú thích |
| **Success** | `--color-success` | `#16A34A` (Green 600)| `[Điền mã màu]` | Thông báo thành công, trạng thái Active |
| **Warning** | `--color-warning` | `#D97706` (Amber 600)| `[Điền mã màu]` | Cảnh báo, trạng thái Pending |
| **Danger** | `--color-danger` | `#DC2626` (Red 600) | `[Điền mã màu]` | Lỗi, nút xóa, trạng thái Failed |

---

## 2. Kiểu Chữ (Typography)
- **Font Gia Đình (Font Family - Primary)**: `[Ví dụ: 'Inter', system-ui, -apple-system, sans-serif]`
- **Font Gia Đình (Monospace / Code)**: `[Ví dụ: 'JetBrains Mono', 'Fira Code', monospace]`
- **Cỡ chữ chuẩn (Font Sizes)**:
  - `text-xs`: `0.75rem (12px)`
  - `text-sm`: `0.875rem (14px)`
  - `text-base`: `1.0rem (16px)` - Body text mặc định
  - `text-lg`: `1.125rem (18px)`
  - `text-xl`: `1.25rem (20px)`
  - `text-2xl`: `1.5rem (24px)` - Tiêu đề phụ (H2)
  - `text-3xl`: `1.875rem (30px)` - Tiêu đề chính (H1)

---

## 3. Khoảng Cách & Bo Góc (Spacing & Border Radius)
- **Bo góc (Border Radius)**:
  - `--radius-sm`: `4px`
  - `--radius-md`: `8px` (Thẻ Card, Input form)
  - `--radius-lg`: `12px` (Modal, Dialog)
  - `--radius-full`: `9999px` (Avatar, Pill badge)
- **Khoảng cách cơ sở**: Hệ số `4px` (4px, 8px, 12px, 16px, 24px, 32px, 48px, 64px).

---

## 4. Chế Độ Tối (Dark Mode Support)
- Dự án có hỗ trợ Dark Mode không?: `[Có / Không]`
- Nếu có, phương thức kích hoạt: `[class="dark" trên thẻ html / media query]`
