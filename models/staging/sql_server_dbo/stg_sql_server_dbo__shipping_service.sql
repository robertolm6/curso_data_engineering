with 

source_shipping_service as (

    select shipping_service from {{ source('sql_server_dbo', 'orders') }}

),

renamed_shipping_service as (

    select distinct
        case
            when shipping_service = '' then md5('unknown')
            else md5(shipping_service)
        end as shipping_service_id,
        case
            when shipping_service = '' then 'unknown'
            else shipping_service
        end as shipping_service_desc

    from source_shipping_service
)

select * from renamed_shipping_service