{{ config(materialized='table', alias='care_sites') }}

select
    row_number() over (order by organization_id) as care_site_id,
    organization_id,
    name,
    city,
    state_name,
    zip
from {{ ref('organizations') }}
