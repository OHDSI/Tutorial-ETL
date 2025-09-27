-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name vocab.CONCEPT_ancestor,
--   audits (
--     concept_ancestor_ancestor_concept_id_is_required,
--     concept_ancestor_ancestor_concept_id_is_foreign_key,
--     concept_ancestor_descendant_concept_id_is_required,
--     concept_ancestor_descendant_concept_id_is_foreign_key,
--     concept_ancestor_max_levels_of_separation_is_required,
--     concept_ancestor_min_levels_of_separation_is_required,
--   )
-- );

-- Description: Check for NULLs in required field 'CONCEPT_ANCESTOR.ANCESTOR_CONCEPT_ID'.
AUDIT (
  name concept_ancestor_ancestor_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.CONCEPT_ANCESTOR WHERE ANCESTOR_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'CONCEPT_ANCESTOR.ANCESTOR_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name concept_ancestor_ancestor_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM vocab.CONCEPT_ANCESTOR c
LEFT JOIN vocab.CONCEPT p ON c.ANCESTOR_CONCEPT_ID = p.CONCEPT_ID
WHERE c.ANCESTOR_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'CONCEPT_ANCESTOR.DESCENDANT_CONCEPT_ID'.
AUDIT (
  name concept_ancestor_descendant_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.CONCEPT_ANCESTOR WHERE DESCENDANT_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'CONCEPT_ANCESTOR.DESCENDANT_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name concept_ancestor_descendant_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM vocab.CONCEPT_ANCESTOR c
LEFT JOIN vocab.CONCEPT p ON c.DESCENDANT_CONCEPT_ID = p.CONCEPT_ID
WHERE c.DESCENDANT_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'CONCEPT_ANCESTOR.MAX_LEVELS_OF_SEPARATION'.
AUDIT (
  name concept_ancestor_max_levels_of_separation_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.CONCEPT_ANCESTOR WHERE MAX_LEVELS_OF_SEPARATION IS NULL;

-- Description: Check for NULLs in required field 'CONCEPT_ANCESTOR.MIN_LEVELS_OF_SEPARATION'.
AUDIT (
  name concept_ancestor_min_levels_of_separation_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.CONCEPT_ANCESTOR WHERE MIN_LEVELS_OF_SEPARATION IS NULL;

