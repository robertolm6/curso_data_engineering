with 

source as (

        select status from {{ source('sql_server_dbo', 'orders') }} 

),

renamed as (

    select
        md5(status) as order_status_id,
        status as order_status
    from source
    group by status
)

select * from renamed