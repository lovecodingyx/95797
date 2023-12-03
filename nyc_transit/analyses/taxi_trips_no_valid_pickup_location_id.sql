-- finds taxi trips which don’t have a pick up location_id in the locations table
select 
    *
from {{ ref('mart__fact_all_taxi_trips') }} t
left join {{ ref('mart__dim_locations') }} l on (l.locationid = t.PUlocationID)
where l.locationid is null

-- duckdb main.db -s ".read nyc_transit/target/compiled/nyc_transit/analyses/taxi_trips_no_valid_pickup_location_id.sql"> answers/no_valid_pickup_location_id.txt