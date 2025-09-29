-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name vocab.concept_ancestor,
--   depends_on (
--     vocab.concept,
--   ),
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
SELECT * FROM vocab.concept_ancestor WHERE ANCESTOR_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'CONCEPT_ANCESTOR.ANCESTOR_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name concept_ancestor_ancestor_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM vocab.concept_ancestor c
LEFT JOIN vocab.concept p ON c.ANCESTOR_CONCEPT_ID = p.CONCEPT_ID
WHERE c.ANCESTOR_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'CONCEPT_ANCESTOR.DESCENDANT_CONCEPT_ID'.
AUDIT (
  name concept_ancestor_descendant_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.concept_ancestor WHERE DESCENDANT_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'CONCEPT_ANCESTOR.DESCENDANT_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name concept_ancestor_descendant_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM vocab.concept_ancestor c
LEFT JOIN vocab.concept p ON c.DESCENDANT_CONCEPT_ID = p.CONCEPT_ID
WHERE c.DESCENDANT_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'CONCEPT_ANCESTOR.MAX_LEVELS_OF_SEPARATION'.
AUDIT (
  name concept_ancestor_max_levels_of_separation_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.concept_ancestor WHERE MAX_LEVELS_OF_SEPARATION IS NULL;

-- Description: Check for NULLs in required field 'CONCEPT_ANCESTOR.MIN_LEVELS_OF_SEPARATION'.
AUDIT (
  name concept_ancestor_min_levels_of_separation_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.concept_ancestor WHERE MIN_LEVELS_OF_SEPARATION IS NULL;

