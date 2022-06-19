{{ config(materialized = 'table') }}

select 
    user_id,
    first_name,
    last_name,
    email,
    phone_number,
    state,
    country
from {{ ref('stg_e_commerce__users') }} as u
join {{ ref('stg_e_commerce__addresses') }} as a
    on u.address_id = a.address_id