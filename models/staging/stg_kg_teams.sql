with kg_teams as (

    select * from {{ source('src_football', 'kg_teams') }}
)

select * from kg_teams