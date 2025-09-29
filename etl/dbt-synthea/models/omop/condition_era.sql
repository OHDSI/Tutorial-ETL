{{ config(materialized='table', alias='condition_era') }}

with condition_events as (
    select
        person_id,
        condition_concept_id,
        condition_start_date as event_start_date,
        case
            when condition_end_date is not null then condition_end_date
            else condition_start_date + interval '1 day'
        end as event_end_date
    from {{ ref('condition_occurrence') }}
    where condition_concept_id <> 0
),
normalized as (
    select
        person_id,
        condition_concept_id,
        event_start_date,
        greatest(event_start_date, event_end_date) as event_end_date
    from condition_events
),
ordered as (
    select
        *,
        case
            when lag(event_end_date) over (partition by person_id, condition_concept_id order by event_start_date, event_end_date) is null then 1
            when datediff('day', lag(event_end_date) over (partition by person_id, condition_concept_id order by event_start_date, event_end_date), event_start_date) > 30 then 1
            else 0
        end as new_era_flag
    from normalized
),
era_assignment as (
    select
        *,
        sum(new_era_flag) over (
            partition by person_id, condition_concept_id
            order by event_start_date, event_end_date
            rows between unbounded preceding and current row
        ) as era_group
    from ordered
),
eras as (
    select
        person_id,
        condition_concept_id,
        era_group,
        min(event_start_date) as condition_era_start_date,
        max(event_end_date) as condition_era_end_date,
        count(*) as condition_occurrence_count
    from era_assignment
    group by person_id, condition_concept_id, era_group
)
select
    row_number() over (order by person_id, condition_concept_id, condition_era_start_date) as condition_era_id,
    person_id,
    condition_concept_id,
    condition_era_start_date,
    condition_era_end_date,
    condition_occurrence_count
from eras
