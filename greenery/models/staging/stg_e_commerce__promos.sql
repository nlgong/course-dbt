-- stg_e_commerce__promos.sql

with

source as (

    select * from {{ source('e_commerce','promos') }}

),

renamed as (

    select
        -- ids
        promo_id,

        --string
        status as promo_status,

        -- numeric
        discount

    from source

)

select * from renamed