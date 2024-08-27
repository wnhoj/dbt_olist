with source as (
    select *
    from {{ source('olist', 'orders_dataset') }}
),

renamed as (
    select
        order_id,
        customer_id as order_customer_id,
        order_status,
        order_purchase_timestamp,
        order_approved_at as order_approved_timestamp,
        order_delivered_carrier_date as order_delivered_carrier_timestamp,
        order_delivered_customer_date as order_delivered_timestamp,
        order_estimated_delivery_date as order_est_delivery_timestamp
    from source
)

select *
from renamed