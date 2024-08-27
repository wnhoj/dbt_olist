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
        order_estimated_delivery_date as order_est_delivery_timestamp,

        -- Steps in purchase -> delivery process
        timestamp_diff(order_approved_at, order_purchase_timestamp, minute) as minutes_purchase_to_approval,
        timestamp_diff(order_delivered_carrier_date, order_approved_at, minute) as minutes_approval_to_carrier,
        timestamp_diff(order_delivered_customer_date, order_delivered_carrier_date, minute) as minutes_carrier_to_delivered,
        timestamp_diff(order_delivered_customer_date, order_purchase_timestamp, day) as days_purchase_to_delivery,

        -- Comparing estimated to actual delivery
        timestamp_diff(order_estimated_delivery_date,order_delivered_customer_date, day) as days_estimated_vs_actual_delivery

    from source
)

select *
from renamed