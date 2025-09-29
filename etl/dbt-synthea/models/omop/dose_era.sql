{{ config(materialized='table', alias='dose_era') }}

select
    cast(null as bigint) as dose_era_id,
    cast(null as bigint) as person_id,
    cast(null as int) as drug_concept_id,
    cast(null as int) as unit_concept_id,
    cast(null as real) as dose_value,
    cast(null as date) as dose_era_start_date,
    cast(null as date) as dose_era_end_date
where 1 = 0
