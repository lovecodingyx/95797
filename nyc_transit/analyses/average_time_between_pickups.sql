-- Find the average time between taxi pick ups per zone
with TaxiZonePickups as (
    select
        l.zone,
        t.pickup_datetime,
        lead(t.pickup_datetime) over (partition by l.zone order by t.pickup_datetime) as next_pickup_time
    from 
        {{ ref('mart__fact_all_taxi_trips') }} as t
    inner join 
        {{ ref('mart__dim_locations') }} as l on t.pulocationid = l.locationid
),
TimeDifferences as (
    select
        zone,
        pickup_datetime,
        next_pickup_time,
        extract(epoch from (next_pickup_time - pickup_datetime)) as seconds_between_pickups
    from TaxiZonePickups
)
select
    zone,
    avg(seconds_between_pickups) as avg_seconds_between_pickups
from TimeDifferences
group by zone;

-- duckdb main.db -s ".read nyc_transit/target/compiled/nyc_transit/analyses/average_time_between_pickups.sql"> answers/average_time_between_pickups.txt