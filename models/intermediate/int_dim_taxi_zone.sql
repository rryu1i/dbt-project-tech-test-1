with

    source as (
    
        select * from {{ ref('taxi_zone_lookup') }}

    )

    select * from source