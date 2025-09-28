{{ config(materialized='table', alias='procedures') }}

with source as (
    select
        START,
        STOP,
        PATIENT,
        ENCOUNTER,
        SYSTEM,
        CODE,
        DESCRIPTION
    from {{ ref('synthea_procedures') }}
)
select
    PATIENT as patient_id,
    ENCOUNTER as encounter_id,
    try_cast(START as date) as procedure_date,
    try_cast(START as timestamp) as procedure_datetime,
    try_cast(STOP as date) as procedure_end_date,
    try_cast(STOP as timestamp) as procedure_end_datetime,
    CODE as source_code,
    CODE as procedure_code,
    DESCRIPTION as source_description,
    DESCRIPTION as procedure_description,
    'SNOMED' as source_vocabulary_id
from source
