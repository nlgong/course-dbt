{{ config(materialized = 'table') }}

select
    user_id,
    count(order_id) as order_counts,
    count(case when promo_id is not null then 1 else 0 end) as promo_order_counts,
    sum(order_cost) as sum_order_cost,
    avg(order_cost) as avg_order_cost,
    sum(shipping_cost) as sum_shipping_cost,
    avg(shipping_cost) as avg_shipping_cost,
    sum(case when order_created_at >= date_trunc('day', current_date - interval '1 month') then 1 else 0 end) as order_counts_in_recent_month,
    sum(case when order_created_at >= date_trunc('day', current_date - interval '6 months') then 1 else 0 end) as order_counts_in_recent_6_months,
    sum(case when order_created_at >= date_trunc('day', current_date - interval '1 month') then order_cost else 0 end) as sum_order_cost_in_recent_month,
    sum(case when order_created_at >= date_trunc('day', current_date - interval '6 months') then order_cost else 0 end) as sum_order_cost_in_recent_6_months,
    min(date_trunc('day', order_created_at)) as min_order_date,
    max(date_trunc('day', order_created_at)) as max_order_date
from {{ ref('stg_e_commerce__orders')}}
group by user_id
