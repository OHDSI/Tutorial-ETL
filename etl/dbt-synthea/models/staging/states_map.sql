{{ config(materialized='table', alias='states_map') }}

select
    upper(trim(state)) as state_name,
    upper(trim(state_abbreviation)) as state_abbreviation
from {{ ref('reference_states_map') }}
