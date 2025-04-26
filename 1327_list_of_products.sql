select product_name,sum(unit) as unit from products p
inner join orders o on p.product_id=o.product_id
where o.order_date like '2020-02%'
group by 1 having sum(unit)>=100 order by 1;
