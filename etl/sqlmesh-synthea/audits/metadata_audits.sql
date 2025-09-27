-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.metadata,
--   depends_on (
--     vocab.concept,
--   ),
--   audits (
--     metadata_metadata_concept_id_is_required,
--     metadata_metadata_concept_id_is_foreign_key,
--     metadata_metadata_id_is_required,
--     metadata_metadata_id_is_primary_key,
--     metadata_metadata_type_concept_id_is_required,
--     metadata_metadata_type_concept_id_is_foreign_key,
--     metadata_name_is_required,
--     metadata_value_as_concept_id_is_foreign_key,
--   )
-- );

-- Description: Check for NULLs in required field 'METADATA.METADATA_CONCEPT_ID'.
AUDIT (
  name metadata_metadata_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.METADATA WHERE METADATA_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'METADATA.METADATA_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name metadata_metadata_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.METADATA c
LEFT JOIN vocab.concept p ON c.METADATA_CONCEPT_ID = p.CONCEPT_ID
WHERE c.METADATA_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'METADATA.METADATA_ID'.
AUDIT (
  name metadata_metadata_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.METADATA WHERE METADATA_ID IS NULL;

-- Description: Check for duplicate values in primary key field 'METADATA.METADATA_ID'.
        AUDIT (
          name metadata_metadata_id_is_primary_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT METADATA_ID, COUNT(*)
FROM omop.METADATA
WHERE METADATA_ID IS NOT NULL
GROUP BY METADATA_ID
HAVING COUNT(*) > 1;;

-- Description: Check for NULLs in required field 'METADATA.METADATA_TYPE_CONCEPT_ID'.
AUDIT (
  name metadata_metadata_type_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.METADATA WHERE METADATA_TYPE_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'METADATA.METADATA_TYPE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name metadata_metadata_type_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.METADATA c
LEFT JOIN vocab.concept p ON c.METADATA_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.METADATA_TYPE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'METADATA.NAME'.
AUDIT (
  name metadata_name_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.METADATA WHERE NAME IS NULL;

-- Description: Check for orphaned foreign keys in 'METADATA.VALUE_AS_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name metadata_value_as_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.METADATA c
LEFT JOIN vocab.concept p ON c.VALUE_AS_CONCEPT_ID = p.CONCEPT_ID
WHERE c.VALUE_AS_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

