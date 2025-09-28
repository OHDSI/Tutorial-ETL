{{ config(materialized='table', alias='all_visits') }}

with encounters as (
    select
        encounter_id,
        patient_id,
        lower(encounter_class) as encounter_class,
        encounter_start_date,
        coalesce(encounter_end_date, encounter_start_date) as encounter_end_date
    from {{ ref('encounters') }}
),
ranked_inpatient as (
    select
        *,
        case
            when lag(encounter_end_date) over (partition by patient_id order by encounter_start_date) is null
                or datediff('day', lag(encounter_end_date) over (partition by patient_id order by encounter_start_date), encounter_start_date) > 1
            then 1
            else 0
        end as new_stay
    from encounters
    where encounter_class = 'inpatient'
),
inpatient_groups as (
    select
        *,
        sum(new_stay) over (partition by patient_id order by encounter_start_date rows unbounded preceding) as grp
    from ranked_inpatient
),
inpatient_visits as (
    select
        min(encounter_id) as encounter_id,
        patient_id,
        'inpatient' as encounter_class,
        min(encounter_start_date) as visit_start_date,
        max(encounter_end_date) as visit_end_date
    from inpatient_groups
    group by patient_id, grp
),
er_visits as (
    select
        min(encounter_id) as encounter_id,
        patient_id,
        encounter_class,
        encounter_start_date as visit_start_date,
        max(encounter_end_date) as visit_end_date
    from encounters
    where encounter_class in ('emergency', 'urgent', 'urgentcare')
    group by patient_id, encounter_class, encounter_start_date
),
op_visits as (
    select
        min(encounter_id) as encounter_id,
        patient_id,
        encounter_class,
        encounter_start_date as visit_start_date,
        max(encounter_end_date) as visit_end_date
    from encounters
    where encounter_class in ('ambulatory', 'wellness', 'outpatient')
    group by patient_id, encounter_class, encounter_start_date
),
all_visits as (
    select * from inpatient_visits
    union all
    select * from er_visits
    union all
    select * from op_visits
)
select
    encounter_id,
    patient_id,
    encounter_class,
    visit_start_date,
    visit_end_date,
    row_number() over (order by patient_id, visit_start_date, encounter_id) as visit_occurrence_id
from all_visits
