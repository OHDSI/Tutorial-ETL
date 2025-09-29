{{ config(materialized='table', alias='condition_occurrence') }}

with encounter_providers as (
    select
        encounter_id,
        prov.provider_id
    from {{ ref('encounters') }} as e
    left join {{ ref('providers') }} as prov
        on e.provider_source_value = prov.provider_source_value
),
base as (
    select
        ids.person_id,
        cond.patient_id,
        cond.encounter_id,
        cast(cond.condition_start_ts as date) as condition_start_date,
        cond.condition_start_ts,
        cast(cond.condition_end_ts as date) as condition_end_date,
        cond.condition_end_ts,
        cond.condition_code,
        cond.condition_description,
        case upper(cond.coding_system)
            when 'SNOMED-CT' then 'SNOMED'
            when 'ICD10' then 'ICD10CM'
            else upper(cond.coding_system)
        end as source_vocabulary_id,
        std_map.target_concept_id,
        std_map.source_concept_id,
        prov.provider_id
    from {{ ref('conditions') }} as cond
    join {{ ref('patient_ids') }} as ids
      on cond.patient_id = ids.patient_id
    left join {{ ref('source_to_standard_map') }} as std_map
      on std_map.source_code = cond.condition_code
     and std_map.source_vocabulary_id = case upper(cond.coding_system)
            when 'SNOMED-CT' then 'SNOMED'
            when 'ICD10' then 'ICD10CM'
            else upper(cond.coding_system)
        end
     and std_map.target_domain_id = 'CONDITION'
    left join encounter_providers as prov
      on prov.encounter_id = cond.encounter_id
), visits as (
    select encounter_id, visit_occurrence_id
    from {{ ref('final_visit_ids') }}
)
select
    row_number() over (order by person_id, condition_start_ts, condition_code) as condition_occurrence_id,
    person_id,
    coalesce(target_concept_id, 0) as condition_concept_id,
    condition_start_date,
    try_cast(condition_start_ts as timestamp) as condition_start_datetime,
    condition_end_date,
    try_cast(condition_end_ts as timestamp) as condition_end_datetime,
    32827 as condition_type_concept_id,
    cast(null as text) as stop_reason,
    visit_occurrence_id,
    provider_id,
    case when visit_occurrence_id is not null then visit_occurrence_id + 1000000 else null end as visit_detail_id,
    coalesce(source_concept_id, 0) as condition_source_concept_id,
    condition_code as condition_source_value,
    cast(null as text) as condition_status_source_value,
    0 as condition_status_concept_id
from base
left join visits using (encounter_id)
