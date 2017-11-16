--CMPE2400 Ica 14 Rkwok2 --

--q1--
--make sure procedure is found and exists
if exists
(
select *
from sysobjects
where name = 'ica14_01' --give it a name that it should be looking for to see if it exists
)
--Call Procedure with this name
drop procedure ica14_01
go


--What is the procedure, create it here
create procedure ica14_01
--Put parameters here (note: if you don't know what type the data needs to be, Check your tables in the database!!!)
@category as nvarchar(30) = 'Beverages'
as
select TOP 1 @category as 'Category', ProductName as 'Product Name', Quantity as 'Highest Quantity'
from NorthwindTraders.dbo.Products left outer join NorthwindTraders.dbo.[Order Details]
	 on Products.ProductID = [Order Details].ProductID
	 group by ProductName,Quantity
	 order by Quantity Desc
go

--Execute procedure
exec ica14_01
go

exec ica14_01 'Confections'
go