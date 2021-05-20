# MsSQL-
SQL

One stop shop for SQL functions, analysis etc.

Rank Vs Dense_Rank

![image](https://user-images.githubusercontent.com/52436599/118962363-4b233000-b933-11eb-8e22-d97e2516284e.png)


![image](https://user-images.githubusercontent.com/52436599/118968797-56c62500-b93a-11eb-8705-8cd1eff84e68.png)

##N-Tile Function

NTILE function 
1. Introduced in SQL Server 2005
2. ORDER BY Clause is required
3. PARTITION BY clause is optional
4. Distributes the rows into a specified number of groups
5. If the number of rows is not divisible by number of groups, you may have groups of two different sizes.
6. Larger groups come before smaller groups

For example
   NTILE(2) of 10 rows divides the rows in 2 Groups (5 in each group)
   NTILE(3) of 10 rows divides the rows in 3 Groups (4 in first group, 3 in 2nd & 3rd group)

**Syntax : NTILE (Number_of_Groups) OVER (ORDER BY Col1, Col2, ...)**
