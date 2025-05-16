with

    source as (
    
        select * from {{ source('gov', 'yellow_taxi_trip_records') }}

    )

    , renamed as (

        select

            VendorID as VENDOR_ID
            , tpep_pickup_datetime as PICKUP_DATETIME
            , tpep_dropoff_datetime as DROP_OFF_DATETIME
            , passenger_count as PASSENGER_COUNT
            , trip_distance as TRIP_DISTANCE
            , CASE WHEN payment_type = 0 and RatecodeID is null then 0 else RatecodeID end as RATE_CODE_ID
            , store_and_fwd_flag as STORE_AND_FWD_FLAG
            , PULocationID as PU_LOCATION_ID
            , DOLocationID as DO_LOCATION_ID
            , payment_type as PAYMENT_TYPE
            , fare_amount as FARE_AMOUNT
            , extra as EXTRA
            , mta_tax as MTA_TAX
            , tip_amount as TIP_AMOUNT
            , tolls_amount as TOLLS_AMOUNT
            , improvement_surcharge as IMPROVEMENT_SURCHARGE
            , total_amount as TOTAL_AMOUNT
            , congestion_surcharge as CONGESTION_SURCHARGE
            , airport_fee as AIRPORT_FEE

        from source

    )

select * from renamed