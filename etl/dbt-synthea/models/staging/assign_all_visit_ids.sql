{{ config(materialized='table', alias='assign_all_visit_ids') }}

with encounters as (
    select
        encounter_id,
        patient_id,
        lower(encounter_class) as encounter_class,
        encounter_start_date,
        coalesce(encounter_end_date, encounter_start_date) as encounter_end_date
    from {{ ref('encounters') }}
),
candidate_visits as (
    select
        e.encounter_id,
        e.patient_id,
        e.encounter_class,
        v.encounter_class as visit_type,
        v.visit_occurrence_id,
        v.visit_start_date,
        v.visit_end_date,
        case
            when e.encounter_class = 'inpatient' and v.encounter_class = 'inpatient' then 1
            when e.encounter_class in ('emergency', 'urgent', 'urgentcare') then
                case
                    when v.encounter_class = 'inpatient' and e.encounter_start_date > v.visit_start_date then 1
                    when v.encounter_class in ('emergency', 'urgent', 'urgentcare') and e.encounter_start_date = v.visit_start_date then 2
                    else 99
                end
            when e.encounter_class in ('ambulatory', 'wellness', 'outpatient') then
                case
                    when v.encounter_class = 'inpatient' and e.encounter_start_date >= v.visit_start_date then 1
                    when v.encounter_class in ('ambulatory', 'wellness', 'outpatient') then 2
                    else 99
                end
            else 99
        end as priority
    from encounters as e
    join {{ ref('all_visits') }} as v
        on e.patient_id = v.patient_id
       and e.encounter_start_date between v.visit_start_date and v.visit_end_date
)
select
    encounter_id,
    visit_occurrence_id,
    visit_type,
    row_number() over (
        partition by encounter_id
        order by priority, visit_start_date, visit_end_date, visit_occurrence_id
    ) as visit_rank
from candidate_visits
where priority < 99
