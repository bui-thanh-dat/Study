# Ngày 11: LEFT JOIN, RIGHT JOIN và SELF JOIN

## LEFT JOIN
Lấy **tất cả bản ghi bảng trái**, bảng phải nếu không khớp thì NULL.

```
[Tất cả A] + [Phần khớp B]
```

```sql
SELECT cot1, cot2
FROM bang_trai
LEFT JOIN bang_phai ON bang_trai.khoa = bang_phai.khoa;
```

---

## RIGHT JOIN
Lấy **tất cả bản ghi bảng phải**, bảng trái nếu không khớp thì NULL.

```
[Phần khớp A] + [Tất cả B]
```

```sql
SELECT cot1, cot2
FROM bang_trai
RIGHT JOIN bang_phai ON bang_trai.khoa = bang_phai.khoa;
```

---

## So sánh 4 loại JOIN

```sql
-- INNER JOIN: chỉ bản ghi khớp cả 2 bảng
SELECT kh.ho_ten, dh.id
FROM khach_hang kh
INNER JOIN don_hang dh ON kh.id = dh.khach_hang_id;

-- LEFT JOIN: tất cả khách hàng (kể cả chưa có đơn)
SELECT kh.ho_ten, dh.id AS ma_don
FROM khach_hang kh
LEFT JOIN don_hang dh ON kh.id = dh.khach_hang_id;

-- RIGHT JOIN: tất cả đơn hàng (kể cả không tìm thấy khách)
SELECT kh.ho_ten, dh.id AS ma_don
FROM khach_hang kh
RIGHT JOIN don_hang dh ON kh.id = dh.khach_hang_id;
```

---

## Ứng dụng thực tế của LEFT JOIN

### Tìm bản ghi không có trong bảng phụ
```sql
-- Khách hàng CHƯA mua hàng lần nào
SELECT kh.ho_ten, kh.email
FROM khach_hang kh
LEFT JOIN don_hang dh ON kh.id = dh.khach_hang_id
WHERE dh.id IS NULL;

-- Danh mục chưa có sản phẩm nào
SELECT dm.ten AS danh_muc
FROM danh_muc dm
LEFT JOIN san_pham sp ON dm.id = sp.danh_muc_id
WHERE sp.id IS NULL;
```

### Thống kê kể cả khi không có dữ liệu
```sql
-- Số đơn hàng của mỗi khách (kể cả khách chưa mua = 0)
SELECT
    kh.ho_ten,
    COUNT(dh.id) AS so_don_hang  -- NULL không được đếm bởi COUNT()
FROM khach_hang kh
LEFT JOIN don_hang dh ON kh.id = dh.khach_hang_id
GROUP BY kh.id, kh.ho_ten
ORDER BY so_don_hang DESC;
```

---

## SELF JOIN - Bảng join với chính nó

```sql
-- Ví dụ: bảng nhân viên có cột quan_ly_id trỏ về id của người quản lý
CREATE TABLE nhan_vien (
    id          INT PRIMARY KEY AUTO_INCREMENT,
    ho_ten      VARCHAR(100),
    chuc_vu     VARCHAR(100),
    quan_ly_id  INT,
    FOREIGN KEY (quan_ly_id) REFERENCES nhan_vien(id)
);

INSERT INTO nhan_vien (ho_ten, chuc_vu, quan_ly_id) VALUES
    ('Nguyễn Giám Đốc', 'Giám đốc', NULL),
    ('Trần Trưởng Phòng', 'Trưởng phòng', 1),
    ('Lê Nhân Viên A', 'Nhân viên', 2),
    ('Phạm Nhân Viên B', 'Nhân viên', 2);

-- Hiển thị nhân viên và tên người quản lý
SELECT
    nv.ho_ten AS nhan_vien,
    nv.chuc_vu,
    ql.ho_ten AS quan_ly
FROM nhan_vien nv
LEFT JOIN nhan_vien ql ON nv.quan_ly_id = ql.id;
```

---

## CROSS JOIN - Tích Descartes

```sql
-- Kết hợp tất cả bản ghi với nhau (ít dùng)
SELECT a.ten AS mau_sac, b.ten AS kich_thuoc
FROM mau_sac a
CROSS JOIN kich_thuoc b;
-- Nếu màu sắc có 3 hàng, kích thước có 4 hàng → kết quả 12 hàng
```

---

## Thực hành tổng hợp

```sql
USE shop;

-- 1. Tất cả danh mục và số sản phẩm (kể cả danh mục trống)
SELECT
    dm.ten AS danh_muc,
    COUNT(sp.id) AS so_san_pham
FROM danh_muc dm
LEFT JOIN san_pham sp ON dm.id = sp.danh_muc_id
GROUP BY dm.id, dm.ten;

-- 2. Khách hàng chưa mua hàng
SELECT kh.ho_ten, kh.email, kh.ngay_tao
FROM khach_hang kh
LEFT JOIN don_hang dh ON kh.id = dh.khach_hang_id
WHERE dh.id IS NULL;

-- 3. Tất cả sản phẩm và số lần được đặt mua
SELECT
    sp.ten,
    COALESCE(SUM(ct.so_luong), 0) AS da_ban
FROM san_pham sp
LEFT JOIN chi_tiet_don_hang ct ON sp.id = ct.san_pham_id
GROUP BY sp.id, sp.ten
ORDER BY da_ban DESC;
```

---

## Bài tập thực hành
1. Lấy danh sách tất cả sinh viên kèm điểm (sinh viên chưa có điểm vẫn hiển thị)
2. Tìm sinh viên chưa có điểm của bất kỳ môn nào
3. Tìm môn học chưa có sinh viên nào thi
4. Hiển thị cấu trúc cây quản lý (nhân viên - người quản lý)

## Ghi chú cá nhân
> _(Ghi lại những điều bạn học được hoặc gặp khó khăn ở đây)_
