with 
    dim_rate_code as (
        select
            *
        from {{ ref('int_dim_rate_code') }}
    )

    select * from dim_rate_code