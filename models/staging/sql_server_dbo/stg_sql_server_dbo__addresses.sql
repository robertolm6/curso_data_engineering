
{{
  config(
    materialized='view'
  )
}}

with 

source_addresses as (

    select * from {{ source('sql_server_dbo', 'addresses') }}

),

renamed_addresses as (

    select
        address_id,
        zipcode,
        country,
        address,
        state,
        _fivetran_deleted as deleted,
        _fivetran_synced as date_load

    from source_addresses

)

select * from renamed_addresses
