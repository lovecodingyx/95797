with source as (

    select * from {{ source('main', 'fhv_bases') }}

),

-- select the data and change them to the correct data type
renamed as (

    select
        -- clean up the base_num to be properly linked as foreign keys
        trim(upper(base_number)) as base_number,
        base_name,
        dba,
        dba_category,
        filename

    from source

)

select * from renamed