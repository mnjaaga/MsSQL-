select Name, Gender, Salary,
RANK() OVER (ORDER BY Salary DESC) AS [Rank],
DENSE_RANK() OVER (ORDER BY Salary DESC) as DenseRank
from EmpSalary

select Name, Gender, Salary,
RANK() OVER (PARTITION BY Gender ORDER BY Salary DESC) AS [Rank],
DENSE_RANK() OVER (PARTITION BY Gender ORDER BY Salary DESC) as DenseRank
from EmpSalary

--Business usecase requiring to return second highest salary requires the dense_rank
--below is an example why

select * from EmpSalary order by salary desc;

WITH Result as
(
select Salary,
RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
from EmpSalary
)
SELECT TOP 1 Salary from Result where SalaryRank = 1

--Dense_rank returns all the rankings without skipping

select * from EmpSalary order by salary desc;

WITH Result1 as
(
select Salary,
DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
from EmpSalary
)
SELECT TOP 1 Salary from Result1 where SalaryRank = 2


--To find 3rd highest salary among the female gender
--The Common Table Expressions (CTE) were introduced into standard SQL in order to simplify various classes of SQL Queries 
--for which a derived table was just unsuitable. CTE was introduced in SQL Server 2005, the common table expression (CTE) is
--a temporary named result set that you can reference within a SELECT, INSERT, UPDATE, or DELETE statement. 
--You can also use a CTE in a CREATE a view, as part of the view’s SELECT query. 
--In addition, as of SQL Server 2008, you can add a CTE to the new MERGE statement.


select * from EmpSalary order by salary desc;

WITH Result1 as
(
select Gender, Salary,
DENSE_RANK() OVER (PARTITION BY Gender ORDER BY Salary DESC) AS SalaryRank
from EmpSalary
)
SELECT TOP 1 Salary from Result1 where SalaryRank = 3 and Gender = 'Female'


--Ntile for equal portions

select Name, Gender, Salary,
NTILE(2) OVER (ORDER BY Salary DESC) AS [Ntile]
from EmpSalary

--Ntile where # of records is not a divisor of the group value, larger quartile is displayed first

select Name, Gender, Salary,
NTILE(3) OVER (ORDER BY Salary DESC) AS [Ntile]
from EmpSalary

--Ntile when specified group is greater than the number of rows
--with 10 rows in the table, ntile(11) will create 10 groups with 1 row in each group

select Name, Gender, Salary,
NTILE(11) OVER (ORDER BY Salary DESC) AS [Ntile]
from EmpSalary

--partition & Ntile

select Name, Gender, Salary,
NTILE(11) OVER (PARTITION by Gender ORDER BY Salary DESC) AS [Ntile]
from EmpSalary

--

select Name, Gender, Salary,
AVG(Salary) OVER (ORDER BY Salary DESC) AS Average
from EmpSalary

select AVG(Salary)
from EmpSalary

--without row bound

select Name, Gender, Salary,
AVG(Salary) OVER (ORDER BY Salary) AS Average,
count(Salary) OVER (ORDER BY Salary) AS [count],
sum(Salary) OVER (ORDER BY Salary) AS [sum]
from EmpSalary

--to correct what seems like cummulative aggregation
--use of ROW unbounded

select Name, Gender, Salary,
AVG(Salary) OVER (ORDER BY Salary ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Average,
count(Salary) OVER (ORDER BY Salary ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS [count],
sum(Salary) OVER (ORDER BY Salary ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS [sum]
from EmpSalary

--using partition and rows unbounded

select Name, Gender, Salary,
AVG(Salary) OVER (PARTITION BY Gender ORDER BY Salary ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Average,
count(Salary) OVER (PARTITION BY Gender ORDER BY Salary ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS [count],
sum(Salary) OVER (PARTITION BY Gender ORDER BY Salary ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS [sum]
from EmpSalary