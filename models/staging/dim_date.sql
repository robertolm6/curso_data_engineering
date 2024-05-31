with date_spine as (
{{ dbt_utils.date_spine(
    datepart="day",
    start_date="cast('2020-01-01' as date)",
    end_date="cast('2024-01-01' as date)"
   )
}}
),

dim_date as (
    select

    date_day as date,
    extract(day from date_day) as day,
    extract(month from date_day) as month,
    extract(year from date_day) as year

    from date_spine
)

select * from dim_date