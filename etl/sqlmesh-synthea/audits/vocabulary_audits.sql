-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name vocab.VOCABULARY,
--   audits (
--     vocabulary_vocabulary_concept_id_is_required,
--     vocabulary_vocabulary_concept_id_is_foreign_key,
--     vocabulary_vocabulary_id_is_required,
--     vocabulary_vocabulary_id_is_primary_key,
--     vocabulary_vocabulary_name_is_required,
--   )
-- );

-- Description: Check for NULLs in required field 'VOCABULARY.VOCABULARY_CONCEPT_ID'.
AUDIT (
  name vocabulary_vocabulary_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.VOCABULARY WHERE VOCABULARY_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'VOCABULARY.VOCABULARY_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name vocabulary_vocabulary_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM vocab.VOCABULARY c
LEFT JOIN vocab.CONCEPT p ON c.VOCABULARY_CONCEPT_ID = p.CONCEPT_ID
WHERE c.VOCABULARY_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'VOCABULARY.VOCABULARY_ID'.
AUDIT (
  name vocabulary_vocabulary_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.VOCABULARY WHERE VOCABULARY_ID IS NULL;

-- Description: Check for duplicate values in primary key field 'VOCABULARY.VOCABULARY_ID'.
        AUDIT (
          name vocabulary_vocabulary_id_is_primary_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT VOCABULARY_ID, COUNT(*)
FROM vocab.VOCABULARY
WHERE VOCABULARY_ID IS NOT NULL
GROUP BY VOCABULARY_ID
HAVING COUNT(*) > 1;;

-- Description: Check for NULLs in required field 'VOCABULARY.VOCABULARY_NAME'.
AUDIT (
  name vocabulary_vocabulary_name_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.VOCABULARY WHERE VOCABULARY_NAME IS NULL;

