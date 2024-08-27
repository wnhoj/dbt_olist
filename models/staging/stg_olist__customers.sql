with source as (
    select *
    from {{ source('olist', 'customers_dataset') }}
),

renamed as (
    select 
        customer_id as order_customer_id,
        customer_unique_id as customer_id,
        customer_zip_code_prefix as customer_zip_code,
        customer_city,
        customer_state
    from source
)

select *
from renamed