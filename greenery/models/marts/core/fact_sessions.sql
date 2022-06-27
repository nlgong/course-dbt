{{ config(materialized = 'table') }}

select 
    session_id,
    order_id,
    s.product_id,
    product_name,
    user_id,
    is_page_view,
    is_add_to_cart,
    is_checkout,
    is_package_shipped
from {{ ref('int_sessions') }} s
left join {{ ref('dim_products') }} p
    on s.product_id = p.product_id
