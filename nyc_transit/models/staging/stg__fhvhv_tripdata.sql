with source as (

    select * from {{ source('main', 'fhvhv_tripdata') }}

),

renamed as (

    select
        hvfhs_license_num,
        dispatching_base_num,
        originating_base_num,
        request_datetime,
        on_scene_datetime,
        pickup_datetime,
        dropoff_datetime,
        pulocationid,
        dolocationid,
        trip_miles,
        trip_time,
        base_passenger_fare,
        tolls,
        bcf,
        sales_tax,
        congestion_surcharge,
        airport_fee,
        tips,
        driver_pay,
        {{to_boolean("shared_request_flag")}} as shared_request_flag,
        {{to_boolean("shared_match_flag")}} as shared_match_flag,
        {{to_boolean("access_a_ride_flag")}} as access_a_ride_flag,
        {{to_boolean("wav_request_flag")}} as wav_request_flag,
        {{to_boolean("wav_match_flag")}} as wav_match_flag,
        filename

    from source
    where trip_miles >= 0
    and request_datetime <= '2022-12-31'
    and on_scene_datetime <= '2022-12-31'
    and pickup_datetime <= '2022-12-31'
    and dropoff_datetime <= '2022-12-31'

)

select * from renamed