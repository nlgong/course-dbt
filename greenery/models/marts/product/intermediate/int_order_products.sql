{{ config(materialized = 'table') }}

with order_products as (
    select 
        o.order_id,
        p.product_id,
        e.session_id
    from {{ ref('stg_e_commerce__orders')}} as o
    join {{ ref('stg_e_commerce__order_items')}} as oi
        on o.order_id = oi.order_id
    join {{ ref('stg_e_commerce__products')}} as p
        on oi.product_id = p.product_id
    join {{ ref('stg_e_commerce__events')}} as e
        on o.order_id = e.order_id
)

select * from order_products