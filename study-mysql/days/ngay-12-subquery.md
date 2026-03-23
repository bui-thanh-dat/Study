# Ngày 12: Subquery (Truy Vấn Lồng Nhau)

## Subquery là gì?
**Subquery** là một câu truy vấn SELECT nằm bên trong một truy vấn khác.
Subquery luôn được đặt trong **dấu ngoặc ()**.

---

## Subquery trong WHERE

```sql
-- Sản phẩm có giá cao hơn giá trung bình
SELECT ten, gia
FROM san_pham
WHERE gia > (SELECT AVG(gia) FROM san_pham);

-- Khách hàng có đơn hàng trị giá lớn nhất
SELECT ho_ten, email
FROM khach_hang
WHERE id = (SELECT khach_hang_id FROM don_hang ORDER BY tong_tien DESC LIMIT 1);

-- Sản phẩm thuộc danh mục có từ "điện" trong tên
SELECT ten, gia
FROM san_pham
WHERE danh_muc_id IN (
    SELECT id FROM danh_muc WHERE ten LIKE '%điện%'
);
```

---

## Subquery trong FROM (Derived Table)

```sql
-- Subquery tạo ra bảng tạm, phải đặt alias
SELECT dm_ten, so_sp
FROM (
    SELECT danh_muc_id, COUNT(*) AS so_sp
    FROM san_pham
    GROUP BY danh_muc_id
) AS thong_ke
WHERE so_sp > 1;

-- Thống kê đơn hàng mỗi khách, rồi lấy khách chi tiêu nhiều
SELECT ho_ten, tong_chi_tieu
FROM (
    SELECT kh.ho_ten, SUM(dh.tong_tien) AS tong_chi_tieu
    FROM khach_hang kh
    JOIN don_hang dh ON kh.id = dh.khach_hang_id
    GROUP BY kh.id, kh.ho_ten
) AS chi_tieu
WHERE tong_chi_tieu > 10000000;
```

---

## Subquery trong SELECT

```sql
-- Hiển thị tên danh mục cho mỗi sản phẩm (thay thế JOIN)
SELECT
    ten,
    gia,
    (SELECT ten FROM danh_muc WHERE id = san_pham.danh_muc_id) AS danh_muc
FROM san_pham;

-- Số đơn hàng của mỗi khách
SELECT
    ho_ten,
    (SELECT COUNT(*) FROM don_hang WHERE khach_hang_id = kh.id) AS so_don
FROM khach_hang kh;
```

---

## EXISTS và NOT EXISTS

```sql
-- EXISTS: trả về TRUE nếu subquery có ít nhất 1 kết quả
-- Khách hàng đã từng đặt hàng
SELECT ho_ten
FROM khach_hang kh
WHERE EXISTS (
    SELECT 1 FROM don_hang dh WHERE dh.khach_hang_id = kh.id
);

-- NOT EXISTS: khách chưa từng đặt hàng
SELECT ho_ten
FROM khach_hang kh
WHERE NOT EXISTS (
    SELECT 1 FROM don_hang dh WHERE dh.khach_hang_id = kh.id
);

-- Sản phẩm chưa từng được đặt mua
SELECT ten, gia
FROM san_pham sp
WHERE NOT EXISTS (
    SELECT 1 FROM chi_tiet_don_hang ct WHERE ct.san_pham_id = sp.id
);
```

---

## ANY và ALL

```sql
-- ANY: thỏa mãn ít nhất 1 giá trị trong subquery
-- Sản phẩm đắt hơn ít nhất 1 sản phẩm danh mục thời trang
SELECT ten, gia
FROM san_pham
WHERE gia > ANY (
    SELECT gia FROM san_pham WHERE danh_muc_id = 2
);

-- ALL: thỏa mãn tất cả giá trị trong subquery
-- Sản phẩm đắt hơn tất cả sản phẩm danh mục thời trang
SELECT ten, gia
FROM san_pham
WHERE gia > ALL (
    SELECT gia FROM san_pham WHERE danh_muc_id = 2
);
```

---

## So sánh Subquery vs JOIN

```sql
-- Cùng kết quả, dùng Subquery
SELECT ten, gia FROM san_pham
WHERE danh_muc_id IN (SELECT id FROM danh_muc WHERE ten = 'Điện tử');

-- Cùng kết quả, dùng JOIN (thường nhanh hơn)
SELECT sp.ten, sp.gia
FROM san_pham sp
JOIN danh_muc dm ON sp.danh_muc_id = dm.id
WHERE dm.ten = 'Điện tử';
```

> **Lời khuyên:** Khi có thể, ưu tiên dùng **JOIN** vì thường nhanh hơn subquery.
> Dùng subquery khi cần kết quả tổng hợp (AVG, MAX...) hoặc logic phức tạp.

---

## Thực hành tổng hợp

```sql
USE shop;

-- 1. Sản phẩm đắt hơn giá trung bình của danh mục mình
SELECT sp1.ten, sp1.gia, dm.ten AS danh_muc
FROM san_pham sp1
JOIN danh_muc dm ON sp1.danh_muc_id = dm.id
WHERE sp1.gia > (
    SELECT AVG(sp2.gia)
    FROM san_pham sp2
    WHERE sp2.danh_muc_id = sp1.danh_muc_id
);

-- 2. Danh mục có nhiều sản phẩm nhất
SELECT ten
FROM danh_muc
WHERE id = (
    SELECT danh_muc_id
    FROM san_pham
    GROUP BY danh_muc_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- 3. Khách hàng có đơn hàng gần nhất
SELECT ho_ten, email
FROM khach_hang
WHERE id = (
    SELECT khach_hang_id FROM don_hang
    ORDER BY ngay_dat DESC LIMIT 1
);
```

---

## Bài tập thực hành
1. Tìm sinh viên có điểm cao hơn điểm trung bình
2. Tìm môn học không có sinh viên nào đăng ký (NOT EXISTS)
3. Tìm lớp có nhiều sinh viên nhất (dùng subquery trong WHERE)
4. Hiển thị mỗi sinh viên kèm số môn họ đã học (subquery trong SELECT)

## Ghi chú cá nhân
> _(Ghi lại những điều bạn học được hoặc gặp khó khăn ở đây)_
