with

    payment_type as (
    
        select distinct PAYMENT_TYPE from {{ ref('stg_gov__yellow_taxi_trips') }}

    ),

    payment_type_descriptions as (
        select
            PAYMENT_TYPE
            , case
                when PAYMENT_TYPE = 0 then 'Flex Fare trip'
                when PAYMENT_TYPE = 1 then 'Credit card'
                when PAYMENT_TYPE = 2 then 'Cash'
                when PAYMENT_TYPE = 3 then 'No charge'
                when PAYMENT_TYPE = 4 then 'Dispute'
                when PAYMENT_TYPE = 5 then 'Unkwnown'
                when PAYMENT_TYPE = 6 then 'Voided trip'
                else 'Missing description'
            end as PAYMENT_TYPE_DESCRIPTION

        from payment_type
    )

    select * from payment_type_descriptions