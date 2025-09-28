{{ config(materialized='table', alias='device_exposure') }}

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
        dev.encounter_id,
        dev.device_start_date,
        dev.device_start_datetime,
        dev.device_end_date,
        dev.device_end_datetime,
        dev.device_code,
        dev.device_description,
        dev.unique_device_id,
        std_map.target_concept_id,
        src_map.source_concept_id,
        prov.provider_id
    from {{ ref('devices') }} as dev
    join {{ ref('patient_ids') }} as ids
      on dev.patient_id = ids.patient_id
    left join {{ ref('source_to_standard_map') }} as std_map
      on std_map.source_code = dev.device_code
     and std_map.source_vocabulary_id = dev.source_vocabulary_id
     and std_map.target_domain_id = 'DEVICE'
    left join {{ ref('source_to_source_map') }} as src_map
      on src_map.source_code = dev.device_code
     and src_map.source_vocabulary_id = dev.source_vocabulary_id
    left join encounter_providers as prov
      on prov.encounter_id = dev.encounter_id
),
visits as (
    select encounter_id, visit_occurrence_id
    from {{ ref('final_visit_ids') }}
)
select
    row_number() over (order by person_id, device_start_datetime, device_code) as device_exposure_id,
    person_id,
    coalesce(target_concept_id, 0) as device_concept_id,
    device_start_date as device_exposure_start_date,
    try_cast(device_start_datetime as timestamp) as device_exposure_start_datetime,
    device_end_date as device_exposure_end_date,
    try_cast(device_end_datetime as timestamp) as device_exposure_end_datetime,
    32827 as device_type_concept_id,
    unique_device_id,
    cast(null as text) as production_id,
    cast(null as double) as quantity,
    provider_id,
    visits.visit_occurrence_id,
    case when visits.visit_occurrence_id is not null then visits.visit_occurrence_id + 1000000 else null end as visit_detail_id,
    device_code as device_source_value,
    coalesce(source_concept_id, 0) as device_source_concept_id,
    cast(null as integer) as unit_concept_id,
    cast(null as text) as unit_source_value,
    cast(null as integer) as unit_source_concept_id
from base
left join visits
  on base.encounter_id = visits.encounter_id
