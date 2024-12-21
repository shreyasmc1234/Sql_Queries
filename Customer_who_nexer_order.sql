select name "Customers" from Customers where id not in
(select customers.id
from Customers inner join Orders on customers.id=orders.customerid)

