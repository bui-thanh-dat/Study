-- ============================================================
-- BÀI TẬP 03: NÂNG CAO
-- Chủ đề: Quản lý nhà hàng (tiếp theo)
-- Kiến thức: VIEW, INDEX, TRANSACTION, Stored Procedure, Trigger, Function
-- ============================================================
-- Yêu cầu: Đã chạy SETUP ở bai-tap-01-co-ban.sql trước
-- ============================================================

USE nha_hang;

-- ============================================================
-- BÀI TẬP
-- ============================================================

-- BÀI 12: VIEW
-- -------------------------------------------------------

-- 12.1 Tạo VIEW tên `v_menu_day_du` hiển thị:
--      tên món, giá, tên danh mục, trạng thái (Còn bán / Ngừng bán)
-- Viết SQL ở đây:


-- 12.2 Dùng VIEW vừa tạo để lọc ra các món trong danh mục "Đồ uống" còn bán
-- Viết SQL ở đây:


-- 12.3 Tạo VIEW tên `v_hoa_don_chi_tiet` hiển thị:
--      mã hóa đơn, tên khách hàng, số bàn, tầng, thời gian, trạng thái, tổng tiền
-- Gợi ý: tổng tiền = SUM(so_luong * don_gia) join từ chi_tiet_hoa_don
-- Viết SQL ở đây:


-- 12.4 Dùng `v_hoa_don_chi_tiet` để xem các hóa đơn đã thanh toán có tổng tiền > 300.000
-- Viết SQL ở đây:


-- BÀI 13: INDEX
-- -------------------------------------------------------

-- 13.1 Tạo index trên cột `ten` của bảng mon_an (để tìm kiếm theo tên nhanh hơn)
-- Viết SQL ở đây:


-- 13.2 Tạo index trên cột `sdt` của bảng khach_hang
-- Viết SQL ở đây:


-- 13.3 Dùng EXPLAIN để xem MySQL có sử dụng index không khi tìm kiếm:
--      SELECT * FROM mon_an WHERE ten = 'Phở bò tái chín';
-- Viết SQL ở đây:


-- 13.4 Xóa index `idx_ten_mon` trên bảng mon_an
-- Viết SQL ở đây:


-- BÀI 14: TRANSACTION
-- -------------------------------------------------------

-- 14.1 Viết transaction thực hiện việc "khách gọi thêm món":
--      - Thêm 1 bản ghi vào chi_tiet_hoa_don: hóa đơn 6, món "Bún bò Huế" (id=5), số lượng 1
--      - Commit nếu thành công
-- Viết SQL ở đây:


-- 14.2 Viết transaction chuyển hóa đơn 6 từ 'dang_an' sang 'thanh_toan':
--      - Cập nhật trang_thai hóa đơn 6
--      - Cộng 100 điểm cho khách hàng của hóa đơn 6
--      - Commit
-- Gợi ý: khách hàng của hóa đơn 6 có thể tìm bằng subquery
-- Viết SQL ở đây:


-- 14.3 Viết transaction mô phỏng lỗi và ROLLBACK:
--      - Bắt đầu transaction
--      - Thử update số lượng một món trong chi_tiet thành giá trị âm (-5)
--      - Nhận ra lỗi, ROLLBACK
--      - Kiểm tra lại dữ liệu không thay đổi
-- Viết SQL ở đây:


-- BÀI 15: STORED PROCEDURE
-- -------------------------------------------------------

-- 15.1 Tạo procedure `them_mon_an(ten, gia, danh_muc_id)`
--      để thêm một món ăn mới vào bảng mon_an
-- Viết SQL ở đây:


-- Gọi thử procedure vừa tạo:
-- CALL them_mon_an('Lẩu thái', 150000, 2);


-- 15.2 Tạo procedure `xem_hoa_don_khach(p_khach_hang_id INT)`
--      trả về tất cả hóa đơn của khách hàng đó kèm tổng tiền từng hóa đơn
-- Viết SQL ở đây:


-- Gọi thử:
-- CALL xem_hoa_don_khach(1);


-- 15.3 Tạo procedure `dat_ban(p_ban_id INT, p_khach_hang_id INT)`
--      tạo hóa đơn mới với trạng thái 'dang_an'
--      nếu bàn đó đang có hóa đơn 'dang_an' thì báo lỗi: SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '...'
-- Viết SQL ở đây:


-- BÀI 16: STORED FUNCTION
-- -------------------------------------------------------

-- 16.1 Tạo function `tinh_tong_hoa_don(p_hoa_don_id INT)` RETURNS DECIMAL(10,0)
--      trả về tổng tiền của hóa đơn đó
-- Viết SQL ở đây:


-- Dùng thử:
-- SELECT id, tinh_tong_hoa_don(id) AS tong_tien FROM hoa_don;


-- 16.2 Tạo function `xep_hang_khach(p_diem INT)` RETURNS VARCHAR(10)
--      trả về 'Vàng' / 'Bạc' / 'Đồng' / 'Thường' dựa trên điểm
-- Viết SQL ở đây:


-- Dùng thử:
-- SELECT ho_ten, diem, xep_hang_khach(diem) AS hang FROM khach_hang;


-- BÀI 17: TRIGGER
-- -------------------------------------------------------

-- 17.1 Tạo bảng log trước:
CREATE TABLE IF NOT EXISTS log_hoa_don (
    id          INT PRIMARY KEY AUTO_INCREMENT,
    hanh_dong   VARCHAR(20),
    hoa_don_id  INT,
    thoi_gian   DATETIME DEFAULT NOW(),
    ghi_chu     TEXT
);

-- 17.2 Tạo TRIGGER `sau_khi_them_hoa_don`
--      AFTER INSERT trên bảng hoa_don
--      Ghi vào log_hoa_don: hành động 'TAO_MOI', hoa_don_id, ghi chú 'Tạo hóa đơn mới'
-- Viết SQL ở đây:


-- Kiểm tra trigger: thêm hóa đơn mới rồi xem log
-- INSERT INTO hoa_don (ban_id, khach_hang_id) VALUES (3, 3);
-- SELECT * FROM log_hoa_don;


-- 17.3 Tạo TRIGGER `khi_huy_hoa_don`
--      BEFORE UPDATE trên bảng hoa_don
--      Nếu trang_thai mới là 'huy' thì ghi log: hành động 'HUY', kèm ghi chú 'Hóa đơn bị hủy'
-- Viết SQL ở đây:


-- 17.4 Tạo TRIGGER `sau_khi_goi_mon`
--      AFTER INSERT trên bảng chi_tiet_hoa_don
--      Tự động giảm số lượng (so_luong) trong bảng mon_an đi đúng số lượng vừa gọi
-- Viết SQL ở đây:


-- Kiểm tra:
-- SELECT ten, so_luong FROM mon_an WHERE id = 5;  -- trước
-- INSERT INTO chi_tiet_hoa_don (hoa_don_id, mon_an_id, so_luong, don_gia) VALUES (1, 5, 3, 70000);
-- SELECT ten, so_luong FROM mon_an WHERE id = 5;  -- sau (phải giảm 3)


-- ============================================================
-- GỢI Ý ĐÁP ÁN
-- ============================================================
/*

-- 12.1
CREATE VIEW v_menu_day_du AS
SELECT m.ten, m.gia, dm.ten AS danh_muc,
    CASE WHEN m.con_ban = TRUE THEN 'Còn bán' ELSE 'Ngừng bán' END AS trang_thai
FROM mon_an m
JOIN danh_muc_mon dm ON m.danh_muc_id = dm.id;

-- 12.2
SELECT * FROM v_menu_day_du WHERE danh_muc = 'Đồ uống' AND trang_thai = 'Còn bán';

-- 12.3
CREATE VIEW v_hoa_don_chi_tiet AS
SELECT h.id AS ma_hoa_don, kh.ho_ten AS khach_hang,
    b.so_ban, b.tang, h.thoi_gian, h.trang_thai,
    COALESCE(SUM(ct.so_luong * ct.don_gia), 0) AS tong_tien
FROM hoa_don h
JOIN khach_hang kh ON h.khach_hang_id = kh.id
JOIN ban_an b ON h.ban_id = b.id
LEFT JOIN chi_tiet_hoa_don ct ON h.id = ct.hoa_don_id
GROUP BY h.id, kh.ho_ten, b.so_ban, b.tang, h.thoi_gian, h.trang_thai;

-- 12.4
SELECT * FROM v_hoa_don_chi_tiet WHERE trang_thai = 'thanh_toan' AND tong_tien > 300000;

-- 13.1
CREATE INDEX idx_ten_mon ON mon_an(ten);

-- 13.2
CREATE INDEX idx_sdt_khach ON khach_hang(sdt);

-- 13.3
EXPLAIN SELECT * FROM mon_an WHERE ten = 'Phở bò tái chín';

-- 13.4
DROP INDEX idx_ten_mon ON mon_an;

-- 14.1
START TRANSACTION;
INSERT INTO chi_tiet_hoa_don (hoa_don_id, mon_an_id, so_luong, don_gia)
VALUES (6, 5, 1, 70000);
COMMIT;

-- 14.2
START TRANSACTION;
UPDATE hoa_don SET trang_thai = 'thanh_toan' WHERE id = 6;
UPDATE khach_hang SET diem = diem + 100
WHERE id = (SELECT khach_hang_id FROM hoa_don WHERE id = 6);
COMMIT;

-- 14.3
START TRANSACTION;
UPDATE chi_tiet_hoa_don SET so_luong = -5 WHERE id = 1;
-- nhận ra sai
ROLLBACK;
SELECT * FROM chi_tiet_hoa_don WHERE id = 1; -- vẫn như cũ

-- 15.1
DELIMITER //
CREATE PROCEDURE them_mon_an(IN p_ten VARCHAR(150), IN p_gia DECIMAL(10,0), IN p_danh_muc_id INT)
BEGIN
    INSERT INTO mon_an (ten, gia, danh_muc_id) VALUES (p_ten, p_gia, p_danh_muc_id);
    SELECT LAST_INSERT_ID() AS id_moi;
END //
DELIMITER ;

-- 15.2
DELIMITER //
CREATE PROCEDURE xem_hoa_don_khach(IN p_khach_hang_id INT)
BEGIN
    SELECT h.id, h.thoi_gian, h.trang_thai,
        COALESCE(SUM(ct.so_luong * ct.don_gia), 0) AS tong_tien
    FROM hoa_don h
    LEFT JOIN chi_tiet_hoa_don ct ON h.id = ct.hoa_don_id
    WHERE h.khach_hang_id = p_khach_hang_id
    GROUP BY h.id, h.thoi_gian, h.trang_thai;
END //
DELIMITER ;

-- 15.3
DELIMITER //
CREATE PROCEDURE dat_ban(IN p_ban_id INT, IN p_khach_hang_id INT)
BEGIN
    DECLARE v_dang_su_dung INT;
    SELECT COUNT(*) INTO v_dang_su_dung FROM hoa_don
    WHERE ban_id = p_ban_id AND trang_thai = 'dang_an';
    IF v_dang_su_dung > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Bàn đang có khách, không thể đặt!';
    ELSE
        INSERT INTO hoa_don (ban_id, khach_hang_id) VALUES (p_ban_id, p_khach_hang_id);
        SELECT LAST_INSERT_ID() AS hoa_don_id;
    END IF;
END //
DELIMITER ;

-- 16.1
DELIMITER //
CREATE FUNCTION tinh_tong_hoa_don(p_hoa_don_id INT) RETURNS DECIMAL(10,0)
READS SQL DATA
BEGIN
    DECLARE v_tong DECIMAL(10,0);
    SELECT COALESCE(SUM(so_luong * don_gia), 0) INTO v_tong
    FROM chi_tiet_hoa_don WHERE hoa_don_id = p_hoa_don_id;
    RETURN v_tong;
END //
DELIMITER ;

-- 16.2
DELIMITER //
CREATE FUNCTION xep_hang_khach(p_diem INT) RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    DECLARE v_hang VARCHAR(10);
    SET v_hang = CASE
        WHEN p_diem >= 400 THEN 'Vàng'
        WHEN p_diem >= 200 THEN 'Bạc'
        WHEN p_diem >= 100 THEN 'Đồng'
        ELSE 'Thường'
    END;
    RETURN v_hang;
END //
DELIMITER ;

-- 17.2
DELIMITER //
CREATE TRIGGER sau_khi_them_hoa_don
AFTER INSERT ON hoa_don
FOR EACH ROW
BEGIN
    INSERT INTO log_hoa_don (hanh_dong, hoa_don_id, ghi_chu)
    VALUES ('TAO_MOI', NEW.id, 'Tạo hóa đơn mới');
END //
DELIMITER ;

-- 17.3
DELIMITER //
CREATE TRIGGER khi_huy_hoa_don
BEFORE UPDATE ON hoa_don
FOR EACH ROW
BEGIN
    IF NEW.trang_thai = 'huy' THEN
        INSERT INTO log_hoa_don (hanh_dong, hoa_don_id, ghi_chu)
        VALUES ('HUY', OLD.id, 'Hóa đơn bị hủy');
    END IF;
END //
DELIMITER ;

-- 17.4
DELIMITER //
CREATE TRIGGER sau_khi_goi_mon
AFTER INSERT ON chi_tiet_hoa_don
FOR EACH ROW
BEGIN
    UPDATE mon_an SET so_luong = so_luong - NEW.so_luong WHERE id = NEW.mon_an_id;
END //
DELIMITER ;

*/
