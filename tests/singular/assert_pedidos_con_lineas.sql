with orders as (
    select
        order_id
    from {{ ref('fct_orders') }}
),

order_items as(
    select
        order_id
    from {{ ref('slv_sql_server_dbo__orders_items') }}
)

select
    *
from orders as a
left order_items as b
    on a.order_id=b.order_id
where b.order_id is null