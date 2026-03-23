-- ============================================================
-- NGÀY 4: INSERT - Thêm Dữ Liệu
-- ============================================================

USE hoc_mysql;

-- BƯỚC 1: Thêm danh mục (INSERT đơn giản)
INSERT INTO danh_muc (ten, mo_ta)
VALUES ('Điện tử', 'Thiết bị điện tử, công nghệ');

-- Xem kết quả ngay
SELECT * FROM danh_muc;

-- BƯỚC 2: Thêm nhiều bản ghi cùng lúc
INSERT INTO danh_muc (ten, mo_ta) VALUES
    ('Thời trang', 'Quần áo, giày dép, phụ kiện'),
    ('Thực phẩm', 'Đồ ăn, thức uống, gia vị'),
    ('Sách', 'Sách giáo khoa, truyện, kỹ năng'),
    ('Thể thao', 'Dụng cụ thể thao, tập gym');

SELECT * FROM danh_muc;

-- BƯỚC 3: Thêm khách hàng
INSERT INTO khach_hang (ho_ten, email, so_dien_thoai, dia_chi) VALUES
    ('Nguyễn Văn An', 'an.nguyen@email.com', '0901234567', 'Hà Nội'),
    ('Trần Thị Bình', 'binh.tran@email.com', '0912345678', 'TP.HCM'),
    ('Lê Văn Cường', 'cuong.le@email.com', '0923456789', 'Đà Nẵng'),
    ('Phạm Thị Dung', 'dung.pham@email.com', NULL, 'Hải Phòng'),
    ('Hoàng Văn Em', 'em.hoang@email.com', '0945678901', 'Cần Thơ');

SELECT * FROM khach_hang;

-- BƯỚC 4: Thêm sản phẩm (có foreign key)
INSERT INTO san_pham (danh_muc_id, ten, gia, so_luong, ngay_nhap) VALUES
    (1, 'iPhone 15 Pro', 27990000, 50, '2024-01-10'),
    (1, 'Samsung Galaxy S24', 22990000, 30, '2024-01-15'),
    (1, 'Laptop Dell XPS 13', 35000000, 15, '2024-01-20'),
    (1, 'Tai nghe Sony WH-1000XM5', 8500000, 40, '2024-01-25'),
    (2, 'Áo thun nam basic', 250000, 200, '2024-02-01'),
    (2, 'Quần jeans nữ slim', 450000, 150, '2024-02-05'),
    (2, 'Giày sneaker trắng', 890000, 80, '2024-02-10'),
    (3, 'Cà phê Arabica 500g', 120000, 500, '2024-02-15'),
    (3, 'Trà xanh Nhật Bản', 85000, 300, '2024-02-20'),
    (4, 'Clean Code - Robert C. Martin', 180000, 100, '2024-03-01'),
    (4, 'Lập trình Python từ A-Z', 150000, 120, '2024-03-05'),
    (5, 'Tạ đôi 5kg', 350000, 60, '2024-03-10');

SELECT * FROM san_pham;

-- BƯỚC 5: Thêm đơn hàng
INSERT INTO don_hang (khach_hang_id, tong_tien, trang_thai) VALUES
    (1, 27990000, 'da_giao'),
    (2, 700000, 'dang_giao'),
    (3, 205000, 'da_giao'),
    (1, 8500000, 'cho_xu_ly');

INSERT INTO chi_tiet_don_hang (don_hang_id, san_pham_id, so_luong, don_gia) VALUES
    (1, 1, 1, 27990000),
    (2, 5, 2, 250000),
    (2, 6, 1, 450000) -- Chú ý: 2*250k + 1*450k = 950k (ví dụ demo)
    (3, 8, 1, 120000),
    (3, 9, 1, 85000),
    (4, 4, 1, 8500000);

SELECT * FROM don_hang;
SELECT * FROM chi_tiet_don_hang;

-- BƯỚC 6: Thực hành INSERT IGNORE
INSERT IGNORE INTO khach_hang (ho_ten, email)
VALUES ('Trùng Email', 'an.nguyen@email.com');  -- email đã tồn tại → bỏ qua

SELECT * FROM khach_hang;  -- vẫn còn 5 bản ghi

-- BƯỚC 7: INSERT với DEFAULT
INSERT INTO san_pham (danh_muc_id, ten, gia)
VALUES (1, 'iPad Pro', 25000000);
-- so_luong tự dùng DEFAULT = 0

SELECT ten, gia, so_luong FROM san_pham ORDER BY id DESC LIMIT 3;

-- ============================================================
-- BÀI TẬP:
-- 1. Thêm 3 danh mục mới vào bảng danh_muc
-- 2. Thêm 2 khách hàng mới, 1 không có số điện thoại
-- 3. Thử thêm sản phẩm với danh_muc_id không tồn tại → quan sát lỗi
-- 4. Dùng INSERT SELECT để copy toàn bộ danh_muc vào bảng backup
-- ============================================================

-- Giải bài tập số 4
CREATE TABLE IF NOT EXISTS danh_muc_backup LIKE danh_muc;
INSERT INTO danh_muc_backup SELECT * FROM danh_muc;
SELECT * FROM danh_muc_backup;
