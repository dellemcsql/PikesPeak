-- perform the table update

-- deleting one row from the table

delete from adventureWorks_Update where id = 1
GO

-- udating one record into the table from "Product 3"

update adventureWorks_Update
SET price = 22222,
    lastUpdate = getdate()
WHERE productname = 'product 3'
GO

-- Inserting one new record into the table

insert into adventureWorks_Update(productname,price) values('New product 6', 5555555)
GO

-- showing table data

SELECT * from adventureWorks_Update
GO
