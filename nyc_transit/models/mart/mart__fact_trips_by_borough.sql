--- number of trips by each Borough
select l.borough, count(*) as all_trips
from {{ ref('mart__fact_all_taxi_trips')}} t
join {{ ref('mart__dim_locations') }} l on t.PUlocationID = l.LocationID
group by all