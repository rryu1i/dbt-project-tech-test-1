with

    vendors as (
    
        select distinct VENDOR_ID from {{ ref('stg_gov__yellow_taxi_trips') }}

    ),

    vendors_descriptions as (
        select
            VENDOR_ID
            , case
                when VENDOR_ID = 1 then 'Creative Mobile Technologies, LLC'
                when VENDOR_ID = 2 then 'Curb Mobility, LLC'
                when VENDOR_ID = 6 then 'Myle Technologies Inc'
                when VENDOR_ID = 7 then 'Helix'
                else 'Missing description'
            end as VENDOR_DESCRIPTION

        from vendors
    )

    select * from vendors_descriptions