-- stg_e_commerce__events.sql

with

source as (

    select * from {{ source('e_commerce','events') }}

),

renamed as (

    select
        -- ids
        event_id,
        session_id,
        user_id,
        order_id,
        product_id

        -- strings
        event_type,
        page_url,
                
        -- timestamp
        created_at as event_created_at

    from source

)

select * from renamed