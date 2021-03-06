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
from NorthwindTraders.dbo.Products as P left outer join NorthwindTraders.dbo.[Order Details] as OD
	 on P.ProductID = OD.ProductID
	 inner join NorthwindTraders.dbo.Categories as C
	 on P.CategoryID = C.CategoryID
	 where @category = C.CategoryName
	 group by ProductName,Quantity
	 order by Quantity Desc
go

--Execute procedure
exec ica14_01
go

exec ica14_01 'Confections'
go



--q2--
--make sure procedure is found and exists
if exists
(
select *
from sysobjects
where name = 'ica14_02' --give it a name that it should be looking for to see if it exists
)
--Call Procedure with this name
drop procedure ica14_02
go

--Create procedure
create procedure ica14_02
--arguments for procedure
@year as int,
@name as nvarchar(64),
@freight as money
as
select Year(OrderDate) as 'Year',
 (LastName + ', ' + FirstName) as 'Name',
 AVG(Freight) as 'Biggest Avg Freight'

 from NorthwindTraders.dbo.Employees as E
	left outer Join NorthwindTraders.dbo.Orders as O
	on E.EmployeeID = O.EmployeeID

where ( YEAR(OrderDate) = @year) AND ((LastName +', '+ FirstName) = @name)  

group by LastName, FirstName, Year(OrderDate)--Group non aggregate values

having AVG(Freight) < @freight

order by AVG(Freight) desc

go

exec ica14_02 1996, 'Buchanan, Steven', 200
exec ica14_02 1997, 'Leverling, Janet', 100
go

--q3--
