-- finds all the Zones where there are less than 100000 trips.
select 
    zone
from {{ ref('mart__fact_all_taxi_trips') }} t
left join {{ ref('mart__dim_locations') }} l on (l.locationid = t.PUlocationID)
group by zone
having count(*) <= 100000
-- duckdb main.db -s ".read nyc_transit/target/compiled/nyc_transit/analyses/zones_with_less_than_100k_trips.sql"> answers/zones_with_less_than_100k_trips.txt