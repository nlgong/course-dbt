-- stg_e_commerce__products.sql

with

source as (

    select * from {{ source('e_commerce','products') }}

),

renamed as (

    select
        -- ids
        product_id,

        -- strings
        name as product_name,
        
        -- numeric
        price,
        inventory

    from source

)

select * from renamed