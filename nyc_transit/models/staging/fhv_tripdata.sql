with source as (

    select * from {{ source('main', 'fhv_tripdata') }}

),

-- exclude SR_Flag since there is no value in this column
renamed as (
    
    select
        dispatching_base_num,
        pickup_datetime,
        dropoff_datetime,
        pulocationID,
        dolocationID,
        -- drop sr_flag since the whole column is null
        affiliated_base_number,
        filename
    
    from source

    where
        pickup_datetime <= '2022-12-31' 
        AND 
        dropOff_datetime <= '2022-12-31'  

)

select * from renamed