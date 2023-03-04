with source as (

    select * from {{ source('src_football', 'kg_teams') }}
    )

select * from source