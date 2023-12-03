-- calculate the 7 day moving average precipitation for every day in the weather data.
select date, 
    avg(prcp) over (order by date
            rows between 3 preceding and 3 following) 
    as avg_prcp
from {{ ref('stg__central_park_weather') }}

-- duckdb main.db -s ".read nyc_transit/target/compiled/nyc_transit/analyses/seven_day_moving_average_prcp.sql"> answers/seven_day_moving_average_prcp.txt