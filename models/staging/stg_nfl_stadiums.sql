with source as (

    select * from {{ source('src_football', 'sd_stadiums') }}
    )

select * from source