{{ config(materialized = 'table') }}

select 
    month_order_created_at,
    order_counts,
    promo_order_counts,
    sum_order_cost,
    avg_order_cost,
    sum_shipping_cost,
    avg_shipping_cost
from {{ ref('int_orders_agg') }}
order by 1