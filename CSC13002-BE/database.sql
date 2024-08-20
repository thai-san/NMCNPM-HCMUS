﻿CREATE DATABASE QLHS
GO
USE QLHS
GO
-------------------Tạo database----------------------
CREATE TABLE KHOI
(
MAKHOI CHAR(5) NOT NULL,
TENKHOI NVARCHAR(40),
SOLUONG INT
PRIMARY KEY(MAKHOI)
)
GO

CREATE TABLE LOP
(
MALOP CHAR(5) NOT NULL,
TENLOP NVARCHAR(10),
SISO INT,
MAKHOI CHAR(5)
PRIMARY KEY(MALOP)
)
GO

CREATE TABLE HOCSINH
(
MAHS CHAR(5) NOT NULL,
HOTEN NVARCHAR(40),
GIOITINH NVARCHAR(5), -- NAM OR NỮ OR KHÁC
NGAYSINH DATE,
DIACHI NVARCHAR(40),
EMAIL NVARCHAR(20),
MALOP CHAR(5)
PRIMARY KEY(MAHS)
)
GO

CREATE TABLE HOCKI
(
MAHK CHAR(5) NOT NULL,
TENHK NVARCHAR(10)
PRIMARY KEY(MAHK)
)
GO

CREATE TABLE MONHOC
(
MAMH CHAR(5) NOT NULL,
TENMH NVARCHAR(20)
PRIMARY KEY(MAMH)
)
GO

CREATE TABLE DIEMTK
(
MADIEMTK CHAR(5) NOT NULL,
DIEMTK FLOAT,
MAHK CHAR(5),
MAMH CHAR(5),
MAHS CHAR(5)
PRIMARY KEY(MADIEMTK)
)
GO

CREATE TABLE LOAIKT
(
MAKT CHAR(5) NOT NULL,
TENKT NVARCHAR(10)
PRIMARY KEY(MAKT)
)
GO

CREATE TABLE CHITIETDIEM
(
MADIEMKT CHAR(5) NOT NULL,
MAKT CHAR(5),
DIEMKT FLOAT
PRIMARY KEY(MADIEMKT,MAKT)
)
GO

CREATE TABLE TAIKHOAN
(
MATK CHAR(5) NOT NULL,
TENDANGNHAP CHAR(100),
MATKHAU CHAR(100),
LOAITK INT -- 1. GIÁO VỤ 2. GIÁO VIÊN
)
GO
select * from khoi

INSERT INTO KHOI(MAKHOI,TENKHOI,SOLUONG)
VALUES('KH010','Khối 10',3),('KH011','Khối 11',3),('KH012','Khối 12',3)

insert into HOCKI(MAHK,TENHK)
values('HK001','HK1'),('HK002','HK2')

INSERT INTO MONHOC(MAMH,TENMH)
VALUES('MH001','Toán'),
('MH002','Lý'),
('MH003','Hóa'),
('MH004','Sinh'),
('MH005','Sử'),
('MH006','Địa'),
('MH007','Văn'),
('MH008','Đạo đức'),
('MH009','Thể dục')

insert into LOP(MALOP,TENLOP,SISO,MAKHOI)
values('L10A1','10A1',0,'KH010'),
('L10A2','10A2',0,'KH010'),
('L10A3','10A3',0,'KH010'),
('L11A1','11A1',0,'KH011'),
('L11A2','11A2',0,'KH011'),
('L11A3','11A3',0,'KH011'),
('L12A1','12A1',0,'KH012'),
('L12A2','12A2',0,'KH012'),
('L12A3','12A3',0,'KH012')

insert into LOAIKT(MAKT,TENKT)
values('KT001','KT15p'),('KT002','KT 1 tiết'),('KT003','KT Học Kỳ')
go

create proc ThemHS @hoten nvarchar(40), @gioitinh nvarchar(5), @ngaysinh date, @diachi nvarchar(40), @email nvarchar(20), @malop char(5)
as
begin
	declare @mahs char(5)
	declare @count int
	select @count = count(*) from HOCSINH
	set @count = @count + 1
	set @mahs = 'HS' + ltrim(str(@count,10))
	insert into HOCSINH(MAHS,HOTEN,GIOITINH,NGAYSINH,DIACHI,EMAIL,MALOP)
	values(@mahs,@hoten,@gioitinh,@ngaysinh,@diachi,@email,@malop)

	update LOP
	set SISO = SISO + 1
	where MALOP = @malop
end
go

create proc XoaHS @mahs char(5)
as
begin
	declare @malop char(5)
	select @malop = L.MALOP from LOP L, HOCSINH HS where L.MALOP = HS.MALOP and HS.MAHS = @mahs
	delete from HOCSINH where MAHS = @mahs
	update LOP
	set SISO = SISO - 1
	where MALOP = @malop
end
go

create proc XoaHS @mahs char(5), @hoten nvarchar(40), @gioitinh nvarchar(5), @ngaysinh date, @diachi nvarchar(40), @email nvarchar(20), @malop char(5)
as
begin
update HOCSINH
set HOTEN = @hoten, GIOITINH = @gioitinh, NGAYSINH=@ngaysinh,DIACHI=@diachi,EMAIL=@email,MALOP=@malop
where MAHS = @mahs
end
go

create proc ThemLop @malop char(5), @tenlop nvarchar(10), @makhoi char(5)
as
begin
insert into LOP(MALOP,TENLOP,SISO,MAKHOI)
values(@malop,@tenlop,0,@makhoi)
update KHOI
set SOLUONG = SOLUONG + 1
where MAKHOI = @makhoi
end
go

create proc XoaLop @malop char(5)
as
begin
declare @makhoi char(5)
select @makhoi = MAKHOI from LOP where MALOP=@malop
delete from LOP where MALOP=@malop
update KHOI
set SOLUONG = SOLUONG - 1
where MAKHOI=@makhoi
end
go


create proc TracuuHS @mahs char(5)
as
begin
	select * from HOCSINH where MAHS = @mahs
end
go

print YEAR(GETDATE()) - YEAR('1/1/2000')

------------Tạo ràng buộc-----------------
ALTER TABLE HOCSINH
ADD CONSTRAINT QD_TUOI CHECK( (YEAR(GETDATE()) - YEAR(NGAYSINH)) >=15 AND (YEAR(GETDATE()) - YEAR(NGAYSINH)) <= 20 )

ALTER TABLE LOP
ADD CONSTRAINT QD_LOP CHECK(SISO<=40)

ALTER TABLE KHOI
ADD CONSTRAINT QD_KHOI CHECK(SOLUONG=3)
GO

create TRIGGER QD_TUOI
ON HOCSINH
FOR INSERT, UPDATE
AS
	BEGIN
		IF(EXISTS( SELECT * FROM inserted I WHERE YEAR(GETDATE()) - YEAR(I.NGAYSINH) >=15 AND (YEAR(GETDATE()) - YEAR(I.NGAYSINH)) <= 20))
			BEGIN
				RAISERROR(N'Độ tuổi sai quy định',16,1)
				rollback
			end
	end
go

create trigger QD_LOP
ON LOP
for update
as
	begin
		if(exists(select * from inserted I where I.SISO>40))
			begin
				raiserror(N'Sỉ số vượt quá qui định',16,1)
				rollback
			end
	end
go

create trigger QD_KHOI
ON KHOI
for update
as
	begin
		if(exists( Select * from inserted I where I.SOLUONG>3))
			begin
				raiserror(N'Số lượng lớp vượt quá qui định',16,1)
				rollback
			end
	end
go


------------Thay đổi quy định------------------
