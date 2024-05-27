with 

source_budget as (

    select * from {{ source('google_sheets', 'budget') }}

),

renamed_budget as (

    select
        _row as fila,
        quantity as cantidad,
        month as mes,
        product_id as id_producto,
        _fivetran_synced as carga_datos

    from source_budget

)

select * from renamed_budget
