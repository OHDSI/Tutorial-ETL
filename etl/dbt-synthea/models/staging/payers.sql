{{ config(materialized='table', alias='payers') }}

select
    Id as payer_id,
    NAME as name,
    OWNERSHIP as ownership,
    CITY,
    STATE_HEADQUARTERED as state,
    ZIP,
    PHONE
from {{ ref('synthea_payers') }}
