{{ config(materialized='table', alias='medications') }}

with source as (
    select
        START,
        STOP,
        PATIENT,
        PAYER,
        ENCOUNTER,
        CODE,
        DESCRIPTION,
        BASE_COST,
        PAYER_COVERAGE,
        DISPENSES,
        TOTALCOST
    from {{ ref('synthea_medications') }}
)
select
    PATIENT as patient_id,
    ENCOUNTER as encounter_id,
    try_cast(START as date) as drug_exposure_start_date,
    try_cast(START as timestamp) as drug_exposure_start_datetime,
    try_cast(START as timestamp) as medication_start_ts,
    try_cast(STOP as date) as drug_exposure_end_date,
    try_cast(STOP as timestamp) as drug_exposure_end_datetime,
    try_cast(STOP as timestamp) as medication_end_ts,
    CODE as source_code,
    CODE as medication_code,
    DESCRIPTION as source_description,
    DESCRIPTION as medication_description,
    try_cast(DISPENSES as double) as quantity,
    try_cast(BASE_COST as double) as base_cost,
    try_cast(TOTALCOST as double) as total_cost,
    'RXNORM' as source_vocabulary_id
from source
