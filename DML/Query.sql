--1. Truy xuất tất cả các cá nhân đã tài trợ với số tiền lớn hơn 3 triệu
USE AIESEC;
GO
Select  [Cá nhân].[ID_nhà tài trợ], [Nhà tài trợ].[Số tiền quyên góp], [Cá nhân].[Họ và tên]
From [Nhà tài trợ], [Cá nhân]
Where [Nhà tài trợ].[ID_nhà tài trợ] = [Cá nhân].[ID_nhà tài trợ] And [Nhà tài trợ].[Số tiền quyên góp] > 3000000
Order by [Cá nhân].[Họ và tên] ASC

--2. Truy xuất tất cả các công ty đã hỗ trợ thực tập trong chương trình 'Thuc tap thu nghiem'

Select [Chương trình].[Tên chương trình], [Công ty].[Tên công ty]
From [Chương trình], [Công ty], [Thực tập tại]
Where [Thực tập tại].[Mã số kinh doanh] = [Công ty].[Mã số kinh doanh] and [Thực tập tại].[ID_chương trình]=[Chương trình].[ID_chương trình] 
and [Chương trình].[Tên chương trình]='Thuc tap thu nghiem'
Order by [Công ty].[Tên công ty] ASC

--3. Truy xuất tất cả thành viên ban quản lý
Select [Thành viên].[ID_thành viên],[Thành viên].[Họ và tên],[Thành viên].[Ngày sinh],[Thành viên].[Vai trò]
From [Thành viên], [Phòng ban]
Where [Thành viên].[ID_phòng ban] = [Phòng ban].[ID_phòng ban] and [Phòng ban].[Loại ban]='Quan ly'
Order by [Thành viên].[Họ và tên] ASC


--4. Truy xuất tất cả mốc sự kiện của chương trình 'Hung bien tieng anh'
Select [Mốc sự kiện].[Công việc],[Mốc sự kiện].[Thời gian]
From [Mốc sự kiện],[Chương trình]
Where [Mốc sự kiện].[ID_chương trình]=[Chương trình].[ID_chương trình] and [Chương trình].[Tên chương trình]='Hung bien tieng anh'
Order by [Mốc sự kiện].[Thời gian] ASC


--5. Truy xuất tất cả sinh viên tham gia chương trình 'Thanh nien can gi'
Select [Sinh viên].MSSV,[Sinh viên].[Họ và tên],[Sinh viên].[Ngày sinh],[Sinh viên].[Tên trường]
From [Sinh viên],[Đánh giá],[Chương trình]
Where [Sinh viên].MSSV=[Đánh giá].MSSV and [Đánh giá].[ID_chương trình] =[Chương trình].[ID_chương trình] and [Chương trình].[Tên chương trình]='Thanh nien can gi'
Order by [Sinh viên].[Họ và tên] ASC

--6. Truy xuất tất cả công ty đã quyên tiền trong năm 2021
Select  [Nhà tài trợ].[ID_nhà tài trợ],[Công ty].[Tên công ty], [Quyên tiền].Ngày
From [Quyên tiền], [Nhà tài trợ], [Công ty]
Where [Công ty].[ID_Nhà tài trợ]=[Nhà tài trợ].[ID_nhà tài trợ] and [Quyên tiền].[ID_nhà tài trợ]=[Nhà tài trợ].[ID_nhà tài trợ] and ([Quyên tiền].Ngày Between '2021/1/1' and '2021/12/31') 
Order by [Công ty].[Tên công ty] ASC

--7. Truy xuất tất cả thành viên ban sự kiện trên 21 tuổi
Select [Thành viên].[ID_thành viên],[Thành viên].[Họ và tên],[Thành viên].[Vai trò], DATEDIFF(Year,[Thành viên].[Ngày sinh],GETDATE()) as 'Tuổi'
From [Thành viên], [Phòng ban]
Where [Thành viên].[ID_phòng ban] = [Phòng ban].[ID_phòng ban] and [Phòng ban].[Loại ban]='Su kien' and DATEDIFF(Year,[Thành viên].[Ngày sinh],GETDATE())>21
Order by [Thành viên].[Họ và tên] ASC


--8. Truy xuất tất cả sinh viên có chứng chỉ năm 2021
Select [Sinh viên].MSSV,[Sinh viên].[Họ và tên], [Chứng chỉ].[Mã chứng chỉ], [Chứng chỉ].[Ngày cấp]
From [Sinh viên], [Chứng chỉ]
Where [Sinh viên].MSSV=[Chứng chỉ].MSSV and [Chứng chỉ].[Ngày cấp] Between '2021/1/1' and '2021/12/31'
Order by [Sinh viên].[Họ và tên] ASC


--9. Truy xuất tất cả sinh viên nhỏ tuổi nhất có chứng chỉ chương trình 'Giao duc vung cao' 

Select [Họ và tên],[Sinh viên].[Tên viết tắt của trường], [Sinh viên].MSSV, DATEDIFF(Year, [Sinh viên].[Ngày sinh],GETDATE()) AS "Tuổi"
From [Sinh viên], [Chứng chỉ], [Chương trình]
Where [Sinh viên].MSSV = [Chứng chỉ].MSSV and [Chứng chỉ].[ID_chương trình] = [Chương trình].[ID_chương trình] and [Chương trình].[Tên chương trình]='Giao duc vung cao'
Group by [Sinh viên].[Tên viết tắt của trường], [Sinh viên].MSSV, [Sinh viên].[Họ và tên], [Sinh viên].[Ngày sinh]
Having DATEDIFF(Year, [Sinh viên].[Ngày sinh],GETDATE())=MIN(DATEDIFF(YEAR,[Sinh viên].[Ngày sinh],GETDATE()))
Order by [Sinh viên].[Tên viết tắt của trường] ASC


--10. Truy xuất tất cả thành viên lớn tuổi nhất các phòng ban và nhóm theo ban
SELECT [Thành viên].[Họ và tên], [Thành viên].[ID_thành viên], [Phòng ban].[Loại ban], DATEDIFF(YEAR,[Thành viên].[Ngày sinh],GETDATE()) AS "Tuổi"
From [Thành viên], [Phòng ban]
Where dbo.[Thành viên].[ID_phòng ban] = dbo.[Phòng ban].[ID_phòng ban]
Group by [Thành viên].[Họ và tên], [Thành viên].[ID_thành viên], [Phòng ban].[Loại ban], [Thành viên].[Ngày sinh]
Having DATEDIFF(YEAR,[Thành viên].[Ngày sinh],GETDATE()) = (SELECT MAX(DATEDIFF(YEAR,[Thành viên].[Ngày sinh],GETDATE())) FROM dbo.[Thành viên])
Order by [Phòng ban].[Loại ban] ASC

--11. Truy xuất tất cả cá nhân tài trợ nhiều hơn mức trung bình các cá nhân tài trợ
Select [Cá nhân].[Họ và tên], [Nhà tài trợ].[Số tiền quyên góp]
From [Cá nhân],[Nhà tài trợ]
Where [Cá nhân].[ID_nhà tài trợ]=[Nhà tài trợ].[ID_nhà tài trợ]
Group by [Cá nhân].[Họ và tên], [Nhà tài trợ].[Số tiền quyên góp]
Having [Nhà tài trợ].[Số tiền quyên góp] > (Select AVG([Nhà tài trợ].[Số tiền quyên góp])
											From [Nhà tài trợ],[Cá nhân]
											Where [Nhà tài trợ].[ID_nhà tài trợ]=[Cá nhân].[ID_nhà tài trợ])
Order by [Cá nhân].[Họ và tên] ASC

--12. Truy xuất tất cả công ty tài trợ nhiều hơn tổng số tiền các cá nhân tài trợ
Select [Công ty].[Tên công ty],[Nhà tài trợ].[Số tiền quyên góp]
From [Công ty], [Nhà tài trợ]
Where [Công ty].[ID_Nhà tài trợ]=[Nhà tài trợ].[ID_nhà tài trợ]
Group by [Công ty].[Tên công ty], [Nhà tài trợ].[Số tiền quyên góp]
Having [Nhà tài trợ].[Số tiền quyên góp] > (Select SUM([Nhà tài trợ].[Số tiền quyên góp])
											From [Nhà tài trợ],[Cá nhân]
											Where [Nhà tài trợ].[ID_nhà tài trợ]=[Cá nhân].[ID_nhà tài trợ])
Order by [Công ty].[Tên công ty] ASC

--13. Truy xuất tất cả thành viên ban sự kiện lớn tuổi hơn độ tuổi trung bình các thành viên tất cả các ban
Select [Thành viên].[Họ và tên], [Thành viên].[Vai trò], DATEDIFF(YEAR,[Thành viên].[Ngày sinh],GETDATE()) AS 'Tuổi'
From [Thành viên], [Phòng ban], [Ban sự kiện]
Where [Thành viên].[ID_phòng ban] = [Phòng ban].[ID_phòng ban] and [Phòng ban].[Loại ban] = 'Su kien'
Group by [Thành viên].[Họ và tên], [Thành viên].[Vai trò], [Thành viên].[Ngày sinh] 
Having DATEDIFF(YEAR,[Thành viên].[Ngày sinh],GETDATE()) > (Select AVG(DATEDIFF(YEAR,[Thành viên].[Ngày sinh],GETDATE()))
															From [Thành viên], [Phòng ban], [Ban sự kiện]
															Where [Thành viên].[ID_phòng ban] = [Phòng ban].[ID_phòng ban])
Order by [Thành viên].[Họ và tên] ASC


--14. Truy xuất tất cả chương trình có ít hơn 3 mốc sự kiện
Select [Chương trình].[Tên chương trình], Count([Mốc sự kiện].[Công việc]) as 'Số sự kiện' 
From [Chương trình], [Mốc sự kiện]
Where [Mốc sự kiện].[ID_chương trình] = [Chương trình].[ID_chương trình]
Group by [Chương trình].[Tên chương trình]
Having Count([Mốc sự kiện].[Công việc]) < 3
Order by [Chương trình].[Tên chương trình] ASC



--15. Truy xuất các cá nhân tài trợ nhiều hơn 1 lần
Select [Cá nhân].[Họ và tên],COUNT([Cá nhân].[Họ và tên]) as 'Số lần tài trợ'
From [Cá nhân], [Nhà tài trợ], [Quyên tiền]
Where [Cá nhân].[ID_nhà tài trợ]=[Nhà tài trợ].[ID_nhà tài trợ] and [Quyên tiền].[ID_nhà tài trợ]=[Nhà tài trợ].[ID_nhà tài trợ]
Group by [Cá nhân].[Họ và tên]
Having COUNT([Cá nhân].[Họ và tên])>1
Order by [Cá nhân].[Họ và tên] ASC



--16. Truy xuất các sinh viên có nhiều chứng chỉ hơn số chứng chỉ trung bình
Select [Sinh viên].[Họ và tên], [Sinh viên].MSSV, Count([Chứng chỉ].[Mã chứng chỉ]) as 'Số chứng chỉ'
From [Sinh viên], [Chứng chỉ]
Where [Sinh viên].MSSV=[Chứng chỉ].MSSV
Group by [Sinh viên].[Họ và tên], [Sinh viên].MSSV
Having Count([Chứng chỉ].[Mã chứng chỉ]) >  (Select AVG(T.[Số chứng chỉ]) 
											 From (Select Count([Chứng chỉ].[Mã chứng chỉ]) as [Số chứng chỉ]
												   From [Sinh viên], [Chứng chỉ]
												   Where [Sinh viên].MSSV=[Chứng chỉ].MSSV
												   Group by [Sinh viên].[Họ và tên], [Sinh viên].MSSV) as T
											 )
Order by [Sinh viên].[Họ và tên] ASC
