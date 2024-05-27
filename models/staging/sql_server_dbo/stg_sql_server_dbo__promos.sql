with 

source_promos as (

    select * from {{ source('sql_server_dbo', 'promos') }}

),

renamed_promos as (

    select
        promo_id,
        discount,
        status,
        _fivetran_deleted,
        _fivetran_synced

    from source_promos

)

select * from renamed_promos
