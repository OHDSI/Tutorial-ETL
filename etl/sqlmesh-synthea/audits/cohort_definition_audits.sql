-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.cohort_definition,
--   audits (
--     cohort_definition_cohort_definition_id_is_required,
--     cohort_definition_cohort_definition_id_is_foreign_key,
--     cohort_definition_cohort_definition_name_is_required,
--     cohort_definition_definition_type_concept_id_is_required,
--     cohort_definition_definition_type_concept_id_is_foreign_key,
--     cohort_definition_definition_type_concept_id_is_standard_valid_concept,
--     cohort_definition_subject_concept_id_is_required,
--     cohort_definition_subject_concept_id_is_foreign_key,
--     cohort_definition_subject_concept_id_is_standard_valid_concept,
--   )
-- );

-- Description: Check for NULLs in required field 'COHORT_DEFINITION.COHORT_DEFINITION_ID'.
AUDIT (
  name cohort_definition_cohort_definition_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.COHORT_DEFINITION WHERE COHORT_DEFINITION_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'COHORT_DEFINITION.COHORT_DEFINITION_ID' pointing to 'COHORT.COHORT_DEFINITION_ID'.
        AUDIT (
          name cohort_definition_cohort_definition_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.COHORT_DEFINITION c
LEFT JOIN omop.COHORT p ON c.COHORT_DEFINITION_ID = p.COHORT_DEFINITION_ID
WHERE c.COHORT_DEFINITION_ID IS NOT NULL AND p.COHORT_DEFINITION_ID IS NULL;;

-- Description: Check for NULLs in required field 'COHORT_DEFINITION.COHORT_DEFINITION_NAME'.
AUDIT (
  name cohort_definition_cohort_definition_name_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.COHORT_DEFINITION WHERE COHORT_DEFINITION_NAME IS NULL;

-- Description: Check for NULLs in required field 'COHORT_DEFINITION.DEFINITION_TYPE_CONCEPT_ID'.
AUDIT (
  name cohort_definition_definition_type_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.COHORT_DEFINITION WHERE DEFINITION_TYPE_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'COHORT_DEFINITION.DEFINITION_TYPE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name cohort_definition_definition_type_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.COHORT_DEFINITION c
LEFT JOIN vocab.CONCEPT p ON c.DEFINITION_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.DEFINITION_TYPE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'COHORT_DEFINITION.DEFINITION_TYPE_CONCEPT_ID' are standard and valid.
        AUDIT (
          name cohort_definition_definition_type_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.COHORT_DEFINITION t
LEFT JOIN vocab.CONCEPT c ON t.DEFINITION_TYPE_CONCEPT_ID = c.concept_id
WHERE t.DEFINITION_TYPE_CONCEPT_ID IS NOT NULL
  AND t.DEFINITION_TYPE_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for NULLs in required field 'COHORT_DEFINITION.SUBJECT_CONCEPT_ID'.
AUDIT (
  name cohort_definition_subject_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.COHORT_DEFINITION WHERE SUBJECT_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'COHORT_DEFINITION.SUBJECT_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name cohort_definition_subject_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.COHORT_DEFINITION c
LEFT JOIN vocab.CONCEPT p ON c.SUBJECT_CONCEPT_ID = p.CONCEPT_ID
WHERE c.SUBJECT_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'COHORT_DEFINITION.SUBJECT_CONCEPT_ID' are standard and valid.
        AUDIT (
          name cohort_definition_subject_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.COHORT_DEFINITION t
LEFT JOIN vocab.CONCEPT c ON t.SUBJECT_CONCEPT_ID = c.concept_id
WHERE t.SUBJECT_CONCEPT_ID IS NOT NULL
  AND t.SUBJECT_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

