-- ============================================================
-- NODE MIỀN BẮC: Thí sinh mã 001 - 500
-- Chạy script này trên SQL Server instance thứ nhất
-- ============================================================

-- Tạo Database
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'DiemThi_MienBac')
BEGIN
    CREATE DATABASE DiemThi_MienBac;
END
GO

USE DiemThi_MienBac;
GO

-- ============================================================
-- TẠO BẢNG
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
    SoBaoDanh   CHAR(7)      PRIMARY KEY,   -- VD: 1000001
    HoTen       NVARCHAR(100) NOT NULL,
    NgaySinh    DATE,
    GioiTinh    BIT,                         -- 1=Nam, 0=Nữ
    TinhTP      NVARCHAR(50),
    TruongTHPT  NVARCHAR(100),
    Node        NVARCHAR(20) DEFAULT N'Miền Bắc'
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
-- DỮ LIỆU THÍ SINH MIỀN BẮC (SBD 1000001 → 1000500)
-- ============================================================

INSERT INTO ThiSinh (SoBaoDanh, HoTen, NgaySinh, GioiTinh, TinhTP, TruongTHPT) VALUES
('1000001', N'Nguyễn Văn An',       '2006-03-12', 1, N'Hà Nội',        N'THPT Chu Văn An'),
('1000002', N'Trần Thị Bình',       '2006-07-24', 0, N'Hà Nội',        N'THPT Kim Liên'),
('1000003', N'Lê Minh Cường',       '2006-01-05', 1, N'Hà Nội',        N'THPT Ams'),
('1000004', N'Phạm Thị Dung',       '2006-09-18', 0, N'Hải Phòng',     N'THPT Trần Phú'),
('1000005', N'Hoàng Văn Em',        '2006-11-30', 1, N'Hải Phòng',     N'THPT Ngô Quyền'),
('1000006', N'Ngô Thị Fương',       '2006-04-22', 0, N'Hải Dương',     N'THPT Chuyên HD'),
('1000007', N'Vũ Quang Giang',      '2006-06-14', 1, N'Nam Định',      N'THPT Chuyên LQĐ'),
('1000008', N'Đặng Thị Hoa',        '2006-08-07', 0, N'Thái Bình',     N'THPT Chuyên TB'),
('1000009', N'Bùi Văn Inh',         '2006-02-19', 1, N'Ninh Bình',     N'THPT Lương Văn Tụy'),
('1000010', N'Đinh Thị Kim',        '2006-10-03', 0, N'Quảng Ninh',    N'THPT Chuyên HLQ'),
('1000011', N'Trịnh Văn Long',      '2006-05-25', 1, N'Phú Thọ',       N'THPT Chuyên HV'),
('1000012', N'Nguyễn Thị Mai',      '2006-12-11', 0, N'Vĩnh Phúc',     N'THPT Chuyên VP'),
('1000013', N'Lê Quốc Nam',         '2006-03-29', 1, N'Bắc Ninh',      N'THPT Hàn Thuyên'),
('1000014', N'Phan Thị Oanh',       '2006-07-08', 0, N'Hưng Yên',      N'THPT Chuyên HY'),
('1000015', N'Cao Văn Phong',       '2006-09-16', 1, N'Thái Nguyên',   N'THPT Chuyên TN'),
('1000016', N'Dương Thị Quỳnh',     '2006-01-27', 0, N'Bắc Giang',     N'THPT Chuyên BG'),
('1000017', N'Nguyễn Văn Rộng',     '2006-11-04', 1, N'Lào Cai',       N'THPT Chuyên LC'),
('1000018', N'Trần Thị Sen',        '2006-06-20', 0, N'Yên Bái',       N'THPT Chuyên YB'),
('1000019', N'Lê Hữu Thành',        '2006-04-13', 1, N'Hòa Bình',      N'THPT Chuyên HB'),
('1000020', N'Võ Thị Uyên',         '2006-08-31', 0, N'Sơn La',        N'THPT Chuyên SL'),
('1000021', N'Phạm Văn Việt',       '2006-02-06', 1, N'Điện Biên',     N'THPT Chuyên DB'),
('1000022', N'Hoàng Thị Xuân',      '2006-10-17', 0, N'Lai Châu',      N'THPT Chuyên LC2'),
('1000023', N'Ngô Thanh Yên',       '2006-03-01', 0, N'Hà Giang',      N'THPT Chuyên HG'),
('1000024', N'Vũ Văn Anh',          '2006-07-15', 1, N'Tuyên Quang',   N'THPT Chuyên TQ'),
('1000025', N'Đặng Thị Bông',       '2006-09-09', 0, N'Cao Bằng',      N'THPT Chuyên CB'),
('1000026', N'Bùi Quang Cảnh',      '2006-12-23', 1, N'Lạng Sơn',      N'THPT Chuyên LS'),
('1000027', N'Đinh Thị Duyên',      '2006-05-07', 0, N'Bắc Kạn',       N'THPT Chuyên BK'),
('1000028', N'Trịnh Văn Đức',       '2006-01-21', 1, N'Hà Nam',        N'THPT Chuyên HN2'),
('1000029', N'Nguyễn Thị Êm',       '2006-11-14', 0, N'Hải Phòng',     N'THPT Lê Hồng Phong'),
('1000030', N'Lê Anh Phúc',         '2006-04-28', 1, N'Hà Nội',        N'THPT Việt Đức'),
-- 30 more records
('1000031', N'Phạm Thị Gấm',        '2006-06-10', 0, N'Hà Nội',        N'THPT Yên Hòa'),
('1000032', N'Cao Văn Hào',         '2006-08-24', 1, N'Hưng Yên',      N'THPT Phù Cừ'),
('1000033', N'Dương Thị Inh',       '2006-02-15', 0, N'Hải Dương',     N'THPT Bình Giang'),
('1000034', N'Nguyễn Quang Khải',   '2006-10-29', 1, N'Hà Nội',        N'THPT Cầu Giấy'),
('1000035', N'Trần Thị Lan',        '2006-03-17', 0, N'Nam Định',       N'THPT Trần Hưng Đạo'),
('1000036', N'Lê Văn Mạnh',         '2006-07-03', 1, N'Thái Bình',     N'THPT Vũ Thư'),
('1000037', N'Phan Thị Ngọc',       '2006-09-22', 0, N'Ninh Bình',     N'THPT Nho Quan'),
('1000038', N'Hoàng Văn Oanh',      '2006-12-05', 1, N'Quảng Ninh',    N'THPT Hạ Long'),
('1000039', N'Ngô Thị Phương',      '2006-04-19', 0, N'Phú Thọ',       N'THPT Lâm Thao'),
('1000040', N'Vũ Đình Quang',       '2006-06-08', 1, N'Vĩnh Phúc',     N'THPT Vĩnh Yên'),
('1000041', N'Đặng Thị Ráng',       '2006-08-16', 0, N'Bắc Ninh',      N'THPT Gia Bình'),
('1000042', N'Bùi Văn Sơn',         '2006-02-28', 1, N'Thái Nguyên',   N'THPT Đồng Hỷ'),
('1000043', N'Đinh Thị Thúy',       '2006-10-12', 0, N'Bắc Giang',     N'THPT Sơn Động'),
('1000044', N'Trịnh Quang Ủng',     '2006-05-26', 1, N'Hà Nội',        N'THPT Hoàng Mai'),
('1000045', N'Nguyễn Thị Vân',      '2006-01-09', 0, N'Hải Phòng',     N'THPT Kiến An'),
('1000046', N'Lê Huy Xưởng',        '2006-11-23', 1, N'Hà Nội',        N'THPT Đống Đa'),
('1000047', N'Phạm Thị Yến',        '2006-03-05', 0, N'Hà Nội',        N'THPT Tây Hồ'),
('1000048', N'Cao Văn Zung',         '2006-07-19', 1, N'Nam Định',       N'THPT Xuân Trường'),
('1000049', N'Dương Thị Ái',        '2006-09-02', 0, N'Ninh Bình',     N'THPT Yên Mô'),
('1000050', N'Nguyễn Văn Bách',     '2006-12-16', 1, N'Hà Nội',        N'THPT Thăng Long'),
-- Additional records to reach representative 50 for demo
('1000100', N'Trần Minh Hiếu',      '2006-04-07', 1, N'Hà Nội',        N'THPT Nguyễn Tất Thành'),
('1000150', N'Lê Thị Hạnh',         '2006-06-21', 0, N'Hải Phòng',     N'THPT Thái Phiên'),
('1000200', N'Phạm Quốc Hùng',      '2006-08-09', 1, N'Quảng Ninh',    N'THPT Uông Bí'),
('1000250', N'Hoàng Thị Thu',       '2006-02-23', 0, N'Hà Nội',        N'THPT Phan Đình Phùng'),
('1000300', N'Ngô Thanh Tùng',      '2006-10-06', 1, N'Hưng Yên',      N'THPT Mỹ Hào'),
('1000350', N'Vũ Thị Linh',         '2006-05-14', 0, N'Vĩnh Phúc',     N'THPT Bình Xuyên'),
('1000400', N'Đặng Văn Khôi',       '2006-01-28', 1, N'Bắc Ninh',      N'THPT Tiên Du'),
('1000450', N'Bùi Thị Ngân',        '2006-11-11', 0, N'Thái Nguyên',   N'THPT Phú Bình'),
('1000500', N'Đinh Văn Trọng',      '2006-03-25', 1, N'Hà Nội',        N'THPT Trương Định');
GO

-- ============================================================
-- DỮ LIỆU ĐIỂM THI MIỀN BẮC
-- ============================================================

-- SBD 1000001 - Nguyễn Văn An (khá giỏi)
INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000001','TOAN',8.40),('1000001','VAN',7.50),('1000001','ANH',8.00),
('1000001','LY',8.20),('1000001','HOA',7.80),('1000001','GDCD',9.00);

-- SBD 1000002 - Trần Thị Bình
INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000002','TOAN',6.20),('1000002','VAN',8.00),('1000002','ANH',7.20),
('1000002','SU',7.50),('1000002','DIA',8.20),('1000002','GDCD',8.00);

-- SBD 1000003 - Lê Minh Cường (xuất sắc)
INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000003','TOAN',9.80),('1000003','VAN',8.25),('1000003','ANH',9.40),
('1000003','LY',9.60),('1000003','HOA',9.20),('1000003','GDCD',9.50);

-- SBD 1000004 - Phạm Thị Dung
INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000004','TOAN',5.60),('1000004','VAN',6.75),('1000004','ANH',5.80),
('1000004','SU',6.20),('1000004','DIA',6.50),('1000004','GDCD',7.00);

-- SBD 1000005 - Hoàng Văn Em
INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000005','TOAN',7.20),('1000005','VAN',6.50),('1000005','ANH',6.80),
('1000005','LY',7.00),('1000005','HOA',6.60),('1000005','GDCD',7.50);

-- SBD 1000006 - Ngô Thị Fương
INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000006','TOAN',8.80),('1000006','VAN',7.75),('1000006','ANH',8.60),
('1000006','LY',8.40),('1000006','HOA',8.20),('1000006','GDCD',8.75);

-- SBD 1000007 - Vũ Quang Giang
INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000007','TOAN',9.20),('1000007','VAN',7.00),('1000007','ANH',8.80),
('1000007','LY',9.40),('1000007','HOA',9.00),('1000007','GDCD',8.50);

-- SBD 1000008 - Đặng Thị Hoa
INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000008','TOAN',4.60),('1000008','VAN',5.50),('1000008','ANH',4.80),
('1000008','SU',5.00),('1000008','DIA',5.25),('1000008','GDCD',6.00);

-- SBD 1000009 - Bùi Văn Inh
INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000009','TOAN',7.60),('1000009','VAN',7.25),('1000009','ANH',7.00),
('1000009','LY',7.80),('1000009','HOA',7.40),('1000009','GDCD',8.00);

-- SBD 1000010 - Đinh Thị Kim
INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000010','TOAN',6.80),('1000010','VAN',8.50),('1000010','ANH',7.60),
('1000010','SU',8.00),('1000010','DIA',7.75),('1000010','GDCD',8.25);

-- SBD 1000011 đến 1000050 (rút gọn)
INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000011','TOAN',8.00),('1000011','VAN',7.00),('1000011','ANH',7.80),('1000011','LY',8.20),('1000011','HOA',7.60),('1000011','GDCD',8.40),
('1000012','TOAN',9.00),('1000012','VAN',8.75),('1000012','ANH',9.20),('1000012','SU',8.50),('1000012','DIA',8.80),('1000012','GDCD',9.00),
('1000013','TOAN',5.40),('1000013','VAN',6.00),('1000013','ANH',5.60),('1000013','LY',5.80),('1000013','HOA',5.20),('1000013','GDCD',6.50),
('1000014','TOAN',7.40),('1000014','VAN',7.75),('1000014','ANH',7.20),('1000014','SU',7.50),('1000014','DIA',7.80),('1000014','GDCD',8.00),
('1000015','TOAN',8.60),('1000015','VAN',7.50),('1000015','ANH',8.40),('1000015','LY',8.80),('1000015','HOA',8.20),('1000015','GDCD',8.75);

INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000016','TOAN',6.40),('1000016','VAN',8.25),('1000016','ANH',6.80),('1000016','SU',7.00),('1000016','DIA',7.50),('1000016','GDCD',7.75),
('1000017','TOAN',7.80),('1000017','VAN',6.75),('1000017','ANH',7.40),('1000017','LY',7.60),('1000017','HOA',7.20),('1000017','GDCD',8.00),
('1000018','TOAN',5.80),('1000018','VAN',7.50),('1000018','ANH',6.20),('1000018','SU',6.50),('1000018','DIA',6.75),('1000018','GDCD',7.00),
('1000019','TOAN',9.40),('1000019','VAN',8.00),('1000019','ANH',9.00),('1000019','LY',9.20),('1000019','HOA',8.80),('1000019','GDCD',9.25),
('1000020','TOAN',6.60),('1000020','VAN',7.25),('1000020','ANH',6.40),('1000020','SU',6.80),('1000020','DIA',7.00),('1000020','GDCD',7.50);

INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000021','TOAN',8.20),('1000021','VAN',7.75),('1000021','ANH',8.00),('1000021','LY',8.40),('1000021','HOA',7.80),('1000021','GDCD',8.50),
('1000022','TOAN',7.00),('1000022','VAN',8.50),('1000022','ANH',7.60),('1000022','SU',7.75),('1000022','DIA',8.00),('1000022','GDCD',8.25),
('1000023','TOAN',5.20),('1000023','VAN',6.50),('1000023','ANH',5.40),('1000023','SU',5.60),('1000023','DIA',5.80),('1000023','GDCD',6.25),
('1000024','TOAN',8.40),('1000024','VAN',7.25),('1000024','ANH',8.20),('1000024','LY',8.60),('1000024','HOA',8.00),('1000024','GDCD',8.75),
('1000025','TOAN',6.00),('1000025','VAN',7.00),('1000025','ANH',6.20),('1000025','SU',6.50),('1000025','DIA',6.75),('1000025','GDCD',7.25);

INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000026','TOAN',7.60),('1000026','VAN',6.75),('1000026','ANH',7.40),('1000026','LY',7.20),('1000026','HOA',7.00),('1000026','GDCD',7.75),
('1000027','TOAN',8.80),('1000027','VAN',8.00),('1000027','ANH',8.60),('1000027','LY',9.00),('1000027','HOA',8.40),('1000027','GDCD',9.00),
('1000028','TOAN',4.40),('1000028','VAN',5.25),('1000028','ANH',4.60),('1000028','SU',4.80),('1000028','DIA',5.00),('1000028','GDCD',5.75),
('1000029','TOAN',7.20),('1000029','VAN',7.75),('1000029','ANH',7.00),('1000029','SU',7.25),('1000029','DIA',7.50),('1000029','GDCD',7.75),
('1000030','TOAN',9.60),('1000030','VAN',8.50),('1000030','ANH',9.40),('1000030','LY',9.80),('1000030','HOA',9.20),('1000030','GDCD',9.50);

INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000031','TOAN',6.80),('1000031','VAN',7.50),('1000031','ANH',6.60),('1000031','SU',7.00),('1000031','DIA',7.25),('1000031','GDCD',7.75),
('1000032','TOAN',7.40),('1000032','VAN',6.75),('1000032','ANH',7.20),('1000032','LY',7.60),('1000032','HOA',6.80),('1000032','GDCD',8.00),
('1000033','TOAN',5.60),('1000033','VAN',6.25),('1000033','ANH',5.80),('1000033','SU',5.50),('1000033','DIA',6.00),('1000033','GDCD',6.50),
('1000034','TOAN',8.60),('1000034','VAN',7.75),('1000034','ANH',8.40),('1000034','LY',8.80),('1000034','HOA',8.20),('1000034','GDCD',8.75),
('1000035','TOAN',7.00),('1000035','VAN',8.25),('1000035','ANH',7.20),('1000035','SU',7.50),('1000035','DIA',7.75),('1000035','GDCD',8.25);

INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000036','TOAN',6.20),('1000036','VAN',5.75),('1000036','ANH',6.00),('1000036','LY',6.40),('1000036','HOA',5.80),('1000036','GDCD',6.75),
('1000037','TOAN',8.00),('1000037','VAN',8.50),('1000037','ANH',7.80),('1000037','SU',8.00),('1000037','DIA',8.25),('1000037','GDCD',8.75),
('1000038','TOAN',7.80),('1000038','VAN',7.00),('1000038','ANH',7.60),('1000038','LY',8.00),('1000038','HOA',7.40),('1000038','GDCD',8.25),
('1000039','TOAN',5.00),('1000039','VAN',6.75),('1000039','ANH',5.20),('1000039','SU',5.50),('1000039','DIA',5.75),('1000039','GDCD',6.25),
('1000040','TOAN',9.00),('1000040','VAN',7.75),('1000040','ANH',8.80),('1000040','LY',9.20),('1000040','HOA',8.60),('1000040','GDCD',9.00);

INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000041','TOAN',6.60),('1000041','VAN',7.25),('1000041','ANH',6.80),('1000041','SU',6.50),('1000041','DIA',7.00),('1000041','GDCD',7.50),
('1000042','TOAN',7.60),('1000042','VAN',6.50),('1000042','ANH',7.40),('1000042','LY',7.80),('1000042','HOA',7.20),('1000042','GDCD',7.75),
('1000043','TOAN',8.20),('1000043','VAN',8.75),('1000043','ANH',8.00),('1000043','SU',8.25),('1000043','DIA',8.50),('1000043','GDCD',8.75),
('1000044','TOAN',5.40),('1000044','VAN',5.75),('1000044','ANH',5.60),('1000044','LY',5.20),('1000044','HOA',5.00),('1000044','GDCD',6.00),
('1000045','TOAN',7.20),('1000045','VAN',7.75),('1000045','ANH',7.00),('1000045','SU',7.25),('1000045','DIA',7.50),('1000045','GDCD',8.00);

INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000046','TOAN',8.40),('1000046','VAN',7.25),('1000046','ANH',8.20),('1000046','LY',8.60),('1000046','HOA',8.00),('1000046','GDCD',8.50),
('1000047','TOAN',6.40),('1000047','VAN',8.00),('1000047','ANH',6.60),('1000047','SU',6.75),('1000047','DIA',7.00),('1000047','GDCD',7.50),
('1000048','TOAN',7.80),('1000048','VAN',6.75),('1000048','ANH',7.60),('1000048','LY',8.00),('1000048','HOA',7.40),('1000048','GDCD',8.00),
('1000049','TOAN',5.60),('1000049','VAN',7.00),('1000049','ANH',5.80),('1000049','SU',6.00),('1000049','DIA',6.25),('1000049','GDCD',6.75),
('1000050','TOAN',9.20),('1000050','VAN',8.25),('1000050','ANH',9.00),('1000050','LY',9.40),('1000050','HOA',8.80),('1000050','GDCD',9.25);

-- Các SBD đặc biệt (round numbers)
INSERT INTO DiemThi (SoBaoDanh, MaMon, Diem) VALUES
('1000100','TOAN',8.00),('1000100','VAN',7.50),('1000100','ANH',7.80),('1000100','LY',8.20),('1000100','HOA',7.60),('1000100','GDCD',8.50),
('1000150','TOAN',7.40),('1000150','VAN',8.25),('1000150','ANH',7.20),('1000150','SU',7.50),('1000150','DIA',7.75),('1000150','GDCD',8.00),
('1000200','TOAN',9.40),('1000200','VAN',7.75),('1000200','ANH',9.20),('1000200','LY',9.60),('1000200','HOA',9.00),('1000200','GDCD',9.25),
('1000250','TOAN',6.80),('1000250','VAN',8.75),('1000250','ANH',7.00),('1000250','SU',7.25),('1000250','DIA',7.50),('1000250','GDCD',8.00),
('1000300','TOAN',7.60),('1000300','VAN',6.75),('1000300','ANH',7.40),('1000300','LY',7.80),('1000300','HOA',7.20),('1000300','GDCD',7.75),
('1000350','TOAN',8.60),('1000350','VAN',8.00),('1000350','ANH',8.40),('1000350','SU',8.25),('1000350','DIA',8.50),('1000350','GDCD',8.75),
('1000400','TOAN',5.80),('1000400','VAN',6.50),('1000400','ANH',6.00),('1000400','LY',5.60),('1000400','HOA',5.40),('1000400','GDCD',6.25),
('1000450','TOAN',7.00),('1000450','VAN',7.75),('1000450','ANH',6.80),('1000450','SU',7.00),('1000450','DIA',7.25),('1000450','GDCD',7.75),
('1000500','TOAN',8.80),('1000500','VAN',7.50),('1000500','ANH',8.60),('1000500','LY',9.00),('1000500','HOA',8.40),('1000500','GDCD',9.00);
GO

-- ============================================================
-- VIEW tiện tra cứu
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

PRINT N'✅ Database DiemThi_MienBac đã được tạo thành công!';
PRINT N'   - Bảng: ThiSinh, DiemThi, MonThi';
PRINT N'   - SBD range: 1000001 → 1000500';
GO
