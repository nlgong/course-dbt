-- stg_e_commerce__users.sql

with

source as (

    select * from {{ source('e_commerce','users') }}

),

renamed as (

    select
        -- ids
        user_id,
        address_id,

        -- strings
        first_name,
        last_name,
        email,
        phone_number,
        
        -- dates
        date_trunc('day', created_at) as created_date,

        -- timestamps
        created_at as user_created_at,
        updated_at as user_updated_at

    from source

)

select * from renamed