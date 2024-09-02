with orders as (
  select *
  from {{ ref('int_orders') }}
), 

payments as (
  select *
  from {{ ref('int_order_payments') }}
)

select 
  extract(year from o.order_purchase_timestamp) as order_year,
  extract(week from o.order_purchase_timestamp) as order_week,
  count(o.order_id) as number_of_orders,
  round(sum(ifnull(p.total_payment_value, 0)),2) as sales_value
from orders o
left join payments p
  on o.order_id = p.order_id
where order_status != 'canceled' and order_status != 'unavailable'
group by order_year, order_week
order by order_year desc, order_week desc