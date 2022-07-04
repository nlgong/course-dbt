{{ config(materialized = 'table') }}

{% set event_types = dbt_utils.get_column_values(
        table=ref('stg_e_commerce__events'),
        column='event_type'
) 
%}

select 
    date_trunc('day', event_created_at) as date_event_created,
    session_id,
    order_id,
    product_id,
    user_id,
    {%- for event_type in event_types %}
    case when event_type = '{{event_type}}' then 1 else 0 end as is_{{event_type}}{% if not loop.last %},{% endif %}
    {% endfor %}
from {{ ref('stg_e_commerce__events') }}