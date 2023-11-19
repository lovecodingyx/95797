-- by weekday, count of total trips, trips starting and ending in a different borough, 
-- and percentage w/ different start/end

with total_trips as (
    select 
        weekday(pickup_datetime) as weekday,
        count(*) as trips
    from 
        {{ ref('mart__fact_all_taxi_trips') }}
    group by 
        weekday
),
inter_borough_trips as (
    select 
        weekday(t.pickup_datetime) as weekday,
        count(*) as trips
    from 
        {{ ref('mart__fact_all_taxi_trips') }} t
    join 
        {{ ref('mart__dim_locations') }} pl on t.PUlocationID = pl.LocationID
    join 
        {{ ref('mart__dim_locations') }} dl on t.DOlocationID = dl.LocationID
    where 
        pl.borough <> dl.borough
    group by 
        weekday
)
select 
    tt.weekday,
    tt.trips as all_trips,
    COALESCE(ib.trips, 0) as inter_borough_trips,
    COALESCE(ib.trips, 0)::float / NULLIF(tt.trips, 0) as percent_inter_borough
from 
    total_trips tt
left join 
    inter_borough_trips ib on tt.weekday = ib.weekday;
