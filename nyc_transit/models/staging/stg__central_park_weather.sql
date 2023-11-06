with source as(

    select * from {{source('main', 'central_park_weather') }}
),

renamed as (
    select 
        trim(station) as station,
        trim(name) as name,
        date:: date as date,
        awnd:: double as awnd,
        prcp:: double as prcp,
        snow:: double as snwd,
        tmax:: int as tmax,
        tmin:: int as tmin,
        filename 

    from source
)

select * from renamed