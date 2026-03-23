-- ============================================================
-- NGÀY 7: UPDATE và DELETE
-- ============================================================

USE hoc_mysql;

-- *** LUÔN SELECT TRƯỚC KHI UPDATE/DELETE ***

-- ==============================
-- PHẦN 1: UPDATE
-- ==============================

-- BƯỚC 1: Xem dữ liệu trước khi sửa
SELECT id, ten, gia FROM san_pham WHERE id = 1;

-- BƯỚC 2: Cập nhật 1 cột
UPDATE san_pham SET gia = 26990000 WHERE id = 1;

-- Kiểm tra kết quả
SELECT id, ten, gia FROM san_pham WHERE id = 1;

-- BƯỚC 3: Cập nhật nhiều cột cùng lúc
SELECT id, ten, gia, so_luong FROM san_pham WHERE id = 2;

UPDATE san_pham
SET gia = 21990000, so_luong = 25
WHERE id = 2;

SELECT id, ten, gia, so_luong FROM san_pham WHERE id = 2;

-- BƯỚC 4: Cập nhật dựa trên giá trị hiện tại
-- Tăng giá tất cả sản phẩm danh mục 1 lên 5%
SELECT ten, gia FROM san_pham WHERE danh_muc_id = 1;

UPDATE san_pham
SET gia = gia * 1.05
WHERE danh_muc_id = 1;

SELECT ten, gia FROM san_pham WHERE danh_muc_id = 1;

-- BƯỚC 5: Cập nhật nhiều bản ghi với IN
SELECT ten, so_luong FROM san_pham WHERE id IN (8, 9);

UPDATE san_pham
SET so_luong = so_luong + 100
WHERE id IN (8, 9);

SELECT ten, so_luong FROM san_pham WHERE id IN (8, 9);

-- BƯỚC 6: Cập nhật với CASE WHEN (điều kiện phân nhánh)
-- Giảm giá: điện tử -10%, thời trang -15%, còn lại giữ nguyên
SELECT ten, danh_muc_id, gia FROM san_pham ORDER BY danh_muc_id;

UPDATE san_pham
SET gia = CASE
    WHEN danh_muc_id = 1 THEN gia * 0.90
    WHEN danh_muc_id = 2 THEN gia * 0.85
    ELSE gia
END;

SELECT ten, danh_muc_id, gia FROM san_pham ORDER BY danh_muc_id;

-- BƯỚC 7: Cập nhật địa chỉ khách hàng
SELECT id, ho_ten, dia_chi FROM khach_hang;

UPDATE khach_hang
SET dia_chi = 'Quận 1, TP.HCM'
WHERE email = 'binh.tran@email.com';

SELECT ho_ten, dia_chi FROM khach_hang WHERE email = 'binh.tran@email.com';

-- ==============================
-- PHẦN 2: DELETE
-- ==============================

-- BƯỚC 8: Xem trước khi xóa (LUÔN LÀM ĐIỀU NÀY!)
SELECT * FROM san_pham WHERE so_luong = 0;

-- Xóa sản phẩm hết hàng
DELETE FROM san_pham WHERE so_luong = 0;

-- Kiểm tra sau khi xóa
SELECT COUNT(*) AS con_lai FROM san_pham;

-- BƯỚC 9: Xóa với giới hạn (chỉ xóa tối đa N bản ghi)
-- Thêm vài bản ghi tạm để test
INSERT INTO danh_muc (ten) VALUES ('Tạm 1'), ('Tạm 2'), ('Tạm 3');
SELECT * FROM danh_muc;

-- Chỉ xóa 2 bản ghi
DELETE FROM danh_muc WHERE ten LIKE 'Tạm%' LIMIT 2;
SELECT * FROM danh_muc;

-- Xóa nốt
DELETE FROM danh_muc WHERE ten LIKE 'Tạm%';
SELECT * FROM danh_muc;

-- ==============================
-- PHẦN 3: TRANSACTION AN TOÀN
-- ==============================

-- BƯỚC 10: Dùng Transaction để an toàn
START TRANSACTION;

-- Thay đổi dữ liệu
UPDATE khach_hang SET dia_chi = 'TEST THÔI' WHERE id = 1;

-- Kiểm tra
SELECT id, ho_ten, dia_chi FROM khach_hang WHERE id = 1;

-- Hoàn tác (vì đây chỉ là test)
ROLLBACK;

-- Kiểm tra lại → dữ liệu trở về
SELECT id, ho_ten, dia_chi FROM khach_hang WHERE id = 1;

-- ============================================================
-- BÀI TẬP:
-- 1. Tăng giá tất cả sản phẩm sách lên 10%
-- 2. Cập nhật trạng thái đơn hàng id=4 thành "da_giao"
-- 3. Xóa sản phẩm có id = 13 (iPad Pro đã thêm ngày 4)
--    → Nhớ SELECT trước!
-- 4. Dùng TRANSACTION để thực hiện đổi địa chỉ khách hàng,
--    kiểm tra, rồi COMMIT nếu đúng
-- ============================================================

-- Giải bài tập
-- 1.
SELECT ten, gia FROM san_pham WHERE danh_muc_id = 4;
UPDATE san_pham SET gia = gia * 1.1 WHERE danh_muc_id = 4;
SELECT ten, gia FROM san_pham WHERE danh_muc_id = 4;

-- 2.
SELECT id, trang_thai FROM don_hang WHERE id = 4;
UPDATE don_hang SET trang_thai = 'da_giao' WHERE id = 4;
SELECT id, trang_thai FROM don_hang WHERE id = 4;

-- 3.
SELECT * FROM san_pham WHERE id = 13;
DELETE FROM san_pham WHERE id = 13;

-- 4.
START TRANSACTION;
UPDATE khach_hang SET dia_chi = 'Quận 3, TP.HCM' WHERE id = 2;
SELECT ho_ten, dia_chi FROM khach_hang WHERE id = 2;
COMMIT;
