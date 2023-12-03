-- Window functions with QUALIFY and ROW_NUMBER to remove duplicate rows.
select  * 
from {{ ref('events') }}
qualify row_number() over (partition by event_id order by insert_timestamp desc) = 1

-- duckdb main.db -s ".read nyc_transit/target/compiled/nyc_transit/analyses/dedupe.sql"> answers/dedupe.txt