# Ngày 15: Transaction và ACID

## Transaction là gì?
**Transaction** là một nhóm các câu lệnh SQL được thực thi như một **đơn vị duy nhất**.
Hoặc tất cả thành công, hoặc tất cả thất bại (không có trạng thái nửa vời).

---

## Tính chất ACID

| Tính chất | Mô tả | Ví dụ |
|-----------|-------|-------|
| **A**tomicity (Tính nguyên tử) | Tất cả hoặc không có gì | Chuyển tiền: trừ A và cộng B phải cùng xảy ra |
| **C**onsistency (Tính nhất quán) | Dữ liệu luôn hợp lệ | Tổng tiền trước và sau chuyển phải bằng nhau |
| **I**solation (Tính cô lập) | Transaction độc lập nhau | 2 người mua cuốn sách cuối cùng: chỉ 1 thành công |
| **D**urability (Tính bền vững) | Dữ liệu được lưu vĩnh viễn | Sau COMMIT, dữ liệu không mất dù mất điện |

---

## Cú pháp cơ bản

```sql
START TRANSACTION;  -- hoặc BEGIN;

-- Các câu lệnh SQL
UPDATE tai_khoan SET so_du = so_du - 1000000 WHERE id = 1;
UPDATE tai_khoan SET so_du = so_du + 1000000 WHERE id = 2;

COMMIT;    -- xác nhận, lưu thay đổi vĩnh viễn
-- hoặc
ROLLBACK;  -- hoàn tác, hủy tất cả thay đổi trong transaction
```

---

## Ví dụ thực tế: Chuyển tiền

```sql
-- Tạo bảng tài khoản
CREATE TABLE tai_khoan (
    id      INT PRIMARY KEY AUTO_INCREMENT,
    chu_so  VARCHAR(100),
    so_du   DECIMAL(15, 2) DEFAULT 0
);

INSERT INTO tai_khoan (chu_so, so_du) VALUES
    ('Nguyễn Văn An', 5000000),
    ('Trần Thị Bình', 2000000);

-- Chuyển 1 triệu từ tài khoản 1 sang tài khoản 2
START TRANSACTION;

-- Bước 1: Kiểm tra số dư
SELECT so_du FROM tai_khoan WHERE id = 1;
-- Giả sử đủ tiền → tiếp tục

-- Bước 2: Trừ tiền người gửi
UPDATE tai_khoan SET so_du = so_du - 1000000 WHERE id = 1;

-- Bước 3: Cộng tiền người nhận
UPDATE tai_khoan SET so_du = so_du + 1000000 WHERE id = 2;

-- Bước 4: Kiểm tra lại
SELECT * FROM tai_khoan;
-- Nếu đúng → xác nhận
COMMIT;
-- Nếu sai → hoàn tác
-- ROLLBACK;
```

---

## SAVEPOINT - Điểm lưu giữa chừng

```sql
START TRANSACTION;

INSERT INTO don_hang (khach_hang_id, tong_tien) VALUES (1, 500000);
SAVEPOINT sau_don_hang;  -- đặt điểm lưu

INSERT INTO chi_tiet_don_hang (don_hang_id, san_pham_id, so_luong, don_gia)
VALUES (LAST_INSERT_ID(), 4, 2, 250000);
SAVEPOINT sau_chi_tiet;

-- Nếu có lỗi ở bước nào, có thể rollback về savepoint
ROLLBACK TO sau_don_hang;  -- hoàn tác về sau_don_hang, giữ lại INSERT đơn hàng

-- Xóa savepoint
RELEASE SAVEPOINT sau_don_hang;

COMMIT;
```

---

## Các mức Isolation

```sql
-- Xem mức isolation hiện tại
SELECT @@transaction_isolation;

-- Đổi mức isolation (cho session hiện tại)
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
```

| Mức | Dirty Read | Non-Repeatable Read | Phantom Read |
|-----|-----------|---------------------|-------------|
| READ UNCOMMITTED | Có | Có | Có |
| READ COMMITTED | Không | Có | Có |
| REPEATABLE READ | Không | Không | Có |
| SERIALIZABLE | Không | Không | Không |

> MySQL mặc định: **REPEATABLE READ**

---

## Autocommit

```sql
-- MySQL mặc định: mỗi lệnh là 1 transaction tự động commit
SHOW VARIABLES LIKE 'autocommit';  -- ON

-- Tắt autocommit (phải COMMIT thủ công)
SET autocommit = 0;

UPDATE san_pham SET gia = 100 WHERE id = 1;
COMMIT;  -- phải commit thủ công

-- Bật lại
SET autocommit = 1;
```

---

## Thực hành tổng hợp

```sql
USE shop;

-- Kịch bản: Khách đặt hàng
START TRANSACTION;

-- 1. Tạo đơn hàng
INSERT INTO don_hang (khach_hang_id, tong_tien, trang_thai)
VALUES (1, 27990000, 'cho_xu_ly');

SET @ma_don = LAST_INSERT_ID();

-- 2. Thêm chi tiết đơn hàng
INSERT INTO chi_tiet_don_hang (don_hang_id, san_pham_id, so_luong, don_gia)
VALUES (@ma_don, 1, 1, 27990000);

-- 3. Giảm tồn kho
UPDATE san_pham SET so_luong = so_luong - 1 WHERE id = 1;

-- 4. Kiểm tra tồn kho không âm
SELECT so_luong FROM san_pham WHERE id = 1;
-- Nếu >= 0 → COMMIT, nếu < 0 → ROLLBACK

COMMIT;

-- Kiểm tra kết quả
SELECT * FROM don_hang WHERE id = @ma_don;
SELECT so_luong FROM san_pham WHERE id = 1;
```

---

## Bài tập thực hành
1. Tạo transaction nhập điểm cho sinh viên (phải kiểm tra sinh viên và môn học tồn tại)
2. Thực hành ROLLBACK khi có lỗi xảy ra
3. Dùng SAVEPOINT trong transaction phức tạp
4. Thử START TRANSACTION, làm thay đổi dữ liệu, rồi ROLLBACK → dữ liệu trở về

## Ghi chú cá nhân
> _(Ghi lại những điều bạn học được hoặc gặp khó khăn ở đây)_
