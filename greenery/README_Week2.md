### Week 2 project
What is our user repeat rate?

```with user_orders as (
select 
    user_id, 
    count(order_id) as order_counts
from dbt_nancy_g.stg_e_commerce__orders
group by user_id
),
user_buckets as (
select 
user_id, 
order_counts = 1 as has_one_order,
order_counts > 1 as "has_>=two_order"
from user_orders
)
select round((select count(*) from user_buckets 
where "has_>=two_order" is true)::numeric(10, 2) / count(*), 3)
from user_buckets```

What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

Good indicators of a user likely to purchase again:
1. High monthly/quarterly/annual order numbers
2. High monthly/quarterly/annual total dollar spent
3. The recent date for order is very recent
4. High monthly/quarterly/annual session numbers

The opposite indictors would indicator that a user is not likely to purchase again

If having more data, I would look into features such as 
1. Cancellation of orders or not
2. Return certain or all items or not
3. Reviews given
3. If inquiries on more products or not