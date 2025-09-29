{{ config(materialized='table', alias='metadata') }}

select
    cast(null as bigint) as metadata_id,
    cast(null as int) as metadata_concept_id,
    cast(null as int) as metadata_type_concept_id,
    cast(null as text) as name,
    cast(null as text) as value_as_string,
    cast(null as int) as value_as_concept_id,
    cast(null as real) as value_as_number,
    cast(null as date) as metadata_date,
    cast(null as timestamp) as metadata_datetime
where 1 = 0
