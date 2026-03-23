-- ============================================================
-- NGÀY 11: LEFT JOIN, RIGHT JOIN, SELF JOIN
-- ============================================================

USE hoc_mysql;

-- ==============================
-- PHẦN 1: LEFT JOIN
-- ==============================

-- BƯỚC 1: Nhắc lại INNER JOIN (chỉ bản ghi khớp)
SELECT kh.ho_ten, dh.id AS ma_don
FROM khach_hang kh
INNER JOIN don_hang dh ON kh.id = dh.khach_hang_id;
-- Chỉ thấy khách hàng CÓ đơn hàng

-- BƯỚC 2: LEFT JOIN (tất cả khách hàng, kể cả chưa có đơn)
SELECT kh.ho_ten, dh.id AS ma_don
FROM khach_hang kh
LEFT JOIN don_hang dh ON kh.id = dh.khach_hang_id;
-- Thấy TẤT CẢ khách hàng, không có đơn thì ma_don = NULL

-- BƯỚC 3: Khách hàng CHƯA MUA HÀNG (dùng IS NULL)
SELECT kh.ho_ten, kh.email
FROM khach_hang kh
LEFT JOIN don_hang dh ON kh.id = dh.khach_hang_id
WHERE dh.id IS NULL;

-- BƯỚC 4: Đếm đơn hàng của mỗi khách (kể cả khách chưa mua = 0)
SELECT
    kh.ho_ten,
    COUNT(dh.id) AS so_don_hang  -- NULL không được đếm
FROM khach_hang kh
LEFT JOIN don_hang dh ON kh.id = dh.khach_hang_id
GROUP BY kh.id, kh.ho_ten
ORDER BY so_don_hang DESC;

-- BƯỚC 5: Tất cả danh mục và số sản phẩm (kể cả danh mục trống)
SELECT
    dm.ten AS danh_muc,
    COUNT(sp.id) AS so_san_pham
FROM danh_muc dm
LEFT JOIN san_pham sp ON dm.id = sp.danh_muc_id
GROUP BY dm.id, dm.ten
ORDER BY so_san_pham DESC;

-- BƯỚC 6: Danh mục CHƯA CÓ sản phẩm nào
SELECT dm.ten AS danh_muc_trong
FROM danh_muc dm
LEFT JOIN san_pham sp ON dm.id = sp.danh_muc_id
WHERE sp.id IS NULL;

-- ==============================
-- PHẦN 2: RIGHT JOIN
-- ==============================

-- BƯỚC 7: RIGHT JOIN (tất cả bảng phải)
SELECT kh.ho_ten, dh.id AS ma_don, dh.tong_tien
FROM khach_hang kh
RIGHT JOIN don_hang dh ON kh.id = dh.khach_hang_id;
-- Tất cả đơn hàng, kể cả không tìm thấy khách

-- Ghi chú: RIGHT JOIN ít dùng hơn, thường đổi thứ tự bảng để dùng LEFT JOIN cho rõ hơn
-- Câu trên tương đương với:
SELECT kh.ho_ten, dh.id AS ma_don, dh.tong_tien
FROM don_hang dh
LEFT JOIN khach_hang kh ON kh.id = dh.khach_hang_id;

-- ==============================
-- PHẦN 3: SELF JOIN
-- ==============================

-- BƯỚC 8: Tạo bảng nhân viên có quan hệ cấp bậc
CREATE TABLE IF NOT EXISTS nhan_vien_ql (
    id         INT PRIMARY KEY AUTO_INCREMENT,
    ho_ten     VARCHAR(100) NOT NULL,
    chuc_vu    VARCHAR(100),
    quan_ly_id INT,
    luong      DECIMAL(12, 2),
    FOREIGN KEY (quan_ly_id) REFERENCES nhan_vien_ql(id)
);

INSERT INTO nhan_vien_ql (ho_ten, chuc_vu, quan_ly_id, luong) VALUES
    ('Nguyễn CEO', 'Giám đốc', NULL, 50000000),
    ('Trần Trưởng KD', 'Trưởng phòng KD', 1, 25000000),
    ('Lê Trưởng KT', 'Trưởng phòng KT', 1, 23000000),
    ('Phạm NV KD1', 'Nhân viên KD', 2, 12000000),
    ('Hoàng NV KD2', 'Nhân viên KD', 2, 11000000),
    ('Đặng NV KT1', 'Nhân viên KT', 3, 13000000);

SELECT * FROM nhan_vien_ql;

-- BƯỚC 9: SELF JOIN - Hiển thị nhân viên và tên quản lý
SELECT
    nv.ho_ten AS nhan_vien,
    nv.chuc_vu,
    COALESCE(ql.ho_ten, '-- Lãnh đạo cao nhất --') AS quan_ly
FROM nhan_vien_ql nv
LEFT JOIN nhan_vien_ql ql ON nv.quan_ly_id = ql.id
ORDER BY ql.id, nv.id;

-- BƯỚC 10: Tìm nhân viên cùng quản lý
SELECT
    a.ho_ten AS nhan_vien_1,
    b.ho_ten AS nhan_vien_2,
    ql.ho_ten AS quan_ly_chung
FROM nhan_vien_ql a
JOIN nhan_vien_ql b ON a.quan_ly_id = b.quan_ly_id AND a.id < b.id
JOIN nhan_vien_ql ql ON a.quan_ly_id = ql.id;

-- ==============================
-- PHẦN 4: TỔNG HỢP
-- ==============================

-- BƯỚC 11: Báo cáo đầy đủ - tất cả sản phẩm và số lần bán
SELECT
    dm.ten AS danh_muc,
    sp.ten AS san_pham,
    sp.so_luong AS ton_kho,
    COALESCE(SUM(ct.so_luong), 0) AS da_ban
FROM san_pham sp
JOIN danh_muc dm ON sp.danh_muc_id = dm.id
LEFT JOIN chi_tiet_don_hang ct ON sp.id = ct.san_pham_id
GROUP BY sp.id, dm.ten, sp.ten, sp.so_luong
ORDER BY dm.ten, da_ban DESC;

-- ============================================================
-- BÀI TẬP:
-- 1. Tìm sản phẩm chưa có trong bất kỳ đơn hàng nào
-- 2. Đếm số đơn hàng mỗi khách (kể cả 0), chỉ hiển thị khách chưa mua
-- 3. Trong bảng nhan_vien_ql: nhân viên nào có lương cao hơn quản lý của mình?
-- ============================================================

-- Giải bài tập
-- 1.
SELECT sp.ten, sp.gia
FROM san_pham sp
LEFT JOIN chi_tiet_don_hang ct ON sp.id = ct.san_pham_id
WHERE ct.id IS NULL;

-- 2.
SELECT kh.ho_ten, COUNT(dh.id) AS so_don
FROM khach_hang kh
LEFT JOIN don_hang dh ON kh.id = dh.khach_hang_id
GROUP BY kh.id, kh.ho_ten
HAVING so_don = 0;

-- 3.
SELECT
    nv.ho_ten AS nhan_vien,
    nv.luong AS luong_nv,
    ql.ho_ten AS quan_ly,
    ql.luong AS luong_ql
FROM nhan_vien_ql nv
JOIN nhan_vien_ql ql ON nv.quan_ly_id = ql.id
WHERE nv.luong > ql.luong;
