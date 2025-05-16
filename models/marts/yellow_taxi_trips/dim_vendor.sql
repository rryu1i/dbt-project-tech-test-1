with 
    dim_vendor as (
        select
            *
        from {{ ref('int_dim_vendor') }}
    )

    select * from dim_vendor