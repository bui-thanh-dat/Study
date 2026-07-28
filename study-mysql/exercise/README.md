# Học MySQL Cơ Bản - Hướng Dẫn Sử Dụng

## Cấu trúc thư mục

```
study-mysql/
├── README.md                    ← File này
├── lo-trinh-hoc-mysql.md        ← Lộ trình tổng quan
├── days/                        ← Lý thuyết từng ngày
│   ├── ngay-01-gioi-thieu-mysql.md
│   ├── ngay-02-kieu-du-lieu.md
│   ├── ngay-03-tao-database-va-table.md
│   ├── ngay-04-insert-them-du-lieu.md
│   ├── ngay-05-select-co-ban.md
│   ├── ngay-06-where-nang-cao.md
│   ├── ngay-07-update-delete.md
│   ├── ngay-08-ham-tong-hop.md
│   ├── ngay-09-group-by-having.md
│   ├── ngay-10-inner-join.md
│   ├── ngay-11-left-right-join.md
│   ├── ngay-12-subquery.md
│   ├── ngay-13-ham-chuoi-va-ngay.md
│   ├── ngay-14-index.md
│   ├── ngay-15-transaction.md
│   ├── ngay-16-view.md
│   ├── ngay-17-stored-procedure.md
│   ├── ngay-18-trigger.md
│   ├── ngay-19-stored-function.md
│   └── ngay-20-on-tap-tong-hop.md
└── sql/                         ← Bài tập SQL thực hành từng ngày
    ├── ngay-01.sql
    ├── ngay-02.sql
    ├── ngay-03.sql
    ├── ngay-04.sql
    ├── ngay-05.sql
    ├── ngay-06.sql
    ├── ngay-07.sql
    ├── ngay-08.sql
    ├── ngay-09.sql
    ├── ngay-10.sql
    ├── ngay-11.sql
    ├── ngay-12.sql
    ├── ngay-13.sql
    ├── ngay-14.sql
    ├── ngay-15.sql
    ├── ngay-16.sql
    ├── ngay-17.sql
    ├── ngay-18.sql
    ├── ngay-19.sql
    └── ngay-20.sql
```

## Cách học mỗi ngày

1. Đọc file lý thuyết trong `days/ngay-XX-...md`
2. Mở MySQL Workbench
3. Chạy từng BƯỚC trong file `sql/ngay-XX.sql`
4. Đọc kết quả và hiểu tại sao
5. Tự làm BÀI TẬP ở cuối mỗi file SQL
6. Ghi chú vào phần "Ghi chú cá nhân" trong file .md

## Lộ trình học (20 ngày)

| Ngày | Chủ đề | File SQL |
|------|--------|----------|
| 1 | Giới thiệu, cài đặt, lệnh đầu tiên | ngay-01.sql |
| 2 | Kiểu dữ liệu | ngay-02.sql |
| 3 | CREATE DATABASE, CREATE TABLE | ngay-03.sql |
| 4 | INSERT - Thêm dữ liệu | ngay-04.sql |
| 5 | SELECT cơ bản | ngay-05.sql |
| 6 | WHERE nâng cao: LIKE, IN, BETWEEN | ngay-06.sql |
| 7 | UPDATE và DELETE | ngay-07.sql |
| 8 | Hàm tổng hợp COUNT, SUM, AVG | ngay-08.sql |
| 9 | GROUP BY và HAVING | ngay-09.sql |
| 10 | INNER JOIN | ngay-10.sql |
| 11 | LEFT JOIN, RIGHT JOIN, SELF JOIN | ngay-11.sql |
| 12 | Subquery | ngay-12.sql |
| 13 | Hàm chuỗi và ngày tháng | ngay-13.sql |
| 14 | INDEX và EXPLAIN | ngay-14.sql |
| 15 | Transaction và ACID | ngay-15.sql |
| 16 | VIEW | ngay-16.sql |
| 17 | Stored Procedure | ngay-17.sql |
| 18 | Trigger | ngay-18.sql |
| 19 | Stored Function | ngay-19.sql |
| 20 | Ôn tập + Dự án thư viện sách | ngay-20.sql |

## Lưu ý

- **Không chạy toàn bộ file SQL** một lúc — chạy từng BƯỚC
- **Đọc kết quả** sau mỗi lệnh trước khi tiếp tục
- **Thử sai** là bình thường — đọc thông báo lỗi để học
- Ngày 3-4 tạo database `hoc_mysql` dùng xuyên suốt từ ngày 3-19
- Ngày 20 tạo database `thu_vien` riêng cho dự án
