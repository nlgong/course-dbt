{{ config(materialized = 'table') }}

select 
    date_trunc('month', order_created_at) month_order_created_at,
    count(order_id) as order_counts,
    count(case when promo_id is not null then 1 else 0 end) as promo_order_counts,
    sum(order_cost) as sum_order_cost,
    avg(order_cost) as avg_order_cost,
    sum(shipping_cost) as sum_shipping_cost,
    avg(shipping_cost) as avg_shipping_cost
from {{ ref('stg_e_commerce__orders') }} o
group by date_trunc('month', order_created_at)