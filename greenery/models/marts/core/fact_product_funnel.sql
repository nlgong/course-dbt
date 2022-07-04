{{ config(materialized = 'table') }}

with sessions as (
    select
        {{ session_counts('is_page_view') }},
        {{ session_counts('is_add_to_cart') }},
        {{ session_counts('is_checkout') }}
    from {{ ref('int_sessions') }}
),
funnels as (
    select
        1 as funnel_stage1,
        cast(is_add_to_cart_counts::float/is_page_view_counts::float as numeric(5, 3)) as funnel_stage2,
        cast(is_checkout_counts::float/is_page_view_counts::float as numeric(5, 3)) as funnel_stage3
    from sessions
)
select * from funnels