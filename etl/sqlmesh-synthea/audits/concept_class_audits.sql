-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.concept_class,
--   audits (
--     concept_class_concept_class_concept_id_is_required,
--     concept_class_concept_class_concept_id_is_foreign_key,
--     concept_class_concept_class_id_is_required,
--     concept_class_concept_class_id_is_primary_key,
--     concept_class_concept_class_name_is_required,
--   )
-- );

-- Description: Check for NULLs in required field 'CONCEPT_CLASS.CONCEPT_CLASS_CONCEPT_ID'.
AUDIT (
  name concept_class_concept_class_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CONCEPT_CLASS WHERE CONCEPT_CLASS_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'CONCEPT_CLASS.CONCEPT_CLASS_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name concept_class_concept_class_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.CONCEPT_CLASS c
LEFT JOIN omop.CONCEPT p ON c.CONCEPT_CLASS_CONCEPT_ID = p.CONCEPT_ID
WHERE c.CONCEPT_CLASS_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'CONCEPT_CLASS.CONCEPT_CLASS_ID'.
AUDIT (
  name concept_class_concept_class_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CONCEPT_CLASS WHERE CONCEPT_CLASS_ID IS NULL;

-- Description: Check for duplicate values in primary key field 'CONCEPT_CLASS.CONCEPT_CLASS_ID'.
        AUDIT (
          name concept_class_concept_class_id_is_primary_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT CONCEPT_CLASS_ID, COUNT(*)
FROM omop.CONCEPT_CLASS
WHERE CONCEPT_CLASS_ID IS NOT NULL
GROUP BY CONCEPT_CLASS_ID
HAVING COUNT(*) > 1;;

-- Description: Check for NULLs in required field 'CONCEPT_CLASS.CONCEPT_CLASS_NAME'.
AUDIT (
  name concept_class_concept_class_name_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CONCEPT_CLASS WHERE CONCEPT_CLASS_NAME IS NULL;

