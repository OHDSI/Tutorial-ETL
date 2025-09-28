{{ config(materialized='table', alias='final_visit_ids') }}

select
    encounter_id,
    visit_occurrence_id
from {{ ref('assign_all_visit_ids') }}
where visit_rank = 1
