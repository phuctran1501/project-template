# Quy Chuẩn Hành Vi Tác Tử (Agent Behavior Protocol)

Quy tắc này áp dụng cho mọi AI Agent và Subagent khi hoạt động trong dự án:

1. **Tuân Thủ Lựa Chọn Của Người Dùng**:
   - Tuyệt đối không tự ý áp đặt ngôn ngữ, framework, kiến trúc hoặc bảng màu nếu người dùng chưa phê duyệt trong `docs/techs/` hoặc `docs/ui-ux/`.
   - Nếu chưa có quyết định, hỏi người dùng bằng câu hỏi lựa chọn rõ ràng hoặc yêu cầu người dùng cập nhật file checklist.

2. **Không Tự Ý Commit Hay Push Lên GitHub**:
   - Tuyệt đối không tự ý chạy các lệnh `git commit` hoặc `git push`.
   - Chỉ đưa ra gợi ý câu lệnh, template commit và tên commit chuẩn theo [docs/standards/git-workflow-and-commit.md](../../docs/standards/git-workflow-and-commit.md) để người dùng tự xác nhận và thực thi.

3. **Quy Chuẩn Chú Thích Mã Nguồn (Code Comments)**:
   - Toàn bộ ghi chú, chú thích bên trong mã nguồn phải viết bằng tiếng Việt.
   - Tuyệt đối không sử dụng dấu ngoặc đơn `()` trong câu chú thích.
   - Tuyệt đối không sử dụng icon hoặc biểu tượng cảm xúc trong câu chú thích.

4. **Quy Tắc Đọc Trước Khi Viết (Read-Before-Write)**:
   - Trước khi gọi lệnh tạo hoặc chỉnh sửa file, Agent bắt buộc phải đọc nội dung hiện tại và kiểm tra các file phụ thuộc liên quan.
   - Ưu tiên sử dụng CodeGraph để nắm bắt cấu trúc call-tree.

5. **Tiết Kiệm Token & Giao Tiếp Chuẩn Mực**:
   - Giao tiếp hoàn toàn bằng tiếng Việt kỹ thuật, ngắn gọn, súc tích, không chào hỏi rườm rà.
   - Mọi đường dẫn file trong câu trả lời bắt buộc định dạng markdown link rõ ràng.

6. **Trách Nhiệm Hoàn Thiện (Definition of Done)**:
   - Một tác vụ chỉ được coi là hoàn thành khi có mã nguồn + kiểm thử + cập nhật tài liệu tương ứng tại `docs/`.

7. **Nghiệm Thu Dựa Trên Bằng Chứng Thực Tế (Evidence-Based Completion)**:
   - Tuyệt đối không tự suy diễn hoặc ngầm định kiểm thử thành công khi chưa chạy lệnh kiểm chứng thực tế.
   - Báo cáo kết quả phải phân định rõ ràng các trạng thái: PASS (đã chạy và vượt qua), FAIL (đã chạy và thất bại), NOT RUN (chưa chạy). Tuyệt đối không ngầm hiểu bài test chưa chạy là PASS.
   - Phải cung cấp bằng chứng thực thi rõ ràng từ log terminal, test runner hoặc linter.
