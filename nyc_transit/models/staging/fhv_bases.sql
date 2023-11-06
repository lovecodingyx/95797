with source as (

    select * from {{ source('main', 'fhv_bases') }}

),

renamed as (
    
    select
        trim(base_number) as base_license_number,
        trim(base_name) as base_name,
        trim(dba) as dba,
        trim(dba_category) as dba_category,
        filename
    
    from source

)

select * from renamed