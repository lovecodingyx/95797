-- by weekday, count of total trips, trips starting and ending in a different borough, 
-- and percentage w/ different start/end

select
    weekday(t.pickup_datetime) as weekday,
    count(*) as all_trips,
    count(case when pl.borough != dl.borough then 1 end) as inter_borough_trips,
    COUNT(case when pl.borough != dl.borough then 1 end) / count(*)::float as percent_inter_borough
from
    {{ ref('mart__fact_all_taxi_trips') }} t
join
    {{ ref('mart__dim_locations') }} pl on t.PUlocationID = pl.LocationID
join
    {{ ref('mart__dim_locations') }} dl on t.DOlocationID = dl.LocationID
group by
    weekday(t.pickup_datetime);