### Week 2 project
What is our user repeat rate?
'''
with user_orders as (
select user_id, count(order_id) order_counts
from dbt_nancy_g.stg_e_commerce__orders
group by user_id
),
user_buckets as (
select user_id, 
order_counts = 1 as has_one_order,
order_counts > 1 as "has_>=two_order"
from user_orders
)
select round((select count(*) from user_buckets where "has_>=two_order" is true)::numeric(10, 2) / count(*), 3)
from user_buckets'''


What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

NOTE: This is a hypothetical question vs. something we can analyze in our Greenery data set. Think about what exploratory analysis you would do to approach this question.