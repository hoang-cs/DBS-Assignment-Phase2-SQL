-- Tự động thêm 1 chứng chỉ nếu đánh giá là đạt
USE AIESEC;
GO

CREATE TRIGGER add_danh_gia ON [Đánh giá]
FOR INSERT
AS
BEGIN
	DECLARE @Dat AS BIT;
	DECLARE @Count INT = 0;
	DECLARE @EndTime DATE;
	DECLARE @ID AS INT;

	SELECT @ID = Inserted.[ID_chương trình] FROM Inserted;
	SELECT @EndTime = dbo.[Chương trình].[THời gian kết thúc] FROM dbo.[Chương trình] WHERE dbo.[Chương trình].[ID_chương trình] = @ID;
	SELECT @Dat = Đạt FROM INSERTED;
	SELECT @Count = COUNT(*) FROM dbo.[Chứng chỉ]
	WHERE @ID = dbo.[Chứng chỉ].[ID_chương trình];

	IF @Dat = 1
		INSERT INTO dbo.[Chứng chỉ]
		SELECT [MSSV], [Tên viết tắt của trường], @Count + 1, [ID_chương trình], DATEADD(DAY, 1, @EndTime) FROM INSERTED;
END;
GO

-- Không thể xóa trưởng ban.
CREATE TRIGGER delete_Member ON [Thành viên]
FOR DELETE
AS
BEGIN
	DECLARE @roll NVARCHAR(255) = N'';
	SELECT @roll = DELETED.[Vai trò] FROM DELETED;
	IF @roll = N'Trưởng ban'
		BEGIN
			PRINT N'Không thể xóa trưởng ban';
			ROLLBACK TRANSACTION;
			RETURN;
		END
END;
GO

-- Khi insert 1 record vào quyên tiền, cập nhật tổng số tiền
-- của nhà tài trợ và tổng số tiền hiện có của tổ chức
CREATE TRIGGER add_Donate ON dbo.[Quyên tiền]
FOR INSERT
AS
BEGIN
    DECLARE @IDntt AS INT;
	DECLARE @Money AS INT;
	SELECT @IDntt = Inserted.[ID_nhà tài trợ] FROM Inserted;
	SELECT @Money = Inserted.[Số tiền] FROM Inserted;

	UPDATE dbo.[Nhà tài trợ] 
	SET [Số tiền quyên góp] = [Số tiền quyên góp] + @Money 
	WHERE [ID_nhà tài trợ] = @IDntt;

	UPDATE dbo.[Ban tài chính]
	SET [Tổng số tiền] = [Tổng số tiền] + @Money
	WHERE [ID_phòng ban] = 3;
END;
GO

-- Trừ bớt tiền khi có chương trình mới
CREATE TRIGGER add_Program ON dbo.[Chương trình]
FOR INSERT
AS
BEGIN
	DECLARE @Money INT = 0;
	SELECT @Money = [Số tiền chi] FROM Inserted;
	UPDATE dbo.[Ban tài chính] SET [Tổng số tiền] = [Tổng số tiền] - @Money WHERE [ID_phòng ban] = 3;
END;
GO

-- Khi insert 1 mốc sự kiện, nếu thời gian của sự kiện
-- lớn hơn thời gian kết thúc chương trình, update thời
-- gian kết thúc chương trình = thời gian của sự kiện + 1 ngày
CREATE TRIGGER add_Event ON dbo.[Mốc sự kiện]
FOR INSERT , UPDATE
AS
BEGIN
	DECLARE @EndTime DATE;
	DECLARE @ID INT;
	DECLARE @EventTime DATE;

	SELECT @ID = [Inserted].[ID_chương trình] FROM Inserted;
	SELECT @EndTime = [THời gian kết thúc] FROM dbo.[Chương trình] WHERE [ID_chương trình] = @ID;
	SELECT @EventTime = Inserted.[Thời gian] FROM Inserted;
	
	IF @EventTime > @EndTime
		UPDATE dbo.[Chương trình] SET [THời gian kết thúc] = DATEADD(DAY, 1, @EventTime) 
		WHERE dbo.[Chương trình].[ID_chương trình] = @ID;
END;
GO

-- Cập nhật lại MSSV và tên viết tắt của trưởng trên bảng
-- chứng chỉ nếu có thay đổi trên bảng sinh viên
CREATE TRIGGER update_Student ON dbo.[Sinh viên]
INSTEAD OF UPDATE
AS
BEGIN
	DECLARE @Abbrev NVARCHAR(255);
	DECLARE @MS INT;
	DECLARE @OldAbbrev AS NVARCHAR(255);
	DECLARE @OLDMS AS INT;

	SELECT @OldAbbrev = Deleted.[Tên viết tắt của trường] FROM Deleted;
	SELECT @OLDMS = Deleted.MSSV FROM Deleted;

	SELECT @Abbrev = Inserted.[Tên viết tắt của trường] FROM Inserted;
	SELECT @MS = Inserted.MSSV FROM Inserted;
	IF @Abbrev <> @OldAbbrev OR @MS <> @OLDMS
	BEGIN
	INSERT INTO dbo.[Sinh viên]
	SELECT * FROM Inserted;

    UPDATE dbo.[Chứng chỉ]
	SET dbo.[Chứng chỉ].[Tên viết tắt của trường] = @Abbrev,
	dbo.[Chứng chỉ].MSSV = @MS
	WHERE dbo.[Chứng chỉ].[Tên viết tắt của trường] = @OldAbbrev AND dbo.[Chứng chỉ].MSSV = @OLDMS
	
	UPDATE dbo.[Đánh giá]
	SET MSSV = @MS, [Tên viết tắt của trường] = @Abbrev
	WHERE MSSV = @OLDMS AND [Tên viết tắt của trường] = @OldAbbrev;
	
	DELETE FROM dbo.[Sinh viên] WHERE MSSV = @OLDMS AND [Tên viết tắt của trường] = @OldAbbrev;
	END
	ELSE
	BEGIN
	    DECLARE @Name AS NVARCHAR(255);
		DECLARE @UniName AS NVARCHAR(255);
		DECLARE @DOB AS DATE;
		DECLARE @Major AS NVARCHAR(255);
		DECLARE @SDT AS CHAR(10);

		SELECT @Name = Inserted.[Họ và tên],@UniName = Inserted.[Tên trường], 
		@DOB = Inserted.[Ngày sinh], @Major = Inserted.[Ngành học],  @SDT = Inserted.SĐT 
		FROM Inserted;
		
		UPDATE dbo.[Sinh viên] 
		SET [Họ và tên] = @Name, [Tên trường] = @UniName, [Ngày sinh] = @DOB, [Ngành học] = @Major, SĐT = @SDT
		WHERE MSSV = @OLDMS AND [Tên viết tắt của trường] = @OldAbbrev

	END
END;
GO

-- Xóa sinh viên thì xóa các thông tin về đánh giá và chứng chỉ
CREATE TRIGGER delete_Student ON dbo.[Sinh viên]
INSTEAD OF DELETE
AS
BEGIN
    DECLARE @MSSV INT;

	SELECT @MSSV = Deleted.MSSV FROM Deleted;
	DELETE FROM dbo.[Chứng chỉ] WHERE dbo.[Chứng chỉ].MSSV = @MSSV;
	DELETE FROM dbo.[Đánh giá] WHERE dbo.[Đánh giá].MSSV = @MSSV; 
	DELETE FROM dbo.[Sinh viên] WHERE MSSV = @MSSV AND [Tên viết tắt của trường] = [Tên viết tắt của trường]
END;
GO


-- Xóa chương trình thì kiểm tra ngày xóa với ngày bắt đầu ctrinh
-- Nếu xóa trước khi ctrinh bắt đầu, thì xóa toàn bộ info liên quan, trả lại tiền cho ban tài chính
-- Nếu xóa trong khi dra chương trình, chỉ xóa các chứng chỉ liên quan tới chương trình
-- Không được xóa các chương trình đã diễn ra xong.
CREATE TRIGGER delete_Program ON dbo.[Chương trình]
INSTEAD OF DELETE
AS
BEGIN
    DECLARE @ID_Prog INT;
	DECLARE @StartTime DATE;
	DECLARE @EndTime DATE;
	DECLARE @Money INT;
	DECLARE @Now DATE = GETDATE();

	SELECT @ID_Prog = Deleted.[ID_chương trình] FROM Deleted;
	SELECT @StartTime = Deleted.[Thời gian bắt đầu] FROM Deleted;
	SELECT @EndTime = Deleted.[THời gian kết thúc] FROM Deleted;
	SELECT @Money = Deleted.[Số tiền chi] FROM Deleted;
	IF @Now > @EndTime
	BEGIN
		PRINT N'Không thể xóa chương trình đã diễn ra'
	END
	ELSE 
	BEGIN
		IF @Now < @StartTime
		BEGIN
			DELETE FROM dbo.[Thực tập tại] WHERE dbo.[Thực tập tại].[ID_chương trình] = @ID_Prog;
			DELETE FROM dbo.[Tình nguyện] WHERE dbo.[Tình nguyện].[ID_chương trình] = @ID_Prog;
			DELETE FROM dbo.[Giáo dục] WHERE dbo.[Giáo dục].[ID_chương trình] = @ID_Prog;
			DELETE FROM dbo.[Hỗ trợ truyền thông] WHERE dbo.[Hỗ trợ truyền thông].[ID_chương trình] = @ID_Prog;
			UPDATE dbo.[Ban tài chính] SET [Tổng số tiền] = [Tổng số tiền] + @Money WHERE [ID_phòng ban] = 3;
			DELETE FROM dbo.[Mốc sự kiện] WHERE dbo.[Mốc sự kiện].[ID_chương trình] = @ID_Prog;
		END
		DELETE FROM dbo.[Đánh giá] WHERE dbo.[Đánh giá].[ID_chương trình] = @ID_Prog;
		DELETE FROM dbo.[Chứng chỉ] WHERE dbo.[Chứng chỉ].[ID_chương trình] = @ID_Prog;
		DELETE FROM dbo.[Chương trình] WHERE [ID_chương trình] = @ID_Prog;
		
	END
END;
GO

-- Khi thêm 1 record vào "Cá nhân" -> tự động thêm 1 record vào nhà tài trợ
-- và cập nhật id = count(nhà tài trợ) + 1
CREATE TRIGGER insert_Personal ON dbo.[Cá nhân]
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @CMND INT;
	DECLARE @counter INT;
	SELECT @CMND = Inserted.CMND FROM Inserted;
	SELECT @counter = COUNT(*) FROM dbo.[Nhà tài trợ];
	INSERT dbo.[Nhà tài trợ]
	VALUES
	(   @counter + 1, -- ID_nhà tài trợ - int
	    3, -- ID_phòng ban - int
	    0  -- Số tiền quyên góp - int
	    );
	INSERT INTO dbo.[Cá nhân]
	SELECT @counter + 1, Inserted.CMND, Inserted.[Họ và tên], 
	Inserted.[Xã/phường], Inserted.[Quận/huyện/thị xã], 
	Inserted.[Tỉnh/thành phố], Inserted.[Ngày sinh]
	FROM Inserted;
END;
GO


-- Khi thêm 1 record vào "Công ty" -> tự động thêm 1 record vào nhà tài trợ
-- và cập nhật id = count(nhà tài trợ) + 1
CREATE TRIGGER insert_Company ON dbo.[Công ty]
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @MS INT;
	DECLARE @counter INT;
	SELECT @MS = Inserted.[Mã số kinh doanh] FROM Inserted;
	SELECT @counter = COUNT(*) FROM dbo.[Nhà tài trợ];
	INSERT dbo.[Nhà tài trợ]
	VALUES
	(   @counter + 1, -- ID_nhà tài trợ - int
	    3, -- ID_phòng ban - int
	    0  -- Số tiền quyên góp - int
	    );
	INSERT INTO dbo.[Công ty]
	SELECT (@counter + 1), Inserted.[Tên công ty], 
	Inserted.[Mã số kinh doanh], Inserted.[Tên người đại diện], 
	Inserted.[SĐT người đại diện]
	FROM Inserted; 
END;
GO


-- Nếu xóa 1 record của "giáo dục" thì cập nhật loại chương trình
CREATE TRIGGER changeTypeGD ON dbo.[Giáo dục]
FOR DELETE
AS
BEGIN
    DECLARE @GD NVARCHAR(255) = N'GD';
	DECLARE @ID INT;

	SELECT @ID = Deleted.[ID_chương trình] FROM Deleted;
	UPDATE dbo.[Chương trình] SET [Loại chương trình] = REPLACE([Loại chương trình], @GD, '') 
	WHERE [ID_chương trình] = @ID;
END;
GO

-- Nếu xóa 1 record của "tình nguyện" thì cập nhật loại chương trình
CREATE TRIGGER changeTypeTN ON dbo.[Tình nguyện]
FOR DELETE
AS
BEGIN
	DECLARE @ID INT;

	SELECT @ID = Deleted.[ID_chương trình] FROM Deleted;
	UPDATE dbo.[Chương trình] SET [Loại chương trình] = REPLACE([Loại chương trình], N'TN', N'') 
	WHERE [ID_chương trình] = @ID;
END;
GO

-- Nếu xóa 1 record của "thực tập" thì cập nhật loại chương trình
CREATE TRIGGER changeTypeTT ON dbo.[Thực tập tại]
FOR DELETE
AS
BEGIN
	DECLARE @ID INT;

	SELECT @ID = Deleted.[ID_chương trình] FROM Deleted;
	UPDATE dbo.[Chương trình] SET [Loại chương trình] = REPLACE([Loại chương trình], N'TT', N'') 
	WHERE [ID_chương trình] = @ID;
END;
GO

-------------------BONUS-----------------------
CREATE TRIGGER delete_TV_ACC ON dbo.[Thành viên]
INSTEAD OF DELETE
AS
BEGIN
    DECLARE @ID AS INT;
	DECLARE @Role AS NVARCHAR(255);

	SELECT @ID = Deleted.[ID_thành viên] FROM Deleted;
	SELECT @Role = Deleted.[Vai trò] FROM Deleted;

	IF @Role <> N'Truong ban'
	BEGIN
	    DELETE dbo.[Tài khoản] WHERE [ID_thành viên] = @ID;
		DELETE dbo.[Thành viên] WHERE [ID_thành viên] = @ID;
	END
END