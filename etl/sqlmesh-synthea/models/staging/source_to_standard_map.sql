MODEL (
  name stg.source_to_standard_map,
  kind FULL,
  description 'Filtered vocabulary mappings needed for Synthea sources',
  columns (
    source_code TEXT,
    source_concept_id INT,
    source_code_description TEXT,
    source_vocabulary_id TEXT,
    target_concept_id INT,
    target_concept_name TEXT,
    target_vocabulary_id TEXT,
    target_domain_id TEXT,
    target_concept_class_id TEXT
  )
);

WITH source AS (
  SELECT * FROM vocab.source_to_standard_vocab_map
)
SELECT
  source_code,
  CAST(source_concept_id AS INTEGER) AS source_concept_id,
  source_code_description,
  UPPER(TRIM(source_vocabulary_id)) AS source_vocabulary_id,
  CAST(target_concept_id AS INTEGER) AS target_concept_id,
  target_concept_name,
  UPPER(TRIM(target_vocabulary_id)) AS target_vocabulary_id,
  UPPER(TRIM(target_domain_id)) AS target_domain_id,
  UPPER(TRIM(target_concept_class_id)) AS target_concept_class_id
FROM source
WHERE UPPER(TRIM(target_standard_concept)) = 'S'
  AND UPPER(TRIM(source_vocabulary_id)) IN ('SNOMED', 'ICD10CM', 'RXNORM', 'LOINC', 'UCUM', 'CVX');
