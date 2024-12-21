Top Travellers Leetcode


# Write your MySQL query statement below
select u.name,
CASE 
        WHEN sum(r.distance) is null then 0
        WHEN sum(r.distance) is not null then sum(r.distance)
END as travelled_distance
 from users u
    left join
rides r 
    on u.id=r.user_id
group by u.id order by 2 desc, 1 asc;
