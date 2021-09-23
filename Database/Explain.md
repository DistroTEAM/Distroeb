# Database

Database of blogs is created by SQL server

## Tables
Database has 8 Tables  
1- Permission  
2- Roles  
3- Users  
4- login_users    
5- blog_types  
6- blog_categories  
7- Blogs  
8- Comments 

## Relations and ERD  
Relations                  |  ERD  
:-------------------------:|:-------------------------:
![Relation](https://github.com/hoco1/Distroteam.github.io/blob/main/Database/img/Screenshot%202021-09-22%20211028.jpg)   |  ![ERD](https://github.com/hoco1/Distroteam.github.io/blob/main/Database/img/ERD.jpg)
**To display better, you can use attach files**  
## Query
Show all permission and roles  
```sql
SELECT 
	r.role_name,
	p.per_name
FROM
	Roles r
INNER JOIN Permission p ON r.per_id = p.per_id
```
Show all users with permission and roles    
```sql
SELECT
	u.user_name,
	r.role_name
FROM	
	Users u
INNER JOIN Roles r ON r.role_id = u.user_role
```
Use login table to show username  permission and roles  
```sql
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
```
Show all categories with types  
```sql
SELECT
	c.bc_title,
	t.bt_name
FROM
	blog_categories c
INNER JOIN blog_types t ON c.bc_type = t.bt_id

```
Show all blog post with category and types and author  
```sql
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
```
Show all comments of blog and show title of blog and author  
```sql
SELECT
	c.comm_title,
	u.user_name,
	b.blog_title
FROM
	Comments c
INNER JOIN Users u ON u.user_id = c.comm_userID
INNER JOIN Blogs b ON b.blog_id = c.comm_blog
```
## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

I want to create 'Distor' blog with Flask and every one can help me in this project such as idea about design blog etc.  
you can reach me in [GitHub](https://github.com/hoco1), [email](hocohelper@gmail.com)
