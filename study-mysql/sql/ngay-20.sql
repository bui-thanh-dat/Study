-- ============================================================
-- NGÀY 20: Ôn Tập Tổng Hợp - Dự Án Thực Hành
-- ============================================================
-- Xây dựng hệ thống quản lý thư viện sách từ đầu

-- ==============================
-- PHẦN 1: THIẾT KẾ CSDL
-- ==============================

-- BƯỚC 1: Tạo database
CREATE DATABASE IF NOT EXISTS thu_vien
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE thu_vien;

-- BƯỚC 2: Tạo bảng thể loại
CREATE TABLE the_loai (
    id  INT PRIMARY KEY AUTO_INCREMENT,
    ten VARCHAR(100) NOT NULL UNIQUE
);

-- BƯỚC 3: Tạo bảng tác giả
CREATE TABLE tac_gia (
    id       INT PRIMARY KEY AUTO_INCREMENT,
    ho_ten   VARCHAR(100) NOT NULL,
    quoc_tich VARCHAR(50),
    mo_ta    TEXT
);

-- BƯỚC 4: Tạo bảng sách
CREATE TABLE sach (
    id            INT PRIMARY KEY AUTO_INCREMENT,
    the_loai_id   INT,
    tieu_de       VARCHAR(300) NOT NULL,
    isbn          VARCHAR(20) UNIQUE,
    nam_xb        YEAR,
    so_trang      INT,
    so_luong      INT DEFAULT 0,
    mo_ta         TEXT,
    FOREIGN KEY (the_loai_id) REFERENCES the_loai(id)
);

-- BƯỚC 5: Bảng quan hệ sách - tác giả (nhiều-nhiều)
CREATE TABLE sach_tac_gia (
    sach_id   INT,
    tac_gia_id INT,
    PRIMARY KEY (sach_id, tac_gia_id),
    FOREIGN KEY (sach_id) REFERENCES sach(id),
    FOREIGN KEY (tac_gia_id) REFERENCES tac_gia(id)
);

-- BƯỚC 6: Tạo bảng bạn đọc
CREATE TABLE ban_doc (
    id        INT PRIMARY KEY AUTO_INCREMENT,
    ho_ten    VARCHAR(100) NOT NULL,
    email     VARCHAR(255) UNIQUE,
    so_the    VARCHAR(20) UNIQUE NOT NULL,
    ngay_cap  DATE DEFAULT (CURDATE()),
    han_the   DATE
);

-- BƯỚC 7: Tạo bảng mượn sách
CREATE TABLE muon_sach (
    id          INT PRIMARY KEY AUTO_INCREMENT,
    ban_doc_id  INT NOT NULL,
    sach_id     INT NOT NULL,
    ngay_muon   DATE DEFAULT (CURDATE()),
    han_tra     DATE,
    ngay_tra    DATE,
    da_tra      TINYINT(1) DEFAULT 0,
    FOREIGN KEY (ban_doc_id) REFERENCES ban_doc(id),
    FOREIGN KEY (sach_id) REFERENCES sach(id)
);

SHOW TABLES;

-- ==============================
-- PHẦN 2: NHẬP DỮ LIỆU MẪU
-- ==============================

-- BƯỚC 8: Thêm thể loại
INSERT INTO the_loai (ten) VALUES
    ('Lập trình'), ('Văn học'), ('Kinh tế'), ('Khoa học'), ('Kỹ năng sống');

-- BƯỚC 9: Thêm tác giả
INSERT INTO tac_gia (ho_ten, quoc_tich) VALUES
    ('Robert C. Martin', 'Mỹ'),
    ('Martin Fowler', 'Anh'),
    ('Nguyễn Nhật Ánh', 'Việt Nam'),
    ('Dale Carnegie', 'Mỹ'),
    ('Yuval Noah Harari', 'Israel'),
    ('Gang of Four', 'Mỹ');

-- BƯỚC 10: Thêm sách
INSERT INTO sach (the_loai_id, tieu_de, isbn, nam_xb, so_trang, so_luong) VALUES
    (1, 'Clean Code', '978-0132350884', 2008, 431, 5),
    (1, 'Design Patterns', '978-0201633610', 1994, 395, 3),
    (1, 'Refactoring', '978-0134757599', 2018, 448, 4),
    (2, 'Cho tôi xin một vé đi tuổi thơ', '978-6041066299', 2008, 234, 7),
    (2, 'Mắt biếc', '978-6041068667', 1990, 249, 6),
    (3, 'Sapiens', '978-0062316097', 2011, 443, 4),
    (4, 'Đắc nhân tâm', '978-6047790746', 1936, 320, 8),
    (4, 'Nghĩ giàu làm giàu', '978-6041080508', 1937, 356, 5),
    (1, 'The Pragmatic Programmer', '978-0201616224', 1999, 352, 3),
    (1, 'Structure and Interpretation of Computer Programs', '978-0262510875', 1996, 657, 2);

-- BƯỚC 11: Liên kết sách - tác giả
INSERT INTO sach_tac_gia VALUES
    (1, 1), (2, 6), (3, 2), (4, 3), (5, 3),
    (6, 5), (7, 4), (8, 4), (9, 1), (10, 1);

-- BƯỚC 12: Thêm bạn đọc
INSERT INTO ban_doc (ho_ten, email, so_the, ngay_cap, han_the) VALUES
    ('Nguyễn Minh Tuấn', 'tuan@email.com', 'BD001', '2024-01-01', '2025-01-01'),
    ('Trần Thị Lan', 'lan@email.com', 'BD002', '2024-01-15', '2025-01-15'),
    ('Lê Văn Hùng', 'hung@email.com', 'BD003', '2024-02-01', '2025-02-01'),
    ('Phạm Thị Mai', 'mai@email.com', 'BD004', '2024-02-15', '2025-02-15'),
    ('Hoàng Văn Nam', 'nam@email.com', 'BD005', '2024-03-01', '2025-03-01');

-- BƯỚC 13: Thêm lịch sử mượn
INSERT INTO muon_sach (ban_doc_id, sach_id, ngay_muon, han_tra, ngay_tra, da_tra) VALUES
    (1, 1, '2024-01-10', '2024-01-24', '2024-01-20', 1),
    (1, 2, '2024-02-01', '2024-02-15', '2024-02-14', 1),
    (2, 4, '2024-01-20', '2024-02-03', NULL, 0),    -- chưa trả!
    (2, 5, '2024-02-10', '2024-02-24', '2024-02-22', 1),
    (3, 1, '2024-02-15', '2024-03-01', NULL, 0),    -- chưa trả!
    (3, 7, '2024-03-01', '2024-03-15', '2024-03-10', 1),
    (4, 6, '2024-03-05', '2024-03-19', NULL, 0),    -- chưa trả!
    (5, 3, '2024-03-10', '2024-03-24', '2024-03-20', 1);

-- ==============================
-- PHẦN 3: TRUY VẤN THỰC HÀNH
-- ==============================

-- BƯỚC 14: Danh sách sách kèm tác giả và thể loại
SELECT
    s.tieu_de,
    tl.ten AS the_loai,
    GROUP_CONCAT(tg.ho_ten SEPARATOR ', ') AS tac_gia,
    s.nam_xb,
    s.so_luong AS hien_co
FROM sach s
JOIN the_loai tl ON s.the_loai_id = tl.id
JOIN sach_tac_gia stg ON s.id = stg.sach_id
JOIN tac_gia tg ON stg.tac_gia_id = tg.id
GROUP BY s.id, s.tieu_de, tl.ten, s.nam_xb, s.so_luong
ORDER BY tl.ten, s.tieu_de;

-- BƯỚC 15: Sách đang được mượn (chưa trả)
SELECT
    bd.ho_ten AS ban_doc,
    s.tieu_de AS sach,
    ms.ngay_muon,
    ms.han_tra,
    DATEDIFF(CURDATE(), ms.han_tra) AS qua_han_ngay
FROM muon_sach ms
JOIN ban_doc bd ON ms.ban_doc_id = bd.id
JOIN sach s ON ms.sach_id = s.id
WHERE ms.da_tra = 0
ORDER BY ms.han_tra;

-- BƯỚC 16: Sách quá hạn
SELECT
    bd.ho_ten AS ban_doc,
    bd.email,
    s.tieu_de,
    ms.han_tra AS pha_tra,
    DATEDIFF(CURDATE(), ms.han_tra) AS so_ngay_tre
FROM muon_sach ms
JOIN ban_doc bd ON ms.ban_doc_id = bd.id
JOIN sach s ON ms.sach_id = s.id
WHERE ms.da_tra = 0
  AND ms.han_tra < CURDATE()
ORDER BY so_ngay_tre DESC;

-- BƯỚC 17: Thống kê mượn sách
SELECT
    s.tieu_de,
    COUNT(ms.id) AS so_lan_muon,
    SUM(ms.da_tra) AS da_tra,
    COUNT(ms.id) - SUM(ms.da_tra) AS dang_muon
FROM sach s
LEFT JOIN muon_sach ms ON s.id = ms.sach_id
GROUP BY s.id, s.tieu_de
ORDER BY so_lan_muon DESC;

-- BƯỚC 18: Bạn đọc mượn nhiều nhất
SELECT
    bd.ho_ten,
    COUNT(ms.id) AS tong_luot_muon,
    SUM(ms.da_tra) AS da_tra,
    COUNT(ms.id) - SUM(ms.da_tra) AS dang_muon
FROM ban_doc bd
LEFT JOIN muon_sach ms ON bd.id = ms.ban_doc_id
GROUP BY bd.id, bd.ho_ten
ORDER BY tong_luot_muon DESC;

-- ==============================
-- PHẦN 4: VIEW VÀ PROCEDURE
-- ==============================

-- BƯỚC 19: Tạo View
CREATE OR REPLACE VIEW v_sach_dang_muon AS
SELECT
    ms.id AS ma_muon,
    bd.ho_ten AS ban_doc,
    bd.so_the,
    s.tieu_de,
    ms.ngay_muon,
    ms.han_tra,
    CASE
        WHEN ms.han_tra < CURDATE() THEN CONCAT('Quá hạn ', DATEDIFF(CURDATE(), ms.han_tra), ' ngày')
        ELSE CONCAT('Còn ', DATEDIFF(ms.han_tra, CURDATE()), ' ngày')
    END AS trang_thai
FROM muon_sach ms
JOIN ban_doc bd ON ms.ban_doc_id = bd.id
JOIN sach s ON ms.sach_id = s.id
WHERE ms.da_tra = 0;

SELECT * FROM v_sach_dang_muon ORDER BY han_tra;

-- BƯỚC 20: Procedure mượn sách
DELIMITER //

CREATE PROCEDURE muon_sach_proc(
    IN  p_ban_doc_id INT,
    IN  p_sach_id    INT,
    IN  p_so_ngay    INT,    -- số ngày được mượn
    OUT p_thong_bao  VARCHAR(300)
)
BEGIN
    DECLARE v_so_luong INT;
    DECLARE v_dang_muon INT;

    -- Kiểm tra sách còn hàng không
    SELECT so_luong INTO v_so_luong FROM sach WHERE id = p_sach_id;
    IF v_so_luong IS NULL THEN
        SET p_thong_bao = 'Sách không tồn tại!';
        LEAVE sp;
    END IF;

    -- Kiểm tra bạn đọc đang mượn cuốn này chưa
    SELECT COUNT(*) INTO v_dang_muon
    FROM muon_sach
    WHERE ban_doc_id = p_ban_doc_id AND sach_id = p_sach_id AND da_tra = 0;

    IF v_dang_muon > 0 THEN
        SET p_thong_bao = 'Bạn đọc đang mượn cuốn sách này rồi!';
    ELSEIF v_so_luong <= 0 THEN
        SET p_thong_bao = 'Sách đã hết, không thể mượn!';
    ELSE
        START TRANSACTION;

        -- Tạo bản ghi mượn
        INSERT INTO muon_sach (ban_doc_id, sach_id, han_tra)
        VALUES (p_ban_doc_id, p_sach_id, DATE_ADD(CURDATE(), INTERVAL p_so_ngay DAY));

        -- Giảm số lượng sách
        UPDATE sach SET so_luong = so_luong - 1 WHERE id = p_sach_id;

        COMMIT;
        SET p_thong_bao = CONCAT('Mượn thành công! Hạn trả: ',
            DATE_FORMAT(DATE_ADD(CURDATE(), INTERVAL p_so_ngay DAY), '%d/%m/%Y'));
    END IF;
END //

DELIMITER ;

-- Test procedure
CALL muon_sach_proc(5, 4, 14, @tb);
SELECT @tb;

SELECT * FROM v_sach_dang_muon;

-- ============================================================
-- TỔNG KẾT: Kiểm tra kiến thức
-- ============================================================

-- Câu 1: Thể loại nào có nhiều sách nhất?
SELECT tl.ten, COUNT(s.id) AS so_sach
FROM the_loai tl
LEFT JOIN sach s ON tl.id = s.the_loai_id
GROUP BY tl.id, tl.ten
ORDER BY so_sach DESC;

-- Câu 2: Tác giả nào viết nhiều sách nhất?
SELECT tg.ho_ten, COUNT(stg.sach_id) AS so_sach
FROM tac_gia tg
LEFT JOIN sach_tac_gia stg ON tg.id = stg.tac_gia_id
GROUP BY tg.id, tg.ho_ten
ORDER BY so_sach DESC;

-- Câu 3: Tổng số sách đang được mượn
SELECT COUNT(*) AS sach_dang_muon FROM muon_sach WHERE da_tra = 0;

-- Câu 4: Bạn đọc nào chưa mượn sách lần nào?
SELECT bd.ho_ten, bd.so_the
FROM ban_doc bd
LEFT JOIN muon_sach ms ON bd.id = ms.ban_doc_id
WHERE ms.id IS NULL;
