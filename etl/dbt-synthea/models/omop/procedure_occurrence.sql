{{ config(materialized='table', alias='procedure_occurrence') }}

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
        proc.encounter_id,
        proc.procedure_date,
        proc.procedure_datetime,
        proc.procedure_end_date,
        proc.procedure_end_datetime,
        proc.procedure_code,
        proc.procedure_description,
        std_map.target_concept_id,
        src_map.source_concept_id,
        prov.provider_id
    from {{ ref('procedures') }} as proc
    join {{ ref('patient_ids') }} as ids
      on proc.patient_id = ids.patient_id
    left join {{ ref('source_to_standard_map') }} as std_map
      on std_map.source_code = proc.procedure_code
     and std_map.source_vocabulary_id = proc.source_vocabulary_id
     and std_map.target_domain_id = 'PROCEDURE'
    left join {{ ref('source_to_source_map') }} as src_map
      on src_map.source_code = proc.procedure_code
     and src_map.source_vocabulary_id = proc.source_vocabulary_id
    left join encounter_providers as prov
      on prov.encounter_id = proc.encounter_id
),
visits as (
    select encounter_id, visit_occurrence_id from {{ ref('final_visit_ids') }}
)
select
    row_number() over (order by person_id, procedure_datetime, procedure_code) as procedure_occurrence_id,
    person_id,
    coalesce(target_concept_id, 0) as procedure_concept_id,
    procedure_date,
    try_cast(procedure_datetime as timestamp) as procedure_datetime,
    coalesce(procedure_end_date, procedure_date) as procedure_end_date,
    try_cast(coalesce(procedure_end_datetime, procedure_datetime) as timestamp) as procedure_end_datetime,
    32827 as procedure_type_concept_id,
    0 as modifier_concept_id,
    cast(null as integer) as quantity,
    provider_id,
    visits.visit_occurrence_id,
    case when visits.visit_occurrence_id is not null then visits.visit_occurrence_id + 1000000 else null end as visit_detail_id,
    procedure_code as procedure_source_value,
    coalesce(source_concept_id, 0) as procedure_source_concept_id,
    cast(null as text) as modifier_source_value
from base
left join visits
  on base.encounter_id = visits.encounter_id
