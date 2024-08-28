with payments as (
    select *
    from {{ ref('stg_olist__payments') }}
)

select
  order_id,
  count(*) as total_number_of_payments,
  sum(payment_value) as total_payment_value
from payments
group by order_id