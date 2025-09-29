{{ config(materialized='table', alias='source_to_source_map') }}

select
    source_code,
    cast(source_concept_id as integer) as source_concept_id,
    source_code_description,
    upper(trim(source_vocabulary_id)) as source_vocabulary_id,
    upper(trim(source_domain_id)) as source_domain_id,
    cast(target_concept_id as integer) as target_concept_id,
    target_concept_name,
    upper(trim(target_vocabulary_id)) as target_vocabulary_id,
    upper(trim(target_domain_id)) as target_domain_id
from {{ ref('source_to_source_vocab_map') }}
where coalesce(target_invalid_reason, '') = ''
