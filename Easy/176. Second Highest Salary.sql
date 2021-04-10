/*Write a SQL query to get the second highest salary from the Employee table.
+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
For example, given the above Employee table, the query should return 200 as the second highest salary. If there is no second highest salary, 
then the query should return null.
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+ */

# wrong output
with cte as (select salary, row_number() over (order by salary desc) from employee limit 1 offset 1)
select IFNULL(salary,null) as 'SecondHighestSalary' from cte

# wrong output
with cte as (select salary, row_number() over (order by salary desc) from employee)
select IFNULL(salary,null) as 'SecondHighestSalary' from cte limit 1 offset 1

# wrong output
select IFNULL(salary,null) as 'SecondHighestSalary' from employee order by salary desc limit 1 offset 1

# wrong output
select case when row_num != 2 then null else salary end as SecondHighestSalary 
from (select salary, row_number() over (order by salary desc) row_num from employee) t where row_num=2

# correct output
select IFNULL((select 
              max(salary)  from employee 
              where salary < (select max(salary) from employee)), null) as SecondHighestSalary
