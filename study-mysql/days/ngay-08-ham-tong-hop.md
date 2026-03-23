# Ngày 8: Hàm Tổng Hợp - COUNT, SUM, AVG, MAX, MIN

## Các hàm tổng hợp cơ bản

| Hàm | Mô tả | Ví dụ |
|-----|-------|-------|
| `COUNT()` | Đếm số bản ghi | Đếm số khách hàng |
| `SUM()` | Tính tổng | Tổng doanh thu |
| `AVG()` | Tính trung bình | Giá trung bình sản phẩm |
| `MAX()` | Giá trị lớn nhất | Sản phẩm đắt nhất |
| `MIN()` | Giá trị nhỏ nhất | Sản phẩm rẻ nhất |

---

## COUNT

```sql
-- Đếm tất cả bản ghi
SELECT COUNT(*) FROM san_pham;

-- Đếm bản ghi không NULL
SELECT COUNT(so_dien_thoai) FROM khach_hang;

-- Đếm giá trị duy nhất
SELECT COUNT(DISTINCT danh_muc_id) FROM san_pham;

-- Đặt tên kết quả
SELECT COUNT(*) AS tong_san_pham FROM san_pham;
SELECT COUNT(*) AS tong_khach_hang FROM khach_hang WHERE dia_chi = 'Hà Nội';
```

---

## SUM

```sql
-- Tổng tồn kho
SELECT SUM(so_luong) AS tong_ton_kho FROM san_pham;

-- Tổng giá trị tồn kho
SELECT SUM(gia * so_luong) AS tong_gia_tri FROM san_pham;

-- Tổng theo điều kiện
SELECT SUM(so_luong) AS ton_kho_dien_tu
FROM san_pham
WHERE danh_muc_id = 1;
```

---

## AVG

```sql
-- Giá trung bình
SELECT AVG(gia) AS gia_trung_binh FROM san_pham;

-- Giá trung bình theo danh mục
SELECT AVG(gia) AS gia_tb_dien_tu
FROM san_pham WHERE danh_muc_id = 1;

-- Làm tròn kết quả
SELECT ROUND(AVG(gia), 2) AS gia_trung_binh FROM san_pham;
```

---

## MAX và MIN

```sql
-- Sản phẩm đắt nhất và rẻ nhất
SELECT MAX(gia) AS gia_cao_nhat, MIN(gia) AS gia_thap_nhat
FROM san_pham;

-- Ngày nhập gần nhất và xa nhất
SELECT MAX(ngay_nhap) AS nhap_moi_nhat, MIN(ngay_nhap) AS nhap_cu_nhat
FROM san_pham;

-- Tổng hợp toàn bộ
SELECT
    COUNT(*) AS tong_sp,
    SUM(so_luong) AS tong_ton_kho,
    ROUND(AVG(gia), 0) AS gia_tb,
    MAX(gia) AS gia_cao_nhat,
    MIN(gia) AS gia_thap_nhat
FROM san_pham;
```

---

## Hàm tổng hợp với điều kiện (WHERE)

```sql
-- Thống kê sản phẩm điện tử
SELECT
    COUNT(*) AS so_luong_loai,
    SUM(so_luong) AS tong_ton_kho,
    AVG(gia) AS gia_tb
FROM san_pham
WHERE danh_muc_id = 1;

-- Đếm khách hàng có email gmail
SELECT COUNT(*) AS khach_gmail
FROM khach_hang
WHERE email LIKE '%@gmail.com';
```

---

## Hàm số học hỗ trợ

```sql
-- Làm tròn
SELECT ROUND(AVG(gia), 2) FROM san_pham;     -- 2 chữ số thập phân
SELECT CEIL(AVG(gia)) FROM san_pham;          -- làm tròn lên
SELECT FLOOR(AVG(gia)) FROM san_pham;         -- làm tròn xuống

-- Trị tuyệt đối
SELECT ABS(-100);      -- kết quả: 100

-- Lũy thừa và căn bậc hai
SELECT POW(2, 10);     -- 2^10 = 1024
SELECT SQRT(144);      -- 12
```

---

## Thực hành tổng hợp

```sql
USE shop;

-- 1. Thống kê tổng quan cửa hàng
SELECT
    (SELECT COUNT(*) FROM san_pham) AS tong_san_pham,
    (SELECT COUNT(*) FROM khach_hang) AS tong_khach_hang,
    (SELECT SUM(gia * so_luong) FROM san_pham) AS tong_gia_tri_kho;

-- 2. Sản phẩm đắt nhất trong từng khoảng giá
SELECT
    COUNT(*) AS so_san_pham,
    SUM(so_luong) AS tong_ton_kho,
    MIN(gia) AS gia_thap_nhat,
    MAX(gia) AS gia_cao_nhat,
    ROUND(AVG(gia), 0) AS gia_trung_binh
FROM san_pham
WHERE gia BETWEEN 100000 AND 1000000;

-- 3. Thống kê khách hàng
SELECT
    COUNT(*) AS tong,
    COUNT(so_dien_thoai) AS co_sdt,
    COUNT(*) - COUNT(so_dien_thoai) AS chua_co_sdt
FROM khach_hang;
```

---

## Bài tập thực hành
1. Đếm tổng số sinh viên trong database
2. Tính điểm trung bình của tất cả sinh viên
3. Tìm điểm cao nhất và thấp nhất
4. Tính tổng số tín chỉ của tất cả môn học

## Ghi chú cá nhân
> _(Ghi lại những điều bạn học được hoặc gặp khó khăn ở đây)_
