{{ config(materialized='table', alias='provider') }}

with providers as (
    select
        p.provider_id,
        p.provider_source_value,
        p.provider_name,
        p.gender_concept_id,
        p.gender_source_value,
        p.specialty_concept_id,
        p.specialty_source_value,
        cs.care_site_id
    from {{ ref('providers') }} as p
    left join {{ ref('care_sites') }} as cs
      on p.organization_id = cs.organization_id
)
select
    provider_id,
    provider_name,
    cast(null as text) as npi,
    cast(null as text) as dea,
    specialty_concept_id,
    care_site_id,
    cast(null as integer) as year_of_birth,
    gender_concept_id,
    provider_source_value,
    specialty_source_value,
    specialty_concept_id as specialty_source_concept_id,
    gender_source_value,
    gender_concept_id as gender_source_concept_id
from providers
