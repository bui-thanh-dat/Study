# Ngày 9: GROUP BY và HAVING

## GROUP BY là gì?
`GROUP BY` nhóm các bản ghi có cùng giá trị lại, thường dùng kết hợp với hàm tổng hợp.

---

## Cú pháp

```sql
SELECT cot_nhom, ham_tong_hop(cot)
FROM ten_bang
WHERE dieu_kien_loc_truoc
GROUP BY cot_nhom
HAVING dieu_kien_loc_sau_nhom
ORDER BY ...;
```

---

## GROUP BY cơ bản

```sql
-- Đếm sản phẩm theo danh mục
SELECT danh_muc_id, COUNT(*) AS so_san_pham
FROM san_pham
GROUP BY danh_muc_id;

-- Tổng tồn kho theo danh mục
SELECT danh_muc_id, SUM(so_luong) AS tong_ton_kho
FROM san_pham
GROUP BY danh_muc_id;

-- Thống kê đầy đủ theo danh mục
SELECT
    danh_muc_id,
    COUNT(*) AS so_sp,
    SUM(so_luong) AS ton_kho,
    MIN(gia) AS gia_thap,
    MAX(gia) AS gia_cao,
    ROUND(AVG(gia), 0) AS gia_tb
FROM san_pham
GROUP BY danh_muc_id;
```

---

## GROUP BY nhiều cột

```sql
-- Nhóm theo danh mục và ngày nhập
SELECT danh_muc_id, ngay_nhap, COUNT(*) AS so_sp
FROM san_pham
GROUP BY danh_muc_id, ngay_nhap;
```

---

## HAVING - Lọc sau khi nhóm

> **Khác biệt quan trọng:**
> - `WHERE` → lọc **trước** khi nhóm (lọc từng bản ghi)
> - `HAVING` → lọc **sau** khi nhóm (lọc kết quả nhóm)

```sql
-- Danh mục có hơn 1 sản phẩm
SELECT danh_muc_id, COUNT(*) AS so_sp
FROM san_pham
GROUP BY danh_muc_id
HAVING so_sp > 1;

-- Sai: không dùng WHERE với hàm tổng hợp
-- WHERE COUNT(*) > 1  ← LỖI!

-- Danh mục có giá trung bình > 1 triệu
SELECT danh_muc_id, ROUND(AVG(gia), 0) AS gia_tb
FROM san_pham
GROUP BY danh_muc_id
HAVING gia_tb > 1000000;
```

---

## Kết hợp WHERE và HAVING

```sql
-- WHERE lọc trước, HAVING lọc sau
-- Chỉ xét sản phẩm còn hàng, rồi nhóm theo danh mục có >= 2 sản phẩm
SELECT danh_muc_id, COUNT(*) AS so_sp
FROM san_pham
WHERE so_luong > 0          -- lọc từng sản phẩm trước
GROUP BY danh_muc_id
HAVING so_sp >= 2;           -- lọc nhóm sau
```

---

## GROUP BY với ORDER BY

```sql
-- Nhóm theo danh mục, sắp xếp theo số lượng giảm dần
SELECT danh_muc_id, COUNT(*) AS so_sp, SUM(so_luong) AS ton_kho
FROM san_pham
GROUP BY danh_muc_id
ORDER BY so_sp DESC;

-- Top 3 danh mục có nhiều sản phẩm nhất
SELECT danh_muc_id, COUNT(*) AS so_sp
FROM san_pham
GROUP BY danh_muc_id
ORDER BY so_sp DESC
LIMIT 3;
```

---

## Hàm GROUP_CONCAT - Nối chuỗi trong nhóm

```sql
-- Nối tên sản phẩm trong cùng danh mục
SELECT
    danh_muc_id,
    GROUP_CONCAT(ten ORDER BY ten SEPARATOR ', ') AS danh_sach_sp
FROM san_pham
GROUP BY danh_muc_id;
```

---

## Thực hành tổng hợp

```sql
USE shop;

-- 1. Thống kê sản phẩm theo danh mục (kèm tên danh mục)
SELECT
    dm.ten AS danh_muc,
    COUNT(sp.id) AS so_san_pham,
    ROUND(AVG(sp.gia), 0) AS gia_trung_binh,
    SUM(sp.so_luong) AS tong_ton_kho
FROM san_pham sp
JOIN danh_muc dm ON sp.danh_muc_id = dm.id
GROUP BY dm.id, dm.ten
ORDER BY so_san_pham DESC;

-- 2. Danh mục có tổng giá trị tồn kho > 5 triệu
SELECT
    danh_muc_id,
    SUM(gia * so_luong) AS gia_tri_kho
FROM san_pham
GROUP BY danh_muc_id
HAVING gia_tri_kho > 5000000
ORDER BY gia_tri_kho DESC;

-- 3. Khách hàng theo tỉnh thành
SELECT
    COALESCE(dia_chi, 'Chưa cập nhật') AS tinh_thanh,
    COUNT(*) AS so_khach
FROM khach_hang
GROUP BY dia_chi
ORDER BY so_khach DESC;
```

---

## Thứ tự thực thi SQL (quan trọng!)

```
1. FROM      → xác định bảng
2. WHERE     → lọc bản ghi
3. GROUP BY  → nhóm bản ghi
4. HAVING    → lọc nhóm
5. SELECT    → chọn cột
6. ORDER BY  → sắp xếp
7. LIMIT     → giới hạn
```

---

## Bài tập thực hành
1. Đếm số sinh viên theo từng lớp
2. Tính điểm trung bình theo từng môn học
3. Tìm lớp có hơn 5 sinh viên (dùng HAVING)
4. Top 3 môn học có điểm trung bình cao nhất

## Ghi chú cá nhân
> _(Ghi lại những điều bạn học được hoặc gặp khó khăn ở đây)_
