with source as (
    select *
    from {{ source('olist', 'products_dataset') }}
),

renamed as (
    select
        product_id,
        product_category_name as product_category,
        product_name_lenght as product_name_length,
        product_description_lenght as product_description_length,
        product_photos_qty,
        product_weight_g,
        product_length_cm,
        product_width_cm,
        product_height_cm
    from source
)

select *
from renamed