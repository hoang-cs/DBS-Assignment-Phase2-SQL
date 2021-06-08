USE AIESEC;
GO

ALTER TABLE [Thành viên] ADD FOREIGN KEY ([ID_phòng ban]) REFERENCES [Phòng ban] ([ID_phòng ban])
GO

ALTER TABLE [Ban quản lý] ADD FOREIGN KEY ([ID_phòng ban]) REFERENCES [Phòng ban] ([ID_phòng ban])
GO

ALTER TABLE [Ban sự kiện] ADD FOREIGN KEY ([ID_phòng ban]) REFERENCES [Phòng ban] ([ID_phòng ban])
GO

ALTER TABLE [Ban tài chính] ADD FOREIGN KEY ([ID_phòng ban]) REFERENCES [Phòng ban] ([ID_phòng ban])
GO

ALTER TABLE [Tình nguyện] ADD FOREIGN KEY ([ID_chương trình]) REFERENCES [Chương trình]  ([ID_chương trình])
GO

ALTER TABLE [Giáo dục] ADD FOREIGN KEY ([ID_chương trình]) REFERENCES [Chương trình] ([ID_chương trình])
GO

ALTER TABLE [Cá nhân] ADD FOREIGN KEY ([ID_nhà tài trợ]) REFERENCES [Nhà tài trợ] ([ID_nhà tài trợ])
GO

ALTER TABLE [Công ty] ADD FOREIGN KEY ([ID_Nhà tài trợ]) REFERENCES [Nhà tài trợ] ([ID_nhà tài trợ])
GO

ALTER TABLE [Chứng chỉ] ADD FOREIGN KEY ([ID_chương trình]) REFERENCES [Chương trình] ([ID_chương trình])
GO

ALTER TABLE [Chứng chỉ] ADD FOREIGN KEY ([MSSV],[Tên viết tắt của trường]) REFERENCES [Sinh viên] ([MSSV],[Tên viết tắt của trường])
GO


ALTER TABLE [Đánh giá] ADD FOREIGN KEY ([MSSV],[Tên viết tắt của trường]) REFERENCES [Sinh viên] ([MSSV],[Tên viết tắt của trường])
GO

ALTER TABLE [Đánh giá] ADD FOREIGN KEY ([ID_chương trình]) REFERENCES [Chương trình] ([ID_chương trình])
GO

ALTER TABLE [Đánh giá] ADD FOREIGN KEY ([ID_phòng ban]) REFERENCES [Ban quản lý] ([ID_phòng ban])
GO

ALTER TABLE [Mốc sự kiện] ADD FOREIGN KEY ([ID_phòng ban]) REFERENCES [Ban sự kiện] ([ID_phòng ban])
GO

ALTER TABLE [Mốc sự kiện] ADD FOREIGN KEY ([ID_chương trình]) REFERENCES [Chương trình] ([ID_chương trình])
GO

ALTER TABLE [Quyên tiền] ADD FOREIGN KEY ([ID_nhà tài trợ]) REFERENCES [Nhà tài trợ] ([ID_nhà tài trợ])
GO

ALTER TABLE [Quyên tiền] ADD FOREIGN KEY ([ID_phòng ban]) REFERENCES [Ban tài chính] ([ID_phòng ban])
GO

ALTER TABLE [Hỗ trợ truyền thông] ADD FOREIGN KEY ([ID_nhà tài trợ]) REFERENCES [Nhà tài trợ] ([ID_nhà tài trợ])
GO

ALTER TABLE [Hỗ trợ truyền thông] ADD FOREIGN KEY ([ID_chương trình]) REFERENCES [Chương trình] ([ID_chương trình])
GO

ALTER TABLE [Thực tập tại] ADD FOREIGN KEY ([ID_chương trình]) REFERENCES [Chương trình] ([ID_chương trình])
GO

ALTER TABLE [Thực tập tại] ADD FOREIGN KEY ([Mã số kinh doanh]) REFERENCES [Công ty] ([Mã số kinh doanh])
GO


CREATE INDEX idsv ON [Sinh viên] ([MSSV],[Tên viết tắt của trường])

CREATE INDEX iddg ON [Đánh giá] ([MSSV],[ID_chương trình])

CREATE INDEX idsk ON [Mốc sự kiện] ([Công việc], [Thời gian], [ID_chương trình])

CREATE INDEX idcom ON [Công ty] ([Mã số kinh doanh])

CREATE INDEX iddn ON [Quyên tiền]([ID_nhà tài trợ],[Ngày])
