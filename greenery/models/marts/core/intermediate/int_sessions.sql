{{ config(materialized = 'table') }}

select 
    session_id,
    order_id,
    product_id,
    user_id,
    case event_type when 'page_view' then 1 else 0 end as is_page_view,
    case event_type when 'add_to_cart' then 1 else 0 end as is_add_to_cart,
    case event_type when 'checkout' then 1 else 0 end as is_checkout,
    case event_type when 'package_shipped' then 1 else 0 end as is_package_shipped
from {{ ref('stg_e_commerce__events') }}