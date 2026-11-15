# Quy Tắc Chống Ảo Giác & Xác Thực Mã Nguồn (Anti-Hallucination Rules)

1. **Không Tự Bịa Gói Phụ Thuộc (Package Hallucination)**:
   - Trước khi import bất kỳ thư viện bên ngoài nào, Agent phải kiểm tra file quản lý gói tương ứng (`package.json`, `requirements.txt`, `go.mod`, `Cargo.toml`, v.v.).
   - Nếu gói chưa có, thông báo rõ ràng cho người dùng hoặc cập nhật file quản lý gói kèm lý do.

2. **Xác Minh Chữ Ký Hàm & Kiểu Dữ Liệu**:
   - Sử dụng `.codegraph` hoặc đọc trực tiếp định nghĩa để biết chính xác tham số, kiểu trả về và exceptions có thể phát sinh. Không đoán mò API contract.

3. **Chạy Thử Nghiệm Xác Minh (Verification Execution)**:
   - Sau khi sửa code, nếu môi trường terminal cho phép, luôn chạy linter hoặc unit test để đảm bảo không làm gãy (break) hệ thống hiện hữu.
   - Nếu phát hiện lỗi biên dịch hoặc test hỏng, lập tức sửa chữa trước khi báo cáo hoàn thành.

4. **Trích Dẫn Sự Thật Kỹ Thuật (Grounded Technical Reasoning)**:
   - Mọi khuyến nghị về hiệu năng hay bảo mật phải dựa trên benchmark hoặc chuẩn thực tế (OWASP, RFC, Official Docs), không đưa ra kết luận chủ quan thiếu căn cứ.
