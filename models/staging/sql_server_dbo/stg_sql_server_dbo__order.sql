-- =============================================================================
-- stg_sql_server_dbo__order
-- =============================================================================

-- =============================================================================

with source as (
    select * from {{ source('sql_server_dbo', 'orders') }}
),

renamed as (
    select
          * EXCLUDE(created_at, ESTIMATED_DELIVERY_AT, _FIVETRAN_SYNCED, _LOADED_AT)
        ,  created_at                              as created_at_utc
        , ESTIMATED_DELIVERY_AT                    as estimated_delivery_at_utc
        , _FIVETRAN_SYNCED                         as FIVETRAN_SYNCED_utc
        , _LOADED_AT                               as is_deleted_utc
    from source
)

select * from renamed