CREATE DATABASE DB_MienBac;
GO
USE DB_MienBac;
GO
CREATE TABLE ThiSinh (
    SBD INT PRIMARY KEY,
    HoTen NVARCHAR(100),
    Diem FLOAT
);
GO
-- Insert dữ liệu mẫu (SBD từ 001 - 500)
INSERT INTO ThiSinh (SBD, HoTen, Diem) VALUES 
(1, N'Nguyễn Văn A', 8.5),
(2, N'Trần Thị B', 9.0),
(150, N'Lê Văn C', 7.0),
(500, N'Hoàng Thị D', 8.0);
GO