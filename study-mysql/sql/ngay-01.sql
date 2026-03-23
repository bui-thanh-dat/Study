-- ============================================================
-- NGÀY 1: Giới Thiệu MySQL - Các Lệnh Đầu Tiên
-- ============================================================
-- Hướng dẫn: Chạy từng lệnh một, đọc kết quả trước khi tiếp tục

-- BƯỚC 1: Xem phiên bản MySQL đang cài
SELECT VERSION();

-- BƯỚC 2: Xem thời gian hiện tại
SELECT NOW();

-- BƯỚC 3: Xem danh sách tất cả database có sẵn
SHOW DATABASES;

-- BƯỚC 4: Tính toán đơn giản bằng SQL
SELECT 1 + 1 AS phep_cong;
SELECT 100 * 5 AS phep_nhan;
SELECT 2024 - 1990 AS hieu;

-- BƯỚC 5: Nối chuỗi
SELECT CONCAT('Xin chào', ' ', 'MySQL!') AS loi_chao;
SELECT 'Tên tôi là: ' AS nhan, 'Học viên' AS gia_tri;

-- BƯỚC 6: Xem người dùng hiện tại
SELECT USER();
SELECT DATABASE();  -- sẽ trả NULL vì chưa chọn database nào

-- ============================================================
-- BÀI TẬP:
-- 1. Chạy từng lệnh trên và ghi lại kết quả
-- 2. Tính: 365 * 24 * 60 (số phút trong 1 năm)
-- 3. Hiển thị chuỗi: "MySQL version: X.X.X" (thay X bằng version thực)
-- ============================================================

-- Giải bài tập
SELECT 365 * 24 * 60 AS phut_trong_nam;
SELECT CONCAT('MySQL version: ', VERSION()) AS thong_tin;
