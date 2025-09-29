{{ config(materialized='table', alias='source_to_standard_map') }}

with source as (
    select *
    from {{ ref('source_to_standard_vocab_map') }}
)
select
    source_code,
    cast(source_concept_id as integer) as source_concept_id,
    source_code_description,
    upper(trim(source_vocabulary_id)) as source_vocabulary_id,
    cast(target_concept_id as integer) as target_concept_id,
    target_concept_name,
    upper(trim(target_vocabulary_id)) as target_vocabulary_id,
    upper(trim(target_domain_id)) as target_domain_id,
    upper(trim(target_concept_class_id)) as target_concept_class_id
from source
where upper(trim(target_standard_concept)) = 'S'
  and upper(trim(source_vocabulary_id)) in ('SNOMED', 'ICD10CM', 'RXNORM', 'LOINC', 'UCUM', 'CVX')
