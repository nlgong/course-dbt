{{ config(materialized = 'table') }}

with product_page_views_by_date as (
    select 
        p.product_id,
        date_trunc('day', event_created_at) date_event_created_at,
        sum(case event_type when 'page_view' then 1 else 0 end) as number_of_page_views,
        sum(case event_type when 'add_to_cart' then 1 else 0 end) as number_of_purchases
from {{ ref('stg_e_commerce__products')}} as p
join {{ ref('stg_e_commerce__events')}} as e
    on p.product_id = e.product_id
group by p.product_id,
    date_trunc('day', event_created_at)
),
daily_product_page_views as (
    select
        product_id,
        avg(number_of_page_views) as daily_page_views,
        avg(number_of_purchases) as daily_purchases,
        avg(number_of_purchases) / avg(number_of_page_views) as conversion_rate
    from product_page_views_by_date
    group by product_id
)

select * from daily_product_page_views

