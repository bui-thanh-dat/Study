# Ngày 4: INSERT - Thêm Dữ Liệu

## Cú pháp cơ bản

### Chèn 1 bản ghi
```sql
-- Cú pháp đầy đủ (liệt kê cột)
INSERT INTO ten_bang (cot1, cot2, cot3)
VALUES ('gia_tri1', 'gia_tri2', 'gia_tri3');

-- Cú pháp ngắn (không liệt kê cột — phải điền đủ theo thứ tự)
INSERT INTO ten_bang
VALUES (1, 'Nguyen Van A', 'a@email.com');
```

### Chèn nhiều bản ghi cùng lúc
```sql
INSERT INTO ten_bang (cot1, cot2)
VALUES
    ('gia_tri1a', 'gia_tri2a'),
    ('gia_tri1b', 'gia_tri2b'),
    ('gia_tri1c', 'gia_tri2c');
```

---

## Thực hành với dữ liệu thực tế

### Setup bảng
```sql
USE shop;
```

### Thêm danh mục
```sql
INSERT INTO danh_muc (ten, mo_ta) VALUES
    ('Điện tử', 'Các thiết bị điện tử công nghệ'),
    ('Thời trang', 'Quần áo, giày dép, phụ kiện'),
    ('Thực phẩm', 'Đồ ăn, thức uống'),
    ('Sách', 'Sách giáo khoa, truyện, tài liệu');
```

### Thêm sản phẩm
```sql
INSERT INTO san_pham (danh_muc_id, ten, gia, so_luong, ngay_nhap) VALUES
    (1, 'iPhone 15 Pro', 27990000, 50, '2024-01-10'),
    (1, 'Samsung Galaxy S24', 22990000, 30, '2024-01-15'),
    (1, 'Laptop Dell XPS 13', 35000000, 20, '2024-01-20'),
    (2, 'Áo thun nam', 250000, 200, '2024-02-01'),
    (2, 'Quần jeans nữ', 450000, 150, '2024-02-05'),
    (3, 'Cà phê Arabica 500g', 120000, 500, '2024-02-10'),
    (4, 'Lập trình Python cơ bản', 85000, 100, '2024-02-15');
```

### Thêm khách hàng
```sql
INSERT INTO khach_hang (ho_ten, email, so_dien_thoai, dia_chi) VALUES
    ('Nguyễn Văn An', 'an@email.com', '0901234567', 'Hà Nội'),
    ('Trần Thị Bình', 'binh@email.com', '0912345678', 'TP.HCM'),
    ('Lê Văn Cường', 'cuong@email.com', '0923456789', 'Đà Nẵng'),
    ('Phạm Thị Dung', 'dung@email.com', '0934567890', 'Hải Phòng'),
    ('Hoàng Văn Em', 'em@email.com', '0945678901', 'Cần Thơ');
```

---

## Các trường hợp đặc biệt

### Chèn giá trị NULL
```sql
INSERT INTO khach_hang (ho_ten, email, so_dien_thoai)
VALUES ('Khách vãng lai', 'vang_lai@email.com', NULL);
```

### Chèn với giá trị DEFAULT
```sql
INSERT INTO san_pham (ten, gia)
VALUES ('Sản phẩm mới', 100000);
-- so_luong sẽ tự lấy DEFAULT là 0
-- ngay_tao sẽ tự lấy CURRENT_TIMESTAMP
```

### INSERT ... SELECT (sao chép dữ liệu)
```sql
-- Tạo bảng backup
CREATE TABLE san_pham_backup LIKE san_pham;

-- Sao chép dữ liệu
INSERT INTO san_pham_backup
SELECT * FROM san_pham;
```

### INSERT IGNORE (bỏ qua lỗi duplicate)
```sql
INSERT IGNORE INTO khach_hang (ho_ten, email)
VALUES ('Người dùng A', 'an@email.com');
-- Nếu email đã tồn tại → bỏ qua, không báo lỗi
```

### ON DUPLICATE KEY UPDATE (thêm hoặc cập nhật)
```sql
INSERT INTO san_pham (ten, gia, so_luong)
VALUES ('iPhone 15 Pro', 27990000, 60)
ON DUPLICATE KEY UPDATE so_luong = so_luong + 60;
```

---

## Lỗi thường gặp

| Lỗi | Nguyên nhân | Cách sửa |
|-----|-------------|----------|
| `Duplicate entry` | Vi phạm UNIQUE/PRIMARY KEY | Dùng `INSERT IGNORE` hoặc kiểm tra trước |
| `Column cannot be null` | Bỏ trống cột NOT NULL | Cung cấp giá trị cho cột đó |
| `Data too long` | Chuỗi quá dài | Cắt ngắn hoặc tăng độ dài cột |
| `Cannot add or update a child row` | Foreign key không tồn tại | Thêm bản ghi cha trước |

---

## Bài tập thực hành
1. Thêm 5 sinh viên vào bảng `sinh_vien`
2. Thêm 3 môn học vào bảng `mon_hoc`
3. Thử chèn 1 bản ghi bị thiếu cột NOT NULL → quan sát lỗi
4. Thêm nhiều bản ghi cùng một câu lệnh INSERT

## Ghi chú cá nhân
> _(Ghi lại những điều bạn học được hoặc gặp khó khăn ở đây)_
