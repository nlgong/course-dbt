### Week 1 project
(3) Answer these questions using the data available using SQL queries. You should query the dbt generated (staging) tables you have just created. For these short answer questions/queries create a separate readme file in your repo with your answers.

How many users do we have?
Answer: 130 users in the database, but only 124 of them made purchases somehow.

SQL queries:
select count(distinct user_id) from dbt_nancy_g.stg_e_commerce__orders
select count(*) from dbt_nancy_g.stg_e_commerce__users

On average, how many orders do we receive per hour?
Answer: 7.52 orders/hr

Query:
select round(avg(counts), 2) as avg_sessions_per_hr
from
    (
        select
            date_trunc('hour', order_created_at) "hour", count(distinct order_id) counts
        from dbt_nancy_g.stg_e_commerce__orders
        group by 1
    ) a

On average, how long does an order take from being placed to being delivered?
Answer: 3 days 21 hours 24 min

Query:
select
    sum(delivered_at - order_created_at),
    sum(1),
    (sum(delivered_at - order_created_at) / sum(1))::interval
from dbt_nancy_g.stg_e_commerce__orders
where delivered_at is not null

How many users have only made one purchase? Two purchases? Three+ purchases?
Answer: 25 users made one purchase, 28 made two purchases and 71 made three+ purchases.

Query:
select purchase_number, count(distinct user_id) user_counts
from
    (
        select
            user_id,
            case
                when counts = 1
                then 'one purchase'
                when counts = 2
                then 'two purchases'
                when counts >= 3
                then 'three+ purchases'
            end as purchase_number
        from
            (
                select user_id, count(distinct order_id) counts
                from dbt_nancy_g.stg_e_commerce__orders
                group by user_id
            ) a
    ) b


On average, how many unique sessions do we have per hour?
Answer: 16.33 sessions/hr

Query:
select round(avg(counts), 2) as avg_sessions_per_hr
from
    (
        select
            date_trunc('hour', event_created_at) "hour",
            count(distinct session_id) counts
        from dbt_nancy_g.stg_e_commerce__events
        group by 1
    ) a
