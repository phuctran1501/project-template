# Bảng Kế Hoạch Sprint (Sprint Backlog Template)

**Sprint**: `[Sprint 01]`  
**Khoảng thời gian**: `[YYYY-MM-DD]` đến `[YYYY-MM-DD]`  
**Mục tiêu Sprint (Sprint Goal)**: `[Ví dụ: Hoàn tất module xác thực người dùng và dựng khung API chuẩn]`

---

## 1. Bảng Theo Dõi Tiến Độ Task (Kanban View)

| Mã Task | Tiêu Đề Nhiệm Vụ | Phụ Trách (Assignee) | Điểm (SP) | Ước Lượng (Giờ) | Thực Tế (Giờ) | Trạng Thái |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `TASK-101` | Khởi tạo cấu hình linter & formatter | Lập trình viên | 1 | 1h | 0.8h | ✅ DONE |
| `TASK-102` | Thiết kế migration CSDL cho bảng Users | Kiến trúc | 2 | 2h | 1.5h | ✅ DONE |
| `TASK-103` | Viết API Endpoint POST /auth/register | Backend | 3 | 3h | - | 🟡 IN PROGRESS |
| `TASK-104` | Viết Unit Test cho Auth Controller | QA | 2 | 2h | - | ⚪ TODO |
| `TASK-105` | Rà soát bảo mật mã nguồn trước khi merge | Security Reviewer | 1 | 1h | - | ⚪ TODO |

*Quy ước trạng thái*:
- ⚪ `TODO`: Chưa bắt đầu
- 🟡 `IN PROGRESS`: Đang thực hiện
- 🟣 `IN REVIEW`: Đang chờ Reviewer duyệt PR
- 🧪 `TESTING`: Đang chạy bộ kiểm thử
- ✅ `DONE`: Đã đạt Definition of Done (DoD) và merge vào branch chính
- 🛑 `BLOCKED`: Đang bị nghẽn (Cần ghi rõ lý do nghẽn vào dev-logs)
