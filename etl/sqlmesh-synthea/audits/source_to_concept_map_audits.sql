-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.source_to_concept_map,
--   depends_on (
--     vocab.concept,
--     vocab.vocabulary,
--   ),
--   audits (
--     source_to_concept_map_source_code_is_required,
--     source_to_concept_map_source_concept_id_is_required,
--     source_to_concept_map_source_concept_id_is_foreign_key,
--     source_to_concept_map_source_vocabulary_id_is_required,
--     source_to_concept_map_target_concept_id_is_required,
--     source_to_concept_map_target_concept_id_is_foreign_key,
--     source_to_concept_map_target_concept_id_is_standard_valid_concept,
--     source_to_concept_map_target_vocabulary_id_is_required,
--     source_to_concept_map_target_vocabulary_id_is_foreign_key,
--     source_to_concept_map_valid_end_date_is_required,
--     source_to_concept_map_valid_start_date_is_required,
--     source_to_concept_map_valid_start_date_start_before_end,
--   )
-- );

-- Description: Check for NULLs in required field 'SOURCE_TO_CONCEPT_MAP.SOURCE_CODE'.
AUDIT (
  name source_to_concept_map_source_code_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.SOURCE_TO_CONCEPT_MAP WHERE SOURCE_CODE IS NULL;

-- Description: Check for NULLs in required field 'SOURCE_TO_CONCEPT_MAP.SOURCE_CONCEPT_ID'.
AUDIT (
  name source_to_concept_map_source_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.SOURCE_TO_CONCEPT_MAP WHERE SOURCE_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'SOURCE_TO_CONCEPT_MAP.SOURCE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name source_to_concept_map_source_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.SOURCE_TO_CONCEPT_MAP c
LEFT JOIN vocab.concept p ON c.SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.SOURCE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'SOURCE_TO_CONCEPT_MAP.SOURCE_VOCABULARY_ID'.
AUDIT (
  name source_to_concept_map_source_vocabulary_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.SOURCE_TO_CONCEPT_MAP WHERE SOURCE_VOCABULARY_ID IS NULL;

-- Description: Check for NULLs in required field 'SOURCE_TO_CONCEPT_MAP.TARGET_CONCEPT_ID'.
AUDIT (
  name source_to_concept_map_target_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.SOURCE_TO_CONCEPT_MAP WHERE TARGET_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'SOURCE_TO_CONCEPT_MAP.TARGET_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name source_to_concept_map_target_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.SOURCE_TO_CONCEPT_MAP c
LEFT JOIN vocab.concept p ON c.TARGET_CONCEPT_ID = p.CONCEPT_ID
WHERE c.TARGET_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'SOURCE_TO_CONCEPT_MAP.TARGET_CONCEPT_ID' are standard and valid.
        AUDIT (
          name source_to_concept_map_target_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.SOURCE_TO_CONCEPT_MAP t
LEFT JOIN vocab.concept c ON t.TARGET_CONCEPT_ID = c.concept_id
WHERE t.TARGET_CONCEPT_ID IS NOT NULL
  AND t.TARGET_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for NULLs in required field 'SOURCE_TO_CONCEPT_MAP.TARGET_VOCABULARY_ID'.
AUDIT (
  name source_to_concept_map_target_vocabulary_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.SOURCE_TO_CONCEPT_MAP WHERE TARGET_VOCABULARY_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'SOURCE_TO_CONCEPT_MAP.TARGET_VOCABULARY_ID' pointing to 'VOCABULARY.VOCABULARY_ID'.
        AUDIT (
          name source_to_concept_map_target_vocabulary_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.SOURCE_TO_CONCEPT_MAP c
LEFT JOIN vocab.vocabulary p ON c.TARGET_VOCABULARY_ID = p.VOCABULARY_ID
WHERE c.TARGET_VOCABULARY_ID IS NOT NULL AND p.VOCABULARY_ID IS NULL;;

-- Description: Check for NULLs in required field 'SOURCE_TO_CONCEPT_MAP.VALID_END_DATE'.
AUDIT (
  name source_to_concept_map_valid_end_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.SOURCE_TO_CONCEPT_MAP WHERE VALID_END_DATE IS NULL;

-- Description: Check for NULLs in required field 'SOURCE_TO_CONCEPT_MAP.VALID_START_DATE'.
AUDIT (
  name source_to_concept_map_valid_start_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.SOURCE_TO_CONCEPT_MAP WHERE VALID_START_DATE IS NULL;

-- Description: Check that 'SOURCE_TO_CONCEPT_MAP.VALID_START_DATE' occurs before 'SOURCE_TO_CONCEPT_MAP.VALID_END_DATE'.
AUDIT (
  name source_to_concept_map_valid_start_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.SOURCE_TO_CONCEPT_MAP WHERE VALID_START_DATE > VALID_END_DATE;

