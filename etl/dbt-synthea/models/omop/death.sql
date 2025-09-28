{{ config(materialized='table', alias='death') }}

with death_encounters as (
    select
        e.patient_id,
        e.encounter_start_date,
        e.encounter_start_datetime,
        e.reason_code,
        ids.person_id
    from {{ ref('encounters') }} as e
    join {{ ref('patient_ids') }} as ids
      on e.patient_id = ids.patient_id
    where e.encounter_code = '308646001'
      and e.reason_code is not null
),
causes as (
    select
        source_code,
        target_concept_id,
        source_concept_id
    from {{ ref('source_to_standard_map') }}
    where target_domain_id = 'CONDITION'
      and source_vocabulary_id = 'SNOMED'
      and target_vocabulary_id = 'SNOMED'
)
select
    person_id,
    encounter_start_date as death_date,
    try_cast(encounter_start_datetime as timestamp) as death_datetime,
    32817 as death_type_concept_id,
    coalesce(causes.target_concept_id, 0) as cause_concept_id,
    reason_code as cause_source_value,
    coalesce(causes.source_concept_id, 0) as cause_source_concept_id
from death_encounters
left join causes
  on upper(death_encounters.reason_code) = causes.source_code
