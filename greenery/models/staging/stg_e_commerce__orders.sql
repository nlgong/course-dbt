-- stg_e_commerce__orders.sql

with

source as (

    select * from {{ source('e_commerce','orders') }}

),

renamed as (

    select
        -- ids
        order_id,
        promo_id,
        user_id,
        address_id,
        tracking_id,

        -- strings
        shipping_service,
        status as order_status,
                
        --numeric
        order_cost,
        shipping_cost,
        order_total,
                
        -- timestamp
        created_at as order_created_at,
        estimated_delivery_at,
        delivered_at

    from source

)

select * from renamed