with 

source_products as (

    select * from {{ source('sql_server_dbo', 'products') }}

),

renamed_products as (

    select
        product_id,
        price,
        name,
        inventory,
        _fivetran_deleted,
        _fivetran_synced

    from source_products

)

select * from renamed_products
