Use AdventureWorks2017
GO

-- creating sample table

create table adventureWorks_Update (
id int identity(1,1),
productname varchar(50),
price bigint,
createDate datetime default getdate(),
lastUpdate datetime default getdate()
)
GO

-- inserting sample rows into the table

insert into adventureWorks_Update(productname,price) values('product 1', 100)
insert into adventureWorks_Update(productname,price) values('product 2', 1000)
insert into adventureWorks_Update(productname,price) values('product 3', 10000)
insert into adventureWorks_Update(productname,price) values('product 4', 100000)
insert into adventureWorks_Update(productname,price) values('product 5', 1000000)
GO

-- show the table data
SELECT * from adventureWorks_Update
GO
