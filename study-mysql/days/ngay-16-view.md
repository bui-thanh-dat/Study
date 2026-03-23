# Ngày 16: VIEW - Bảng Ảo

## VIEW là gì?
**VIEW** là một câu truy vấn SELECT được lưu lại với tên, dùng như một bảng ảo.
- Không lưu dữ liệu thực, chỉ lưu câu truy vấn
- Mỗi lần truy vấn VIEW → MySQL chạy lại SELECT gốc

### Lợi ích:
- **Đơn giản hóa:** ẩn độ phức tạp của JOIN nhiều bảng
- **Bảo mật:** giới hạn dữ liệu người dùng được xem
- **Tái sử dụng:** viết query 1 lần, dùng nhiều lần

---

## Tạo VIEW

```sql
-- Cú pháp
CREATE VIEW ten_view AS
SELECT ...;

-- Ví dụ: View đơn hàng chi tiết
CREATE VIEW v_don_hang_chi_tiet AS
SELECT
    dh.id AS ma_don,
    kh.ho_ten AS khach_hang,
    kh.email,
    dh.ngay_dat,
    dh.tong_tien,
    dh.trang_thai
FROM don_hang dh
JOIN khach_hang kh ON dh.khach_hang_id = kh.id;

-- Sử dụng như bảng thường
SELECT * FROM v_don_hang_chi_tiet;
SELECT * FROM v_don_hang_chi_tiet WHERE trang_thai = 'da_giao';
SELECT * FROM v_don_hang_chi_tiet WHERE khach_hang = 'Nguyễn Văn An';
```

---

## Tạo nhiều VIEW hữu ích

```sql
-- View: thống kê sản phẩm theo danh mục
CREATE VIEW v_thong_ke_danh_muc AS
SELECT
    dm.id,
    dm.ten AS danh_muc,
    COUNT(sp.id) AS so_san_pham,
    COALESCE(SUM(sp.so_luong), 0) AS tong_ton_kho,
    COALESCE(ROUND(AVG(sp.gia), 0), 0) AS gia_trung_binh
FROM danh_muc dm
LEFT JOIN san_pham sp ON dm.id = sp.danh_muc_id
GROUP BY dm.id, dm.ten;

-- View: khách hàng VIP (đã chi hơn 20 triệu)
CREATE VIEW v_khach_hang_vip AS
SELECT
    kh.id,
    kh.ho_ten,
    kh.email,
    COUNT(dh.id) AS so_don,
    SUM(dh.tong_tien) AS tong_chi_tieu
FROM khach_hang kh
JOIN don_hang dh ON kh.id = dh.khach_hang_id
GROUP BY kh.id, kh.ho_ten, kh.email
HAVING tong_chi_tieu > 20000000;

-- View: sản phẩm bán chạy (đã bán hơn 5 cái)
CREATE VIEW v_san_pham_ban_chay AS
SELECT
    sp.id,
    sp.ten,
    sp.gia,
    SUM(ct.so_luong) AS da_ban
FROM san_pham sp
JOIN chi_tiet_don_hang ct ON sp.id = ct.san_pham_id
GROUP BY sp.id, sp.ten, sp.gia
HAVING da_ban > 5;
```

---

## Quản lý VIEW

```sql
-- Xem danh sách VIEW
SHOW FULL TABLES WHERE Table_type = 'VIEW';

-- Xem định nghĩa VIEW
SHOW CREATE VIEW v_don_hang_chi_tiet;

-- Sửa VIEW
CREATE OR REPLACE VIEW v_don_hang_chi_tiet AS
SELECT
    dh.id AS ma_don,
    kh.ho_ten AS khach_hang,
    dh.ngay_dat,
    dh.tong_tien,
    dh.trang_thai,
    COUNT(ct.id) AS so_san_pham  -- thêm cột mới
FROM don_hang dh
JOIN khach_hang kh ON dh.khach_hang_id = kh.id
LEFT JOIN chi_tiet_don_hang ct ON dh.id = ct.don_hang_id
GROUP BY dh.id, kh.ho_ten, dh.ngay_dat, dh.tong_tien, dh.trang_thai;

-- Xóa VIEW
DROP VIEW v_don_hang_chi_tiet;
DROP VIEW IF EXISTS v_don_hang_chi_tiet;
```

---

## VIEW có thể cập nhật dữ liệu không?

```sql
-- View đơn giản (1 bảng, không GROUP BY) → CÓ THỂ UPDATE
CREATE VIEW v_san_pham_don_gian AS
SELECT id, ten, gia FROM san_pham WHERE danh_muc_id = 1;

UPDATE v_san_pham_don_gian SET gia = 25000000 WHERE id = 1;  -- CÓ THỂ

-- View phức tạp (JOIN, GROUP BY, DISTINCT...) → KHÔNG THỂ UPDATE
UPDATE v_don_hang_chi_tiet SET tong_tien = 100 WHERE ma_don = 1;  -- LỖI!
```

---

## WITH CHECK OPTION

```sql
-- Đảm bảo dữ liệu INSERT/UPDATE qua view phải thỏa mãn điều kiện view
CREATE VIEW v_san_pham_gia_cao AS
SELECT id, ten, gia
FROM san_pham
WHERE gia > 1000000
WITH CHECK OPTION;

-- Sẽ báo lỗi vì 500000 < 1000000 (vi phạm điều kiện view)
INSERT INTO v_san_pham_gia_cao (ten, gia) VALUES ('Sản phẩm rẻ', 500000);
```

---

## Thực hành tổng hợp

```sql
USE shop;

-- Tạo view tổng hợp
CREATE VIEW v_bao_cao_shop AS
SELECT
    dm.ten AS danh_muc,
    COUNT(DISTINCT sp.id) AS so_san_pham,
    SUM(sp.so_luong) AS ton_kho,
    COALESCE(SUM(ct.so_luong), 0) AS da_ban,
    ROUND(AVG(sp.gia), 0) AS gia_tb
FROM danh_muc dm
LEFT JOIN san_pham sp ON dm.id = sp.danh_muc_id
LEFT JOIN chi_tiet_don_hang ct ON sp.id = ct.san_pham_id
GROUP BY dm.id, dm.ten;

-- Sử dụng
SELECT * FROM v_bao_cao_shop;
SELECT * FROM v_bao_cao_shop WHERE da_ban > 0 ORDER BY da_ban DESC;
```

---

## Bài tập thực hành
1. Tạo view `v_danh_sach_sinh_vien` hiển thị họ tên, lớp, email
2. Tạo view `v_bang_diem` hiển thị tên sinh viên, tên môn, điểm
3. Tạo view `v_diem_cao` chỉ hiển thị điểm >= 8
4. Dùng view để lấy top 3 sinh viên có điểm trung bình cao nhất

## Ghi chú cá nhân
> _(Ghi lại những điều bạn học được hoặc gặp khó khăn ở đây)_
