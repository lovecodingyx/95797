-- Calculate the number of trips and average duration by borough and zone
select l.Borough, l.Zone,
    count(*) as all_trips,
    avg(duration_min) as avg_dur_min,
    avg(duration_sec) as avg_dur_sec
from {{ ref('mart__fact_all_taxi_trips') }} t
join {{ ref('mart__dim_locations') }} l on t.pulocationid = l.locationid
group by l.Borough, l.Zone

-- duckdb main.db -s ".read nyc_transit/target/compiled/nyc_transit/analyses/trips_duration_grouped_by_borough_zone.sql"> answers/trips_duration_grouped_by_borough_zone.txt