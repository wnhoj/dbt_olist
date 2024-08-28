with customers as (
    select *
    from {{ ref('stg_olist__customers') }}
),

orders as (
    select *
    from {{ ref('stg_olist__orders') }}
)

select 
  c.customer_id,
  o.*
from orders o 
join customers c 
  on o.order_customer_id = c.order_customer_id