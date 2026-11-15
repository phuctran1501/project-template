# Cấu Trúc Phân Rã Công Việc (Work Breakdown Structure - WBS)

Tài liệu này dùng để phân rã dự án từ cấp độ Epic (Tính năng lớn) xuống Task và Subtask kỹ thuật.

---

## 1. Nguyên Tắc Phân Rã (WBS Rules)
- **Quy tắc 100%**: Tổng các nhiệm vụ con phải bao hàm 100% phạm vi của nhiệm vụ cha, không thừa, không thiếu.
- **Kích thước Task tối ưu**: Một task kỹ thuật của AI Agent hoặc lập trình viên nên kéo dài từ `1 - 4 giờ` làm việc (Story points từ 1 đến 5). Nếu lớn hơn 8 giờ, bắt buộc phải chia nhỏ tiếp.

---

## 2. Bảng Phân Rã Công Việc Tổng Thể

| WBS ID | Giai Đoạn / Epic | Mã Nhiệm Vụ | Tên Nhiệm Vụ Kỹ Thuật | Người / Agent Thực Hiện | Trạng Thái |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `1.0` | **Thiết Kế & Chuẩn Bị** | `TASK-101` | Khảo sát & chốt Tech Stack tại `docs/techs/` | Tech Lead / User | Hoàn thành |
| `1.1` | | `TASK-102` | Thiết kế CSDL và viết schema mẫu tại `docs/database/`| Architect Agent | Đang làm |
| `1.2` | | `TASK-103` | Viết đặc tả OpenAPI cho Module Auth & Items | Architect Agent | Chờ xử lý |
| `2.0` | **Lập Trình Backend** | `TASK-201` | Khởi tạo khung dự án (Scaffold) theo kiến trúc đã chọn | Developer Agent | Chờ xử lý |
| `2.1` | | `TASK-202` | Viết Service xác thực JWT và Middleware phân quyền | Developer Agent | Chờ xử lý |
| `2.2` | | `TASK-203` | Hiện thực CRUD endpoints cho Items kèm validation | Developer Agent | Chờ xử lý |
| `3.0` | **Kiểm Thử (QA)** | `TASK-301` | Viết Unit Test cho Auth Service & Token Generator | QA Tester Agent | Chờ xử lý |
| `3.1` | | `TASK-302` | Viết Integration Test cho toàn bộ API endpoints | QA Tester Agent | Chờ xử lý |
| `4.0` | **Hạ Tầng & Vận Hành** | `TASK-401` | Viết Dockerfile multi-stage và docker-compose.yml | DevOps Agent | Chờ xử lý |
| `4.1` | | `TASK-402` | Kích hoạt GitHub Actions CI kiểm tra lint & test tự động | DevOps Agent | Chờ xử lý |
