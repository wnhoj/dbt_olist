with source as (
    select *
    from {{ source('olist', 'order_payments_dataset' )}}
),

renamed as (
    select
        order_id,
        payment_sequential,
        payment_type as payment_method,
        payment_installments,
        payment_value
    from source
)

select *
from renamed