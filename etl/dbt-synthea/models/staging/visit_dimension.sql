{{ config(materialized='table', alias='visit_dimension') }}

with visits as (
    select
        av.visit_occurrence_id,
        av.encounter_id as representative_encounter_id,
        av.patient_id,
        ids.person_id,
        av.encounter_class,
        av.visit_start_date,
        av.visit_end_date
    from {{ ref('all_visits') }} as av
    join {{ ref('patient_ids') }} as ids
      on av.patient_id = ids.patient_id
),
visit_members as (
    select
        f.visit_occurrence_id,
        f.encounter_id,
        e.encounter_start_datetime,
        e.encounter_end_datetime,
        e.encounter_class as member_encounter_class,
        e.source_code,
        e.source_vocabulary_id,
        e.description,
        prov.provider_id,
        row_number() over (
            partition by f.visit_occurrence_id
            order by e.encounter_start_datetime, e.encounter_id
        ) as member_rank
    from {{ ref('final_visit_ids') }} as f
    join {{ ref('encounters') }} as e
      on f.encounter_id = e.encounter_id
    left join {{ ref('providers') }} as prov
      on e.provider_source_value = prov.provider_source_value
),
canonical_member as (
    select *
    from visit_members
    where member_rank = 1
),
lookup as (
    select
        v.visit_occurrence_id,
        v.representative_encounter_id,
        v.person_id,
        v.encounter_class,
        v.visit_start_date,
        v.visit_end_date,
        cm.encounter_start_datetime,
        cm.encounter_end_datetime,
        cm.source_code,
        cm.source_vocabulary_id,
        cm.description,
        cm.provider_id,
        std_map.target_concept_id,
        std_map.source_concept_id
    from visits as v
    left join canonical_member as cm
      on v.visit_occurrence_id = cm.visit_occurrence_id
    left join {{ ref('source_to_standard_map') }} as std_map
      on std_map.source_code = cm.source_code
     and std_map.source_vocabulary_id = cm.source_vocabulary_id
)
select
    visit_occurrence_id,
    representative_encounter_id,
    person_id,
    encounter_class,
    visit_start_date as encounter_start_date,
    coalesce(encounter_start_datetime, cast(visit_start_date as timestamp)) as encounter_start_datetime,
    coalesce(encounter_start_datetime, cast(visit_start_date as timestamp)) as encounter_start_ts,
    visit_end_date as encounter_end_date,
    coalesce(encounter_end_datetime, cast(visit_end_date as timestamp)) as encounter_end_datetime,
    coalesce(encounter_end_datetime, cast(visit_end_date as timestamp)) as encounter_end_ts,
    source_code,
    source_code as encounter_code,
    source_vocabulary_id,
    description,
    provider_id,
    target_concept_id,
    target_concept_id as visit_concept_id,
    source_concept_id,
    source_concept_id as visit_source_concept_id
from lookup
