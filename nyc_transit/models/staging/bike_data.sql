with source as (

    select * from {{ source('main', 'bike_data') }}

),

renamed as (
    
    select
        tripduration::int as tripduration,
        COALESCE(starttime, started_at)::timestamp as start_time,
        COALESCE(stoptime, ended_at)::timestamp as end_time,
        COALESCE("start station id", start_station_id) as start_station_id,
        COALESCE("start station name", start_station_name) as start_station_name,
        COALESCE("start station latitude", start_lat)::double as start_station_latitude,
        COALESCE("start station longitude", start_lng)::double as start_station_longitude,
        COALESCE("end station id", end_station_id) as end_station_id,
        COALESCE("end station name", end_station_name) as end_station_name,
        COALESCE("end station latitude", end_lat)::double as end_station_latitude,
        COALESCE("end station longitude", end_lng)::double as end_station_longitude,
        bikeid,
        "birth year"::int as birth_year,
        case
            when gender = '0' then 'unknown'
            when gender = '1' then 'male'
            when gender = '2' then 'female'
            else NULL
        end as gender,
        ride_id,
        rideable_type,
        member_casual,
        filename

    from source

    where 
        tripduration > 0 AND 
        COALESCE(starttime, started_at) <= '2022-12-31' AND 
        COALESCE(stoptime, ended_at) <= '2022-12-31'
)

select * from renamed