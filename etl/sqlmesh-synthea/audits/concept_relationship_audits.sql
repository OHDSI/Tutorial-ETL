-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name vocab.CONCEPT_relationship,
--   audits (
--     concept_relationship_concept_id_1_is_required,
--     concept_relationship_concept_id_1_is_foreign_key,
--     concept_relationship_concept_id_2_is_required,
--     concept_relationship_concept_id_2_is_foreign_key,
--     concept_relationship_relationship_id_is_required,
--     concept_relationship_relationship_id_is_foreign_key,
--     concept_relationship_valid_end_date_is_required,
--     concept_relationship_valid_start_date_is_required,
--     concept_relationship_valid_start_date_start_before_end,
--   )
-- );

-- Description: Check for NULLs in required field 'CONCEPT_RELATIONSHIP.CONCEPT_ID_1'.
AUDIT (
  name concept_relationship_concept_id_1_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.CONCEPT_RELATIONSHIP WHERE CONCEPT_ID_1 IS NULL;

-- Description: Check for orphaned foreign keys in 'CONCEPT_RELATIONSHIP.CONCEPT_ID_1' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name concept_relationship_concept_id_1_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM vocab.CONCEPT_RELATIONSHIP c
LEFT JOIN vocab.CONCEPT p ON c.CONCEPT_ID_1 = p.CONCEPT_ID
WHERE c.CONCEPT_ID_1 IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'CONCEPT_RELATIONSHIP.CONCEPT_ID_2'.
AUDIT (
  name concept_relationship_concept_id_2_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.CONCEPT_RELATIONSHIP WHERE CONCEPT_ID_2 IS NULL;

-- Description: Check for orphaned foreign keys in 'CONCEPT_RELATIONSHIP.CONCEPT_ID_2' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name concept_relationship_concept_id_2_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM vocab.CONCEPT_RELATIONSHIP c
LEFT JOIN vocab.CONCEPT p ON c.CONCEPT_ID_2 = p.CONCEPT_ID
WHERE c.CONCEPT_ID_2 IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'CONCEPT_RELATIONSHIP.RELATIONSHIP_ID'.
AUDIT (
  name concept_relationship_relationship_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.CONCEPT_RELATIONSHIP WHERE RELATIONSHIP_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'CONCEPT_RELATIONSHIP.RELATIONSHIP_ID' pointing to 'RELATIONSHIP.RELATIONSHIP_ID'.
        AUDIT (
          name concept_relationship_relationship_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM vocab.CONCEPT_RELATIONSHIP c
LEFT JOIN omop.RELATIONSHIP p ON c.RELATIONSHIP_ID = p.RELATIONSHIP_ID
WHERE c.RELATIONSHIP_ID IS NOT NULL AND p.RELATIONSHIP_ID IS NULL;;

-- Description: Check for NULLs in required field 'CONCEPT_RELATIONSHIP.VALID_END_DATE'.
AUDIT (
  name concept_relationship_valid_end_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.CONCEPT_RELATIONSHIP WHERE VALID_END_DATE IS NULL;

-- Description: Check for NULLs in required field 'CONCEPT_RELATIONSHIP.VALID_START_DATE'.
AUDIT (
  name concept_relationship_valid_start_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.CONCEPT_RELATIONSHIP WHERE VALID_START_DATE IS NULL;

-- Description: Check that 'CONCEPT_RELATIONSHIP.VALID_START_DATE' occurs before 'CONCEPT_RELATIONSHIP.VALID_END_DATE'.
AUDIT (
  name concept_relationship_valid_start_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.CONCEPT_RELATIONSHIP WHERE VALID_START_DATE > VALID_END_DATE;

