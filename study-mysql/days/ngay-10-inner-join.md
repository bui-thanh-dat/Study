# Ngày 10: INNER JOIN - Kết Hợp Bảng

## JOIN là gì?
`JOIN` dùng để kết hợp dữ liệu từ 2 hoặc nhiều bảng dựa trên một điều kiện liên kết (thường là Foreign Key).

## INNER JOIN
Chỉ trả về các bản ghi **khớp ở cả hai bảng**.

```
Bảng A     ∩     Bảng B
         [khớp]
```

---

## Cú pháp

```sql
SELECT cot1, cot2, ...
FROM bang_chinh
INNER JOIN bang_phu ON bang_chinh.khoa = bang_phu.khoa;

-- Viết tắt (JOIN = INNER JOIN)
SELECT cot1, cot2
FROM bang_chinh
JOIN bang_phu ON bang_chinh.khoa = bang_phu.khoa;
```

---

## Ví dụ cơ bản

```sql
USE shop;

-- Lấy sản phẩm kèm tên danh mục
SELECT sp.ten, sp.gia, dm.ten AS danh_muc
FROM san_pham sp
INNER JOIN danh_muc dm ON sp.danh_muc_id = dm.id;

-- Sản phẩm danh mục "Điện tử"
SELECT sp.ten, sp.gia
FROM san_pham sp
INNER JOIN danh_muc dm ON sp.danh_muc_id = dm.id
WHERE dm.ten = 'Điện tử';
```

---

## JOIN 3 bảng trở lên

```sql
-- Setup thêm bảng đơn hàng
CREATE TABLE don_hang (
    id            INT PRIMARY KEY AUTO_INCREMENT,
    khach_hang_id INT NOT NULL,
    ngay_dat      DATETIME DEFAULT CURRENT_TIMESTAMP,
    tong_tien     DECIMAL(15, 2),
    trang_thai    VARCHAR(50) DEFAULT 'cho_xu_ly',
    FOREIGN KEY (khach_hang_id) REFERENCES khach_hang(id)
);

CREATE TABLE chi_tiet_don_hang (
    id          INT PRIMARY KEY AUTO_INCREMENT,
    don_hang_id INT NOT NULL,
    san_pham_id INT NOT NULL,
    so_luong    INT NOT NULL,
    don_gia     DECIMAL(15, 2) NOT NULL,
    FOREIGN KEY (don_hang_id) REFERENCES don_hang(id),
    FOREIGN KEY (san_pham_id) REFERENCES san_pham(id)
);

-- Insert dữ liệu mẫu
INSERT INTO don_hang (khach_hang_id, tong_tien, trang_thai) VALUES
    (1, 27990000, 'da_giao'),
    (2, 700000, 'dang_giao'),
    (1, 120000, 'da_giao');

INSERT INTO chi_tiet_don_hang (don_hang_id, san_pham_id, so_luong, don_gia) VALUES
    (1, 1, 1, 27990000),
    (2, 4, 2, 250000),
    (2, 5, 1, 450000) -- Chú ý: 2*250k + 1*450k = 950k ≠ 700k (ví dụ thực tế có thể khác)
    (3, 6, 1, 120000);

-- JOIN 3 bảng: đơn hàng + khách hàng + chi tiết
SELECT
    dh.id AS ma_don,
    kh.ho_ten AS khach_hang,
    sp.ten AS san_pham,
    ct.so_luong,
    ct.don_gia,
    ct.so_luong * ct.don_gia AS thanh_tien
FROM chi_tiet_don_hang ct
JOIN don_hang dh ON ct.don_hang_id = dh.id
JOIN khach_hang kh ON dh.khach_hang_id = kh.id
JOIN san_pham sp ON ct.san_pham_id = sp.id;
```

---

## Alias giúp code ngắn gọn hơn

```sql
-- Dài dòng
SELECT san_pham.ten, danh_muc.ten
FROM san_pham
JOIN danh_muc ON san_pham.danh_muc_id = danh_muc.id;

-- Gọn hơn với alias
SELECT sp.ten AS san_pham, dm.ten AS danh_muc
FROM san_pham sp
JOIN danh_muc dm ON sp.danh_muc_id = dm.id;
```

---

## INNER JOIN với GROUP BY

```sql
-- Doanh thu theo từng khách hàng
SELECT
    kh.ho_ten,
    COUNT(dh.id) AS so_don,
    SUM(dh.tong_tien) AS tong_chi_tieu
FROM khach_hang kh
JOIN don_hang dh ON kh.id = dh.khach_hang_id
GROUP BY kh.id, kh.ho_ten
ORDER BY tong_chi_tieu DESC;

-- Số lượng sản phẩm bán ra theo danh mục
SELECT
    dm.ten AS danh_muc,
    SUM(ct.so_luong) AS da_ban
FROM chi_tiet_don_hang ct
JOIN san_pham sp ON ct.san_pham_id = sp.id
JOIN danh_muc dm ON sp.danh_muc_id = dm.id
GROUP BY dm.id, dm.ten
ORDER BY da_ban DESC;
```

---

## Thực hành tổng hợp

```sql
USE shop;

-- 1. Danh sách sản phẩm và tên danh mục
SELECT sp.id, sp.ten, sp.gia, dm.ten AS danh_muc
FROM san_pham sp
JOIN danh_muc dm ON sp.danh_muc_id = dm.id
ORDER BY dm.ten, sp.ten;

-- 2. Đơn hàng của từng khách hàng
SELECT
    kh.ho_ten,
    dh.id AS ma_don,
    dh.ngay_dat,
    dh.tong_tien,
    dh.trang_thai
FROM don_hang dh
JOIN khach_hang kh ON dh.khach_hang_id = kh.id
ORDER BY kh.ho_ten, dh.ngay_dat DESC;

-- 3. Chi tiết đơn hàng số 1
SELECT
    sp.ten AS san_pham,
    ct.so_luong,
    ct.don_gia,
    ct.so_luong * ct.don_gia AS thanh_tien
FROM chi_tiet_don_hang ct
JOIN san_pham sp ON ct.san_pham_id = sp.id
WHERE ct.don_hang_id = 1;
```

---

## Bài tập thực hành
1. Lấy danh sách sinh viên kèm tên lớp
2. Lấy điểm sinh viên kèm tên môn học và tên sinh viên
3. Tính điểm trung bình của từng sinh viên (GROUP BY + JOIN)
4. Tìm sinh viên có điểm môn "Toán" cao nhất

## Ghi chú cá nhân
> _(Ghi lại những điều bạn học được hoặc gặp khó khăn ở đây)_
