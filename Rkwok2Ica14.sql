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

as
select TOP 5 ProductName as 'Product Name', Quantity 
from NorthwindTraders.dbo.Products left outer join NorthwindTraders.dbo.[Order Details]
	 on Products.ProductID = [Order Details].ProductID
order by Quantity asc
go

--Execute procedure
exec 