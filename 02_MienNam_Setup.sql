-- ============================================================
-- NODE MIỀN NAM: Thí sinh mã 501 - 1000
-- Chạy script này trên SQL Server instance thứ hai (hoặc DB thứ hai)
-- ============================================================

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'DiemThi_MienNam')
BEGIN
    CREATE DATABASE DiemThi_MienNam;
END
GO

USE DiemThi_MienNam;
GO

-- ============================================================
-- TẠO BẢNG (cùng schema với Miền Bắc)
-- ============================================================

IF OBJECT_ID('dbo.ThiSinh', 'U') IS NOT NULL DROP TABLE dbo.ThiSinh;
IF OBJECT_ID('dbo.DiemThi', 'U') IS NOT NULL DROP TABLE dbo.DiemThi;
IF OBJECT_ID('dbo.MonThi', 'U') IS NOT NULL DROP TABLE dbo.MonThi;
GO

CREATE TABLE MonThi (
    MaMon       NVARCHAR(10) PRIMARY KEY,
    TenMon      NVARCHAR(50) NOT NULL,
    DiemToiDa   DECIMAL(4,2) DEFAULT 10.00
);

CREATE TABLE ThiSinh (
    SoBaoDanh   CHAR(7)       PRIMARY KEY,
    HoTen       NVARCHAR(100) NOT NULL,
    NgaySinh    DATE,
    GioiTinh    BIT,
    TinhTP      NVARCHAR(50),
    TruongTHPT  NVARCHAR(100),
    Node        NVARCHAR(20) DEFAULT N'Miền Nam'
);

CREATE TABLE DiemThi (
    ID          INT IDENTITY(1,1) PRIMARY KEY,
    SoBaoDanh   CHAR(7)       NOT NULL,
    MaMon       NVARCHAR(10)  NOT NULL,
    Diem        DECIMAL(4,2),
    GhiChu      NVARCHAR(100) DEFAULT NULL,
    FOREIGN KEY (SoBaoDanh) REFERENCES ThiSinh(SoBaoDanh),
    FOREIGN KEY (MaMon)     REFERENCES MonThi(MaMon)
);
GO

-- ============================================================
-- DỮ LIỆU MÔN THI
-- ============================================================

INSERT INTO MonThi VALUES
('TOAN',  N'Toán',                  10.00),
('VAN',   N'Ngữ Văn',               10.00),
('ANH',   N'Tiếng Anh',             10.00),
('LY',    N'Vật Lý',                10.00),
('HOA',   N'Hóa Học',               10.00),
('SINH',  N'Sinh Học',              10.00),
('SU',    N'Lịch Sử',               10.00),
('DIA',   N'Địa Lý',                10.00),
('GDCD',  N'Giáo dục Công dân',     10.00);
GO

-- ============================================================
-- DỮ LIỆU THÍ SINH MIỀN NAM (SBD 1000501 → 1001000)
-- ============================================================

INSERT INTO ThiSinh (SoBaoDanh, HoTen, NgaySinh, GioiTinh, TinhTP, TruongTHPT) VALUES
('1000501', N'Trần Thanh An',        '2006-02-14', 1, N'TP. Hồ Chí Minh', N'THPT Lê Hồng Phong'),
('1000502', N'Nguyễn Thị Bé',        '2006-05-08', 0, N'TP. Hồ Chí Minh', N'THPT Chuyên Trần Đại Nghĩa'),
('1000503', N'Lê Văn Chính',         '2006-09-21', 1, N'Bình Dương',       N'THPT Chuyên BD'),
('1000504', N'Phạm Thị Duyên',       '2006-01-15', 0, N'Đồng Nai',        N'THPT Chuyên Lương Thế Vinh'),
('1000505', N'Hoàng Quốc Em',        '2006-07-03', 1, N'Bà Rịa-VT',       N'THPT Chuyên BRVT'),
('1000506', N'Ngô Thị Giang',        '2006-11-27', 0, N'Tây Ninh',        N'THPT Chuyên TN'),
('1000507', N'Vũ Anh Hào',           '2006-03-09', 1, N'Long An',         N'THPT Chuyên LA'),
('1000508', N'Đặng Thị Hương',       '2006-06-18', 0, N'Tiền Giang',      N'THPT Chuyên TG'),
('1000509', N'Bùi Văn Inh',          '2006-10-06', 1, N'Bến Tre',         N'THPT Chuyên BT'),
('1000510', N'Đinh Thị Kim Anh',     '2006-04-25', 0, N'Vĩnh Long',       N'THPT Chuyên VL'),
('1000511', N'Trịnh Hữu Lân',        '2006-08-13', 1, N'Cần Thơ',         N'THPT Chuyên CT'),
('1000512', N'Nguyễn Thị Mai',       '2006-12-01', 0, N'Cần Thơ',         N'THPT Phan Ngọc Hiển'),
('1000513', N'Lê Văn Nam',           '2006-02-19', 1, N'An Giang',        N'THPT Chuyên AG'),
('1000514', N'Phan Thị Oanh',        '2006-05-30', 0, N'Kiên Giang',      N'THPT Chuyên KG'),
('1000515', N'Cao Quang Phong',       '2006-09-11', 1, N'Hậu Giang',       N'THPT Chuyên HG'),
('1000516', N'Dương Thị Quế',        '2006-01-24', 0, N'Sóc Trăng',       N'THPT Chuyên ST'),
('1000517', N'Nguyễn Văn Rọi',       '2006-07-16', 1, N'Bạc Liêu',        N'THPT Chuyên BL'),
('1000518', N'Trần Thị Sương',       '2006-11-04', 0, N'Cà Mau',          N'THPT Chuyên CM'),
('1000519', N'Lê Hữu Thắng',         '2006-03-28', 1, N'TP. Hồ Chí Minh', N'THPT Nguyễn Thị Minh Khai'),
('1000520', N'Võ Thị Uyên Nhi',      '2006-06-12', 0, N'TP. Hồ Chí Minh', N'THPT Gia Định'),
('1000521', N'Phạm Văn Việt',        '2006-10-26', 1, N'Đà Lạt',          N'THPT Chuyên Thăng Long'),
('1000522', N'Hoàng Thị Xuân',       '2006-04-07', 0, N'Lâm Đồng',        N'THPT Chuyên LD'),
('1000523', N'Ngô Đình Yên',         '2006-08-21', 1, N'Đắk Lắk',         N'THPT Chuyên DL'),
('1000524', N'Vũ Thị Ánh',           '2006-12-09', 0, N'Đắk Nông',        N'THPT Chuyên DN'),
('1000525', N'Đặng Văn Bửu',         '2006-02-23', 1, N'Gia Lai',         N'THPT Chuyên GL'),
('1000526', N'Bùi Thị Cam',          '2006-05-11', 0, N'Kon Tum',         N'THPT Chuyên KT'),
('1000527', N'Đinh Văn Dũng',        '2006-09-25', 1, N'Bình Phước',       N'THPT Chuyên BP'),
('1000528', N'Trịnh Thị Ê',          '2006-01-07', 0, N'Bình Thuận',       N'THPT Chuyên BT2'),
('1000529', N'Nguyễn Anh Phú',       '2006-07-20', 1, N'Ninh Thuận',       N'THPT Chuyên NT'),
('1000530', N'Lê Thị Giáng Hương',   '2006-11-08', 0, N'Khánh Hòa',        N'THPT Chuyên Lê Quý Đôn'),
('1000531', N'Phạm Văn Hậu',         '2006-03-22', 1, N'Phú Yên',          N'THPT Chuyên PY'),
('1000532', N'Hoàng Thị Ích',        '2006-06-05', 0, N'Quảng Ngãi',        N'THPT Chuyên QN2'),
('1000533', N'Ngô Quang Khải',        '2006-10-19', 1, N'Quảng Nam',         N'THPT Chuyên QN1'),
('1000534', N'Vũ Thị Liên',          '2006-04-02', 0, N'Đà Nẵng',           N'THPT Chuyên Lê Quý Đôn'),
('1000535', N'Đặng Văn Mẫn',         '2006-08-16', 1, N'Thừa Thiên Huế',    N'THPT Chuyên Quốc Học'),
('1000536', N'Bùi Thị Nụ',           '2006-12-30', 0, N'Quảng Trị',          N'THPT Chuyên QTr'),
('1000537', N'Đinh Văn Ổi',           '2006-02-13', 1, N'Quảng Bình',         N'THPT Chuyên QB'),
('1000538', N'Trịnh Thị Phú',         '2006-05-27', 0, N'Hà Tĩnh',            N'THPT Chuyên Phan Đình Phùng'),
('1000539', N'Nguyễn Văn Quý',        '2006-09-14', 1, N'Nghệ An',             N'THPT Chuyên Phan Bội Châu'),
('1000540', N'Trần Thị Rạng',         '2006-01-28', 0, N'Thanh Hóa',           N'THPT Chuyên Lam Sơn'),
('1000541', N'Lê Minh Sang',           '2006-07-11', 1, N'TP. Hồ Chí Minh',    N'THPT Bùi Thị Xuân'),
('1000542', N'Phạm Thị Tâm',           '2006-11-25', 0, N'Bình Dương',          N'THPT Thủ Dầu Một'),
('1000543', N'Hoàng Quang Tú',          '2006-03-08', 1, N'Đồng Nai',            N'THPT Thống Nhất'),
('1000544', N'Ngô Thị Uyên',            '2006-06-22', 0, N'Bà Rịa-VT',           N'THPT Nguyễn Huệ'),
('1000545', N'Vũ Anh Vương',             '2006-10-05', 1, N'TP. Hồ Chí Minh',    N'THPT Trần Khai Nguyên'),
('1000546', N'Đặng Thị Xuân Mai',       '2006-04-19', 0, N'Cần Thơ',             N'THPT Châu Văn Liêm'),
('1000547', N'Bùi Văn Yên',             '2006-08-02', 1, N'An Giang',             N'THPT Thoại Ngọc Hầu'),
('1000548', N'Đinh Thị Ái Như',          '2006-12-16', 0, N'Kiên Giang',           N'THPT Rạch Giá'),
('1000549', N'Trịnh Văn Bình',           '2006-02-04', 1, N'TP. Hồ Chí Minh',     N'THPT Lê Minh Xuân'),
('1000550', N'Nguyễn Thị Cẩm Tú',       '2006-05-18', 0, N'TP. Hồ Chí Minh',     N'THPT Nguyễn Du'),
-- Đặc biệt
('1000600', N'Lê Thanh Danh',            '2006-09-01', 1, N'Bình Dương',            N'THPT Dĩ An'),
('1000650', N'Phạm Thị Ê',               '2006-01-17', 0, N'Đồng Nai',              N'THPT Long Khánh'),
('1000700', N'Hoàng Văn Phú',             '2006-07-31', 1, N'TP. Hồ Chí Minh',      N'THPT Tân Phú'),
('1000750', N'Ngô Thị Gái',               '2006-11-14', 0, N'Khánh Hòa',             N'THPT Nha Trang'),
('1000800', N'Vũ Đình Hải',               '2006-03-28', 1, N'Đà Nẵng',               N'THPT Hoàng Hoa Thám'),
('1000850', N'Đặng Thị Ích Nhi',          '2006-06-11', 0, N'Thừa Thiên Huế',        N'THPT Gia Hội'),
('1000900', N'Bùi Văn Khánh',             '2006-10-25', 1, N'Nghệ An',                N'THPT Diễn Châu'),
('1000950', N'Đinh Thị Lam',              '2006-04-08', 0, N'Hà Tĩnh',                N'THPT Can Lộc'),
('1001000', N'Trịnh Văn Mạnh',            '2006-08-22', 1, N'TP. Hồ Chí Minh',       N'THPT Gò Vấp');
GO

-- ============================================================
-- DỮ LIỆU ĐIỂM THI MIỀN NAM
-- ============================================================

-- SBD 1000501 - Trần Thanh An
INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000501','TOAN',7.80),('1000501','VAN',7.25),('1000501','ANH',8.20),
('1000501','LY',7.60),('1000501','HOA',7.40),('1000501','GDCD',8.00);

-- SBD 1000502 - Nguyễn Thị Bé (xuất sắc)
INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000502','TOAN',9.60),('1000502','VAN',9.00),('1000502','ANH',9.80),
('1000502','LY',9.40),('1000502','HOA',9.20),('1000502','GDCD',9.50);

-- SBD 1000503 - Lê Văn Chính
INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000503','TOAN',6.40),('1000503','VAN',6.75),('1000503','ANH',6.20),
('1000503','SU',6.50),('1000503','DIA',6.80),('1000503','GDCD',7.00);

-- SBD 1000504 - Phạm Thị Duyên
INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000504','TOAN',8.20),('1000504','VAN',8.75),('1000504','ANH',8.00),
('1000504','SU',8.25),('1000504','DIA',8.50),('1000504','GDCD',8.75);

-- SBD 1000505 - Hoàng Quốc Em
INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000505','TOAN',5.40),('1000505','VAN',6.25),('1000505','ANH',5.60),
('1000505','LY',5.20),('1000505','HOA',5.00),('1000505','GDCD',6.25);

-- SBD 1000506 → 1000550 (batch insert)
INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000506','TOAN',7.60),('1000506','VAN',7.00),('1000506','ANH',7.40),('1000506','SU',7.20),('1000506','DIA',7.50),('1000506','GDCD',7.75),
('1000507','TOAN',8.80),('1000507','VAN',7.75),('1000507','ANH',8.60),('1000507','LY',9.00),('1000507','HOA',8.40),('1000507','GDCD',8.75),
('1000508','TOAN',6.20),('1000508','VAN',7.50),('1000508','ANH',6.40),('1000508','SU',6.75),('1000508','DIA',7.00),('1000508','GDCD',7.25),
('1000509','TOAN',9.00),('1000509','VAN',8.00),('1000509','ANH',8.80),('1000509','LY',9.20),('1000509','HOA',8.60),('1000509','GDCD',9.00),
('1000510','TOAN',7.00),('1000510','VAN',8.25),('1000510','ANH',7.20),('1000510','SU',7.50),('1000510','DIA',7.75),('1000510','GDCD',8.00);

INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000511','TOAN',8.40),('1000511','VAN',7.50),('1000511','ANH',8.20),('1000511','LY',8.60),('1000511','HOA',8.00),('1000511','GDCD',8.50),
('1000512','TOAN',5.80),('1000512','VAN',7.00),('1000512','ANH',6.00),('1000512','SU',6.25),('1000512','DIA',6.50),('1000512','GDCD',7.00),
('1000513','TOAN',7.40),('1000513','VAN',6.75),('1000513','ANH',7.20),('1000513','LY',7.60),('1000513','HOA',7.00),('1000513','GDCD',7.75),
('1000514','TOAN',9.20),('1000514','VAN',8.75),('1000514','ANH',9.00),('1000514','SU',8.50),('1000514','DIA',8.75),('1000514','GDCD',9.00),
('1000515','TOAN',6.60),('1000515','VAN',5.75),('1000515','ANH',6.40),('1000515','LY',6.20),('1000515','HOA',5.80),('1000515','GDCD',6.75);

INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000516','TOAN',8.00),('1000516','VAN',8.50),('1000516','ANH',7.80),('1000516','SU',8.00),('1000516','DIA',8.25),('1000516','GDCD',8.50),
('1000517','TOAN',7.20),('1000517','VAN',6.50),('1000517','ANH',7.00),('1000517','LY',7.40),('1000517','HOA',6.80),('1000517','GDCD',7.50),
('1000518','TOAN',5.60),('1000518','VAN',7.25),('1000518','ANH',5.80),('1000518','SU',6.00),('1000518','DIA',6.25),('1000518','GDCD',6.75),
('1000519','TOAN',8.60),('1000519','VAN',7.75),('1000519','ANH',8.40),('1000519','LY',8.80),('1000519','HOA',8.20),('1000519','GDCD',8.75),
('1000520','TOAN',7.80),('1000520','VAN',8.25),('1000520','ANH',7.60),('1000520','SU',7.75),('1000520','DIA',8.00),('1000520','GDCD',8.25);

INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000521','TOAN',6.00),('1000521','VAN',6.75),('1000521','ANH',5.80),('1000521','LY',6.20),('1000521','HOA',5.60),('1000521','GDCD',6.50),
('1000522','TOAN',9.40),('1000522','VAN',8.25),('1000522','ANH',9.20),('1000522','SU',8.75),('1000522','DIA',9.00),('1000522','GDCD',9.25),
('1000523','TOAN',7.60),('1000523','VAN',7.00),('1000523','ANH',7.40),('1000523','LY',7.80),('1000523','HOA',7.20),('1000523','GDCD',7.75),
('1000524','TOAN',5.00),('1000524','VAN',6.50),('1000524','ANH',5.20),('1000524','SU',5.50),('1000524','DIA',5.75),('1000524','GDCD',6.25),
('1000525','TOAN',8.20),('1000525','VAN',7.75),('1000525','ANH',8.00),('1000525','LY',8.40),('1000525','HOA',7.80),('1000525','GDCD',8.50);

INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000526','TOAN',6.80),('1000526','VAN',7.50),('1000526','ANH',6.60),('1000526','SU',7.00),('1000526','DIA',7.25),('1000526','GDCD',7.75),
('1000527','TOAN',7.00),('1000527','VAN',6.25),('1000527','ANH',6.80),('1000527','LY',7.20),('1000527','HOA',6.60),('1000527','GDCD',7.25),
('1000528','TOAN',9.80),('1000528','VAN',8.50),('1000528','ANH',9.60),('1000528','SU',9.00),('1000528','DIA',9.25),('1000528','GDCD',9.50),
('1000529','TOAN',6.40),('1000529','VAN',7.25),('1000529','ANH',6.20),('1000529','LY',6.60),('1000529','HOA',6.00),('1000529','GDCD',7.00),
('1000530','TOAN',8.00),('1000530','VAN',8.75),('1000530','ANH',7.80),('1000530','LY',8.20),('1000530','HOA',7.60),('1000530','GDCD',8.25);

INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000531','TOAN',7.40),('1000531','VAN',6.75),('1000531','ANH',7.20),('1000531','LY',7.60),('1000531','HOA',7.00),('1000531','GDCD',7.75),
('1000532','TOAN',5.80),('1000532','VAN',7.00),('1000532','ANH',5.60),('1000532','SU',6.00),('1000532','DIA',6.25),('1000532','GDCD',6.75),
('1000533','TOAN',8.60),('1000533','VAN',7.50),('1000533','ANH',8.40),('1000533','LY',8.80),('1000533','HOA',8.20),('1000533','GDCD',8.75),
('1000534','TOAN',9.20),('1000534','VAN',9.00),('1000534','ANH',9.40),('1000534','SU',8.75),('1000534','DIA',9.00),('1000534','GDCD',9.25),
('1000535','TOAN',6.20),('1000535','VAN',7.75),('1000535','ANH',6.40),('1000535','LY',6.60),('1000535','HOA',6.00),('1000535','GDCD',7.25);

INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000536','TOAN',7.80),('1000536','VAN',7.25),('1000536','ANH',7.60),('1000536','SU',7.50),('1000536','DIA',7.75),('1000536','GDCD',8.00),
('1000537','TOAN',4.80),('1000537','VAN',5.50),('1000537','ANH',5.00),('1000537','LY',4.60),('1000537','HOA',4.40),('1000537','GDCD',5.75),
('1000538','TOAN',8.40),('1000538','VAN',8.00),('1000538','ANH',8.20),('1000538','SU',8.25),('1000538','DIA',8.50),('1000538','GDCD',8.75),
('1000539','TOAN',9.60),('1000539','VAN',8.75),('1000539','ANH',9.40),('1000539','LY',9.80),('1000539','HOA',9.20),('1000539','GDCD',9.50),
('1000540','TOAN',6.60),('1000540','VAN',7.50),('1000540','ANH',6.80),('1000540','SU',7.00),('1000540','DIA',7.25),('1000540','GDCD',7.75);

INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000541','TOAN',7.20),('1000541','VAN',6.50),('1000541','ANH',7.00),('1000541','LY',7.40),('1000541','HOA',6.80),('1000541','GDCD',7.50),
('1000542','TOAN',8.80),('1000542','VAN',8.25),('1000542','ANH',8.60),('1000542','SU',8.50),('1000542','DIA',8.75),('1000542','GDCD',9.00),
('1000543','TOAN',5.60),('1000543','VAN',6.25),('1000543','ANH',5.80),('1000543','LY',5.40),('1000543','HOA',5.20),('1000543','GDCD',6.25),
('1000544','TOAN',7.60),('1000544','VAN',7.75),('1000544','ANH',7.40),('1000544','SU',7.25),('1000544','DIA',7.50),('1000544','GDCD',8.00),
('1000545','TOAN',9.00),('1000545','VAN',7.50),('1000545','ANH',8.80),('1000545','LY',9.20),('1000545','HOA',8.60),('1000545','GDCD',9.00);

INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000546','TOAN',6.40),('1000546','VAN',8.00),('1000546','ANH',6.60),('1000546','SU',6.75),('1000546','DIA',7.00),('1000546','GDCD',7.50),
('1000547','TOAN',7.80),('1000547','VAN',6.75),('1000547','ANH',7.60),('1000547','LY',8.00),('1000547','HOA',7.40),('1000547','GDCD',8.00),
('1000548','TOAN',5.20),('1000548','VAN',6.75),('1000548','ANH',5.40),('1000548','SU',5.60),('1000548','DIA',5.80),('1000548','GDCD',6.50),
('1000549','TOAN',8.20),('1000549','VAN',7.25),('1000549','ANH',8.00),('1000549','LY',8.40),('1000549','HOA',7.80),('1000549','GDCD',8.50),
('1000550','TOAN',7.00),('1000550','VAN',8.50),('1000550','ANH',7.20),('1000550','SU',7.50),('1000550','DIA',7.75),('1000550','GDCD',8.25);

-- Các SBD đặc biệt (round numbers)
INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000600','TOAN',8.60),('1000600','VAN',7.75),('1000600','ANH',8.40),('1000600','LY',8.80),('1000600','HOA',8.20),('1000600','GDCD',8.75),
('1000650','TOAN',6.80),('1000650','VAN',7.50),('1000650','ANH',7.00),('1000650','SU',7.25),('1000650','DIA',7.50),('1000650','GDCD',8.00),
('1000700','TOAN',9.20),('1000700','VAN',8.00),('1000700','ANH',9.00),('1000700','LY',9.40),('1000700','HOA',8.80),('1000700','GDCD',9.25),
('1000750','TOAN',7.40),('1000750','VAN',8.25),('1000750','ANH',7.20),('1000750','SU',7.50),('1000750','DIA',7.75),('1000750','GDCD',8.00),
('1000800','TOAN',8.00),('1000800','VAN',7.25),('1000800','ANH',7.80),('1000800','LY',8.20),('1000800','HOA',7.60),('1000800','GDCD',8.25),
('1000850','TOAN',5.60),('1000850','VAN',7.00),('1000850','ANH',5.80),('1000850','SU',6.00),('1000850','DIA',6.25),('1000850','GDCD',6.75),
('1000900','TOAN',9.80),('1000900','VAN',8.50),('1000900','ANH',9.60),('1000900','LY',10.00),('1000900','HOA',9.40),('1000900','GDCD',9.50),
('1000950','TOAN',7.60),('1000950','VAN',8.75),('1000950','ANH',7.40),('1000950','SU',7.75),('1000950','DIA',8.00),('1000950','GDCD',8.25),
('1001000','TOAN',8.40),('1001000','VAN',7.00),('1001000','ANH',8.20),('1001000','LY',8.60),('1001000','HOA',8.00),('1001000','GDCD',8.50);
GO

-- ============================================================
-- VIEW
-- ============================================================
CREATE OR ALTER VIEW vw_KetQuaThiSinh AS
SELECT
    ts.SoBaoDanh,
    ts.HoTen,
    ts.GioiTinh,
    ts.TinhTP,
    ts.TruongTHPT,
    mt.TenMon,
    dt.Diem,
    ts.Node
FROM ThiSinh ts
JOIN DiemThi dt ON ts.SoBaoDanh = dt.SoBaoDanh
JOIN MonThi mt  ON dt.MaMon = mt.MaMon;
GO

PRINT N'✅ Database DiemThi_MienNam đã được tạo thành công!';
PRINT N'   - Bảng: ThiSinh, DiemThi, MonThi';
PRINT N'   - SBD range: 1000501 → 1001000';
GO
