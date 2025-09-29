{{ config(materialized='table', alias='observation_period') }}

with base as (
    select
        ids.person_id,
        min(enc.encounter_start_date) as period_start,
        max(coalesce(enc.encounter_end_date, enc.encounter_start_date)) as period_end
    from {{ ref('patient_ids') }} as ids
    join {{ ref('encounters') }} as enc
      on ids.patient_id = enc.patient_id
    group by ids.person_id
)
select
    row_number() over (order by person_id) as observation_period_id,
    person_id,
    period_start as observation_period_start_date,
    period_end as observation_period_end_date,
    32882 as period_type_concept_id
from base
