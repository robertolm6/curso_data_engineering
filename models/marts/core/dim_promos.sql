with 

source as (

    select * from {{ ref('stg_sql_server_dbo__promos') }}

),

renamed as (

    select
        promo_id,
        promo_name,
        discount_dollars,
        status_id,
        _fivetran_deleted,
        _fivetran_synced

    from source
)

select * from renamed