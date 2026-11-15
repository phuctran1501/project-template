# Tài Liệu Yêu Cầu Sản Phẩm (Product Requirement Document - PRD)

**Mã Dự Án**: `[PROJECT-CODE]`  
**Tên Dự Án**: `[Tên dự án]`  
**Người phụ trách (Product Owner / Tech Lead)**: `[Tên người phụ trách]`  
**Ngày cập nhật**: `[YYYY-MM-DD]`  
**Trạng thái**: `[Draft | In Review | Approved | Deprecated]`

---

## 1. Bối Cảnh & Mục Tiêu (Context & Objectives)
- **Bối cảnh kinh doanh**: `[Tại sao chúng ta xây dựng sản phẩm/tính năng này?]`
- **Mục tiêu thành công**: `[Định lượng mục tiêu sau khi ra mắt]`

---

## 2. Yêu Cầu Chức Năng (Functional Requirements)

| Mã Yêu Cầu | Tên Chức Năng | Mô Tả Nghiệp Vụ | Mức Ưu Tiên | Subagent Phụ Trách |
| :--- | :--- | :--- | :--- | :--- |
| `FR-001` | Xác thực người dùng | Đăng ký, đăng nhập JWT, phân quyền RBAC | P0 (Bắt buộc) | Backend / Fullstack |
| `FR-002` | Quản lý thực thể chính | CRUD dữ liệu nghiệp vụ cốt lõi | P0 (Bắt buộc) | Fullstack |
| `FR-003` | Xuất báo cáo dữ liệu | Cho phép xuất dữ liệu ra định dạng Excel/CSV | P1 (Nên có) | Backend |
| `FR-004` | Tích hợp AI gợi ý | Tự động phân tích và đưa ra khuyến nghị | P2 (Có thể hoãn) | AI Harness |

---

## 3. Quy Tắc Nghiệp Vụ Cốt Lõi (Business Rules)
1. **BR-001**: `[Quy tắc 1 - Ví dụ: Mật khẩu phải có tối thiểu 8 ký tự bao gồm số và chữ hoa]`
2. **BR-002**: `[Quy tắc 2 - Ví dụ: Đơn hàng chỉ được hủy khi trạng thái là 'Chờ xác nhận']`
3. **BR-003**: `[Quy tắc 3 - Ví dụ: Dữ liệu nhạy cảm của khách hàng phải được mã hóa khi lưu trữ]`

---

## 4. Giả Định & Rủi Ro (Assumptions & Risks)
- **Giả định (Assumptions)**: Người dùng có kết nối internet băng thông tối thiểu 2Mbps; trình duyệt hỗ trợ ES6+.
- **Rủi ro kỹ thuật (Technical Risks)**: Dịch vụ bên thứ ba (thanh toán/email) có thể bị nghẽn -> Cần cơ chế Retry và Circuit Breaker.
- **Rủi ro sản phẩm**: Tỷ lệ rớt đơn tại bước thanh toán cao -> Cần đo lường qua funnel analytics.
