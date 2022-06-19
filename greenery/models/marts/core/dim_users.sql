{{ config(materialized = 'table') }}

select 
    user_id,
    first_name,
    last_name,
    email,
    phone_number,
    state,
    country
from {{ ref('int_users') }} 