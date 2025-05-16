with 
    dim_taxi_zone as (
        select
            *
        from {{ ref('int_dim_taxi_zone') }}
    )

    select * from dim_taxi_zone