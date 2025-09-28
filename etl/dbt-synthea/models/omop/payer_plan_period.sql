{{ config(materialized='table', alias='payer_plan_period') }}

with transitions as (
    select
        pt.patient_id,
        ids.person_id,
        pt.start_date,
        pt.end_date,
        pt.payer_id,
        pay.name as plan_name
    from {{ ref('payer_transitions') }} as pt
    join {{ ref('patient_ids') }} as ids
      on pt.patient_id = ids.patient_id
    left join {{ ref('payers') }} as pay
      on pt.payer_id = pay.payer_id
)
select
    row_number() over (order by person_id, start_date) as payer_plan_period_id,
    person_id,
    start_date as payer_plan_period_start_date,
    coalesce(end_date, start_date) as payer_plan_period_end_date,
    0 as payer_concept_id,
    payer_id as payer_source_value,
    0 as payer_source_concept_id,
    0 as plan_concept_id,
    plan_name as plan_source_value,
    0 as plan_source_concept_id,
    0 as sponsor_concept_id,
    cast(null as text) as sponsor_source_value,
    0 as sponsor_source_concept_id,
    cast(null as text) as family_source_value,
    0 as stop_reason_concept_id,
    cast(null as text) as stop_reason_source_value,
    0 as stop_reason_source_concept_id
from transitions
