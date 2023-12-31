-- pivot the results by borough
select
  all_trips,
  {{ dbt_utils.pivot( 'Borough',
      dbt_utils.get_column_values(ref('mart__fact_trips_by_borough'), 'Borough')) }}
from {{ ref('mart__fact_trips_by_borough') }}
group by all_trips

-- duckdb main.db -s ".read nyc_transit/target/compiled/nyc_transit/analyses/pivot_trips_by_borough.sql"> answers/pivot_trips_by_borough.txt