-- ============================================================
-- NGÀY 19: Stored Function - Hàm Tự Định Nghĩa
-- ============================================================

USE hoc_mysql;

-- ==============================
-- PHẦN 1: FUNCTION CƠ BẢN
-- ==============================

-- BƯỚC 1: Function định dạng tiền tệ
DELIMITER //

CREATE FUNCTION dinh_dang_tien(so_tien DECIMAL(15, 2))
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    RETURN CONCAT(FORMAT(so_tien, 0), ' VNĐ');
END //

DELIMITER ;

-- Test ngay trong SELECT
SELECT dinh_dang_tien(27990000);
SELECT dinh_dang_tien(0);
SELECT dinh_dang_tien(NULL);

-- Áp dụng vào bảng
SELECT ten, dinh_dang_tien(gia) AS gia_hien_thi FROM san_pham;

-- BƯỚC 2: Function tính tuổi
DELIMITER //

CREATE FUNCTION tinh_tuoi(ngay_sinh DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    IF ngay_sinh IS NULL THEN
        RETURN NULL;
    END IF;
    RETURN TIMESTAMPDIFF(YEAR, ngay_sinh, CURDATE());
END //

DELIMITER ;

-- Test
SELECT tinh_tuoi('1990-05-15') AS tuoi;
SELECT tinh_tuoi('2000-12-31') AS tuoi;

-- BƯỚC 3: Function xếp loại
DELIMITER //

CREATE FUNCTION xep_loai_diem(diem DECIMAL(4, 2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    IF diem IS NULL THEN RETURN 'Chưa có điểm'; END IF;
    IF diem >= 9.0 THEN RETURN 'Xuất sắc';
    ELSEIF diem >= 8.0 THEN RETURN 'Giỏi';
    ELSEIF diem >= 7.0 THEN RETURN 'Khá';
    ELSEIF diem >= 5.0 THEN RETURN 'Trung bình';
    ELSE RETURN 'Yếu';
    END IF;
END //

DELIMITER ;

-- Test
SELECT
    xep_loai_diem(9.5) AS loai_1,
    xep_loai_diem(8.0) AS loai_2,
    xep_loai_diem(6.5) AS loai_3,
    xep_loai_diem(4.9) AS loai_4;

-- ==============================
-- PHẦN 2: FUNCTION ĐỌC DỮ LIỆU
-- ==============================

-- BƯỚC 4: Function lấy tên danh mục
DELIMITER //

CREATE FUNCTION lay_ten_danh_muc(p_id INT)
RETURNS VARCHAR(100)
READS SQL DATA
BEGIN
    DECLARE v_ten VARCHAR(100);
    SELECT ten INTO v_ten FROM danh_muc WHERE id = p_id;
    RETURN COALESCE(v_ten, 'Không xác định');
END //

DELIMITER ;

-- Dùng thay thế JOIN
SELECT ten, lay_ten_danh_muc(danh_muc_id) AS danh_muc, gia
FROM san_pham;

-- BƯỚC 5: Function tính tổng chi tiêu của khách
DELIMITER //

CREATE FUNCTION tong_chi_tieu_khach(p_khach_id INT)
RETURNS DECIMAL(15, 2)
READS SQL DATA
BEGIN
    DECLARE v_tong DECIMAL(15, 2);
    SELECT COALESCE(SUM(tong_tien), 0) INTO v_tong
    FROM don_hang WHERE khach_hang_id = p_khach_id;
    RETURN v_tong;
END //

-- Function xếp loại khách hàng
CREATE FUNCTION hang_khach_hang(p_khach_id INT)
RETURNS VARCHAR(20)
READS SQL DATA
BEGIN
    DECLARE v_tong DECIMAL(15, 2);
    SET v_tong = tong_chi_tieu_khach(p_khach_id);  -- gọi function khác

    IF v_tong >= 50000000 THEN RETURN 'VIP Gold';
    ELSEIF v_tong >= 20000000 THEN RETURN 'VIP Silver';
    ELSEIF v_tong > 0 THEN RETURN 'Thường';
    ELSE RETURN 'Chưa mua';
    END IF;
END //

DELIMITER ;

-- Test
SELECT
    ho_ten,
    dinh_dang_tien(tong_chi_tieu_khach(id)) AS chi_tieu,
    hang_khach_hang(id) AS hang
FROM khach_hang;

-- ==============================
-- PHẦN 3: FUNCTION TIỆN ÍCH
-- ==============================

-- BƯỚC 6: Function kiểm tra email hợp lệ
DELIMITER //

CREATE FUNCTION la_email_hop_le(email VARCHAR(255))
RETURNS TINYINT(1)
DETERMINISTIC
BEGIN
    RETURN email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$';
END //

-- Function tạo slug từ tên (URL friendly)
CREATE FUNCTION tao_slug(ten VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE slug VARCHAR(255);
    SET slug = LOWER(ten);
    SET slug = REPLACE(slug, ' ', '-');
    RETURN slug;
END //

-- Function làm tròn tiền (làm tròn đến nghìn đồng)
CREATE FUNCTION lam_tron_tien(so_tien DECIMAL(15, 2))
RETURNS DECIMAL(15, 0)
DETERMINISTIC
BEGIN
    RETURN ROUND(so_tien / 1000) * 1000;
END //

DELIMITER ;

-- Test
SELECT la_email_hop_le('test@gmail.com') AS hop_le;
SELECT la_email_hop_le('khong_hop_le') AS khong_hop_le;

SELECT tao_slug('iPhone 15 Pro Max') AS slug;
SELECT tao_slug('Laptop Dell XPS 13') AS slug;

SELECT lam_tron_tien(27990000) AS lam_tron;
SELECT lam_tron_tien(255500) AS lam_tron;

-- ==============================
-- PHẦN 4: DÙNG NHIỀU FUNCTION CÙNG LÚC
-- ==============================

-- BƯỚC 7: Báo cáo đẹp
SELECT
    CONCAT('KH', LPAD(id, 4, '0')) AS ma_khach,
    ho_ten,
    IFNULL(so_dien_thoai, 'N/A') AS sdt,
    hang_khach_hang(id) AS hang,
    dinh_dang_tien(tong_chi_tieu_khach(id)) AS tong_chi_tieu
FROM khach_hang
ORDER BY tong_chi_tieu_khach(id) DESC;

-- Bảng sản phẩm đẹp
SELECT
    CONCAT('SP', LPAD(id, 4, '0')) AS ma_sp,
    ten,
    lay_ten_danh_muc(danh_muc_id) AS danh_muc,
    dinh_dang_tien(gia) AS don_gia,
    CONCAT(so_luong, ' cái') AS ton_kho,
    dinh_dang_tien(lam_tron_tien(gia * so_luong)) AS gia_tri_kho
FROM san_pham
ORDER BY gia DESC;

-- ==============================
-- PHẦN 5: QUẢN LÝ FUNCTION
-- ==============================

-- BƯỚC 8: Xem danh sách
SHOW FUNCTION STATUS WHERE Db = 'hoc_mysql';

-- Xem nội dung
SHOW CREATE FUNCTION dinh_dang_tien\G

-- Xóa function
DROP FUNCTION IF EXISTS tao_slug;

-- ============================================================
-- BÀI TẬP:
-- 1. Tạo function phan_tram_giam(gia_goc, gia_sale) tính % giảm giá
-- 2. Tạo function dem_san_pham_danh_muc(danh_muc_id) đếm sản phẩm
-- 3. Tạo function tinh_vat(so_tien, phan_tram_vat) tính thuế VAT
-- 4. Tạo báo cáo dùng tất cả function đã tạo
-- ============================================================

-- Giải bài tập
DELIMITER //

-- 1.
CREATE FUNCTION phan_tram_giam(gia_goc DECIMAL(15,2), gia_sale DECIMAL(15,2))
RETURNS DECIMAL(5, 2)
DETERMINISTIC
BEGIN
    IF gia_goc = 0 OR gia_goc IS NULL THEN RETURN 0; END IF;
    RETURN ROUND((gia_goc - gia_sale) / gia_goc * 100, 2);
END //

-- 2.
CREATE FUNCTION dem_san_pham_danh_muc(p_danh_muc_id INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE v_dem INT;
    SELECT COUNT(*) INTO v_dem FROM san_pham WHERE danh_muc_id = p_danh_muc_id;
    RETURN v_dem;
END //

-- 3.
CREATE FUNCTION tinh_vat(so_tien DECIMAL(15,2), phan_tram DECIMAL(5,2))
RETURNS DECIMAL(15, 2)
DETERMINISTIC
BEGIN
    RETURN ROUND(so_tien * phan_tram / 100, 2);
END //

DELIMITER ;

-- Test
SELECT phan_tram_giam(1000000, 800000) AS phan_tram_giam;
SELECT dem_san_pham_danh_muc(1) AS so_sp_dien_tu;
SELECT
    dinh_dang_tien(27990000) AS gia_goc,
    dinh_dang_tien(tinh_vat(27990000, 10)) AS tien_vat_10pct;
