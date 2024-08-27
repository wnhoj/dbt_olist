with source as (
    select *
    from {{ source('olist', 'sellers_dataset')}}
),

renamed as (
    select 
        seller_id,
        seller_zip_code_prefix as seller_zip_code,
        seller_city,
        seller_state
    from source
)

select *
from renamed