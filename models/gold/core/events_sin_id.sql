{% set excluir = ['event_id'] %}

select
{{ dbt_utils.star(from=ref('slv_sql_server_dbo__events'), except='{{ excluir }}') }}
from {{ ref('slv_sql_server_dbo__events') }}
