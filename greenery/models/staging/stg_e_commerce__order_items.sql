-- stg_e_commerce__order_items.sql

with

source as (

    select * from {{ source('e_commerce','order_items') }}

),

renamed as (

    select
        -- ids
        {{ dbt_utils.surrogate_key(['order_id', 'product_id']) }} as order_item_id,
        order_id,
        product_id,

        -- numeric
        quantity

    from source

)

select * from renamed