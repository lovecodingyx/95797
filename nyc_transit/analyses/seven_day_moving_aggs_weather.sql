-- calculate the 7 day moving average precipitation for every day in the weather data.
select 
    date,
    min(prcp) over seven_days as min_prcp,
    max(prcp) over seven_days as max_prcp,
    avg(prcp) over seven_days as avg_prcp,
    sum(prcp) over seven_days as sum_prcp,
    min(snow) over seven_days as min_snow,
    max(snow) over seven_days as max_snow,
    avg(snow) over seven_days as avg_snow,
    sum(snow) over seven_days as sum_snow
from {{ ref('stg__central_park_weather')}}
window seven_days as (
    order by date asc
    rows between 3 preceding and 3 following)

-- duckdb main.db -s ".read nyc_transit/target/compiled/nyc_transit/analyses/seven_day_moving_aggs_weather.sql"> answers/seven_day_moving_aggs_weather.txt