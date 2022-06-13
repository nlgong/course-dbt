-- stg_e_commerce__addresses.sql

with

source as (

    select * from {{ source('e_commerce','addresses') }}

),

renamed as (

    select
        -- ids
        address_id,

        -- strings
        address,
        state,
        country,
        
        -- numeric
        zipcode

    from source

)

select * from renamed