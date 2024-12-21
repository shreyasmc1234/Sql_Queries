select name "Customers" from Customers where id not in
(select customers.id
from Customers inner join Orders on customers.id=orders.customerid);


select name as Customers
from Customers c left join Orders o on c.id=o.customerid
where o.customerid is null;

select name as Customers
from Customers where id not in (select customerid from orders);

