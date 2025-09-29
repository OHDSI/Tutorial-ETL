{{ config(materialized='table', alias='cost') }}

with visit_costs as (
    select
        v.visit_occurrence_id,
        try_cast(e.base_cost as double) as base_cost,
        try_cast(e.total_cost as double) as total_cost,
        try_cast(e.payer_coverage as double) as payer_coverage,
        e.patient_id
    from {{ ref('encounters') }} as e
    join {{ ref('final_visit_ids') }} as v
      on e.encounter_id = v.encounter_id
)
select
    row_number() over (order by visit_occurrence_id) as cost_id,
    visit_occurrence_id as cost_event_id,
    'Visit Occurrence' as cost_domain_id,
    50387063 as cost_type_concept_id,
    0 as currency_concept_id,
    base_cost as total_charge,
    total_cost as total_cost,
    payer_coverage as total_paid,
    cast(null as double) as paid_copay,
    case
        when total_cost is not null and payer_coverage is not null then total_cost - payer_coverage
        else null
    end as paid_coinsurance,
    cast(null as double) as paid_deductible,
    cast(null as double) as paid_by_payer,
    cast(null as double) as paid_by_patient,
    cast(null as double) as paid_patient_copay,
    cast(null as double) as paid_patient_coinsurance,
    cast(null as double) as paid_patient_deductible,
    cast(null as double) as paid_by_primary,
    cast(null as double) as paid_by_secondary,
    cast(null as double) as paid_by_tertiary,
    cast(null as double) as payer_plan_period_id,
    cast(null as double) as amount_allowed,
    cast(null as double) as revenue_code_concept_id,
    cast(null as text) as revenue_code_source_value,
    cast(null as double) as drg_concept_id,
    cast(null as text) as drg_source_value
from visit_costs
