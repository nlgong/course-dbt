with delivered_at_test (
    select count(*) as counts
    from {{ ref('stg_e_commerce_orders') }}
    where delivered_at is not NULL
    and delivered_at < order_created_at
)

select * from delivered_at_test where counts > 0  