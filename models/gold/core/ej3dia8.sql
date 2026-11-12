with cte as(
    select *
    from {{ ref('dim_users', v=1) }}
)

select *
from cte