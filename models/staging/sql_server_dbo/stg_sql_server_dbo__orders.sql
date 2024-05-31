with 

source_orders as (

    select * from {{ source('sql_server_dbo', 'orders') }}

),

renamed_orders as (

    select
        order_id,
        case
            when shipping_service = '' then md5('unknown')
            else md5(shipping_service)
        end as shipping_service_id,
        shipping_cost as shipping_cost_dollars,
        address_id,
        created_at,
        case
            when promo_id = '' then md5('no promo')
            else md5(promo_id)
        end as promo_id,
        estimated_delivery_at,
        order_cost as order_cost_dollars,
        user_id,
        order_total as order_total_dollars,
        delivered_at,
        tracking_id,
        status,
        _fivetran_deleted,
        _fivetran_synced

    from source_orders

)

select * from renamed_orders

/*Cuando el shipping service es unknown, no hay fecha de entrega estimada, ni fecha de entrega, ni tracking id y el estado es preparing
  Cuando el estado es shipped, no hay fecha de entrega pero sí fecha de entrega estimada.
  Cuando el estado es delivered, todas las columnas están completas
*/
