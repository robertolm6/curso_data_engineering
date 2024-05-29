SELECT *
FROM {{ ref('stg_sql_server_dbo__orders') }}
WHERE delivered_at < created_at
/* comprueba si hay algún caso en el que la fecha de entrega sea anterior a la fecha en que se realizó el pedido, lo que no tendría sentido lógico e indicaría algún tipo de problema con los datos */
