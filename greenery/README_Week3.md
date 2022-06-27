### Week 3 project
What is our overall conversion rate?

Answer: 0.6245674740484429

```with sessions_checkout as 
(
  select count(distinct session_id) counts
  from dbt_nancy_g.fact_sessions
  where is_checkout = 1
)

select counts::float / (select count(distinct session_id) from dbt_nancy_g.fact_sessions)::float
from sessions_checkout```

What is our conversion rate by product?
| product_name      | conversion_rate |
| :---              |    :----:       |
| String of pearls  | 0.60937         |
| Arrow Head        | 0.55555         |
| Cactus            | 0.54545         |

```
select *
from dbt_nancy_g.fact_product_conversion_rate
```