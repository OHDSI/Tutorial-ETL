{{ config(materialized='table', alias='note') }}

select
    cast(null as bigint) as note_id,
    cast(null as bigint) as person_id,
    cast(null as date) as note_date,
    cast(null as timestamp) as note_datetime,
    cast(null as int) as note_type_concept_id,
    cast(null as int) as note_class_concept_id,
    cast(null as text) as note_title,
    cast(null as text) as note_text,
    cast(null as int) as encoding_concept_id,
    cast(null as int) as language_concept_id,
    cast(null as bigint) as provider_id,
    cast(null as bigint) as visit_occurrence_id,
    cast(null as bigint) as visit_detail_id,
    cast(null as text) as note_source_value,
    cast(null as bigint) as note_event_id,
    cast(null as int) as note_event_field_concept_id
where 1 = 0
