-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.relationship,
--   depends_on (
--     vocab.concept,
--   ),
--   audits (
--     relationship_defines_ancestry_is_required,
--     relationship_is_hierarchical_is_required,
--     relationship_relationship_concept_id_is_required,
--     relationship_relationship_concept_id_is_foreign_key,
--     relationship_relationship_id_is_required,
--     relationship_relationship_id_is_primary_key,
--     relationship_relationship_name_is_required,
--     relationship_reverse_relationship_id_is_required,
--   )
-- );

-- Description: Check for NULLs in required field 'RELATIONSHIP.DEFINES_ANCESTRY'.
AUDIT (
  name relationship_defines_ancestry_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.RELATIONSHIP WHERE DEFINES_ANCESTRY IS NULL;

-- Description: Check for NULLs in required field 'RELATIONSHIP.IS_HIERARCHICAL'.
AUDIT (
  name relationship_is_hierarchical_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.RELATIONSHIP WHERE IS_HIERARCHICAL IS NULL;

-- Description: Check for NULLs in required field 'RELATIONSHIP.RELATIONSHIP_CONCEPT_ID'.
AUDIT (
  name relationship_relationship_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.RELATIONSHIP WHERE RELATIONSHIP_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'RELATIONSHIP.RELATIONSHIP_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name relationship_relationship_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.RELATIONSHIP c
LEFT JOIN vocab.concept p ON c.RELATIONSHIP_CONCEPT_ID = p.CONCEPT_ID
WHERE c.RELATIONSHIP_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'RELATIONSHIP.RELATIONSHIP_ID'.
AUDIT (
  name relationship_relationship_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.RELATIONSHIP WHERE RELATIONSHIP_ID IS NULL;

-- Description: Check for duplicate values in primary key field 'RELATIONSHIP.RELATIONSHIP_ID'.
        AUDIT (
          name relationship_relationship_id_is_primary_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT RELATIONSHIP_ID, COUNT(*)
FROM omop.RELATIONSHIP
WHERE RELATIONSHIP_ID IS NOT NULL
GROUP BY RELATIONSHIP_ID
HAVING COUNT(*) > 1;;

-- Description: Check for NULLs in required field 'RELATIONSHIP.RELATIONSHIP_NAME'.
AUDIT (
  name relationship_relationship_name_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.RELATIONSHIP WHERE RELATIONSHIP_NAME IS NULL;

-- Description: Check for NULLs in required field 'RELATIONSHIP.REVERSE_RELATIONSHIP_ID'.
AUDIT (
  name relationship_reverse_relationship_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.RELATIONSHIP WHERE REVERSE_RELATIONSHIP_ID IS NULL;

