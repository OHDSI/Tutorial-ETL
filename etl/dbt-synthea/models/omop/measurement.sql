{{ config(materialized='table', alias='measurement') }}

with encounter_providers as (
    select
        encounter_id,
        prov.provider_id
    from {{ ref('encounters') }} as e
    left join {{ ref('providers') }} as prov
        on e.provider_source_value = prov.provider_source_value
),
observation_base as (
    select
        ids.person_id,
        obs.encounter_id,
        cast(obs.observation_datetime as date) as measurement_date,
        obs.observation_datetime as measurement_datetime,
        obs.observation_code as source_code,
        obs.source_description,
        obs.numeric_value as value_as_number,
        obs.value_source_value,
        obs.observation_units,
        std_map.target_concept_id,
        std_map.source_concept_id,
        unit_map.target_concept_id as unit_concept_id,
        value_map.target_concept_id as value_concept_id,
        prov.provider_id,
        'observation' as record_type
    from {{ ref('observations') }} as obs
    join {{ ref('patient_ids') }} as ids
      on obs.patient_id = ids.patient_id
    left join {{ ref('source_to_standard_map') }} as std_map
      on std_map.source_code = obs.observation_code
     and std_map.source_vocabulary_id = 'LOINC'
     and std_map.target_domain_id = 'MEASUREMENT'
    left join {{ ref('source_to_standard_map') }} as unit_map
      on unit_map.source_code = obs.observation_units
     and unit_map.source_vocabulary_id = 'UCUM'
     and unit_map.target_vocabulary_id = 'UCUM'
     and unit_map.target_domain_id = 'UNIT'
    left join {{ ref('source_to_standard_map') }} as value_map
      on value_map.source_code = obs.value_source_value
     and value_map.target_domain_id = 'MEAS VALUE'
    left join encounter_providers as prov
      on prov.encounter_id = obs.encounter_id
), procedure_base as (
    select
        ids.person_id,
        proc.encounter_id,
        proc.procedure_date as measurement_date,
        proc.procedure_datetime as measurement_datetime,
        proc.procedure_code as source_code,
        proc.procedure_description as source_description,
        cast(null as double) as value_as_number,
        cast(null as text) as value_source_value,
        cast(null as text) as observation_units,
        std_map.target_concept_id,
        std_map.source_concept_id,
        cast(null as integer) as unit_concept_id,
        cast(null as integer) as value_concept_id,
        prov.provider_id,
        'procedure' as record_type
    from {{ ref('procedures') }} as proc
    join {{ ref('patient_ids') }} as ids
      on proc.patient_id = ids.patient_id
    left join {{ ref('source_to_standard_map') }} as std_map
      on std_map.source_code = proc.procedure_code
     and std_map.source_vocabulary_id = 'SNOMED'
     and std_map.target_domain_id = 'MEASUREMENT'
    left join encounter_providers as prov
      on prov.encounter_id = proc.encounter_id
), combined as (
    select * from observation_base
    union all
    select * from procedure_base
), visits as (
    select encounter_id, visit_occurrence_id
    from {{ ref('final_visit_ids') }}
)
select
    row_number() over (order by person_id, measurement_datetime, source_code) as measurement_id,
    person_id,
    coalesce(target_concept_id, 0) as measurement_concept_id,
    measurement_date,
    try_cast(measurement_datetime as timestamp) as measurement_datetime,
    cast(null as time) as measurement_time,
    32827 as measurement_type_concept_id,
    cast(null as integer) as operator_concept_id,
    value_as_number,
    coalesce(value_concept_id, 0) as value_as_concept_id,
    coalesce(unit_concept_id, 0) as unit_concept_id,
    cast(null as double) as range_low,
    cast(null as double) as range_high,
    provider_id,
    visits.visit_occurrence_id,
    case when visits.visit_occurrence_id is not null then visits.visit_occurrence_id + 1000000 else null end as visit_detail_id,
    source_code as measurement_source_value,
    coalesce(source_concept_id, 0) as measurement_source_concept_id,
    observation_units as unit_source_value,
    value_source_value,
    cast(null as integer) as unit_source_concept_id,
    cast(null as bigint) as measurement_event_id,
    cast(null as int) as meas_event_field_concept_id
from combined
left join visits using (encounter_id)
