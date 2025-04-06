create database windowfunction;

create schema practice;

create table employee
( emp_ID int
, emp_NAME varchar(50)
, DEPT_NAME varchar(50)
, SALARY int);

insert into employee values(101, 'Mohan', 'Admin', 4000);
insert into employee values(102, 'Rajkumar', 'HR', 3000);
insert into employee values(103, 'Akbar', 'IT', 4000);
insert into employee values(104, 'Dorvin', 'Finance', 6500);
insert into employee values(105, 'Rohit', 'HR', 3000);
insert into employee values(106, 'Rajesh',  'Finance', 5000);
insert into employee values(107, 'Preet', 'HR', 7000);
insert into employee values(108, 'Maryam', 'Admin', 4000);
insert into employee values(109, 'Sanjay', 'IT', 6500);
insert into employee values(110, 'Vasudha', 'IT', 7000);
insert into employee values(111, 'Melinda', 'IT', 8000);
insert into employee values(112, 'Komal', 'IT', 10000);
insert into employee values(113, 'Gautham', 'Admin', 2000);
insert into employee values(114, 'Manisha', 'HR', 3000);
insert into employee values(115, 'Chandni', 'IT', 4500);
insert into employee values(116, 'Satya', 'Finance', 6500);
insert into employee values(117, 'Adarsh', 'HR', 3500);
insert into employee values(118, 'Tejaswi', 'Finance', 5500);
insert into employee values(119, 'Cory', 'HR', 8000);
insert into employee values(120, 'Monica', 'Admin', 5000);
insert into employee values(121, 'Rosalin', 'IT', 6000);
insert into employee values(122, 'Ibrahim', 'IT', 8000);
insert into employee values(123, 'Vikram', 'IT', 8000);
insert into employee values(124, 'Dheeraj', 'IT', 11000);


select count(*) from employee;

select top 10 * from employee;


select max(salary) as maximum_salary,dept_name from employee group by dept_name order by maximum_salary ; 


select e.*,
max(salary) over(partition by dept_name)
from employee e order by dept_name;


--Row_number

select e.*,
row_number() over(order by dept_name) as a
from
employee e;


select e.*,
row_number() over(partition by dept_name order by dept_name) as a
from
employee e;


Questions 

Fetch department wise, 2 employees who joined first to the organization

select Emp_id,emp_name,dept_name from (
select e.*,
row_number() over(partition by dept_name order by emp_id) as a
from employee e)
where a in (1,2);

EMP_ID	EMP_NAME	DEPT_NAME
101	Mohan	Admin
108	Maryam	Admin
104	Dorvin	Finance
106	Rajesh	Finance
102	Rajkumar	HR
105	Rohit	HR
103	Akbar	IT
109	Sanjay	IT

Top 3 employees from each department having top 3 salaries by using row_number()

select Emp_id,emp_name,dept_name,salary from (
select a.*,
row_number() over(partition by dept_name order by salary desc)as b
from employee as a) where b in (1,2,3);

Top 3 employees from each department having top 3 salaries by using rank()

select emp_id,emp_name,dept_name,salary from 
(select a.*,
rank() over(partition by dept_name order by salary desc) as b from employee as a)
where b<4;

select c.*,
rank() over(partition by dept_name order by salary desc) as rank1 ,
dense_rank() over(partition by dept_name order by salary desc) as dense_rank1 ,
row_number() over(partition by dept_name order by salary desc) as row_number1 from employee as c



Write a query to fetch if the salary of the employee is higher,lower or equal to the previous employee as per the department.

select emp_id,emp_name,
case 
    when salary<prev_sal then 'Salary is higher'
    when salary>prev_sal then 'Salary is lower'
    when salary=prev_sal then 'Salary is same'
    when prev_sal is null then 'There is no previous salary'
end as Salary_status
from
    (
select a.*,
lag(salary) over(partition by dept_name order by salary) as prev_sal
from employee as a
    ) as a;

or 

select a.*,
lag(salary,1,0) over(partition by dept_name order by salary) as prev_sal,
case 
    when salary<lag(salary) over(partition by dept_name order by salary) then 'Salary is higher'
    when salary>lag(salary) over(partition by dept_name order by salary) then 'Salary is lower'
    when salary=lag(salary) over(partition by dept_name order by salary) then 'Salary is same'
    when prev_sal=0 then 'There is no previous salary'
end as Salary_status
from employee as a;

