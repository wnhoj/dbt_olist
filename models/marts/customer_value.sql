with payments as (
    select *
    from {{ ref('int_order_payments') }}
),

orders as (
    select * 
    from {{ ref('int_orders') }}
)

select 
  o.customer_id,
  sum(case 
    when order_status in ('delivered', 'invoice') then p.total_payment_value
    else 0
  end ) as completed_order_value,
  sum(case 
    when order_status in ('created', 'approved', 'processing', 'shipped') then p.total_payment_value
    else 0
  end ) as pending_order_value,
  sum(case
    when order_status in ('canceled', 'unavailable') then p.total_payment_value
    else 0
  end ) as lost_order_value,
  count(distinct o.order_id) as number_of_orders,
  min(date(o.order_purchase_timestamp)) as first_order_date,
  max(date(o.order_purchase_timestamp)) as last_order_date
from orders o 
left join payments p 
  on o.order_id = p.order_id
group by o.customer_id