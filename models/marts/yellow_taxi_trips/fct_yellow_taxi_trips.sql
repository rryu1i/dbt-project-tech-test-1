with 
    cte_joined as (
        select
            a.VENDOR_ID,
            a.PICKUP_DATETIME,
            a.DROP_OFF_DATETIME,
            a.PASSENGER_COUNT,
            a.TRIP_DISTANCE,
            a.RATE_CODE_ID,
            a.STORE_AND_FWD_FLAG,
            a.PU_LOCATION_ID,
            pu.Borough as PU_BOROUGH,
            pu.Zone as PU_ZONE,
            pu.service_zone as PU_SERVICE_ZONE,
            a.DO_LOCATION_ID,
            do.Borough as DO_BOROUGH,
            do.Zone as DO_ZONE,
            do.service_zone as DO_SERVICE_ZONE,
            a.PAYMENT_TYPE,
            a.FARE_AMOUNT,
            a.EXTRA,
            a.MTA_TAX,
            a.TIP_AMOUNT,
            a.TOLLS_AMOUNT,
            a.IMPROVEMENT_SURCHARGE,
            a.TOTAL_AMOUNT,
            a.CONGESTION_SURCHARGE,
            a.AIRPORT_FEE,
            CAST(DATEDIFF(
                second,
                a.PICKUP_DATETIME,
                a.DROP_OFF_DATETIME
            )/60.0 as float) as TRIP_DURATION_MINUTES
        from {{ ref('stg_gov__yellow_taxi_trips') }} as a
        left join {{ ref('int_dim_taxi_zone') }} as pu on a.PU_LOCATION_ID = pu.LocationID
        left join {{ ref('int_dim_taxi_zone') }} as do on a.DO_LOCATION_ID = do.LocationID
        where YEAR(a.PICKUP_DATETIME) = 2022 and YEAR(a.DROP_OFF_DATETIME) = 2022  
    )
    ,
    cte_aggregated as (
        select
            VENDOR_ID,
            PICKUP_DATETIME,
            DROP_OFF_DATETIME,
            PASSENGER_COUNT,
            TRIP_DISTANCE,
            RATE_CODE_ID,
            STORE_AND_FWD_FLAG,
            PU_LOCATION_ID,
            PU_BOROUGH,
            PU_ZONE,
            PU_SERVICE_ZONE,
            DO_LOCATION_ID,
            DO_BOROUGH,
            DO_ZONE,
            DO_SERVICE_ZONE,
            PAYMENT_TYPE,
            FARE_AMOUNT,
            EXTRA,
            MTA_TAX,
            TIP_AMOUNT,
            TOLLS_AMOUNT,
            IMPROVEMENT_SURCHARGE,
            TOTAL_AMOUNT,
            CONGESTION_SURCHARGE,
            AIRPORT_FEE,
            TRIP_DURATION_MINUTES,
            ROUND(CASE 
                WHEN TRIP_DURATION_MINUTES = 0 THEN NULL 
                ELSE TRIP_DISTANCE/(TRIP_DURATION_MINUTES/60.0) 
            END, 2) as AVERAGE_SPEED_MPH
        from cte_joined
    )


    select * from cte_aggregated