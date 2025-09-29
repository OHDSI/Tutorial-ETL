{{ config(materialized='table', alias='patient_ids') }}

select
    patient_id,
    row_number() over (order by patient_id) as person_id
from (
    select distinct patient_id from {{ ref('patients') }}
)
