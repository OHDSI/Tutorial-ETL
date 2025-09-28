{{ config(materialized='table', alias='conditions') }}

with source as (
    select
        PATIENT,
        ENCOUNTER,
        START,
        STOP,
        SYSTEM,
        CODE,
        DESCRIPTION
    from {{ ref('synthea_conditions') }}
)
select
    PATIENT as patient_id,
    ENCOUNTER as encounter_id,
    try_cast(START as date) as condition_start_date,
    try_cast(START as timestamp) as condition_start_datetime,
    try_cast(START as timestamp) as condition_start_ts,
    try_cast(STOP as date) as condition_end_date,
    try_cast(STOP as timestamp) as condition_end_datetime,
    try_cast(STOP as timestamp) as condition_end_ts,
    upper(trim(SYSTEM)) as source_system,
    CODE as source_code,
    CODE as condition_code,
    DESCRIPTION as source_description,
    DESCRIPTION as condition_description,
    case upper(trim(SYSTEM))
        when 'SNOMED-CT' then 'SNOMED'
        when 'ICD-10-CM' then 'ICD10CM'
        when 'ICD10CM' then 'ICD10CM'
        else upper(trim(SYSTEM))
    end as coding_system
from source
