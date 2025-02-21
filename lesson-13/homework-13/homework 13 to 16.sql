---lesson 13  to lesson 16
select 
datepart(YEAR,Date),
case when month(date)<=3 then 1 when month(date)<=6 then 2 when month(date)<=9 then
3 when month(date)<=12 then 4 end, case when month(date)<=3 then 'first' when month(date)<=6 then 'second' 
when month(date)<=9 then 'third' when month(date)<=12 then 'forth' end,case when right (cast(datepart(day,date) as varchar(max)),1)='1'
then datepart(day,date)+'st' when right (cast(datepart(day,date) as varchar(max)),1)='2' then datepart(day,date)+'nd'
when right (cast(datepart(day,date) as varchar(max)),1)='3' then datepart(day,date)+'rd' else datepart(day,date)+'th' end 'first' from [DateSequence]
group by Date

SET @fromdate = '2025-01-01';
SET @todate = '2025-12-31';

WITH DateSequence ([Date]) AS 
(
    SELECT @fromdate AS [Date]
    UNION ALL
    SELECT DATEADD(DAY, 1, [Date])
    FROM DateSequence
    WHERE [Date] < @todate
)
SELECT [Date],convert(datetime2 ,[Date]),day([Date]),DATEname(day,[Date]),datepart(day,[Date]),datepart(week,[Date]),datepart(MONTH,[Date]),datename(MONTH,[Date]),
datepart(YEAR,[Date]),
case when month([Date])<=3 then 1 when month([Date])<=6 then 2 when month([Date])<=9 then
3 when month([Date])<=12 then 4 end, case when month(date)<=3 then 'first' when month([Date])<=6 then 'second' 
when month([Date])<=9 then 'third' when month([Date])<=12 then 'forth' end,case when right (cast(datepart(day,[Date]) as varchar(max)),1)='1'
then cast(datepart(day,[Date]) as varchar(max))+'st' when right (cast(datepart(day,[Date]) as varchar(max)),1)='2' then cast(datepart(day,[Date]) as varchar(max))+'nd'
when right (cast(datepart(day,[Date]) as varchar(max)),1)='3' then cast(datepart(day,[Date]) as varchar(max))+'rd' else cast(datepart(day,[Date]) as varchar(max))+'th' end 'first' FROM DateSequence
OPTION (MAXRECURSION 0);



where salesman_id in (
select salesman_id from Inventory.Salesman
where name='Paul Adam')
select ord_no, purch_amt, ord_date, customer_id, salesman_id from Inventory.Orders
where salesman_id in (select salesman_id from Inventory.Salesman
where city='london')
select ord_no, purch_amt, ord_date, customer_id, salesman_id from Inventory.Orders
where salesman_id in (select salesman_id from Inventory.Customer
where customer_id=3007 )
select ord_no, purch_amt, ord_date, customer_id, salesman_id from Inventory.Orders


where purch_amt>(select AVG(purch_amt) from Inventory.Orders
where  format(ord_date, 'dd MMMM yyyy'
)='10 October 2012')
select  ord_no, purch_amt, ord_date, customer_id , salesman_id from Inventory.Orders
where customer_id in(select customer_id from Inventory.Customer
where city='New York')
select  * from Inventory.Salesman
where salesman_id in (select salesman_id from Inventory.Customer
where city='paris')
select  * from Inventory.Customer
where salesman_id in (select salesman_id from Inventory.Salesman
where customer_id<=2001)
select COUNT(customer_id),grade from Inventory.Customer
group by city,grade
having grade > (select AVG(grade) from Inventory.Customer
where city ='new york')
select ord_no, purch_amt, ord_date,  salesman_id from Inventory.Orders
where salesman_id in (select salesman_id from Inventory.Salesman
where  commission= (select max(commission) from Inventory.Salesman)
)
select distinct ord_no, purch_amt, ord_date, c.customer_id, c.salesman_id , cust_name from inventory.Customer c ,(select * from Inventory.Orders 
where format (ord_date ,'dd MMMM yyyy')= '17 August 2012'
) o
where c.customer_id in (select customer_id from Inventory.Orders 
where format (ord_date ,'dd MMMM yyyy')= '17 August 2012') and c.customer_id=o.customer_id
select * from Inventory.Salesman 
where salesman_id in (select salesman_id from Inventory.Orders
group by salesman_id
having count (customer_id)=2)
select ord_no, purch_amt, ord_date, customer_id , salesman_id from Inventory.Orders
where purch_amt> (select AVG(purch_amt) from Inventory.Orders
)


where purch_amt> =(select AVG(purch_amt) from Inventory.Orders
)
select  sum(purch_amt) from Inventory.Orders a

group by ord_date 

having sum(purch_amt)>=(SELECT 1000.00 + MAX(purch_amt) 
     FROM inventory.orders b 
     WHERE a.ord_date = b.ord_date)
order by ord_date desc
select * from Inventory.Customer
where customer_id In (select customer_id from Inventory.Customer
where city='london')
select * from Inventory.Salesman
where salesman_id in 
(select salesman_id from Inventory.Customer
group by salesman_id
having COUNT(customer_id)>1 )
select * from Inventory.Salesman
where salesman_id in 
(select salesman_id from Inventory.Customer
group by salesman_id
having COUNT(customer_id)=1 )
select * from Inventory.Salesman
where salesman_id in 
(select salesman_id from Inventory.Orders
group by salesman_id
having COUNT(ord_no)>1 )
select * from Inventory.Salesman s
where salesman_id in (select salesman_id from Inventory.Customer c
where s.city=c.city)
select * from Inventory.Salesman s
where city in (select city from Inventory.Customer c
)
select * from Inventory.Salesman s
where  exists (select salesman_id from Inventory.Customer c
where s.name<c.cust_name
)
select * from Inventory.Customer c
where grade= (select max(grade) from Inventory.Customer c2
where  c2.city<'new york')

select  purch_amt from inventory.Orders 
where format (ord_date ,'dd MMMM yyyy')='10 September 2012'
select * from Inventory.Orders
where purch_amt> any
(select purch_amt from inventory.Orders 
where format (ord_date ,'dd MMMM yyyy')='10 September 2012')
select * from Inventory.Orders
where purch_amt< all(
select purch_amt from Inventory.Orders
where customer_id in  (select customer_id from Inventory.Customer
where city = 'london'))
select * from Inventory.Orders
where purch_amt< (
select max(purch_amt) from Inventory.Orders
where customer_id in  (select customer_id from Inventory.Customer
where city = 'london'))
select * from Inventory.Customer
where grade>all(
select grade from Inventory.Customer
where customer_id in  (select customer_id from Inventory.Customer
where city = 'new york'))
select sum(purch_amt) from Inventory.Orders
where salesman_id in (
select salesman_id from Inventory.Salesman s
where salesman_id in (select salesman_id from Inventory.Customer c where s.city=c.city))
select * from Inventory.Customer
where grade<> any(
select grade from Inventory.Customer c
where customer_id in ( select customer_id from Inventory.Customer c2
where  city='london')
)
select * from Inventory.Customer
where grade<> any(
select grade from Inventory.Customer c
where customer_id in ( select customer_id from Inventory.Customer c2
where  city='paris')
)
select * from Inventory.Customer
where grade<> any(
select grade from Inventory.Customer c
where customer_id in ( select customer_id from Inventory.Customer c2
where  city='dallas')
)
select avg(pro_price) from item_mast
group by pro_com
select avg(pro_price) from item_mast
where pro_price>350
group by pro_com
select max(pro_price) from item_mast
group by pro_com
select * from emp_details
where emp_lname= any(select emp_lname from emp_details
where emp_lname ='Gabriel' or emp_lname='dosio')
select * from emp_details
where emp_dept=63 or emp_dept=89



where act_id in (
 select act_id from Movies.Movie_cast
 where mov_id = any(
  select mov_id from Movies.Movie
  where mov_title='Annie Hall'))

  select * from Movies.Director
  where dir_id in (
  select dir_id from Movies.Movie_Direction
  where mov_id in (
  select mov_id from Movies.Movie_cast
  where mov_id in (
  select mov_id from Movies.Movie
  where mov_title ='Eyes Wide Shut')))

  select * from Movies.Movie
  where mov_id not in ( 
  select mov_id from Movies.Movie
  where mov_rel_country = 'uk')

  SELECT 
    m.mov_title, 
    m.mov_year, 
    m.mov_dt_rel, 
    d.dir_fname, 
    d.dir_lname, 
    a.act_fname, 
    a.act_lname
FROM Movies.Movie m
-- Join with Movie_Direction to get directors
INNER JOIN Movies.Movie_Direction md ON m.mov_id = md.mov_id
INNER JOIN Movies.Director d ON md.dir_id = d.dir_id
-- Join with Movie_Cast to get actors
INNER JOIN Movies.Movie_Cast mc ON m.mov_id = mc.mov_id
INNER JOIN Movies.Actor a ON mc.act_id = a.act_id
join Movies.Rating r on r.mov_id = m.mov_id
join Movies.Reviewer rr on rr.rev_id=r.rev_id
where rr.rev_name is null

select * from Movies.Movie_Direction md 
  join Movies.Movie m on m.mov_id= md.mov_id
  join Movies.Director d on d.dir_id=md.dir_id
  where d.dir_fname='woddy' or d.dir_lname='allen'
  
  

  
  select mov_year from Movies.Movie
  where mov_id in (
  
  select mov_id from Movies.Rating
  where rev_stars >=3)
  select mov_title from Movies.Movie
  where mov_id in (
  
  select * from Movies.Rating
  where  num_o_ratings is null)

  select * from Movies.Rating
  select * from Movies.Reviewer
  where rev_id in(
 select rev_id from Movies.Rating
  where  num_o_ratings is null)



   select * from Movies.Rating r, ( select * from Movies.Reviewer
  where rev_id in(select rev_id from Movies.Rating)) as d,(
   select * from Movies.Movie
   where mov_id in (select mov_id from Movies.Rating
   where num_o_ratings is not null)) as g
   where d.rev_id=r.rev_id and g.mov_id=r.mov_id
  
   select d.rev_name,g.mov_title from Movies.Rating r, ( select * from Movies.Reviewer
  where rev_id in(select rev_id from Movies.Rating)) as d,(
   select * from Movies.Movie
   where mov_id in (select mov_id from Movies.Rating
   where num_o_ratings is not null)) as g
   where d.rev_id=r.rev_id and g.mov_id=r.mov_id
   group by d.rev_name,g.mov_title
   
   select g.mov_title,max(r.rev_stars) from Movies.Rating r, ( select * from Movies.Reviewer
  where rev_id in(select rev_id from Movies.Rating)) as d,(
   select * from Movies.Movie
   where mov_id in (select mov_id from Movies.Rating
   where num_o_ratings is not null)) as g
   where d.rev_id=r.rev_id and g.mov_id=r.mov_id
   group by g.mov_title
   order by g.mov_title

   select mov_id from Movies.Movie
   where mov_title ='american beauty'
   select rev_id from Movies.Rating
   where mov_id in (select mov_id from Movies.Movie
   where mov_title ='american beauty')
   select * from Movies.Reviewer
   where rev_id in (select rev_id from Movies.Rating
   where mov_id in (select mov_id from Movies.Movie
   where mov_title ='american beauty'))
   select rev_id from Movies.Reviewer
   where rev_name='paul monks'

   select * from Movies.Movie
   where mov_id in (
   select mov_id from Movies.Rating
   where rev_id  not in (select rev_id from Movies.Reviewer
   where rev_name='paul monks'))


   select * from Movies.Movie m, Movies.Reviewer r, Movies.Rating rr
   where m.mov_id in(
   select mov_id from 
   Movies.Rating where 
   rev_stars = (select min(rev_stars) from Movies.Rating)) 
   and r.rev_id=rr.rev_id and rr.mov_id=m.mov_id
   

   select * from Movies.Movie
   where mov_id in(
   select mov_id from Movies.Movie_Direction
   where dir_id in (
   select dir_id from Movies.Director
   where dir_fname='james' or dir_lname='cameron'))


   select   m.mov_title from Movies.Movie m ,Movies.Movie_cast mc, Movies.Actor a 
   where m.mov_id in ( select mov_id from Movies.Movie_cast 
   where act_id in (
   select act_id from Movies.Movie_cast
   group by act_id
   having count(act_id)>1)) and mc.mov_id=m.mov_id and a.act_id=mc.act_id
