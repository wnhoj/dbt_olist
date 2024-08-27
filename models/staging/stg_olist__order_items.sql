with source as (
    select *
    from {{ source('olist', 'order_items_dataset') }}
),

renamed as (
    select
        order_id,
        order_item_id,
        product_id,
        seller_id,
        shipping_limit_date as shipping_limit_timestamp,
        price as item_price,
        freight_value as item_freight_value
    from source
)

select *
from renamed