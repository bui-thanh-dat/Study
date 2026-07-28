# Lộ Trình Học MySQL Cơ Bản

## Giai đoạn 1: Nền tảng (1-2 tuần)

### 1. Giới thiệu & Cài đặt
- MySQL là gì, dùng để làm gì
- Cài đặt MySQL Server + MySQL Workbench
- Kết nối và làm quen giao diện

### 2. Khái niệm cơ bản
- Database, Table, Row, Column
- Kiểu dữ liệu: `INT`, `VARCHAR`, `TEXT`, `DATE`, `BOOLEAN`, `DECIMAL`
- Primary Key, Foreign Key, Index

---

## Giai đoạn 2: SQL cơ bản (2-3 tuần)

### 3. DDL - Định nghĩa dữ liệu
```sql
CREATE DATABASE ten_database;
CREATE TABLE ten_bang (
    id INT PRIMARY KEY AUTO_INCREMENT,
    ten VARCHAR(100) NOT NULL,
    ngay_tao DATE
);
ALTER TABLE ten_bang ADD COLUMN email VARCHAR(255);
DROP TABLE ten_bang;
```

### 4. DML - Thao tác dữ liệu
```sql
-- Thêm dữ liệu
INSERT INTO ten_bang (ten, email) VALUES ('Nguyen Van A', 'a@email.com');

-- Truy vấn dữ liệu
SELECT * FROM ten_bang WHERE id = 1;

-- Cập nhật dữ liệu
UPDATE ten_bang SET ten = 'Nguyen Van B' WHERE id = 1;

-- Xóa dữ liệu
DELETE FROM ten_bang WHERE id = 1;
```

### 5. Truy vấn nâng cao
```sql
-- Sắp xếp và giới hạn
SELECT * FROM ten_bang ORDER BY ten ASC LIMIT 10 OFFSET 0;

-- Nhóm dữ liệu
SELECT loai, COUNT(*) as so_luong
FROM san_pham
GROUP BY loai
HAVING so_luong > 5;

-- Điều kiện mở rộng
SELECT * FROM ten_bang WHERE ten LIKE 'Nguyen%';
SELECT * FROM ten_bang WHERE id IN (1, 2, 3);
SELECT * FROM ten_bang WHERE gia BETWEEN 100 AND 500;
SELECT * FROM ten_bang WHERE email IS NULL;
```

**Hàm tổng hợp:**
| Hàm | Mô tả |
|-----|-------|
| `COUNT()` | Đếm số bản ghi |
| `SUM()` | Tính tổng |
| `AVG()` | Tính trung bình |
| `MAX()` | Giá trị lớn nhất |
| `MIN()` | Giá trị nhỏ nhất |

---

## Giai đoạn 3: Quan hệ bảng (2 tuần)

### 6. JOIN
```sql
-- INNER JOIN: chỉ lấy bản ghi khớp cả 2 bảng
SELECT dh.id, kh.ten, dh.tong_tien
FROM don_hang dh
INNER JOIN khach_hang kh ON dh.khach_hang_id = kh.id;

-- LEFT JOIN: lấy tất cả bản ghi bảng trái
SELECT kh.ten, dh.tong_tien
FROM khach_hang kh
LEFT JOIN don_hang dh ON kh.id = dh.khach_hang_id;

-- SELF JOIN: join bảng với chính nó
SELECT a.ten AS nhan_vien, b.ten AS quan_ly
FROM nhan_vien a
JOIN nhan_vien b ON a.quan_ly_id = b.id;
```

### 7. Subquery
```sql
-- Subquery trong WHERE
SELECT * FROM san_pham
WHERE gia > (SELECT AVG(gia) FROM san_pham);

-- Subquery trong FROM
SELECT loai, avg_gia
FROM (
    SELECT loai, AVG(gia) as avg_gia
    FROM san_pham
    GROUP BY loai
) AS bang_trung_binh;

-- EXISTS
SELECT * FROM khach_hang kh
WHERE EXISTS (
    SELECT 1 FROM don_hang dh WHERE dh.khach_hang_id = kh.id
);
```

---

## Giai đoạn 4: Nâng cao (2-3 tuần)

### 8. Index & Performance
```sql
-- Tạo index
CREATE INDEX idx_ten ON ten_bang(ten);
CREATE UNIQUE INDEX idx_email ON ten_bang(email);

-- Xem kế hoạch thực thi query
EXPLAIN SELECT * FROM ten_bang WHERE ten = 'Nguyen Van A';

-- Xóa index
DROP INDEX idx_ten ON ten_bang;
```

### 9. Transactions
```sql
-- Bắt đầu transaction
START TRANSACTION;

UPDATE tai_khoan SET so_du = so_du - 500000 WHERE id = 1;
UPDATE tai_khoan SET so_du = so_du + 500000 WHERE id = 2;

-- Nếu thành công
COMMIT;

-- Nếu có lỗi
ROLLBACK;
```

**Các mức Isolation:**
| Mức | Mô tả |
|-----|-------|
| `READ UNCOMMITTED` | Đọc cả dữ liệu chưa commit |
| `READ COMMITTED` | Chỉ đọc dữ liệu đã commit |
| `REPEATABLE READ` | Dữ liệu nhất quán trong transaction (mặc định) |
| `SERIALIZABLE` | An toàn nhất, hiệu năng thấp nhất |

### 10. View
```sql
-- Tạo view
CREATE VIEW v_don_hang_chi_tiet AS
SELECT dh.id, kh.ten, dh.tong_tien, dh.ngay_dat
FROM don_hang dh
JOIN khach_hang kh ON dh.khach_hang_id = kh.id;

-- Sử dụng view như bảng thường
SELECT * FROM v_don_hang_chi_tiet WHERE tong_tien > 1000000;

-- Xóa view
DROP VIEW v_don_hang_chi_tiet;
```

### 11. Stored Procedure
```sql
-- Tạo stored procedure
DELIMITER //
CREATE PROCEDURE LayDonHangTheoKhach(IN p_khach_hang_id INT)
BEGIN
    SELECT * FROM don_hang WHERE khach_hang_id = p_khach_hang_id;
END //
DELIMITER ;

-- Gọi stored procedure
CALL LayDonHangTheoKhach(1);
```

### 12. Trigger
```sql
-- Tự động cập nhật khi có thay đổi
DELIMITER //
CREATE TRIGGER sau_khi_xoa_don_hang
AFTER DELETE ON don_hang
FOR EACH ROW
BEGIN
    INSERT INTO log_xoa (don_hang_id, thoi_gian)
    VALUES (OLD.id, NOW());
END //
DELIMITER ;
```

---

## Giai đoạn 5: Thực hành (liên tục)

### Dự án thực hành gợi ý

#### Dự án 1: Quản lý thư viện sách
- Bảng: `sach`, `tac_gia`, `the_loai`, `ban_doc`, `muon_sach`
- Chức năng: mượn/trả sách, tìm kiếm, thống kê

#### Dự án 2: Hệ thống bán hàng
- Bảng: `san_pham`, `khach_hang`, `don_hang`, `chi_tiet_don_hang`
- Chức năng: quản lý đơn hàng, doanh thu, tồn kho

#### Dự án 3: Quản lý sinh viên
- Bảng: `sinh_vien`, `mon_hoc`, `lop`, `diem`
- Chức năng: nhập điểm, xếp loại, thống kê học lực

---

## Tài nguyên học

| Nguồn | Mô tả |
|-------|-------|
| [W3Schools MySQL](https://www.w3schools.com/mysql) | Học tương tác, có bài tập |
| [MySQL Docs](https://dev.mysql.com/doc) | Tài liệu chính thức |
| [SQLZoo](https://sqlzoo.net) | Luyện tập SQL online |
| [LeetCode - SQL](https://leetcode.com/problemset/database) | Bài tập SQL thực tế |
| [Mode SQL Tutorial](https://mode.com/sql-tutorial) | Hướng dẫn có hình ảnh |

---

## Kế hoạch theo tuần

```
Tuần 1-2  → Cài đặt + DDL + DML cơ bản (INSERT, SELECT, UPDATE, DELETE)
Tuần 3-4  → SELECT nâng cao + GROUP BY + Hàm tổng hợp
Tuần 5-6  → JOIN (INNER, LEFT, RIGHT) + Subquery
Tuần 7-8  → Index + Transaction + View
Tuần 9-10 → Stored Procedure + Trigger
Tuần 11+  → Thực hành project thực tế
```

---

## Checklist tiến độ

- [ ] Cài đặt MySQL + Workbench
- [ ] Tạo được Database và Table
- [ ] Thành thạo INSERT, SELECT, UPDATE, DELETE
- [ ] Sử dụng được WHERE, ORDER BY, GROUP BY
- [ ] Hiểu và dùng được INNER JOIN, LEFT JOIN
- [ ] Viết được Subquery
- [ ] Tạo và sử dụng Index
- [ ] Hiểu Transaction và ACID
- [ ] Tạo được View
- [ ] Viết được Stored Procedure cơ bản
- [ ] Hoàn thành ít nhất 1 dự án thực hành
