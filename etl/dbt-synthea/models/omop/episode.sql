{{ config(materialized='table', alias='episode') }}

select
    cast(null as bigint) as episode_id,
    cast(null as bigint) as person_id,
    cast(null as int) as episode_concept_id,
    cast(null as date) as episode_start_date,
    cast(null as timestamp) as episode_start_datetime,
    cast(null as date) as episode_end_date,
    cast(null as timestamp) as episode_end_datetime,
    cast(null as bigint) as episode_parent_id,
    cast(null as int) as episode_number,
    cast(null as int) as episode_object_concept_id,
    cast(null as int) as episode_type_concept_id,
    cast(null as text) as episode_source_value,
    cast(null as int) as episode_source_concept_id
where 1 = 0
