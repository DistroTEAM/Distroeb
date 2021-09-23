USE master;
DROP DATABASE BlogDistroTV

CREATE DATABASE BlogDistroTV;

USE BlogDistroTV;

CREATE TABLE Permission(
	per_id INT PRIMARY KEY IDENTITY,
	per_name NVARCHAR(100) NOT NULL,
	per_desc NVARCHAR(255)
);

CREATE TABLE Roles(
	role_id INT PRIMARY KEY IDENTITY,
	role_name NVARCHAR(100) NOT NULL,
	role_desc NVARCHAR(255),
	per_id INT NOT NULL,
	CONSTRAINT fk_permission_roles FOREIGN KEY (per_id)
	REFERENCES Permission(per_id)
);



CREATE TABLE Users(
	user_id INT PRIMARY KEY IDENTITY,
	first_name NVARCHAR(255),
	last_name NVARCHAR(255),
	user_name VARCHAR(100) UNIQUE NOT NULL,
	user_password NVARCHAR(100) NOT NULL,
	user_mobile VARCHAR(13) DEFAULT 'empty',
	user_email VARCHAR(255) NOT NULL,
	user_address NTEXT DEFAULT 'empty',
	created_at DATETIME DEFAULT GETDATE(),
	user_role INT NOT NULL,
	CONSTRAINT fk_user_roles FOREIGN KEY (user_role)
	REFERENCES Roles(role_id)
);

CREATE TABLE login_users(
	login_id INT PRIMARY KEY IDENTITY,
	last_seen DATETIME DEFAULT GETDATE(),
	login_user_id INT NOT NULL,
	CONSTRAINT fk_login_user FOREIGN KEY (login_user_id)
	REFERENCES Users(user_id)
);

CREATE TABLE blog_types(
	bt_id INT PRIMARY KEY IDENTITY,
	bt_name NVARCHAR(255) UNIQUE NOT NULL,
	bt_desc NTEXT
);

CREATE TABLE blog_categories(
	bc_id INT PRIMARY KEY IDENTITY,
	bc_title NVARCHAR(255) UNIQUE NOT NULL,
	bc_desc NTEXT NOT NULL,
	bc_content NTEXT,
	bc_type INT,
	CONSTRAINT fk_types_blog FOREIGN KEY (bc_type)
	REFERENCES blog_types(bt_id)
);

CREATE TABLE Blogs(
	blog_id INT PRIMARY KEY IDENTITY,
	blog_title NVARCHAR(255) NOT NULL,
	blog_desc NTEXT NOT NULL,
	blog_content NTEXT,
	blog_type INT,
	blog_category INT NOT NULL,
	blog_userID INT NOT NULL,
	CONSTRAINT fk_blog_type FOREIGN KEY(blog_type)
	REFERENCES blog_types(bt_id),
	CONSTRAINT fk_blog_category FOREIGN KEY(blog_category)
	REFERENCES blog_categories(bc_id),
	CONSTRAINT fk_blog_userID FOREIGN KEY(blog_userID)
	REFERENCES Users(user_id)
);

CREATE TABLE Comments(
	comm_id INT PRIMARY KEY IDENTITY,
	comm_title	NVARCHAR(255) NOT NULL,
	comm_desc NVARCHAR(255) NOT NULL,
	comm_userID INT NOT NULL,
	comm_blog INT NOT NULL,
	CONSTRAINT fk_comments_userID FOREIGN KEY (comm_userID)
	REFERENCES Users(user_id),
	CONSTRAINT fk_comments_type FOREIGN KEY (comm_blog)
	REFERENCES Blogs(blog_id)
);
INSERT INTO Permission VALUES (N'نوشتن',N'نوشتن وبلاگ'),(N'کامنت ',N'قابلیت کامنتگذاشتن')
						,(N'مدیریت کامنت',N'حذف و مدیرت کامنت');

INSERT INTO Roles VALUES (N'ادمین',N'مدیریت سایت',1),(N'ادمین',N'مدیریت سایت',2),
					(N'ادمین',N'مدیریت سایت',3),(N'کاربر',N'کاربر سایت',2);

INSERT INTO Users(
	first_name ,
	last_name ,
	user_name ,
	user_password ,
	user_mobile ,
	user_email ,
	user_address, 
	user_role) VALUES (N'جعفر',N'قلی','jafar43',
						'63643543','745643634','jafar@gmail.com',
						N'جنت اباد بیست متری',4),
					(N'امیر حسین',N'محمدی','amir65',
						'15545745','09120052774','amir@gmail.com',
						N'جنت اباد بیست متری',1),
					(N'رضا',N'داورزنی','reza12',
					'345345','0919742441','reza@gmail.com',
					N'',2)
INSERT INTO login_users (login_user_id)VALUES (1),(2),(3),(1)

INSERT INTO blog_types VALUES (N'تخصصی',N'مباحث هوش مصنوعی و یادگیری عمیق'),
							(N'نیمه تخصصی',N'درباره گیت و هوش مصنوعی سمبلیک')
INSERT INTO blog_categories(bc_title,bc_desc,bc_content,bc_type) VALUES (N'۱هوش مصنوعی',N'تاریخچه و مباحث پایه',
									N' مباحث پایه یعنی ریاضیات و جبر و  ',1),
									(N'۲هوش مصنوعی',N'مباحث پیشرفته',
									N'ماشین لرنیگ و یادگیری عمیق',1),
									(N'گیت',N'تاریخچه و مباحث پایه',
									N' پوش و پول .ووو',2)

INSERT INTO Blogs VALUES(N'هوش مصنوعی چیست ؟',N'ایده هوش مصنوعی زمانی داده شد که کامپیوتر چگونه می تواند فکر کند',
N'https://www.imgacademy.com/sites/default/files/styles/scale_2500w/public/2019-06/rsz_performance_pct26_sport_science_center_-_greg_wilson.jpg?itok=bWEUgYva',1,1,2)

INSERT INTO Comments VALUES (N'خیلی تاثیر گذار بود',N'خب اینجا باید یه روضه خوانده شود',1,1),
(N'خیلی تاثیر گذار بود ۲',N'خب اینجا باید یه روضه خوانده شود ۲',2,1),
(N'خیلی تاثیر گذار بود3 ',N' 3خب اینجا باید یه روضه خوانده شود',3,1)

-- query permission and roles
SELECT 
	r.role_name,
	p.per_name
FROM
	Roles r
INNER JOIN Permission p ON r.per_id = p.per_id

-- query users with permission
SELECT
	u.user_name,
	r.role_name
FROM	
	Users u
INNER JOIN Roles r ON r.role_id = u.user_role

-- query login show username , permission and roles

SELECT
	l.login_user_id,
	u.user_name,
	r.role_name,
	p.per_name
FROM 
	login_users l
INNER JOIN Users u ON l.login_user_id = u.user_id
INNER JOIN Roles r ON r.role_id = u.user_role
INNER JOIN Permission p ON p.per_id = r.per_id

--- query categories with types
SELECT
	c.bc_title,
	t.bt_name
FROM
	blog_categories c
INNER JOIN blog_types t ON c.bc_type = t.bt_id


--- query blog post with category and types and username

SELECT 
	b.blog_title,
	c.bc_title,
	t.bt_name,
	u.user_name
FROM 
	Blogs b
INNER JOIN blog_categories c ON b.blog_category = c.bc_id
INNER JOIN blog_types t ON c.bc_type = t.bt_id
INNER JOIN Users u ON u.user_id = b.blog_userID

--- query comments of blogs and show title and username

SELECT
	c.comm_title,
	u.user_name,
	b.blog_title
FROM
	Comments c
INNER JOIN Users u ON u.user_id = c.comm_userID
INNER JOIN Blogs b ON b.blog_id = c.comm_blog

-- query show all tables
SELECT
  *
FROM
  BlogDistroTV.INFORMATION_SCHEMA.TABLES;