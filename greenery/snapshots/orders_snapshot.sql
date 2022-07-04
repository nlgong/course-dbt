{% snapshot orders_snapshot %}

{{
    config(
      target_database='dbt',
      target_schema='dbt_nancy_g',
      unique_key='order_id',

      strategy='check',
      check_cols='all',
    )
}}

select * from {{ source('e_commerce', 'orders') }}

{% endsnapshot %}