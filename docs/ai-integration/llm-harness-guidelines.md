# Tích hợp LLM vào sản phẩm

Dùng tài liệu này khi ứng dụng gọi mô hình để thực hiện chức năng nghiệp vụ. Ghi tính năng, dữ liệu đầu vào, kết quả mong đợi và tiêu chí chất lượng trong [PRD](../requirements/prd-template.md). Ghi nhà cung cấp, mô hình và phương án dự phòng đã được duyệt trong tài liệu kiến trúc của dự án.

## Ngữ cảnh và đầu ra

1. Chuẩn bị prompt từ hướng dẫn hệ thống và ngữ cảnh cần thiết. Với lịch sử dài hoặc kho tài liệu lớn, chọn lọc hoặc tóm tắt nguồn dữ liệu đã được cấp quyền trước khi gửi đến mô hình.
2. Xử lý đầu vào của người dùng, tài liệu và kết quả công cụ như dữ liệu không tin cậy. Giữ chính sách hệ thống và quyền gọi công cụ ở lớp ứng dụng.
3. Dùng đầu ra có cấu trúc hoặc lược đồ công cụ khi cần dữ liệu máy đọc được. Kiểm tra dữ liệu theo lược đồ trước khi dùng hoặc trả về. Giới hạn số lần yêu cầu mô hình sửa lại kết quả sai định dạng.

## Chọn mô hình và xử lý lỗi

- Đo chất lượng, chi phí và độ trễ trên cùng tập tác vụ trước khi chọn mô hình. Mô hình nhẹ phù hợp để thử với phân loại hoặc trích xuất. Tác vụ nhiều bước cần đánh giá riêng.
- Với lỗi giới hạn tần suất hoặc lỗi tạm thời, dùng số lần thử lại hữu hạn và lùi theo cấp số nhân kèm độ lệch ngẫu nhiên. Tôn trọng `Retry-After` khi có và giữ tổng thời gian trong ngân sách của yêu cầu.
- Chỉ chuyển sang mô hình dự phòng đã được duyệt. Nếu lỗi kéo dài, dùng circuit breaker để tạm dừng gửi yêu cầu đến nhà cung cấp đang lỗi. Chốt ngưỡng mở lại dựa trên số đo của dự án.
- Nếu giao diện trả dần kết quả, đo thời gian đến phần phản hồi đầu tiên và thời gian hoàn tất theo mục tiêu của dự án. [Mẫu yêu cầu phi chức năng](../architecture/non-functional-requirements.md)
