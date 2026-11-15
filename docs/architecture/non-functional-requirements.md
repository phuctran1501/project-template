# Yêu Cầu Phi Chức Năng (Non-Functional Requirements - NFR)

*Bộ tiêu chuẩn định lượng về hiệu năng, độ tin cậy và khả năng mở rộng của hệ thống.*

---

## 1. Hiệu Năng & Độ Trễ (Performance & Latency)
- **Độ trễ API (API Latency)**:
  - 95% request đọc (Read p95): `< 200ms`
  - 95% request ghi (Write p95): `< 500ms`
- **Thời gian phản hồi AI (LLM Completion)**:
  - Streaming First Token (TTFT): `< 1.2s`
  - Tổng thời gian hoàn tất: `< 5s`
- **Tải trọng đồng thời (Concurrency)**:
  - MVP: Hỗ trợ tối thiểu 100 người dùng hoạt động đồng thời (CCU).

---

## 2. Độ Khả Dụng & Ổn Định (Availability & Reliability)
- **Chỉ tiêu SLA (Service Level Agreement)**: Tối thiểu `99.9%` thời gian hoạt động (Downtime không quá 43 phút/tháng).
- **RTO (Recovery Time Objective)**: Thời gian phục hồi sau thảm họa `< 2 giờ`.
- **RPO (Recovery Point Objective)**: Mức độ chấp nhận mất dữ liệu tối đa `< 15 phút` (dựa trên tần suất sao lưu CSDL).

---

## 3. Khả Năng Mở Rộng (Scalability)
- **Stateless Backend**: Thiết kế backend dạng không lưu trạng thái (Stateless) để dễ dàng scale ngang (Horizontal Autoscaling) khi tải tăng đột biến.
- **Caching Layer**: Sử dụng Redis/In-memory cache cho dữ liệu ít thay đổi nhưng đọc nhiều (Hot Data).

---

## 4. Khả Năng Giám Sát (Observability)
- **Logging**: Định dạng Structured JSON logs kèm `trace_id`, `request_id`, `user_id`.
- **Metrics**: Đo lường CPU, RAM, Network I/O, Database Connection Pool qua Prometheus/Datadog.
- **Alerting**: Cảnh báo tức thời qua Slack/Telegram khi tỷ lệ lỗi 5xx vượt quá 1% trong vòng 5 phút.
