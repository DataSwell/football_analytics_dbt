with states as (

    select * from {{ ref('states')}}
)

select * from states