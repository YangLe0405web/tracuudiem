CREATE DATABASE DB_MienNam;
GO
USE DB_MienNam;
GO
CREATE TABLE ThiSinh (
    SBD INT PRIMARY KEY,
    HoTen NVARCHAR(100),
    Diem FLOAT
);
GO
-- Insert dữ liệu mẫu (SBD từ 501 - 1000)
INSERT INTO ThiSinh (SBD, HoTen, Diem) VALUES 
(501, N'Phạm Văn E', 6.5),
(502, N'Ngô Thị F', 7.5),
(750, N'Bùi Văn G', 9.5),
(1000, N'Đinh Thị H', 8.5);
GO