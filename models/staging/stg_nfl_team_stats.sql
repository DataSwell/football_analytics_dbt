with source as (

    select * from {{ source('src_football', 'sd_team_stats') }}
    )


--surrogate key

select * from source