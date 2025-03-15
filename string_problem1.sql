
with cte as (
select * ,len(customer_name)-len(replace(customer_name,' ','')) as leng,
charindex(' ',customer_name) as first_space,
charindex(' ',customer_name,charindex(' ',customer_name)+1) as second_space

from customers)

select *,
case when leng=0 then customer_name
else substr(customer_name,0,first_space)
end as first_name,

case when leng>=1 then substr(customer_name,first_space+1,second_space-first_space)
else null
end as second_name,

case when leng>=2 then substr(customer_name,second_space+1,len(customer_name)-second_space)
else null
end as last_name

from cte
