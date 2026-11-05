-- =============================================================================
-- stg_sql_server_dbo__users
-- =============================================================================

-- =============================================================================

with source as (
    select * from {{ source('sql_server_dbo', 'users') }}
),

renamed as (
    select
        * exclude(created_at, updated_at, _fivetran_deleted, _fivetran_synced)
        , created_at                               as created_at_utc
        , updated_at                               as updated_at_utc
        , coalesce(_fivetran_deleted, false)       as is_deleted
        , _fivetran_synced                         as date_load
    from source
)

select * from renamed