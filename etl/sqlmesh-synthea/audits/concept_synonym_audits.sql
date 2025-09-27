-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.concept_synonym,
--   depends_on (
--     vocab.concept,
--   ),
--   audits (
--     concept_synonym_concept_id_is_required,
--     concept_synonym_concept_id_is_foreign_key,
--     concept_synonym_concept_synonym_name_is_required,
--     concept_synonym_language_concept_id_is_required,
--     concept_synonym_language_concept_id_is_foreign_key,
--   )
-- );

-- Description: Check for NULLs in required field 'CONCEPT_SYNONYM.CONCEPT_ID'.
AUDIT (
  name concept_synonym_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.CONCEPT_SYNONYM WHERE CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'CONCEPT_SYNONYM.CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name concept_synonym_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM vocab.CONCEPT_SYNONYM c
LEFT JOIN vocab.concept p ON c.CONCEPT_ID = p.CONCEPT_ID
WHERE c.CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'CONCEPT_SYNONYM.CONCEPT_SYNONYM_NAME'.
AUDIT (
  name concept_synonym_concept_synonym_name_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.CONCEPT_SYNONYM WHERE CONCEPT_SYNONYM_NAME IS NULL;

-- Description: Check for NULLs in required field 'CONCEPT_SYNONYM.LANGUAGE_CONCEPT_ID'.
AUDIT (
  name concept_synonym_language_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.CONCEPT_SYNONYM WHERE LANGUAGE_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'CONCEPT_SYNONYM.LANGUAGE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name concept_synonym_language_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM vocab.CONCEPT_SYNONYM c
LEFT JOIN vocab.concept p ON c.LANGUAGE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.LANGUAGE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

