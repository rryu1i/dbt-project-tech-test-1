with

    rate_code as (
    
        select distinct RATE_CODE_ID from {{ ref('stg_gov__yellow_taxi_trips') }}

    ),

    rate_code_descriptions as (
        select
            RATE_CODE_ID
            , case
                when RATE_CODE_ID = 1 then 'Standard rate'
                when RATE_CODE_ID = 2 then 'JFK'
                when RATE_CODE_ID = 3 then 'Newark'
                when RATE_CODE_ID = 4 then 'Nassau or Westchester'
                when RATE_CODE_ID = 5 then 'Negotiated fare'
                when RATE_CODE_ID = 6 then 'Group ride'
                when RATE_CODE_ID = 99 then 'Null/unkwnown'
                else 'N/A'
            end as RATE_CODE_DESCRIPTION

        from rate_code
    )

    select * from rate_code_descriptions