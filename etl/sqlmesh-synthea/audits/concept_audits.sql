-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name vocab.concept,
--   depends_on (
--     vocab.concept_class,
--     vocab.domain,
--     vocab.vocabulary,
--   ),
--   audits (
--     concept_concept_class_id_is_required,
--     concept_concept_class_id_is_foreign_key,
--     concept_concept_code_is_required,
--     concept_concept_id_is_required,
--     concept_concept_id_is_primary_key,
--     concept_concept_name_is_required,
--     concept_domain_id_is_required,
--     concept_domain_id_is_foreign_key,
--     concept_valid_end_date_is_required,
--     concept_valid_start_date_is_required,
--     concept_valid_start_date_start_before_end,
--     concept_vocabulary_id_is_required,
--     concept_vocabulary_id_is_foreign_key,
--   )
-- );

-- Description: Check for NULLs in required field 'CONCEPT.CONCEPT_CLASS_ID'.
AUDIT (
  name concept_concept_class_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.concept WHERE CONCEPT_CLASS_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'CONCEPT.CONCEPT_CLASS_ID' pointing to 'CONCEPT_CLASS.CONCEPT_CLASS_ID'.
        AUDIT (
          name concept_concept_class_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM vocab.concept c
LEFT JOIN vocab.concept_class p ON c.CONCEPT_CLASS_ID = p.CONCEPT_CLASS_ID
WHERE c.CONCEPT_CLASS_ID IS NOT NULL AND p.CONCEPT_CLASS_ID IS NULL;;

-- Description: Check for NULLs in required field 'CONCEPT.CONCEPT_CODE'.
AUDIT (
  name concept_concept_code_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.concept WHERE CONCEPT_CODE IS NULL;

-- Description: Check for NULLs in required field 'CONCEPT.CONCEPT_ID'.
AUDIT (
  name concept_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.concept WHERE CONCEPT_ID IS NULL;

-- Description: Check for duplicate values in primary key field 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name concept_concept_id_is_primary_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT CONCEPT_ID, COUNT(*)
FROM vocab.CONCEPT
WHERE CONCEPT_ID IS NOT NULL
GROUP BY CONCEPT_ID
HAVING COUNT(*) > 1;;

-- Description: Check for NULLs in required field 'CONCEPT.CONCEPT_NAME'.
AUDIT (
  name concept_concept_name_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.concept WHERE CONCEPT_NAME IS NULL;

-- Description: Check for NULLs in required field 'CONCEPT.DOMAIN_ID'.
AUDIT (
  name concept_domain_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.concept WHERE DOMAIN_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'CONCEPT.DOMAIN_ID' pointing to 'DOMAIN.DOMAIN_ID'.
        AUDIT (
          name concept_domain_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM vocab.concept c
LEFT JOIN vocab.domain p ON c.DOMAIN_ID = p.DOMAIN_ID
WHERE c.DOMAIN_ID IS NOT NULL AND p.DOMAIN_ID IS NULL;;

-- Description: Check for NULLs in required field 'CONCEPT.VALID_END_DATE'.
AUDIT (
  name concept_valid_end_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.concept WHERE VALID_END_DATE IS NULL;

-- Description: Check for NULLs in required field 'CONCEPT.VALID_START_DATE'.
AUDIT (
  name concept_valid_start_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.concept WHERE VALID_START_DATE IS NULL;

-- Description: Check that 'CONCEPT.VALID_START_DATE' occurs before 'CONCEPT.VALID_END_DATE'.
AUDIT (
  name concept_valid_start_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.concept WHERE VALID_START_DATE > VALID_END_DATE;

-- Description: Check for NULLs in required field 'CONCEPT.VOCABULARY_ID'.
AUDIT (
  name concept_vocabulary_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.concept WHERE VOCABULARY_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'CONCEPT.VOCABULARY_ID' pointing to 'VOCABULARY.VOCABULARY_ID'.
        AUDIT (
          name concept_vocabulary_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM vocab.concept c
LEFT JOIN vocab.vocabulary p ON c.VOCABULARY_ID = p.VOCABULARY_ID
WHERE c.VOCABULARY_ID IS NOT NULL AND p.VOCABULARY_ID IS NULL;;

