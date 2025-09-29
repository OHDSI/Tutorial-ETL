{{ config(materialized='table', alias='drug_exposure') }}

with encounter_providers as (
    select
        encounter_id,
        prov.provider_id
    from {{ ref('encounters') }} as e
    left join {{ ref('providers') }} as prov
        on e.provider_source_value = prov.provider_source_value
),
medication_base as (
    select
        ids.person_id,
        meds.encounter_id,
        meds.drug_exposure_start_date,
        meds.drug_exposure_start_datetime,
        meds.drug_exposure_end_date,
        meds.drug_exposure_end_datetime,
        meds.medication_code as source_code,
        meds.medication_description as source_description,
        meds.quantity,
        std_map.target_concept_id,
        std_map.source_concept_id,
        'medication' as record_type,
        coalesce(datediff('day', meds.drug_exposure_start_date, meds.drug_exposure_end_date), 0) as days_supply,
        prov.provider_id
    from {{ ref('medications') }} as meds
    join {{ ref('patient_ids') }} as ids
      on meds.patient_id = ids.patient_id
    left join {{ ref('source_to_standard_map') }} as std_map
      on std_map.source_code = meds.medication_code
     and std_map.source_vocabulary_id = 'RXNORM'
     and std_map.target_domain_id = 'DRUG'
    left join encounter_providers as prov
      on prov.encounter_id = meds.encounter_id
), immunization_base as (
    select
        ids.person_id,
        imm.encounter_id,
        imm.immunization_date as drug_exposure_start_date,
        imm.immunization_datetime as drug_exposure_start_datetime,
        imm.immunization_date as drug_exposure_end_date,
        imm.immunization_datetime as drug_exposure_end_datetime,
        imm.immunization_code as source_code,
        imm.immunization_description as source_description,
        cast(null as double) as quantity,
        std_map.target_concept_id,
        std_map.source_concept_id,
        'immunization' as record_type,
        0 as days_supply,
        prov.provider_id
    from {{ ref('immunizations') }} as imm
    join {{ ref('patient_ids') }} as ids
      on imm.patient_id = ids.patient_id
    left join {{ ref('source_to_standard_map') }} as std_map
      on std_map.source_code = imm.immunization_code
     and std_map.source_vocabulary_id = 'CVX'
     and std_map.target_domain_id = 'DRUG'
    left join encounter_providers as prov
      on prov.encounter_id = imm.encounter_id
), combined as (
    select * from medication_base
    union all
    select * from immunization_base
), visits as (
    select encounter_id, visit_occurrence_id
    from {{ ref('final_visit_ids') }}
)
select
    row_number() over (order by person_id, drug_exposure_start_datetime, source_code) as drug_exposure_id,
    person_id,
    coalesce(target_concept_id, 0) as drug_concept_id,
    drug_exposure_start_date,
    try_cast(drug_exposure_start_datetime as timestamp) as drug_exposure_start_datetime,
    coalesce(drug_exposure_end_date, drug_exposure_start_date) as drug_exposure_end_date,
    try_cast(coalesce(drug_exposure_end_datetime, drug_exposure_start_datetime) as timestamp) as drug_exposure_end_datetime,
    case when record_type = 'medication'
         then coalesce(drug_exposure_end_date, drug_exposure_start_date)
         else drug_exposure_start_date
    end as verbatim_end_date,
    case when record_type = 'medication' then 32838 else 32827 end as drug_type_concept_id,
    cast(null as text) as stop_reason,
    cast(null as integer) as refills,
    quantity as quantity,
    days_supply,
    cast(null as text) as sig,
    cast(null as integer) as route_concept_id,
    cast(null as text) as lot_number,
    provider_id,
    visits.visit_occurrence_id,
    case when visits.visit_occurrence_id is not null then visits.visit_occurrence_id + 1000000 else null end as visit_detail_id,
    source_code as drug_source_value,
    coalesce(source_concept_id, 0) as drug_source_concept_id,
    cast(null as text) as route_source_value,
    cast(null as text) as dose_unit_source_value
from combined
left join visits using (encounter_id)
