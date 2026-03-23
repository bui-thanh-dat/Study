# Ngày 5: SELECT - Truy Vấn Dữ Liệu Cơ Bản

## Cú pháp SELECT

```sql
SELECT cot1, cot2, ...
FROM ten_bang
WHERE dieu_kien
ORDER BY cot ASC|DESC
LIMIT so_luong OFFSET vi_tri_bat_dau;
```

---

## Lấy dữ liệu cơ bản

```sql
-- Lấy tất cả cột
SELECT * FROM san_pham;

-- Lấy cột cụ thể
SELECT ten, gia, so_luong FROM san_pham;

-- Đặt alias (tên hiển thị) cho cột
SELECT
    ten        AS ten_san_pham,
    gia        AS don_gia,
    so_luong   AS ton_kho
FROM san_pham;

-- Đặt alias cho bảng
SELECT sp.ten, sp.gia
FROM san_pham sp;
```

---

## Lọc dữ liệu với WHERE

```sql
-- So sánh
SELECT * FROM san_pham WHERE gia > 1000000;
SELECT * FROM san_pham WHERE gia = 250000;
SELECT * FROM san_pham WHERE gia <> 250000;   -- khác
SELECT * FROM san_pham WHERE gia != 250000;   -- khác (cách khác)

-- Kết hợp nhiều điều kiện
SELECT * FROM san_pham WHERE gia > 100000 AND so_luong > 50;
SELECT * FROM san_pham WHERE danh_muc_id = 1 OR danh_muc_id = 2;
SELECT * FROM san_pham WHERE NOT danh_muc_id = 3;

-- Kết hợp AND và OR (dùng ngoặc để rõ ràng)
SELECT * FROM san_pham
WHERE (danh_muc_id = 1 OR danh_muc_id = 2)
  AND gia > 500000;
```

---

## Sắp xếp với ORDER BY

```sql
-- Sắp xếp tăng dần (mặc định)
SELECT * FROM san_pham ORDER BY gia;
SELECT * FROM san_pham ORDER BY gia ASC;

-- Sắp xếp giảm dần
SELECT * FROM san_pham ORDER BY gia DESC;

-- Sắp xếp theo nhiều cột
SELECT * FROM san_pham ORDER BY danh_muc_id ASC, gia DESC;
```

---

## Giới hạn kết quả với LIMIT

```sql
-- Lấy 5 bản ghi đầu tiên
SELECT * FROM san_pham LIMIT 5;

-- Phân trang: bỏ qua 10, lấy 5 tiếp theo (trang 3, mỗi trang 5)
SELECT * FROM san_pham LIMIT 5 OFFSET 10;

-- Cú pháp ngắn: LIMIT offset, count
SELECT * FROM san_pham LIMIT 10, 5;
```

---

## Loại bỏ trùng lặp với DISTINCT

```sql
-- Xem có bao nhiêu danh mục đang có sản phẩm
SELECT DISTINCT danh_muc_id FROM san_pham;

-- Kết hợp nhiều cột
SELECT DISTINCT danh_muc_id, so_luong FROM san_pham;
```

---

## Tính toán trong SELECT

```sql
-- Tính toán trực tiếp
SELECT ten, gia, gia * 0.9 AS gia_sau_giam FROM san_pham;

-- Nối chuỗi
SELECT CONCAT(ho_ten, ' - ', email) AS thong_tin FROM khach_hang;

-- Hàm chuỗi
SELECT UPPER(ten) AS ten_viet_hoa FROM san_pham;
SELECT LOWER(email) FROM khach_hang;
SELECT LENGTH(ho_ten) AS do_dai_ten FROM khach_hang;
```

---

## Thực hành tổng hợp

```sql
USE shop;

-- 1. Lấy 3 sản phẩm đắt nhất
SELECT ten, gia FROM san_pham ORDER BY gia DESC LIMIT 3;

-- 2. Sản phẩm thuộc danh mục 1, giá dưới 30 triệu
SELECT ten, gia, so_luong
FROM san_pham
WHERE danh_muc_id = 1 AND gia < 30000000
ORDER BY gia DESC;

-- 3. Tìm khách hàng ở Hà Nội hoặc TP.HCM
SELECT ho_ten, email, dia_chi
FROM khach_hang
WHERE dia_chi = 'Hà Nội' OR dia_chi = 'TP.HCM';

-- 4. Sản phẩm tồn kho nhiều nhất (top 3)
SELECT ten, so_luong
FROM san_pham
ORDER BY so_luong DESC
LIMIT 3;
```

---

## Bài tập thực hành
1. Lấy danh sách tất cả sinh viên, sắp xếp theo tên
2. Lấy 3 sinh viên đầu tiên trong danh sách
3. Tìm sinh viên có tên bắt đầu bằng chữ 'N' (sẽ học LIKE ngày 8)
4. Hiển thị tên và email của sinh viên với alias rõ ràng

## Ghi chú cá nhân
> _(Ghi lại những điều bạn học được hoặc gặp khó khăn ở đây)_
