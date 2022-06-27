{{ config(materialized = 'table') }}

with product_sessions as (
    select 
        fs.product_id,
        fs.product_name,
        fs.session_id,
        is_page_view,
        case when iop.product_id is not null then 1 else 0 end is_purchased
    from {{ ref('fact_sessions') }} fs
    left join {{ ref('int_order_products') }} iop
        on fs.session_id = iop.session_id
            and fs.product_id = iop.product_id
    where fs.product_id is not null
),
product_sessions_agg as (
    SELECT
        product_id,
        product_name,
        count(distinct case when is_page_view = 1 then session_id else null end) view_sessions,
        count(distinct case when is_purchased = 1 then session_id else null end) order_sessions
    from product_sessions
    group by product_id,
        product_name
),
product_conversion_rate as (
    SELECT
        product_id,
        product_name,
        case when view_sessions = 0 then 0 else order_sessions::float / view_sessions::float end as conversion_rate
    from product_sessions_agg
)

select * from product_conversion_rate order by 3 desc