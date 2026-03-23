-- ============================================================
-- NGÀY 17: Stored Procedure
-- ============================================================

USE hoc_mysql;

-- ==============================
-- PHẦN 1: PROCEDURE ĐƠN GIẢN
-- ==============================

-- BƯỚC 1: Procedure không có tham số
DELIMITER //

CREATE PROCEDURE bao_cao_tong_quan()
BEGIN
    SELECT 'Thống kê cửa hàng' AS tieu_de;

    SELECT
        COUNT(*) AS tong_san_pham,
        SUM(so_luong) AS tong_ton_kho,
        SUM(gia * so_luong) AS gia_tri_kho
    FROM san_pham;

    SELECT
        COUNT(*) AS tong_khach_hang,
        COUNT(so_dien_thoai) AS co_sdt
    FROM khach_hang;

    SELECT
        COUNT(*) AS tong_don_hang,
        SUM(tong_tien) AS tong_doanh_thu
    FROM don_hang;
END //

DELIMITER ;

-- Gọi procedure
CALL bao_cao_tong_quan();

-- BƯỚC 2: Xóa và kiểm tra
DROP PROCEDURE IF EXISTS bao_cao_tong_quan;

-- ==============================
-- PHẦN 2: PROCEDURE VỚI THAM SỐ IN
-- ==============================

DELIMITER //

-- Lấy sản phẩm theo danh mục
CREATE PROCEDURE lay_sp_theo_danh_muc(IN p_danh_muc_id INT)
BEGIN
    SELECT sp.ten, sp.gia, sp.so_luong, dm.ten AS danh_muc
    FROM san_pham sp
    JOIN danh_muc dm ON sp.danh_muc_id = dm.id
    WHERE sp.danh_muc_id = p_danh_muc_id
    ORDER BY sp.gia;
END //

-- Lấy đơn hàng của khách hàng
CREATE PROCEDURE lay_don_hang_khach(IN p_khach_hang_id INT)
BEGIN
    SELECT
        dh.id AS ma_don,
        dh.ngay_dat,
        dh.tong_tien,
        dh.trang_thai,
        COUNT(ct.id) AS so_san_pham
    FROM don_hang dh
    LEFT JOIN chi_tiet_don_hang ct ON dh.id = ct.don_hang_id
    WHERE dh.khach_hang_id = p_khach_hang_id
    GROUP BY dh.id, dh.ngay_dat, dh.tong_tien, dh.trang_thai
    ORDER BY dh.ngay_dat DESC;
END //

DELIMITER ;

-- Gọi
CALL lay_sp_theo_danh_muc(1);
CALL lay_sp_theo_danh_muc(2);
CALL lay_don_hang_khach(1);

-- ==============================
-- PHẦN 3: PROCEDURE VỚI THAM SỐ OUT
-- ==============================

DELIMITER //

CREATE PROCEDURE tinh_tong_chi_tieu(
    IN  p_khach_hang_id INT,
    OUT p_tong DECIMAL(15, 2),
    OUT p_so_don INT
)
BEGIN
    SELECT
        COALESCE(SUM(tong_tien), 0),
        COUNT(*)
    INTO p_tong, p_so_don
    FROM don_hang
    WHERE khach_hang_id = p_khach_hang_id;
END //

DELIMITER ;

-- Gọi với biến OUT
CALL tinh_tong_chi_tieu(1, @tong, @so_don);
SELECT
    @tong AS tong_chi_tieu,
    @so_don AS so_don_hang;

CALL tinh_tong_chi_tieu(3, @tong, @so_don);
SELECT @tong AS tong, @so_don AS don;

-- ==============================
-- PHẦN 4: PROCEDURE VỚI LOGIC PHỨC TẠP
-- ==============================

DELIMITER //

CREATE PROCEDURE cap_nhat_gia(
    IN p_danh_muc_id INT,
    IN p_phan_tram   INT,     -- % tăng (+) hoặc giảm (-)
    OUT p_so_san_pham_cap_nhat INT
)
BEGIN
    -- Kiểm tra phần trăm hợp lệ
    IF p_phan_tram < -50 OR p_phan_tram > 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Phần trăm phải từ -50 đến 100';
    END IF;

    -- Thực hiện cập nhật
    UPDATE san_pham
    SET gia = gia * (1 + p_phan_tram / 100)
    WHERE danh_muc_id = p_danh_muc_id;

    -- Đếm số bản ghi đã cập nhật
    SET p_so_san_pham_cap_nhat = ROW_COUNT();

    SELECT CONCAT('Đã cập nhật ', ROW_COUNT(), ' sản phẩm') AS thong_bao;
END //

DELIMITER ;

-- Test
SELECT ten, gia FROM san_pham WHERE danh_muc_id = 2;

CALL cap_nhat_gia(2, 10, @so_sp);  -- tăng 10%
SELECT @so_sp AS so_san_pham_da_cap_nhat;

SELECT ten, gia FROM san_pham WHERE danh_muc_id = 2;

CALL cap_nhat_gia(2, -9, @so_sp);  -- giảm ~9% để về gần giá cũ
SELECT ten, gia FROM san_pham WHERE danh_muc_id = 2;

-- ==============================
-- PHẦN 5: PROCEDURE THÊM KHÁCH HÀNG
-- ==============================

DELIMITER //

CREATE PROCEDURE them_khach_hang(
    IN  p_ho_ten        VARCHAR(100),
    IN  p_email         VARCHAR(255),
    IN  p_dien_thoai    VARCHAR(15),
    IN  p_dia_chi       TEXT,
    OUT p_id_moi        INT,
    OUT p_thong_bao     VARCHAR(200)
)
BEGIN
    DECLARE v_ton_tai INT DEFAULT 0;

    -- Kiểm tra email đã tồn tại chưa
    SELECT COUNT(*) INTO v_ton_tai FROM khach_hang WHERE email = p_email;

    IF v_ton_tai > 0 THEN
        SET p_id_moi = -1;
        SET p_thong_bao = CONCAT('Email ', p_email, ' đã được đăng ký!');
    ELSE
        INSERT INTO khach_hang (ho_ten, email, so_dien_thoai, dia_chi)
        VALUES (p_ho_ten, LOWER(TRIM(p_email)), p_dien_thoai, p_dia_chi);

        SET p_id_moi = LAST_INSERT_ID();
        SET p_thong_bao = CONCAT('Thêm thành công! ID: ', p_id_moi);
    END IF;
END //

DELIMITER ;

-- Test thêm mới
CALL them_khach_hang('Vũ Văn Phúc', 'phuc.vu@email.com', '0966777888', 'Hà Nội', @id, @tb);
SELECT @id AS id_moi, @tb AS thong_bao;
SELECT * FROM khach_hang WHERE id = @id;

-- Test thêm trùng email
CALL them_khach_hang('Người Trùng', 'phuc.vu@email.com', NULL, NULL, @id, @tb);
SELECT @id AS id_moi, @tb AS thong_bao;

-- ==============================
-- PHẦN 6: QUẢN LÝ PROCEDURE
-- ==============================

-- Xem danh sách
SHOW PROCEDURE STATUS WHERE Db = 'hoc_mysql';

-- Xem nội dung
SHOW CREATE PROCEDURE them_khach_hang\G

-- ============================================================
-- BÀI TẬP:
-- 1. Tạo procedure tim_san_pham(tu_khoa) tìm sản phẩm theo từ khóa trong tên
-- 2. Tạo procedure xoa_don_hang(id, OUT thong_bao) xóa đơn hàng kèm chi tiết
-- 3. Tạo procedure thong_ke_thang(thang, nam) trả về thống kê tháng đó
-- ============================================================

-- Giải bài tập 1
DELIMITER //
CREATE PROCEDURE tim_san_pham(IN p_tu_khoa VARCHAR(100))
BEGIN
    SELECT sp.ten, sp.gia, sp.so_luong, dm.ten AS danh_muc
    FROM san_pham sp
    JOIN danh_muc dm ON sp.danh_muc_id = dm.id
    WHERE sp.ten LIKE CONCAT('%', p_tu_khoa, '%')
    ORDER BY sp.ten;
END //
DELIMITER ;

CALL tim_san_pham('Samsung');
CALL tim_san_pham('Pro');
