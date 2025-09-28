{{ config(materialized='table', alias='payer_transitions') }}

select
    PATIENT as patient_id,
    MEMBERID as member_id,
    try_cast(START_DATE as date) as start_date,
    try_cast(END_DATE as date) as end_date,
    PAYER as payer_id,
    SECONDARY_PAYER as secondary_payer_id,
    PLAN_OWNERSHIP as plan_ownership,
    OWNER_NAME as owner_name
from {{ ref('synthea_payer_transitions') }}
