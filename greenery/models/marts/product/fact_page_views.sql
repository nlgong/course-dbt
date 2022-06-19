{{ config(materialized = 'table') }}

select 
    ppv.product_id,
    product_name,
    price,
    daily_page_views,
    daily_purchases,
    conversion_rate
from {{ ref('int_product_page_views_agg') }} ppv
join {{ ref('dim_products') }} p
    on ppv.product_id = p.product_id