with 
    dim_payment_type as (
        select
            *
        from {{ ref('int_dim_payment_type') }}
    )

    select * from dim_payment_type