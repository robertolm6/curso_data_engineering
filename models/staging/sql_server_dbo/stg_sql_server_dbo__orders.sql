
{{
  config(
    materialized='view'
  )
}}

with 

source_orders as (

    select * from {{ source('sql_server_dbo', 'orders') }}

),

renamed_orders as (

    select
        order_id,
        shipping_service,
        shipping_cost,
        address_id,
        created_at,
        promo_id,
        estimated_delivery_at,
        order_cost,
        user_id,
        order_total,
        delivered_at,
        tracking_id,
        status,
        _fivetran_deleted as deleted,
        _fivetran_synced as date_load

    from source_orders

)

select * from renamed_orders
