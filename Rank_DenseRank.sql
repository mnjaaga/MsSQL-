select Name, Gender, Salary,
RANK() OVER (ORDER BY Salary DESC) AS [Rank],
DENSE_RANK() OVER (ORDER BY Salary DESC) as DenseRank
from EmpSalary