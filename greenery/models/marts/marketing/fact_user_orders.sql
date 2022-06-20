{{ config(materialized = 'table') }}

select 
    uo.user_id,
    first_name,
    last_name,
    email,
    phone_number,
    state,
    country,
    order_counts,
    promo_order_counts,
    sum_order_cost,
    avg_order_cost,
    sum_shipping_cost,
    avg_shipping_cost,
    order_counts_in_recent_month,
    order_counts_in_recent_6_months,
    sum_order_cost_in_recent_month,
    sum_order_cost_in_recent_6_months,
    min_order_date,
    max_order_date
from {{ ref('int_user_order_agg')}} as uo
join {{ ref('dim_users')}} as u
    on uo.user_id = u.user_id
