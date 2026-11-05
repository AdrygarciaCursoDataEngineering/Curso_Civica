-- =============================================================================
-- stg_sql_server_dbo__order
-- =============================================================================

-- =============================================================================

with source as (
    select * from {{ source('sql_server_dbo', 'orders') }}
),

renamed as (
    select
        * exclude(created_at, estimated_delivery_at, delivered_at, shipping_cost, order_cost, order_total, status, _fivetran_deleted, _fivetran_synced)
        , created_at                               as created_at_utc
        , estimated_delivery_at                    as estimated_delivery_at_utc
        , delivered_at                             as delivered_at_utc
        , shipping_cost                            as shipping_cost_usd
        , order_cost                               as item_order_cost_usd
        , order_total                              as total_order_cost_usd
        , status                                   as order_status
        , coalesce(_fivetran_deleted, false)       as is_deleted
        , _fivetran_synced                         as date_load
    from source
)

select * from renamed