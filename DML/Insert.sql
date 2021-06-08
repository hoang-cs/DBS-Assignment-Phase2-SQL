USE AIESEC;
GO

INSERT INTO dbo.[Phòng ban]
  VALUES
        (1,'2018/03/05',N'Quan ly'),
        (2, '2018/4/3', N'Su Kien'),
        (3, '2018/3/31', N'Tai Chinh');
GO


INSERT INTO [Ban Quản lý]
  VALUES(1);
GO

INSERT INTO [Ban Sự kiện]
  VALUES (2);
GO
        
INSERT INTO [Ban tài chính]
   VALUES(3, 0);
GO

INSERT INTO dbo.[Thành viên] VALUES (N'Nguyen Thanh Hao','0919813176','20010608',1,N'Trưởng ban');
INSERT INTO dbo.[Thành viên] VALUES (N'Ly','0112346543','19990608',1,N'Thanh vien');
INSERT INTO dbo.[Thành viên] VALUES (N'Ly An','0112346543','19990608',1,N'Thanh vien');
INSERT INTO dbo.[Thành viên] VALUES (N'Hoang Minh','0213548462' ,'19990608',1,N'Thanh vien');
INSERT INTO dbo.[Thành viên] VALUES (N'Xuan Hung', '2135465432','19990608',1,N'Thanh vien');
INSERT INTO dbo.[Thành viên] VALUES (N'Minh Anh', '4513213548','19990608',1,N'Thanh vien');
INSERT INTO dbo.[Thành viên] VALUES (N'Thanh Ha', '2454513212','19990608',2,N'Trưởng ban');
INSERT INTO dbo.[Thành viên] VALUES (N'Thanh Thao', '132545866','19990608',2,N'Thanh vien');
INSERT INTO dbo.[Thành viên] VALUES (N'Quoc Kien', '457846533','19990608',2,N'Thanh vien');
INSERT INTO dbo.[Thành viên] VALUES (N'My Linh', '144657653','19990608',2,N'Thanh vien');
INSERT INTO dbo.[Thành viên] VALUES (N'Long Quyen', '5651321552','19990608',3,N'Trưởng ban');
INSERT INTO dbo.[Thành viên] VALUES (N'Thu Thuy', '4687613245','19990608',3,N'Thanh vien');
INSERT INTO dbo.[Thành viên] VALUES (N'Truc Mai', '4587984324','19990608',3,N'Thanh vien');
INSERT INTO dbo.[Thành viên] VALUES (N'Kim Linh', '1326856512','19990608',3,N'Thanh vien');
INSERT INTO dbo.[Thành viên] VALUES (N'Tan Tai', '3545121322','19990608',3,N'Thanh vien');

GO

DELETE FROM [Thành viên] WHERE [ID_thành viên] = '171'
GO


INSERT INTO [Sinh viên]VALUES (1911881,N'HCMUT',N'Bach Khoa', N'Vo Hong Phuc', '2001/9/19', N'CS', '6065453213');
INSERT INTO [Sinh viên] VALUES (3213542,N'HCMUT',N'Bach Khoa', N'Hoang Minh Tien', '2001/12/3', N'CE', '234513354');
INSERT INTO [Sinh viên] VALUES (19425845, N'HCMUS', N'KHTN', N'Nguyen Canh Long', '2000/2/28', N'IT', '21354321');
INSERT INTO [Sinh viên] VALUES (17676565,N'HCMIU', N'Quoc Te', N'Hoang Van Bac', '1998/12/6', N'IR', '21354651');
INSERT INTO [Sinh viên] VALUES (2012485,N'HCMUT', N'Bach Khoa', N'Nguyen Viet Doan', '2002/2/6', N'MO', '132465321');
INSERT INTO [Sinh viên] VALUES (2102231,N'HCMUT',N'Bach Khoa', N'Luong Xuan Hien', '2001/5/9', N'LG', '33431355');
INSERT INTO [Sinh viên] VALUES (3564322,N'USSH', N'Nhan Van', N'Le Mai Thanh', '1998/6/3', N'UI','356856336');
INSERT INTO [Sinh viên] VALUES (5686525,N'VLU', N'Van Lang', N'Hoang Quoc Tuan', '2002/5/3', N'MD', '54653233');
GO
 
INSERT INTO [Cá nhân] VALUES (-1, 324564732, N'Nguyen Hoai Lam', N'phuong 4', N'thi xa Go Cong', N'Tien Giang', '1988/04/23');
INSERT INTO [Cá nhân] VALUES (-1, 453244676, N'My Tam', N'phuong Tan Tao', N'Quan 7', N'TPHCM', '1984/06/12');
INSERT INTO [Cá nhân] VALUES (-1, 332544658, N'Ha Anh Tuan', N'phuong 6', N'Quan 10', N'TPHCM', '1990/09/30');
INSERT INTO [Cá nhân] VALUES (-1, 322675685, N'Pham Hung', N'phuong 4', N'Quan 2', N'TPHCM', '1980/02/22');
INSERT INTO [Cá nhân] VALUES (-1, 543345321, N'Nguyen Gia Long', N'xa Lap Vo', N'thi xa Sa Det', N'Vinh Long', '1979/05/18');

GO

INSERT INTO [Công ty] VALUES (-1, N'Sen Vang', 25332, N'Pham Van Toan', 0123455678);
INSERT INTO [Công ty] VALUES (-1, N'Vinamilk', 43234, N'Ly Binh', 0334321115);
INSERT INTO [Công ty] VALUES (-1, N'Vin Group', 12664, N'Pham Nhat Vuong', 0453223677);
INSERT INTO [Công ty] VALUES (-1, N'Ton Hoa Sen', 44390, N'Le Phuoc Vu', 0888332333);
INSERT INTO [Công ty] VALUES (-1, N'Daikin', 54334, N'Nguyen Tung Hieu', 0677554321);

GO

INSERT INTO [Chương trình] VALUES (N'Xay que huong', N'TN',N'Bac Giang', N'VietNam', '2018/6/1', '2018/6/30',3000000);
INSERT INTO [Chương trình] VALUES (N'Thuc tap thu nghiem', N'TT', N'HCM', N'VietNam', '2019/3/15', '2019/6/15', 20000000);
INSERT INTO [Chương trình] VALUES (N'Giao duc vung cao', N'TN & GD',N'Lai Chau', N'VietNam', '2018/1/1', '2018/12/5', 6000000);
INSERT INTO [Chương trình] VALUES (N'Thanh nien can gi', N'GD', N'HCM', N'VietNam', '2019/5/15', '2019/6/5', 4500000);
INSERT INTO [Chương trình] VALUES (N'Khai sang uoc mo', N'TN', N'Gia Lai', N'VietNam', '2019/12/7', '2020/1/1', 6000000);
INSERT INTO [Chương trình] VALUES (N'Sinh vien trai nghiem', N'TT', N'Singapore', N'Singapore', '2020/6/1', '2020/8/1', 5000000);
INSERT INTO [Chương trình] VALUES (N'Hoi nhap cho nguoi tre', N'GD', N'HCM', N'VietNam', '2021/2/5', '2021/3/5', 1000000);
INSERT INTO [Chương trình] VALUES (N'Vung cao bien gioi', N'TN', N'Lang Son', N'VietNam', '2021/6/15', '2021/7/8', 5000000);
INSERT INTO [Chương trình] VALUES (N'Hung bien tieng anh', N'GD', N'HCM', N'VietNam', '2021/11/3', '2021/12/5', 2000000);
GO

INSERT INTO [Tình nguyện]
VALUES 	(17, N'Son sua truong hoc'),
		(19, N'Day tieng anh cho tre em'),
		(21, N'Trao hoc bong cho hoc sinh gioi'),
		(24, N'Xay cong vien tai che cho thon');	
GO

INSERT INTO [Giáo dục]
VALUES	(19, 15, N'Huong nghiep'),
		(23, 20, N'Soft skill va phat trien ban than'),
		(25, 16, N'Tieng Anh');
GO

INSERT INTO [Đánh giá] VALUES (1911881, N'HCMUT', 17, 1, 1);
INSERT INTO [Đánh giá] VALUES (1911881, N'HCMUT', 18, 1, 1);
INSERT INTO [Đánh giá] VALUES (1911881, N'HCMUT', 19, 1, 1);
INSERT INTO [Đánh giá] VALUES (3213542, N'HCMUT', 19, 1, 1);
INSERT INTO [Đánh giá] VALUES (19425845, N'HCMUS', 18, 1, 0);
INSERT INTO [Đánh giá] VALUES (17676565, N'HCMIU', 23, 1, 0);
INSERT INTO [Đánh giá] VALUES (2012485, N'HCMUT', 25, 1, 1);
INSERT INTO [Đánh giá] VALUES (2102231, N'HCMUT', 22, 1, 1);
INSERT INTO [Đánh giá] VALUES (3564322, N'USSH', 24, 1, 1);
INSERT INTO [Đánh giá] VALUES (5686525, N'VLU', 20, 1, 0);
		
GO

INSERT INTO [Thực tập tại]
	VALUES (18,25332),
			(22,44390)
GO


INSERT INTO [Hỗ trợ truyền thông]
	VALUES ( 18 ,9),
			(21	,10),
			(25	,8)
GO

INSERT INTO [Mốc sự kiện] VALUES (2,17,N'Le ra quan', '2018/6/10');
INSERT INTO [Mốc sự kiện] VALUES (2,17,N'Le trao tang', '2018/6/30');
INSERT INTO [Mốc sự kiện] VALUES (2,18,N'Le ki ket cong ty','2019/3/15'	);
INSERT INTO [Mốc sự kiện] VALUES (2,18,N'Tong ket thuc tap', '2019/6/15');
INSERT INTO [Mốc sự kiện] VALUES (2,19,N'Ngoai khoa tai truong Lai Chau','2018/12/1');
INSERT INTO [Mốc sự kiện] VALUES (2,19,N'Danh gia ket qua giao duc','2018/12/5');
INSERT INTO [Mốc sự kiện] VALUES (2,20,N'Workshop Thanh nien','	2019/6/5');
INSERT INTO [Mốc sự kiện] VALUES (2,21,N'Dem hoi cho em','2019/12/25');
INSERT INTO [Mốc sự kiện] VALUES (2,21,N'Cay uoc mo','2019/12/29');
INSERT INTO [Mốc sự kiện] VALUES (2,21,N'Don nam moi','2020/1/1');
INSERT INTO [Mốc sự kiện] VALUES (2,22,N'Ki hop tac thuc tap','	2020/6/1');
INSERT INTO [Mốc sự kiện] VALUES (2,22,N'Tong ket chuong trinh','2020/8/1');
INSERT INTO [Mốc sự kiện] VALUES (2,23,N'Buoi le va chuong trinh','2021/3/5');
INSERT INTO [Mốc sự kiện] VALUES (2,24,N'Tham cot co Lung Cu','2021/7/5');
INSERT INTO [Mốc sự kiện] VALUES (2,24,N'Buoi le tai dia phuong','2021/7/7');
INSERT INTO [Mốc sự kiện] VALUES (2,25,N'Vong loai','2021/11/20');
INSERT INTO [Mốc sự kiện] VALUES (2,25,N'Vong ban ket','2021/11/29');
INSERT INTO [Mốc sự kiện] VALUES (2,25,N'Chung ket','2021/12/5');
GO

INSERT INTO [Quyên tiền] VALUES (1, 3, 10000000, '2018/3/11');
INSERT INTO [Quyên tiền] VALUES (2, 3, 10000000, '2018/2/25');
INSERT INTO [Quyên tiền] VALUES (2, 3, 20000000, '2019/4/12');
INSERT INTO [Quyên tiền] VALUES (3, 3, 5000000, '2018/5/17');
INSERT INTO [Quyên tiền] VALUES (3, 3, 15000000, '2019/6/30');
INSERT INTO [Quyên tiền] VALUES (4, 3, 10000000, '2019/8/21');
INSERT INTO [Quyên tiền] VALUES (4, 3, 5000000, '2020/1/12');
INSERT INTO [Quyên tiền] VALUES (4, 3, 10000000, '2020/12/24');
INSERT INTO [Quyên tiền] VALUES (5, 3, 20000000, '2019/3/19');
INSERT INTO [Quyên tiền] VALUES (6, 3, 50000000, '2018/4/30');
INSERT INTO [Quyên tiền] VALUES (7, 3, 100000000, '2019/9/29');
INSERT INTO [Quyên tiền] VALUES (8, 3, 60000000, '2018/7/27');
INSERT INTO [Quyên tiền] VALUES (8, 3, 40000000, '2019/8/22');
INSERT INTO [Quyên tiền] VALUES (8, 3, 50000000, '2021/6/11');
INSERT INTO [Quyên tiền] VALUES (9, 3, 25000000, '2019/10/10');
INSERT INTO [Quyên tiền] VALUES (9, 3, 75000000, '2021/7/1');
INSERT INTO [Quyên tiền] VALUES (10, 3, 50000000, '2020/3/3');
GO

INSERT INTO [Tài khoản] VALUES (170, 'haonguyen123', '123456')
INSERT INTO [Tài khoản] VALUES (172, 'lyancute', '123456')
INSERT INTO [Tài khoản] VALUES (173, 'hoangminh1999', '123456')
INSERT INTO [Tài khoản] VALUES (174, 'xhung@123', '123456')
INSERT INTO [Tài khoản] VALUES (175, 'minhanh_123', '123456')
INSERT INTO [Tài khoản] VALUES (176, 'thanh_ha1234', '123456')
INSERT INTO [Tài khoản] VALUES (177, 'thanhthaobeauti', '123456')
INSERT INTO [Tài khoản] VALUES (178, 'kiendeptroai', '123456')
INSERT INTO [Tài khoản] VALUES (179, 'mylinhday', '123456')
INSERT INTO [Tài khoản] VALUES (180, 'longdiduongquyen', '123456')
INSERT INTO [Tài khoản] VALUES (181, 'thuthuy1234', '123456')
INSERT INTO [Tài khoản] VALUES (182, 'trucmaine', '123456')
INSERT INTO [Tài khoản] VALUES (183, 'kimlinh_@1', '123456')
INSERT INTO [Tài khoản] VALUES (184, 'tantaitanloc', '123456')

GO