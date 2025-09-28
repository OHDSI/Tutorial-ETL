{{ config(materialized='table', alias='devices') }}

select
    PATIENT as patient_id,
    ENCOUNTER as encounter_id,
    try_cast(START as date) as device_start_date,
    try_cast(START as timestamp) as device_start_datetime,
    try_cast(STOP as date) as device_end_date,
    try_cast(STOP as timestamp) as device_end_datetime,
    CODE as device_code,
    DESCRIPTION as device_description,
    UDI as unique_device_id,
    'SNOMED' as source_vocabulary_id
from {{ ref('synthea_devices') }}
