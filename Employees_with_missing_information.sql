select employee_id from employees where employee_id not in
(select a.employee_id from employees as a join
Salaries as b on a.employee_id=b.employee_id)

 union

 select employee_id from salaries where employee_id not in
(select a.employee_id from employees as a join
Salaries as b on a.employee_id=b.employee_id)

 order by employee_id;
