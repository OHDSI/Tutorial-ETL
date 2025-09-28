{{ config(materialized='table', alias='visit_detail') }}

with details as (
    select
        visit_occurrence_id,
        person_id,
        encounter_class,
        encounter_start_date,
        encounter_start_datetime,
        encounter_end_date,
        encounter_end_datetime,
        representative_encounter_id,
        provider_id
    from {{ ref('visit_dimension') }}
),
ordered as (
    select
        visit_occurrence_id,
        person_id,
        encounter_class,
        encounter_start_date,
        encounter_start_datetime,
        encounter_end_date,
        encounter_end_datetime,
        representative_encounter_id,
        provider_id,
        visit_occurrence_id + 1000000 as visit_detail_id,
        lag(visit_occurrence_id + 1000000) over (
            partition by person_id
            order by encounter_start_datetime, visit_occurrence_id
        ) as preceding_visit_detail_id
    from details
)
select
    visit_detail_id,
    person_id,
    case
        when encounter_class in ('ambulatory', 'wellness', 'outpatient') then 9202
        when encounter_class in ('emergency', 'urgent', 'urgentcare') then 9203
        when encounter_class = 'inpatient' then 9201
        else 0
    end as visit_detail_concept_id,
    encounter_start_date as visit_detail_start_date,
    try_cast(encounter_start_datetime as timestamp) as visit_detail_start_datetime,
    encounter_end_date as visit_detail_end_date,
    try_cast(encounter_end_datetime as timestamp) as visit_detail_end_datetime,
    32827 as visit_detail_type_concept_id,
    provider_id,
    cast(null as integer) as care_site_id,
    cast(null as integer) as admitted_from_concept_id,
    cast(null as integer) as discharged_to_concept_id,
    preceding_visit_detail_id,
    cast(representative_encounter_id as text) as visit_detail_source_value,
    0 as visit_detail_source_concept_id,
    cast(null as text) as admitted_from_source_value,
    cast(null as text) as discharged_to_source_value,
    cast(null as integer) as parent_visit_detail_id,
    visit_occurrence_id
from ordered
