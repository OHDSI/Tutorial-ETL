{{ config(materialized='table', alias='care_site') }}

select
    care_site_id,
    name as care_site_name,
    0 as place_of_service_concept_id,
    cast(null as integer) as location_id,
    organization_id as care_site_source_value,
    cast(null as text) as place_of_service_source_value
from {{ ref('care_sites') }}
