use northwind2016
select c.CustomerID,c.CompanyName,o.OrderID,sum(od.Quantity*od.UnitPrice) total from Customers c
join  Orders o on c.CustomerID=o.CustomerID
join  OrderDetails od on od.OrderID=o.OrderID
where year(o.OrderDate)>=2016 and year(o.OrderDate)<=2017 
group by c.CustomerID,c.CompanyName,o.OrderID
having sum(od.Quantity*od.UnitPrice)>=10000
order by sum(od.Quantity*od.UnitPrice) desc
--=================================================
select c.CustomerID,c.CompanyName,sum(od.Quantity*od.UnitPrice) total from Customers c
join  Orders o on c.CustomerID=o.CustomerID
join  OrderDetails od on od.OrderID=o.OrderID
where year(o.OrderDate)>=2016 and year(o.OrderDate)<=2017 		
group by c.CustomerID,c.CompanyName
having sum(od.Quantity*od.UnitPrice)>=15000
order by sum(od.Quantity*od.UnitPrice) desc
--================================================
with cte as(
select c.CustomerID,c.CompanyName,sum(od.Quantity*od.UnitPrice) total,sum(od.Quantity*od.UnitPrice)-sum(od.Quantity*od.UnitPrice*od.Discount) discount  from Customers c
join  Orders o on c.CustomerID=o.CustomerID
join  OrderDetails od on od.OrderID=o.OrderID
where year(o.OrderDate)>=2016 and year(o.OrderDate)<=2017 		
group by c.CustomerID,c.CompanyName
having sum(od.Quantity*od.UnitPrice)-sum(od.Quantity*od.UnitPrice*od.Discount)>=10000
)
select * from cte
order by discount desc
--===============================================
select EmployeeID,OrderID,sum(OrderID),OrderDate from Orders
where OrderDate= EOMONTH(orderdate) 
group by EmployeeID,OrderID,OrderDate
order by EmployeeID
--===============================================
select top 10 o.OrderID,count(od.ProductID) from Orders o
join  OrderDetails od on o.OrderID=od.OrderID
group by o.OrderID
having count(od.ProductID)>1
order by count(od.ProductID) desc
--======================================================
Select Top 2 Percent
		OrderID		
			
	From Orders
	Order By NewID();
--=====================================================

Select
 OrderID
 ,count (ProductID)
 ,Quantity	From	OrderDetails	Where	Quantity	>=	60
 group by OrderID,Quantity
 having count (ProductID)>1 
 --=======================================================
 	Select
		*
	From 
		OrderDetails
	Where OrderId in
		(Select 
			distinct OrderID	
		From 
			OrderDetails
		Where Quantity >= 60
		Group by OrderID, Quantity
			Having Count(ProductID) > 1);
--===================================================================
	Select	OrderDetails.OrderID
 ,ProductID
 ,UnitPrice	,Quantity	,Discount	From	OrderDetails	 Join	(
 Select distinct	OrderID
 From	OrderDetails	Where	Quantity	>=	60
 Group	By	OrderID,	Quantity	Having	Count(*)	>	1
 )		PotentialProblemOrders	on	PotentialProblemOrders.OrderID	=
 OrderDetails.OrderID
 Order	by	OrderDetails.OrderID,	ProductID
 --====================================================================
 select * from Orders
 where (RequiredDate)<=(ShippedDate)
 --====================================================================
  select EmployeeID, count( * )from Orders
 where (RequiredDate)<=(ShippedDate)
 group by EmployeeID
 having count( * )>1
 order by count( * ) desc
 --====================================================================
 with cte as(
 select EmployeeID, count( * ) h from Orders
 where (RequiredDate)<=(ShippedDate)
 group by EmployeeID
 having count( * )>1)
 select c.* ,TotalOrders, LastName,b.EmployeeID from cte c  join (
 Select	EmployeeID
 ,TotalOrders	=	Count(*)	From	Orders	
 Group	By	EmployeeID) b on c.EmployeeID=b.EmployeeID
  join Employees e on e.EmployeeID=b.EmployeeID
 order by h desc
 --=======================================================================
with cte as(
 select EmployeeID, count( * ) h from Orders
 where (RequiredDate)<=(ShippedDate)
 group by EmployeeID
 having count( * )>1)
 select c.* ,TotalOrders, LastName,b.EmployeeID from cte c right join (
 Select	EmployeeID
 ,TotalOrders	=	Count(*)	From	Orders	
 Group	By	EmployeeID) b on c.EmployeeID=b.EmployeeID
 left join Employees e on e.EmployeeID=b.EmployeeID
 order by h desc
 --=======================================================
 with cte as(
 select EmployeeID, count( * ) h from Orders
 where (RequiredDate)<=(ShippedDate)
 group by EmployeeID
 having count( * )>1)
 select isnull(c.h,0) ,TotalOrders, LastName,b.EmployeeID from cte c right join (
 Select	EmployeeID
 ,TotalOrders	=	Count(*)	From	Orders	
 Group	By	EmployeeID) b on c.EmployeeID=b.EmployeeID
 left join Employees e on e.EmployeeID=b.EmployeeID
 order by h desc
 --======================================================
 with cte as(
 select EmployeeID, count( * ) h from Orders
 where (RequiredDate)<=(ShippedDate)
 group by EmployeeID
 having count( * )>1)
 select isnull(c.h,0) ,TotalOrders, LastName,b.EmployeeID,cast (isnull(c.h,0) as decimal(18,6 ))/
 (cast(b.TotalOrders as decimal(18,6)))*100 from cte c right join (
 Select	EmployeeID
 ,TotalOrders	=	Count(*)	From	Orders	
 Group	By	EmployeeID) b on c.EmployeeID=b.EmployeeID
 left join Employees e on e.EmployeeID=b.EmployeeID
 order by h desc
 --====================================================
 with cte as(
 select EmployeeID, count( * ) h from Orders
 where (RequiredDate)<=(ShippedDate)
 group by EmployeeID
 having count( * )>1)
 select isnull(c.h,0) ,TotalOrders, LastName,b.EmployeeID,round(cast (isnull(c.h,0) as decimal(10,2 ))/
 (cast(b.TotalOrders as decimal(10,2))),2) from cte c right join (
 Select	EmployeeID
 ,TotalOrders	=	Count(*)	From	Orders	
 Group	By	EmployeeID) b on c.EmployeeID=b.EmployeeID
 left join Employees e on e.EmployeeID=b.EmployeeID
 order by h desc
 --====================================================
 select*, case when u.b > 0 and u.b<= 1000 then 'low'
			when u.b > 1000 and u. b<=  5000 then 'medium'
			when u.b >  5000 and  u. b<= 10000 then 'high' 
			else 'very high' end f
			from Customers c
 join (
 select CustomerId,isnull(sum(od.Quantity*od.UnitPrice),0 ) b from Orders g
 join OrderDetails od on g.OrderID=od.OrderID
 where year(OrderDate)>=2016 and year(OrderDate)<=2017

 group by CustomerID) u on u.CustomerID=c.CustomerID
 
 --=====================================================
  select f, count(f),cast(count(f)as decimal(10,2))/81  from(
  select u.b, case when u.b > 0 and u.b<= 1000 then 'low'
			when u.b > 1000 and u. b<=  5000 then 'medium'
			when u.b >  5000 and  u. b<= 10000 then 'high' 
			else 'very high' end f
			from Customers c
 join (
 select CustomerId,isnull(sum(od.Quantity*od.UnitPrice),0 ) b from Orders g
 join OrderDetails od on g.OrderID=od.OrderID
 where year(OrderDate)>=2016 and year(OrderDate)<=2017

 group by CustomerID) u on u.CustomerID=c.CustomerID) as f
 group by f
 --=======================================================
 select *,case when TotalOrderAmount > 0 and TotalOrderAmount<= 1000 then 'low'
			when TotalOrderAmount> 1000 and TotalOrderAmount<=  5000 then 'medium'
			when TotalOrderAmount >  5000 and  TotalOrderAmount<= 10000 then 'high' 
			else 'very high' end f from (
 Select	Customers.CustomerID
 ,Customers.CompanyName	,TotalOrderAmount	=	SUM(Quantity	*	UnitPrice)
 From	Customers	join	Orders	on	Orders.CustomerID	=	Customers.CustomerID
 join	OrderDetails	on	Orders.OrderID	=	OrderDetails.OrderID
 Where	OrderDate	>=	'20160101'
 and	OrderDate		<	'20170101'
 Group	By	Customers.CustomerID
 ,Customers.CompanyName)s
 --=========================================================

 select distinct Country,count (SupplierID), null from Suppliers
 group by Country
 union
 select distinct Country, null ,count (CustomerID)from Customers
 group by Country
 --==========================================================
 select distinct s.Country,c.Country from Suppliers s
  full join Customers c on s.Country=c.Country
  order by s.Country,c.Country
  --=========================================================
  select distinct * from (
 select distinct Country,count (SupplierID) s, null c from Suppliers
 
 group by Country
 union
 select distinct Country, null ,count (CustomerID) c from Customers
 group by Country) d
 where s<>null or c<>null
 --=============================================================
 select OrderID,ShipCountry,CustomerID,v.b from Orders o
 join 
 (
 select Country,min(OrderDate) b from Customers c
 join Orders
  d on c.CustomerID=d.CustomerID
 group by country) v on v.b=o.OrderDate

--===============================================================
 Select	InitialOrder.CustomerID
 ,InitialOrderID	=	InitialOrder.OrderID
 ,InitialOrderDate	=	InitialOrder.OrderDate	,NextOrderID	=
 NextOrder.OrderID
 ,NextOrderDate	=	NextOrder.OrderDate	from	Orders	InitialOrder	join	Orders
 NextOrder	on	InitialOrder.CustomerID	=	NextOrder.CustomerID
where	 DATEDIFF(day,InitialOrder.OrderDate,NextOrder.OrderDate)<= 5 and 
InitialOrder.OrderID	<	NextOrder.OrderID
 Order	by	InitialOrder.CustomerID
 ,InitialOrder.OrderId--
 --==============================================================
 	Select	CustomerID
 ,OrderDate	=	convert(date,	OrderDate)	,NextOrderDate	=
 convert(
 date	,Lead(OrderDate,1)	OVER	(Partition	by	CustomerID	order	by
 CustomerID,	OrderDate)	),
 convert(
 date	,Lead(OrderDate,1)	OVER	(Partition	by	CustomerID	order	by
 CustomerID,	OrderDate)	)-		convert(date,	OrderDate)	From	Orders
 Order	by	CustomerID
 ,OrderID
 