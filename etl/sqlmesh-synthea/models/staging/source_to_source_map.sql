MODEL (
  name stg.source_to_source_map,
  kind FULL,
  description 'Source-to-source vocabulary mappings filtered for relevant vocabularies',
  columns (
    source_code TEXT,
    source_concept_id INT,
    source_code_description TEXT,
    source_vocabulary_id TEXT,
    source_domain_id TEXT,
    target_concept_id INT,
    target_concept_name TEXT,
    target_vocabulary_id TEXT,
    target_domain_id TEXT
  )
);

SELECT
  source_code,
  CAST(source_concept_id AS INTEGER) AS source_concept_id,
  source_code_description,
  UPPER(TRIM(source_vocabulary_id)) AS source_vocabulary_id,
  UPPER(TRIM(source_domain_id)) AS source_domain_id,
  CAST(target_concept_id AS INTEGER) AS target_concept_id,
  target_concept_name,
  UPPER(TRIM(target_vocabulary_id)) AS target_vocabulary_id,
  UPPER(TRIM(target_domain_id)) AS target_domain_id
FROM vocab.source_to_source_vocab_map
WHERE COALESCE(target_invalid_reason, '') = '';
