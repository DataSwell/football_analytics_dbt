with source as (

    select * from {{ source('src_football', 'kg_stadiums') }}
    )

select * from source
