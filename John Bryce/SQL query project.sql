-- Project 2:


-- #1 show the ProductID, ProductName, Color, ListPrice, Size for all products that haven't been purchased yet:


select
p.ProductID,
p.Name,
p.Color,
p. ListPrice,
p.Size,
s.salesorderID
from Production.Product p left join Sales.SalesOrderDetail s on p.ProductID = s.ProductID
where s.SalesOrderID is null


-- #2 update:


update sales.customer set personid=customerid

where customerid <=290

update sales.customer set personid=customerid+1700

where customerid >= 300 and customerid<=350

update sales.customer set personid=customerid+1700

where customerid >= 352 and customerid<=701


-- #2: show customers that have never ordered anything by firstname, last name, customer id and sort it by customer id by ascending order. if he has no first+last name, show "unknown"


select 
case
	when p.FirstName is null and p.LastName is null	
	then 'unknown'
	else
	p.FirstName
	end as FirstName,
case
	when p.FirstName is null and p.LastName is null	
	then 'unknown'
	else
	p.LastName
	end as LastName,
c.CustomerID,
s.OrderDate --strictly to show they've never ordered
from Sales.Customer c 
left join Person.Person p on c.PersonID = p.BusinessEntityID
left join Sales.SalesOrderHeader s on c.CustomerID = s.CustomerID
where s.OrderDate is null
order by c.CustomerID asc


-- #3: show firstname, lastname, customerid and amount of orders ordered by desc, for the top 10 customers that had the most orders.


select top 10
p.FirstName,
p.LastName,
Sales.Customer.CustomerID,
count(*) as orders -- counts orders
from Sales.Customer join [Sales].[SalesOrderHeader] on Sales.Customer.CustomerID=Sales.SalesOrderHeader.CustomerID--triple join customers with salesorderheader and person
left join Person.Person p on Sales.Customer.PersonID = p.BusinessEntityID
group by Sales.Customer.CustomerID, p.FirstName, p.LastName 
order by orders desc


-- #4: show employes by their first name, last name, jobtitle, hiredate, and the amount of employees that work at the same position as the employee shown.


select
p.FirstName,
p.LastName,
e.JobTitle,
e.HireDate,
count(*) over(partition by JobTitle) as wsame_title
from HumanResources.Employee e join Person.Person p on e.BusinessEntityID = p.BusinessEntityID
group by e.JobTitle, p.FirstName, p.LastName, e.HireDate 

 
--#5: show customers by firstname, lastname, customerid, salesorderid, last order date and second to last order date.


select 
a.customerid,
a.firstname,
a.lastname,
a.salesorderid,
a.orderdate as last,
a.lead as second_last
from
(
select
h.salesorderid,
h.customerid,
p.lastname,
p.firstname,
h.orderdate,
lead(h.orderdate) over(partition by h.customerid order by h.orderdate desc) as 'lead',
row_number() over(partition by h.customerid order by h.orderdate desc) as 'row'
from Sales.SalesOrderHeader h
left join Sales.Customer c on c.CustomerID = h.CustomerID
left join Person.Person p on p.BusinessEntityID = c.PersonID
--group by h.customerid, h.orderdate, p.lastname, p.firstname, h.salesorderid
)
a
where row = 1
order by a.customerid


--#6: show the most expensive order of the year for each year, show it by year, orderid, full customer name, and total price.


select 
year(orderdate) as orderyear,
salesorderid, 
subtotal,
lastname,
firstname
from sales.salesorderheader h 
left join Sales.Customer c on c.CustomerId = h.CustomerID
left join Person.Person p on p.BusinessEntityID = c.personID
where subtotal in (select max(subtotal) over(partition by year(orderdate)) from sales.salesorderheader)


--#7: show the amount of orders done each month in each year (columns are years rows are months)
select
month(OrderDate) as month,
count(case when year(OrderDate)=2011 then SalesOrderID end) as '2011',
count(case when year(OrderDate)=2012 then SalesOrderID end) as '2012',
count(case when year(OrderDate)=2013 then SalesOrderID end) as '2013',
count(case when year(OrderDate)=2014 then SalesOrderID end) as '2014'
from sales.salesorderheader
group by month(OrderDate)
order by month(OrderDate) asc


--#8: show sum of orders for every month in the year and the running sum of every year. show a line that sums the total of the whole year after the 12th month line. 


select
year(orderdate) as order_year,
month(orderdate) as order_month,
sum(subtotal) as monthly_orders_total,
sum(sum(subtotal)) over(partition by year(orderdate) order by month(orderdate) asc) as running_total_monthly
from sales.salesorderheader
group by year(orderdate), month(orderdate)
having year(orderdate) is not null 

union
select
year(orderdate) as order_year, 
13 as order_month, -- month 13 instead of grand_total because the column with month in it will not accept strings.
sum(subtotal) as monthly_orders_total,
null as running_total_monthly
from sales.salesorderheader
group by year(orderdate)


--#9: show employees ordered from the newest employee to the oldest for each department. 
--want to see department name, employee id, full name, hiring date, mileage in the company (months), full name again :), hiring date of the employee before him, and the
--difference in days between him and that employee. 

select 
d.Name as departmentName,
e.BusinessEntityID as employeeID,
p.FirstName+' '+p.LastName as full_name,
e.HireDate,
datediff(month, e.HireDate, getdate()) as Seniorita,
lead(p.FirstName+' '+p.LastName) over(partition by d.Name order by e.HireDate desc) as prevEmployeeN,
lead(e.HireDate) over(partition by d.Name order by e.HireDate desc) as prevEmployeeD,
datediff(day, lead(e.HireDate) over(partition by d.Name order by e.HireDate desc), e.HireDate) as DaysDiff
from [HumanResources].[Employee] e
left join [HumanResources].[EmployeeDepartmentHistory] h on e.BusinessEntityID=h.BusinessEntityID  -- joining [EmployeeDepartmentHistory] to get e.departmentID from businessentityID
left join [Person].[Person] p on p.BusinessEntityID = e.BusinessEntityID  -- joining [Person] to get p.[FirstName]+p.[LastName] from businessentityID
left join [HumanResources].[Department] d on d.DepartmentID=h.DepartmentID--joining [Department] to get d.[Name](department) from [DepartmentID]
where h.enddate is null -- still in the department
order by d.Name asc




--#10: find all the employees in each department that were recruited on the same day

select

h.departmentid,
e.hiredate,
p.firstname+' '+p.lastname+' '+ cast(e.businessentityid as nvarchar(50)) as 'nameNid'
from HumanResources.Employee e
left join [HumanResources].[EmployeeDepartmentHistory] h on h.[BusinessEntityID] = e.[BusinessEntityID]
left join [Person].[Person] p on p.BusinessEntityID = e.BusinessEntityID
where enddate is null
group by h.departmentid, e.hiredate,  e.businessentityid, p.firstname, p.lastname
order by departmentid asc




select
*
from 
(
select
h.DepartmentID,
e.HireDate,
p.FirstName+' '+p.LastName as name,
row_number() over(partition by h.DepartmentID, e.HireDate order by e.HireDate) as rownum
from HumanResources.Employee e
left join [HumanResources].[EmployeeDepartmentHistory] h on h.[BusinessEntityID] = e.[BusinessEntityID]
left join [Person].[Person] p on p.BusinessEntityID = e.BusinessEntityID
where enddate is null
)a
