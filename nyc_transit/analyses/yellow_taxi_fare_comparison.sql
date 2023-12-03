-- compare an individual fare to the zone, 
-- borough and overall average fare using the fare_amount in yellow taxi trip data
select 
        l.zone,
        t.fare_amount, 
    avg(t.fare_amount) over (partition by l.borough) as average_fare_borough,
    avg(t.fare_amount) over (partition by l.zone, l.borough) as average_fare_zone_borough,
    avg(t.fare_amount) over () as overall_average_fare
from {{ ref('stg__yellow_tripdata') }} t
join {{ ref('mart__dim_locations') }} l on (t.pulocationid = l.locationid)
limit 300

-- duckdb main.db -s ".read nyc_transit/target/compiled/nyc_transit/analyses/yellow_taxi_fare_comparison.sql"> answers/yellow_taxi_fare_comparison.txt