USE AIESEC;
GO

-- Hiển thị các mốc sự kiện của chương trình với input idchtr
CREATE PROCEDURE show_event @idchtr INT
AS
	IF EXISTS (SELECT * FROM [Mốc sự kiện] WHERE [ID_chương trình] = @idchtr)
		SELECT [Công việc], [Thời gian]
		FROM [Mốc sự kiện]
		WHERE [ID_chương trình] = @idchtr
	ELSE raiserror('It is not a valid id',1,1)
GO
--EXEC show_event 17;
--GO

--------------------------NAY LA BONUS, LAM DU------------------------------------
-- Hiển thị danh sách chương trình theo desc order								--
--CREATE PROCEDURE show_chtr @loai nvarchar(30)									--
--AS																			--
--	IF EXISTS (SELECT * FROM [Chương trình] WHERE [Loại chương trình] = @loai)	--
--		SELECT * FROM [Chương trình]											--
--		WHERE [Loại chương trình] = @loai										--
--		ORDER BY [ID_chương trình] DESC											--
--	ELSE raiserror('Khong ton tai loai chuong trinh nay',1,1)					--
--GO																			--
--EXEC show_chtr 'GD';															--
--GO																			--
--------------------------NAY LA BONUS, LAM DU------------------------------------

-- Hiển thị các chứng chỉ của một sinh viên nào đó với mssv là input
CREATE PROCEDURE show_chungchi @mssv INT
AS
	IF EXISTS (SELECT * FROM [Chứng chỉ] WHERE MSSV = @mssv)
		SELECT * FROM [Chứng chỉ]
		WHERE MSSV = @mssv
	ELSE raiserror('Sinh vien nay chua co chung chi nao',1,1)
GO
--EXEC show_chungchi 1911881;
--GO

-- Hiển thị các thành viên với input mã phòng ban
CREATE PROCEDURE show_thanhvien @maphongban INT
AS
	IF EXISTS (SELECT * FROM [Thành viên] WHERE [ID_phòng ban] = @maphongban)
		SELECT * FROM [Thành viên] WHERE [ID_phòng ban] = @maphongban
	ELSE raiserror('Khong ton tai phong ban nay',1,1)
GO
--EXEC show_thanhvien '3'
--GO

-- Hiển thị danh sách nhà tài trợ có thời gian đóng góp trong khoảng input
CREATE PROCEDURE show_ntt @low datetime, @high datetime
AS
	IF EXISTS (SELECT * FROM [Quyên tiền] WHERE Ngày >= @low AND Ngày <= @high)
		IF EXISTS (SELECT * FROM [Cá nhân] WHERE EXISTS (SELECT [ID_nhà tài trợ] FROM [Quyên tiền] WHERE Ngày >= @low AND Ngày <= @high))
			SELECT DISTINCT [Cá nhân].[ID_nhà tài trợ], [Họ và tên], Ngày FROM [Cá nhân], [Quyên tiền]
			WHERE [Cá nhân].[ID_nhà tài trợ] = [Quyên tiền].[ID_nhà tài trợ] AND Ngày >= @low AND Ngày <= @high
		IF EXISTS (SELECT * FROM [Công ty] WHERE EXISTS (SELECT [ID_nhà tài trợ] FROM [Quyên tiền] WHERE Ngày >= @low AND Ngày <= @high))
			SELECT DISTINCT [Công ty].[ID_Nhà tài trợ], [Công ty].[Tên công ty], [Công ty].[Tên người đại diện], Ngày FROM [Công ty], [Quyên tiền]
			WHERE [Công ty].[ID_nhà tài trợ] = [Quyên tiền].[ID_nhà tài trợ] AND Ngày >= @low AND Ngày <= @high
	ELSE raiserror('Khong co nha tai tro nao quyen tien trong khoang thoi gian nay',1,1)
GO
--EXEC show_ntt '2019/1/1', '2020/5/30'
--GO

-- update thời gian bắt đầu, kết thúc của chương trình
CREATE PROCEDURE changetime @idchtr INT, @starttime date, @endtime date
AS
	IF EXISTS (SELECT * FROM [Chương trình] WHERE [ID_chương trình] = @idchtr)
		UPDATE [Chương trình]
		SET [Thời gian bắt đầu] = @starttime, [THời gian kết thúc] = @endtime
		WHERE [ID_chương trình] = @idchtr
	ELSE raiserror('Khong ton tai chuong trinh nay',1,1)
GO
--EXEC changetime '12', '2018/6/1', '2018/6/30'
--GO

-- Update số điện thoại cho sinh viên
CREATE PROCEDURE changesdt @mssv INT, @tenviettattruong nvarchar(255), @sdt char(10)
AS
	IF EXISTS (SELECT * FROM [Sinh viên] WHERE MSSV = @mssv AND [Tên viết tắt của trường] = @tenviettattruong)
		UPDATE [Sinh viên]
		SET SĐT = @sdt
		WHERE MSSV = @mssv AND [Tên viết tắt của trường] = @tenviettattruong
	ELSE raiserror('Sinh vien nay khong ton tai',1,1)
GO
--EXEC changesdt '1911881', 'HCMUS', '0123456789'
--GO

-- Update thông tin người đại diện của công ty (tên, sđt)
CREATE PROCEDURE changinfo @mskinhdoanh INT, @ten nvarchar(255), @sdt char(10)
AS
	IF EXISTS (SELECT * FROM [Công ty] WHERE [Mã số kinh doanh] = @mskinhdoanh)
		UPDATE [Công ty]
		SET [Tên người đại diện] = @ten, [SĐT người đại diện] = @sdt
		WHERE [Mã số kinh doanh] = @mskinhdoanh
	ELSE raiserror('Khong ton tai cong ty nay',1,1)
GO
--EXEC changinfo '54334', 'Nguyen Quang Hieu', '0667123390'
--GO

-- thay đổi thông tin thành viên với input id thành viên
CREATE PROCEDURE change_thanhvien @idtvien INT, @idpban INT
AS
	IF EXISTS (SELECT * FROM [Thành viên] WHERE [ID_thành viên] = @idtvien)
		UPDATE [Thành viên]
		SET [ID_phòng ban] = @idpban
		WHERE [ID_thành viên] = @idtvien
	ELSE raiserror('Khong ton tai thanh vien nay',1,1)
GO
--EXEC change_thanhvien '170', '1'
--GO

-- Count tổng số chứng chỉ chương trình cấp với input idchtr
CREATE FUNCTION sum_chungchi (@idchtr INT)
RETURNS INT
AS
BEGIN
	DECLARE @sochungchi INT = 0
	IF EXISTS (SELECT * FROM [Chứng chỉ] WHERE [ID_chương trình] = @idchtr)
	BEGIN
		DECLARE sochungchicursor CURSOR FOR SELECT [ID_chương trình] FROM [Chứng chỉ]
		OPEN sochungchicursor

		DECLARE @id INT
		FETCH NEXT FROM sochungchicursor INTO @id
		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF (@id = @idchtr)
			BEGIN
				SET @sochungchi = @sochungchi + 1
			END
			FETCH NEXT FROM sochungchicursor INTO @id
		END
		CLOSE sochungchicursor
		DEALLOCATE sochungchicursor
		RETURN @sochungchi
	END
	RETURN cast('Chuong trinh nay khong ton tai' as INT)
END;
GO
--SELECT dbo.sum_chungchi(19) tong_so_chung_chi
--GO

-- Tính tổng số chứng chỉ sinh viên nhận được, input là mssv
CREATE FUNCTION sochungchi_svnhan (@mssv INT)
RETURNS INT
AS
BEGIN
	DECLARE @result INT = 0
	IF EXISTS (SELECT * FROM [Sinh viên] WHERE MSSV = @mssv)
	BEGIN
		DECLARE @count INT
		DECLARE @i INT = 0
		IF NOT EXISTS (SELECT * FROM [Chứng chỉ] WHERE MSSV = @mssv)
		BEGIN
			RETURN @result
		END
		ELSE
		BEGIN
			DECLARE sochungchisvnhan CURSOR FOR SELECT MSSV FROM [Chứng chỉ]
			OPEN sochungchisvnhan

			DECLARE @ms INT
			FETCH NEXT FROM sochungchisvnhan INTO @ms
			WHILE @@FETCH_STATUS = 0
			BEGIN
				IF (@ms = @mssv)
				BEGIN
					SET @result = @result + 1;
				END
				FETCH NEXT FROM sochungchisvnhan INTO @ms
			END
			CLOSE sochungchisvnhan
			DEALLOCATE sochungchisvnhan
			RETURN @result
		END
	END
	RETURN cast('Khong ton tai sinh vien nay' as INT)
END
GO
--SELECT dbo.sochungchi_svnhan(1911881) ket_qua
--GO

-- xem có bao nhiêu thành viên của phòng ban, input là id phòng ban
CREATE FUNCTION so_thanhvien (@idphongban INT, @tuoi INT)
RETURNS INT
AS
BEGIN
	IF EXISTS (SELECT * FROM [Thành viên] WHERE [ID_phòng ban] = @idphongban)
	BEGIN
		DECLARE @result INT = 0
		DECLARE tongtvcursor CURSOR FOR SELECT [ID_phòng ban], [Ngày sinh] FROM [Thành viên]
		OPEN tongtvcursor

		DECLARE @id INT
		DECLARE @ngaysinh date
		FETCH NEXT FROM tongtvcursor INTO @id, @ngaysinh
		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF (@id = @idphongban AND (YEAR(GETDATE()) - YEAR(@ngaysinh)) >= @tuoi)
			BEGIN
				SET @result = @result + 1;
			END
			FETCH NEXT FROM tongtvcursor INTO @id, @ngaysinh
		END
		CLOSE tongtvcursor
		DEALLOCATE tongtvcursor
		RETURN @result
	END
	RETURN cast('Khong ton tai phong ban nay' as INT)
END
GO
--SELECT dbo.so_thanhvien(1, 20) ket_qua
--GO

-- tính tổng số tiền mà nhà tài trợ đã tài trợ trong một năm, input năm
CREATE FUNCTION tong_sotientt (@nam INT)
RETURNS INT
AS
BEGIN
	IF (@nam > 0)
	BEGIN
		DECLARE @result INT = 0
		DECLARE tienttcursor CURSOR FOR SELECT YEAR(Ngày), [Số tiền] FROM [Quyên tiền]
		OPEN tienttcursor

		DECLARE @n INT -- năm mà nhà tài trợ tài trợ
		DECLARE @sotien INT
		FETCH NEXT FROM tienttcursor INTO @n, @sotien
		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF (@n = @nam)
			BEGIN
				SET @result = @result + @sotien
			END
			FETCH NEXT FROM tienttcursor INTO @n, @sotien
		END
		CLOSE tienttcursor
		DEALLOCATE tienttcursor
		RETURN @result
	END
	RETURN cast('Nam khong hop le' as INT)
END
GO
--SELECT dbo.tong_sotientt(2019) ket_qua
--GO
