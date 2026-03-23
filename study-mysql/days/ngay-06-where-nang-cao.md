# Ngày 6: WHERE Nâng Cao - LIKE, IN, BETWEEN, IS NULL

## LIKE - Tìm kiếm theo mẫu

```sql
-- % đại diện cho 0 hoặc nhiều ký tự bất kỳ
-- _ đại diện cho đúng 1 ký tự bất kỳ

-- Bắt đầu bằng "Nguy"
SELECT * FROM khach_hang WHERE ho_ten LIKE 'Nguy%';

-- Kết thúc bằng "An"
SELECT * FROM khach_hang WHERE ho_ten LIKE '%An';

-- Chứa "Van" ở bất kỳ vị trí nào
SELECT * FROM khach_hang WHERE ho_ten LIKE '%Van%';

-- Tìm email gmail
SELECT * FROM khach_hang WHERE email LIKE '%@gmail.com';

-- Đúng 5 ký tự
SELECT * FROM san_pham WHERE ten LIKE '_____';

-- Bắt đầu bằng bất kỳ ký tự nào, theo sau là "Phone"
SELECT * FROM san_pham WHERE ten LIKE '_Phone%';

-- Không chứa từ "Pro"
SELECT * FROM san_pham WHERE ten NOT LIKE '%Pro%';

-- Không phân biệt hoa thường (MySQL mặc định đã vậy)
SELECT * FROM san_pham WHERE ten LIKE '%iphone%';
```

---

## IN - Trong danh sách

```sql
-- Thay thế cho nhiều OR
SELECT * FROM san_pham WHERE danh_muc_id IN (1, 2, 3);

-- Tương đương với:
SELECT * FROM san_pham
WHERE danh_muc_id = 1 OR danh_muc_id = 2 OR danh_muc_id = 3;

-- Với chuỗi
SELECT * FROM khach_hang
WHERE dia_chi IN ('Hà Nội', 'TP.HCM', 'Đà Nẵng');

-- NOT IN
SELECT * FROM san_pham WHERE danh_muc_id NOT IN (1, 4);
```

---

## BETWEEN - Trong khoảng

```sql
-- Số
SELECT * FROM san_pham WHERE gia BETWEEN 100000 AND 1000000;
-- Tương đương: WHERE gia >= 100000 AND gia <= 1000000

-- Ngày
SELECT * FROM san_pham
WHERE ngay_nhap BETWEEN '2024-01-01' AND '2024-01-31';

-- Không trong khoảng
SELECT * FROM san_pham WHERE gia NOT BETWEEN 100000 AND 500000;
```

---

## IS NULL / IS NOT NULL

```sql
-- Tìm bản ghi có giá trị NULL
SELECT * FROM khach_hang WHERE so_dien_thoai IS NULL;

-- Tìm bản ghi có giá trị (không phải NULL)
SELECT * FROM khach_hang WHERE so_dien_thoai IS NOT NULL;

-- KHÔNG dùng = NULL (sai!)
SELECT * FROM khach_hang WHERE so_dien_thoai = NULL;    -- KHÔNG hoạt động
SELECT * FROM khach_hang WHERE so_dien_thoai != NULL;   -- KHÔNG hoạt động
```

---

## REGEXP - Tìm kiếm với biểu thức chính quy

```sql
-- Bắt đầu bằng 'N' hoặc 'T'
SELECT * FROM khach_hang WHERE ho_ten REGEXP '^[NT]';

-- Kết thúc bằng số
SELECT * FROM san_pham WHERE ten REGEXP '[0-9]$';

-- Chứa chỉ chữ cái
SELECT * FROM san_pham WHERE ten REGEXP '^[a-zA-Z ]+$';
```

---

## Kết hợp nhiều điều kiện

```sql
-- Sản phẩm điện tử (danh mục 1), giá từ 5 đến 30 triệu, còn hàng
SELECT ten, gia, so_luong
FROM san_pham
WHERE danh_muc_id = 1
  AND gia BETWEEN 5000000 AND 30000000
  AND so_luong > 0
ORDER BY gia;

-- Tìm sản phẩm: tên chứa "Samsung" HOẶC giá dưới 200k
SELECT ten, gia FROM san_pham
WHERE ten LIKE '%Samsung%' OR gia < 200000;

-- Sản phẩm hết hàng hoặc chưa có ngày nhập
SELECT ten FROM san_pham
WHERE so_luong = 0 OR ngay_nhap IS NULL;
```

---

## Thực hành tổng hợp

```sql
USE shop;

-- 1. Tìm sản phẩm tên có chứa "Pro"
SELECT * FROM san_pham WHERE ten LIKE '%Pro%';

-- 2. Khách hàng ở Hà Nội, TP.HCM hoặc Đà Nẵng
SELECT ho_ten, dia_chi FROM khach_hang
WHERE dia_chi IN ('Hà Nội', 'TP.HCM', 'Đà Nẵng');

-- 3. Sản phẩm giá từ 200k đến 1 triệu
SELECT ten, gia FROM san_pham
WHERE gia BETWEEN 200000 AND 1000000
ORDER BY gia;

-- 4. Khách hàng chưa có số điện thoại
SELECT ho_ten, email FROM khach_hang
WHERE so_dien_thoai IS NULL;
```

---

## Bài tập thực hành
1. Tìm sinh viên có email chứa "@gmail.com"
2. Tìm sinh viên trong danh sách lớp A, B, C (dùng IN)
3. Tìm sinh viên sinh từ 2000 đến 2005 (dùng BETWEEN với DATE)
4. Tìm sinh viên chưa có địa chỉ email (IS NULL)

## Ghi chú cá nhân
> _(Ghi lại những điều bạn học được hoặc gặp khó khăn ở đây)_
