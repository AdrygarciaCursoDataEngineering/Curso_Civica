-- =============================================================================
-- stg_sql_server_dbo__users
-- =============================================================================

-- =============================================================================

with source as (
    select * from {{ source('sql_server_dbo', 'users') }}
),

renamed as (
    select
        * EXCLUDE(created_at, _FIVETRAN_SYNCED, _LOADED_AT)
        ,  created_at                               as created_at_utc
        , _FIVETRAN_SYNCED                         as FIVETRAN_SYNCED_utc
        , _LOADED_AT                               as is_deleted_utc
    from source
)

select * from renamed