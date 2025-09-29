{{ config(materialized='table', alias='observations') }}

with source as (
    select
        DATE,
        PATIENT,
        ENCOUNTER,
        CATEGORY,
        CODE,
        DESCRIPTION,
        VALUE,
        UNITS,
        TYPE
    from {{ ref('synthea_observations') }}
), typed as (
    select
        PATIENT as patient_id,
        ENCOUNTER as encounter_id,
        try_cast(DATE as timestamp) as observation_ts,
        lower(trim(CATEGORY)) as category,
        CODE as source_code,
        DESCRIPTION as source_description,
        trim(UNITS) as unit_source_value,
        trim(TYPE) as value_type,
        try_cast(VALUE as double) as numeric_value,
        VALUE as value_source_value,
        VALUE as observation_value,
        'LOINC' as source_vocabulary_id
    from source
)
select
    patient_id,
    encounter_id,
    cast(observation_ts as date) as observation_date,
    observation_ts as observation_datetime,
    observation_ts,
    observation_ts as observation_start_ts,
    category,
    source_code,
    source_code as observation_code,
    source_description,
    unit_source_value,
    unit_source_value as observation_units,
    value_type,
    numeric_value,
    value_source_value,
    source_vocabulary_id
from typed
