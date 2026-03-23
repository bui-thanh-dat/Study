# Ngày 1: Giới Thiệu MySQL

## MySQL là gì?
- **MySQL** là hệ quản trị cơ sở dữ liệu quan hệ (RDBMS) mã nguồn mở, phổ biến nhất thế giới
- Dùng ngôn ngữ **SQL** (Structured Query Language) để thao tác dữ liệu
- Ứng dụng: web backend, ứng dụng doanh nghiệp, thương mại điện tử

## Cài đặt

### Bước 1: Tải MySQL
- MySQL Community Server: https://dev.mysql.com/downloads/mysql/
- MySQL Workbench (giao diện đồ họa): https://dev.mysql.com/downloads/workbench/

### Bước 2: Cài đặt
1. Chạy file installer
2. Chọn **Developer Default**
3. Đặt mật khẩu cho user `root`
4. Hoàn tất cài đặt

### Bước 3: Kiểm tra kết nối
```sql
-- Mở MySQL Workbench, kết nối với:
-- Host: 127.0.0.1
-- Port: 3306
-- User: root
-- Password: (mật khẩu đã đặt)
```

## Các khái niệm cơ bản

| Khái niệm | Mô tả | Ví dụ thực tế |
|-----------|-------|---------------|
| **Database** | Kho chứa toàn bộ dữ liệu | Cơ sở dữ liệu bán hàng |
| **Table** | Bảng chứa dữ liệu theo chủ đề | Bảng khách hàng |
| **Row** | Một bản ghi trong bảng | Thông tin 1 khách hàng |
| **Column** | Một thuộc tính của bảng | Tên, Email, Điện thoại |

## Lệnh đầu tiên
```sql
-- Xem danh sách tất cả database
SHOW DATABASES;

-- Xem phiên bản MySQL
SELECT VERSION();

-- Xem thời gian hiện tại
SELECT NOW();
```

## Bài tập thực hành
1. Cài đặt MySQL và Workbench thành công
2. Kết nối vào MySQL bằng Workbench
3. Chạy lệnh `SHOW DATABASES;` và ghi lại kết quả
4. Chạy `SELECT VERSION();` — MySQL bạn đang dùng phiên bản mấy?

## Ghi chú cá nhân
> _(Ghi lại những điều bạn học được hoặc gặp khó khăn ở đây)_
