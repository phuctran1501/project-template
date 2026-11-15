# Thư Viện Mẫu Sơ Đồ Mermaid (Mermaid Diagram Templates)

Tài liệu này cung cấp các đoạn mã Mermaid chuẩn để các Sub-Agents và kỹ sư sử dụng khi vẽ sơ đồ kỹ thuật.

---

## 1. Sơ Đồ Ngữ Cảnh Hệ Thống (C4 Model - System Context)

```mermaid
graph TD
    User["Người dùng cuối (Khách hàng/Admin)"]
    System["Hệ Thống Ứng Dụng (App Core)"]
    AuthService["Dịch vụ xác thực bên thứ 3 (OAuth)"]
    PaymentGW["Cổng thanh toán (Stripe / VNPay)"]
    EmailProvider["Dịch vụ gửi Email (Resend / SendGrid)"]

    User -->|"Truy cập web/mobile qua HTTPS"| System
    System -->|"Xác thực người dùng"| AuthService
    System -->|"Xử lý giao dịch thanh toán"| PaymentGW
    System -->|"Gửi email thông báo"| EmailProvider
```

---

## 2. Sơ Đồ Phân Rã Thành Phần (C4 Model - Container Diagram)

```mermaid
graph TB
    subgraph ClientLayer ["Tầng Giao Diện"]
        WebSPA["Web SPA / Frontend (Next.js / Vue)"]
        MobileApp["Mobile App (Flutter / React Native)"]
    end

    subgraph ServerLayer ["Tầng Dịch Vụ Máy Chủ"]
        APIGateway["API Gateway / Reverse Proxy (Nginx)"]
        BackendApp["Backend Core Service (REST / GraphQL)"]
        BackgroundWorker["Background Task Worker"]
    end

    subgraph DataLayer ["Tầng Lưu Trữ & Hàng Đợi"]
        PrimaryDB[("Primary Database (PostgreSQL / MySQL)")]
        RedisCache[("Redis (Cache & Session)")]
        MessageBroker["Message Broker (RabbitMQ / Kafka)"]
    end

    WebSPA -->|"HTTPS / JSON"| APIGateway
    MobileApp -->|"HTTPS / JSON"| APIGateway
    APIGateway --> BackendApp
    BackendApp --> PrimaryDB
    BackendApp --> RedisCache
    BackendApp -->|"Publish event"| MessageBroker
    MessageBroker -->|"Consume job"| BackgroundWorker
    BackgroundWorker --> PrimaryDB
```

---

## 3. Sơ Đồ Tuần Tự (Sequence Diagram - Luồng Nghiệp Vụ)

```mermaid
sequenceDiagram
    autonumber
    actor User as Người dùng
    participant FE as Frontend Client
    participant API as API Server
    participant Cache as Redis Cache
    participant DB as Database

    User->>FE: Bấm xem chi tiết sản phẩm ID=123
    FE->>API: GET /api/v1/products/123
    API->>Cache: Kiểm tra cache "product:123"
    alt Có trong cache (Cache Hit)
        Cache-->>API: Trả về dữ liệu JSON
    else Không có trong cache (Cache Miss)
        API->>DB: SELECT * FROM products WHERE id = 123
        DB-->>API: Trả về bản ghi từ CSDL
        API->>Cache: Lưu cache "product:123" (TTL 10 phút)
    end
    API-->>FE: Trả về HTTP 200 OK kèm payload
    FE-->>User: Hiển thị giao diện chi tiết sản phẩm
```

---

## 4. Sơ Đồ Trạng Thái (State Diagram - Vòng Đời Đơn Hàng / Thực Thể)

```mermaid
stateDiagram-v2
    [*] --> DRAFT: Người dùng tạo bản nháp
    DRAFT --> PENDING_PAYMENT: Xác nhận đặt hàng
    PENDING_PAYMENT --> PAID: Thanh toán thành công
    PENDING_PAYMENT --> CANCELLED: Hủy đơn hoặc hết hạn thanh toán
    PAID --> PROCESSING: Đang đóng gói sản phẩm
    PROCESSING --> SHIPPING: Đã bàn giao đơn vị vận chuyển
    SHIPPING --> DELIVERED: Giao hàng thành công
    SHIPPING --> RETURNED: Giao hàng thất bại / Hoàn trả
    DELIVERED --> [*]
    CANCELLED --> [*]
    RETURNED --> [*]
```

---

## 5. Sơ Đồ Thực Thể Quan Hệ CSDL (Entity-Relationship Diagram - ERD)

```mermaid
erDiagram
    USERS ||--o{ ORDERS : "places"
    USERS {
        uuid id PK
        string email UK
        string password_hash
        string role
        timestamp created_at
    }

    ORDERS ||--|{ ORDER_ITEMS : "contains"
    ORDERS {
        uuid id PK
        uuid user_id FK
        decimal total_amount
        string status
        timestamp created_at
    }

    PRODUCTS ||--o{ ORDER_ITEMS : "ordered_in"
    PRODUCTS {
        uuid id PK
        string title
        decimal price
        int stock_quantity
    }

    ORDER_ITEMS {
        uuid id PK
        uuid order_id FK
        uuid product_id FK
        int quantity
        decimal unit_price
    }
```
