with source as (

    select * from {{ source('src_football', 'sd_teams') }}
    )

select * from source