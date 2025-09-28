{{ config(materialized='table', alias='note_nlp') }}

select
    cast(null as bigint) as note_nlp_id,
    cast(null as bigint) as note_id,
    cast(null as int) as section_concept_id,
    cast(null as text) as snippet,
    cast(null as text) as "offset",
    cast(null as text) as lexical_variant,
    cast(null as int) as note_nlp_concept_id,
    cast(null as int) as note_nlp_source_concept_id,
    cast(null as text) as nlp_system,
    cast(null as date) as nlp_date,
    cast(null as timestamp) as nlp_datetime,
    cast(null as text) as term_exists,
    cast(null as text) as term_temporal,
    cast(null as text) as term_modifiers
where 1 = 0
