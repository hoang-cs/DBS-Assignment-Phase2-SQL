CREATE DATABASE AIESEC;
GO
USE AIESEC;
GO

CREATE TABLE [Thành viên] (
  [ID_thành viên] int PRIMARY KEY IDENTITY(170,1),
  [Họ và tên] nvarchar(255) NOT NULL,
  [SĐT] CHAR(10),
  [Ngày sinh] DATE NOT NULL,
  [ID_phòng ban] INT NOT NULL,
  [Vai trò] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [Phòng ban] (
  [ID_phòng ban] int PRIMARY KEY,
  [Ngày thành lập] DATE NOT NULL,
  [Loại ban] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [Ban quản lý] (
  [ID_phòng ban] int PRIMARY KEY
)
GO

CREATE TABLE [Ban sự kiện] (
  [ID_phòng ban] int PRIMARY KEY
)
GO

CREATE TABLE [Ban tài chính] (
  [ID_phòng ban] int PRIMARY KEY,
  [Tổng số tiền] INT NOT NULL DEFAULT 0
)
GO 

CREATE TABLE [Sinh viên] (
  [MSSV] INT NOT NULL,
  [Tên viết tắt của trường] nvarchar(255) NOT NULL,
  [Tên trường] nvarchar(255) NOT NULL,
  [Họ và tên] nvarchar(255) NOT NULL,
  [Ngày sinh] DATE NOT NULL,
  [Ngành học] nvarchar(255) NOT NULL,
  [SĐT] CHAR(10),
  PRIMARY KEY ([MSSV], [Tên viết tắt của trường])
)
GO

CREATE TABLE [Chương trình] (
  [ID_chương trình] int PRIMARY KEY IDENTITY(17,1),
  [Tên chương trình] nvarchar(255) NOT NULL,
  [Loại chương trình] nvarchar(255) NOT NULL,
  [Tọa độ] nvarchar(255) NOT NULL,
  [Tên quốc gia] nvarchar(255) NOT NULL,
  [Thời gian bắt đầu] DATE NOT NULL,
  [THời gian kết thúc] DATE NOT NULL,
  [Số tiền chi] INT NOT NULL
)
GO

CREATE TABLE [Tình nguyện] (
  [ID_chương trình] int PRIMARY KEY,
  [Công việc] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [Giáo dục] (
  [ID_chương trình] int PRIMARY KEY,
  [Độ tuổi đối tượng] INT NOT NULL,
  [Nội dung] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [Nhà tài trợ] (
  [ID_nhà tài trợ] int PRIMARY KEY,
  [ID_phòng ban] INT NOT NULL,
  [Số tiền quyên góp] int
)
GO

CREATE TABLE [Cá nhân] (
  [ID_nhà tài trợ] INT,
  [CMND] int PRIMARY KEY,
  [Họ và tên] nvarchar(255) NOT NULL,
  [Xã/phường] nvarchar(255) NOT NULL,
  [Quận/huyện/thị xã] nvarchar(255) NOT NULL,
  [Tỉnh/thành phố] nvarchar(255) NOT NULL,
  [Ngày sinh] DATE
)
GO

CREATE TABLE [Công ty] (
  [ID_Nhà tài trợ] INT NOT NULL,
  [Tên công ty] nvarchar(255) NOT NULL UNIQUE,
  [Mã số kinh doanh] int PRIMARY KEY,
  [Tên người đại diện] nvarchar(255) NOT NULL,
  [SĐT người đại diện] CHAR(10) NOT NULL
)
GO

CREATE TABLE [Chứng chỉ] (
  [MSSV] INT NOT NULL,
  [Tên viết tắt của trường] nvarchar(255) NOT NULL,
  [Mã chứng chỉ] INT NOT NULL,
  [ID_chương trình] INT NOT NULL,
  [Ngày cấp] DATE NOT NULL,
  PRIMARY KEY ([Mã chứng chỉ], [ID_chương trình])
)
GO

CREATE TABLE [Đánh giá] (
  [MSSV] INT NOT NULL,
  [Tên viết tắt của trường] nvarchar(255) NOT NULL,
  [ID_chương trình] INT NOT NULL,
  [ID_phòng ban] INT NOT NULL,
  [Đạt] BIT NOT NULL,
  PRIMARY KEY ([MSSV], [Tên viết tắt của trường], [ID_chương trình])
)

GO

CREATE TABLE [Mốc sự kiện] (
  [ID_phòng ban] INT NOT NULL,
  [ID_chương trình] INT NOT NULL,
  [Công việc] nvarchar(255) NOT NULL,
  [Thời gian] DATE NOT NULL,
  PRIMARY KEY ([ID_phòng ban], [ID_chương trình], [Công việc], [Thời gian])
)
GO

CREATE TABLE [Quyên tiền] (
  [ID_nhà tài trợ] INT NOT NULL,
  [ID_phòng ban] INT NOT NULL,
  [Số tiền] INT NOT NULL,
  [Ngày] DATETIME NOT NULL,
  PRIMARY KEY ([ID_nhà tài trợ], [Số tiền], [Ngày])
)
GO

CREATE TABLE [Hỗ trợ truyền thông] (
  [ID_chương trình] INT NOT NULL,
  [ID_nhà tài trợ] INT NOT NULL,
  PRIMARY KEY ([ID_chương trình], [ID_nhà tài trợ])
)
GO

CREATE TABLE [Thực tập tại] (
  [ID_chương trình] int PRIMARY KEY,
  [Mã số kinh doanh] INT NOT NULL
)
GO

-- for login and sing in --
CREATE TABLE [Tài khoản](
	[ID_thành viên] INT PRIMARY KEY,
	[Tên đăng nhập] NVARCHAR(255),
	[Mật khẩu] NVARCHAR(255)
);


ALTER TABLE [dbo].[Tài khoản] ADD FOREIGN KEY ([ID_thành viên]) REFERENCES dbo.[Thành viên] ([ID_thành viên]);
