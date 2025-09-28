{{ config(materialized='table', alias='episode_event') }}

select
    cast(null as bigint) as episode_id,
    cast(null as bigint) as event_id,
    cast(null as int) as episode_event_field_concept_id
where 1 = 0
