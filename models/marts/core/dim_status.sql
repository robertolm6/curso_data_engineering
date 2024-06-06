with 

source as (

    select * from {{ ref('stg_sql_server_dbo__status') }} 

),

renamed as (

    select
        status_id,
        status_desc
    from source
)

select * from renamed