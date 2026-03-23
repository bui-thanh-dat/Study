# Ngày 20: Ôn Tập Tổng Hợp

## Checklist kiến thức

### Giai đoạn 1: Nền tảng
- [ ] Hiểu Database, Table, Row, Column
- [ ] Biết các kiểu dữ liệu quan trọng (INT, VARCHAR, DECIMAL, DATE, TIMESTAMP)
- [ ] Hiểu Primary Key, Foreign Key, Constraint

### Giai đoạn 2: SQL cơ bản
- [ ] CREATE DATABASE, CREATE TABLE, ALTER TABLE, DROP TABLE
- [ ] INSERT INTO (1 bản ghi, nhiều bản ghi)
- [ ] SELECT với WHERE, ORDER BY, LIMIT
- [ ] WHERE nâng cao: LIKE, IN, BETWEEN, IS NULL
- [ ] UPDATE và DELETE (an toàn với WHERE)
- [ ] Hàm tổng hợp: COUNT, SUM, AVG, MAX, MIN
- [ ] GROUP BY và HAVING

### Giai đoạn 3: Quan hệ bảng
- [ ] INNER JOIN (chỉ bản ghi khớp)
- [ ] LEFT JOIN (tất cả bảng trái)
- [ ] RIGHT JOIN (tất cả bảng phải)
- [ ] SELF JOIN (bảng join với chính nó)
- [ ] Subquery trong WHERE, FROM, SELECT
- [ ] EXISTS, NOT EXISTS

### Giai đoạn 4: Nâng cao
- [ ] Hàm chuỗi và ngày tháng
- [ ] INDEX và EXPLAIN
- [ ] TRANSACTION và ACID
- [ ] VIEW
- [ ] STORED PROCEDURE
- [ ] TRIGGER
- [ ] STORED FUNCTION

---

## Bài ôn tập: Hệ thống quản lý bán hàng

Sử dụng database `shop` đã tạo ở các ngày trước.

### Bài 1: Truy vấn cơ bản
```sql
-- 1a. Liệt kê tất cả sản phẩm còn hàng, sắp xếp theo giá giảm dần
SELECT ten, gia, so_luong
FROM san_pham
WHERE so_luong > 0
ORDER BY gia DESC;

-- 1b. Top 5 sản phẩm đắt nhất kèm tên danh mục
SELECT sp.ten, sp.gia, dm.ten AS danh_muc
FROM san_pham sp
JOIN danh_muc dm ON sp.danh_muc_id = dm.id
ORDER BY sp.gia DESC
LIMIT 5;

-- 1c. Thống kê số sản phẩm và giá trị tồn kho theo danh mục
SELECT
    dm.ten AS danh_muc,
    COUNT(sp.id) AS so_san_pham,
    SUM(sp.gia * sp.so_luong) AS gia_tri_ton_kho
FROM danh_muc dm
LEFT JOIN san_pham sp ON dm.id = sp.danh_muc_id
GROUP BY dm.id, dm.ten
ORDER BY gia_tri_ton_kho DESC;
```

### Bài 2: Truy vấn JOIN phức tạp
```sql
-- 2a. Lịch sử mua hàng của từng khách
SELECT
    kh.ho_ten,
    COUNT(dh.id) AS so_don,
    SUM(dh.tong_tien) AS tong_chi_tieu,
    MAX(dh.ngay_dat) AS don_hang_cuoi
FROM khach_hang kh
LEFT JOIN don_hang dh ON kh.id = dh.khach_hang_id
GROUP BY kh.id, kh.ho_ten
ORDER BY tong_chi_tieu DESC;

-- 2b. Chi tiết tất cả đơn hàng
SELECT
    dh.id AS ma_don,
    kh.ho_ten AS khach_hang,
    sp.ten AS san_pham,
    ct.so_luong,
    ct.don_gia,
    ct.so_luong * ct.don_gia AS thanh_tien,
    dh.trang_thai
FROM don_hang dh
JOIN khach_hang kh ON dh.khach_hang_id = kh.id
JOIN chi_tiet_don_hang ct ON dh.id = ct.don_hang_id
JOIN san_pham sp ON ct.san_pham_id = sp.id
ORDER BY dh.id;

-- 2c. Sản phẩm chưa được đặt mua lần nào
SELECT sp.ten, sp.gia, sp.so_luong
FROM san_pham sp
WHERE NOT EXISTS (
    SELECT 1 FROM chi_tiet_don_hang ct WHERE ct.san_pham_id = sp.id
);
```

### Bài 3: Thống kê nâng cao
```sql
-- 3a. Doanh thu theo tháng
SELECT
    YEAR(ngay_dat) AS nam,
    MONTH(ngay_dat) AS thang,
    COUNT(*) AS so_don,
    SUM(tong_tien) AS doanh_thu
FROM don_hang
GROUP BY YEAR(ngay_dat), MONTH(ngay_dat)
ORDER BY nam DESC, thang DESC;

-- 3b. Xếp hạng khách hàng
SELECT
    ho_ten,
    tong_chi_tieu,
    CASE
        WHEN tong_chi_tieu >= 50000000 THEN 'VIP Gold'
        WHEN tong_chi_tieu >= 20000000 THEN 'VIP Silver'
        ELSE 'Thường'
    END AS hang_khach
FROM (
    SELECT kh.ho_ten, COALESCE(SUM(dh.tong_tien), 0) AS tong_chi_tieu
    FROM khach_hang kh
    LEFT JOIN don_hang dh ON kh.id = dh.khach_hang_id
    GROUP BY kh.id, kh.ho_ten
) AS chi_tieu_kh
ORDER BY tong_chi_tieu DESC;

-- 3c. Sản phẩm bán chạy nhất
SELECT
    sp.ten,
    dm.ten AS danh_muc,
    SUM(ct.so_luong) AS da_ban,
    SUM(ct.so_luong * ct.don_gia) AS doanh_thu
FROM san_pham sp
JOIN danh_muc dm ON sp.danh_muc_id = dm.id
JOIN chi_tiet_don_hang ct ON sp.id = ct.san_pham_id
GROUP BY sp.id, sp.ten, dm.ten
ORDER BY da_ban DESC;
```

### Bài 4: CASE WHEN
```sql
-- Phân loại sản phẩm theo giá
SELECT
    ten,
    gia,
    CASE
        WHEN gia < 100000 THEN 'Rẻ'
        WHEN gia < 1000000 THEN 'Trung bình'
        WHEN gia < 10000000 THEN 'Đắt'
        ELSE 'Rất đắt'
    END AS phan_loai
FROM san_pham
ORDER BY gia;

-- Trạng thái tồn kho
SELECT
    ten,
    so_luong,
    CASE
        WHEN so_luong = 0 THEN 'Hết hàng'
        WHEN so_luong < 10 THEN 'Sắp hết'
        WHEN so_luong < 50 THEN 'Còn ít'
        ELSE 'Còn nhiều'
    END AS tinh_trang
FROM san_pham
ORDER BY so_luong;
```

---

## Bài kiểm tra tự đánh giá

> Thử tự trả lời các câu hỏi sau, nếu chưa được hãy xem lại bài tương ứng:

1. `WHERE` và `HAVING` khác nhau như thế nào?
2. `INNER JOIN` và `LEFT JOIN` cho kết quả khác nhau thế nào?
3. Khi nào nên dùng subquery, khi nào dùng JOIN?
4. `DELETE` và `TRUNCATE` khác nhau thế nào?
5. Index giúp ích gì và có nhược điểm không?
6. ACID trong transaction là gì?
7. VIEW có lưu dữ liệu thực không?
8. Sự khác nhau giữa Stored Procedure và Stored Function?
9. `BEFORE` trigger và `AFTER` trigger dùng khi nào?
10. `NEW` và `OLD` trong trigger là gì?

---

## Bài tập nâng cao

Thiết kế và xây dựng CSDL **Quản lý thư viện sách** với các yêu cầu:

### Cấu trúc:
- `sach` (id, ten, isbn, nam_xuat_ban, so_trang, so_luong)
- `tac_gia` (id, ten, quoc_tich)
- `the_loai` (id, ten)
- `sach_tac_gia` (sach_id, tac_gia_id) -- quan hệ nhiều-nhiều
- `ban_doc` (id, ho_ten, email, so_the, ngay_cap)
- `muon_sach` (id, ban_doc_id, sach_id, ngay_muon, ngay_tra, da_tra)

### Yêu cầu:
1. INSERT ít nhất 10 sách, 5 tác giả, 3 thể loại, 5 bạn đọc, 8 lượt mượn
2. Truy vấn danh sách sách kèm tên tác giả (JOIN nhiều bảng)
3. Tìm sách quá hạn trả (ngày trả < TODAY và chưa trả)
4. Thống kê sách được mượn nhiều nhất
5. Bạn đọc nào đang mượn nhiều sách nhất
6. Tạo VIEW `v_sach_dang_muon`
7. Tạo TRIGGER tự động giảm số lượng sách khi mượn
8. Tạo PROCEDURE `muon_sach(ban_doc_id, sach_id)` với kiểm tra hợp lệ

## Ghi chú cá nhân
> _(Ghi lại những điều bạn học được hoặc gặp khó khăn ở đây)_
