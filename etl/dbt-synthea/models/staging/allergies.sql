{{ config(materialized='table', alias='allergies') }}

with source as (
    select *
    from {{ ref('synthea_allergies') }}
)
select
    PATIENT as patient_id,
    ENCOUNTER as encounter_id,
    try_cast(START as date) as allergy_start_date,
    try_cast(START as timestamp) as allergy_start_datetime,
    try_cast(STOP as date) as allergy_end_date,
    try_cast(STOP as timestamp) as allergy_end_datetime,
    CODE as allergy_code,
    DESCRIPTION as allergy_description,
    upper(trim(SYSTEM)) as source_system,
    case upper(trim(SYSTEM))
        when 'SNOMED-CT' then 'SNOMED'
        else upper(trim(SYSTEM))
    end as coding_system
from source
