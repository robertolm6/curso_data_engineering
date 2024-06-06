with 

source as (

    select * from {{ ref('stg_sql_server_dbo__shipping_service') }} 

),

renamed as (

    select
        shipping_service_id,
        shipping_service_desc
    from source
)

select * from renamed