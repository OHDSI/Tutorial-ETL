{{ config(materialized='table', alias='observation') }}

with visits as (
    select encounter_id, visit_occurrence_id from {{ ref('final_visit_ids') }}
),
encounter_providers as (
    select
        encounter_id,
        prov.provider_id
    from {{ ref('encounters') }} as e
    left join {{ ref('providers') }} as prov
        on e.provider_source_value = prov.provider_source_value
),
allergy_obs as (
    select
        ids.person_id,
        a.encounter_id,
        a.allergy_start_date as observation_date,
        a.allergy_start_datetime as observation_datetime,
        std_map.target_concept_id as observation_concept_id,
        32827 as observation_type_concept_id,
        cast(null as double) as value_as_number,
        cast(null as text) as value_as_string,
        0 as value_as_concept_id,
        0 as qualifier_concept_id,
        0 as unit_concept_id,
        prov.provider_id,
        a.allergy_code as observation_source_value,
        coalesce(src_map.source_concept_id, 0) as observation_source_concept_id,
        cast(null as text) as unit_source_value,
        cast(null as text) as qualifier_source_value,
        cast(null as text) as value_source_value
    from {{ ref('allergies') }} as a
    join {{ ref('patient_ids') }} as ids
      on a.patient_id = ids.patient_id
    left join {{ ref('source_to_standard_map') }} as std_map
      on std_map.source_code = a.allergy_code
     and std_map.source_vocabulary_id = a.coding_system
     and std_map.target_domain_id = 'OBSERVATION'
    left join {{ ref('source_to_source_map') }} as src_map
      on src_map.source_code = a.allergy_code
     and src_map.source_vocabulary_id = a.coding_system
    left join encounter_providers as prov
      on prov.encounter_id = a.encounter_id
),
condition_obs as (
    select
        ids.person_id,
        cond.encounter_id,
        cast(cond.condition_start_datetime as date) as observation_date,
        cond.condition_start_datetime as observation_datetime,
        std_map.target_concept_id as observation_concept_id,
        38000280 as observation_type_concept_id,
        cast(null as double) as value_as_number,
        cast(null as text) as value_as_string,
        0 as value_as_concept_id,
        0 as qualifier_concept_id,
        0 as unit_concept_id,
        prov.provider_id,
        cond.condition_code as observation_source_value,
        coalesce(src_map.source_concept_id, 0) as observation_source_concept_id,
        cast(null as text) as unit_source_value,
        cast(null as text) as qualifier_source_value,
        cast(null as text) as value_source_value
    from {{ ref('conditions') }} as cond
    join {{ ref('patient_ids') }} as ids
      on cond.patient_id = ids.patient_id
    left join {{ ref('source_to_standard_map') }} as std_map
      on std_map.source_code = cond.condition_code
     and std_map.source_vocabulary_id = cond.coding_system
     and std_map.target_domain_id = 'OBSERVATION'
    left join {{ ref('source_to_source_map') }} as src_map
      on src_map.source_code = cond.condition_code
     and src_map.source_vocabulary_id = cond.coding_system
    left join encounter_providers as prov
      on prov.encounter_id = cond.encounter_id
),
clinical_obs as (
    select
        ids.person_id,
        obs.encounter_id,
        cast(obs.observation_datetime as date) as observation_date,
        obs.observation_datetime as observation_datetime,
        std_map.target_concept_id as observation_concept_id,
        38000280 as observation_type_concept_id,
        cast(null as double) as value_as_number,
        left(obs.value_source_value, 50) as value_as_string,
        0 as value_as_concept_id,
        0 as qualifier_concept_id,
        0 as unit_concept_id,
        prov.provider_id,
        obs.observation_code as observation_source_value,
        coalesce(src_map.source_concept_id, 0) as observation_source_concept_id,
        obs.observation_units as unit_source_value,
        cast(null as text) as qualifier_source_value,
        left(obs.value_source_value, 50) as value_source_value
    from {{ ref('observations') }} as obs
    join {{ ref('patient_ids') }} as ids
      on obs.patient_id = ids.patient_id
    left join {{ ref('source_to_standard_map') }} as std_map
      on std_map.source_code = obs.observation_code
     and std_map.source_vocabulary_id = 'LOINC'
     and std_map.target_domain_id = 'OBSERVATION'
    left join {{ ref('source_to_source_map') }} as src_map
      on src_map.source_code = obs.observation_code
     and src_map.source_vocabulary_id = 'LOINC'
    left join encounter_providers as prov
      on prov.encounter_id = obs.encounter_id
)
select
    row_number() over (order by person_id, observation_datetime, observation_concept_id) as observation_id,
    person_id,
    coalesce(observation_concept_id, 0) as observation_concept_id,
    observation_date,
    try_cast(observation_datetime as timestamp) as observation_datetime,
    observation_type_concept_id,
    value_as_number,
    value_as_string,
    value_as_concept_id,
    qualifier_concept_id,
    unit_concept_id,
    provider_id,
    visits.visit_occurrence_id,
    case when visits.visit_occurrence_id is not null then visits.visit_occurrence_id + 1000000 else null end as visit_detail_id,
    observation_source_value,
    coalesce(observation_source_concept_id, 0) as observation_source_concept_id,
    unit_source_value,
    qualifier_source_value,
    value_source_value,
    cast(null as bigint) as observation_event_id,
    cast(null as int) as obs_event_field_concept_id
from (
    select * from allergy_obs
    union all
    select * from condition_obs
    union all
    select * from clinical_obs
) as obs
left join visits
  on obs.encounter_id = visits.encounter_id
