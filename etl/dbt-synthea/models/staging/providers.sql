{{ config(materialized='table', alias='providers') }}

with base as (
    select
        Id as provider_source_value,
        ORGANIZATION as organization_id,
        NAME as provider_name,
        upper(trim(GENDER)) as gender_source_value,
        SPECIALITY as specialty_source_value
    from {{ ref('synthea_providers') }}
)
select
    row_number() over (order by provider_source_value) as provider_id,
    provider_source_value,
    organization_id,
    provider_name,
    gender_source_value,
    specialty_source_value,
    case gender_source_value
        when 'M' then 8507
        when 'F' then 8532
        else 0
    end as gender_concept_id,
    38004446 as specialty_concept_id
from base
