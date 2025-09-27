-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name vocab.domain,
--   depends_on (
--     vocab.concept,
--   ),
--   audits (
--     domain_domain_concept_id_is_required,
--     domain_domain_concept_id_is_foreign_key,
--     domain_domain_id_is_required,
--     domain_domain_id_is_primary_key,
--     domain_domain_name_is_required,
--   )
-- );

-- Description: Check for NULLs in required field 'DOMAIN.DOMAIN_CONCEPT_ID'.
AUDIT (
  name domain_domain_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.domain WHERE DOMAIN_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'DOMAIN.DOMAIN_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name domain_domain_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM vocab.domain c
LEFT JOIN vocab.concept p ON c.DOMAIN_CONCEPT_ID = p.CONCEPT_ID
WHERE c.DOMAIN_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'DOMAIN.DOMAIN_ID'.
AUDIT (
  name domain_domain_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.domain WHERE DOMAIN_ID IS NULL;

-- Description: Check for duplicate values in primary key field 'DOMAIN.DOMAIN_ID'.
        AUDIT (
          name domain_domain_id_is_primary_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT DOMAIN_ID, COUNT(*)
FROM vocab.DOMAIN
WHERE DOMAIN_ID IS NOT NULL
GROUP BY DOMAIN_ID
HAVING COUNT(*) > 1;;

-- Description: Check for NULLs in required field 'DOMAIN.DOMAIN_NAME'.
AUDIT (
  name domain_domain_name_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM vocab.domain WHERE DOMAIN_NAME IS NULL;

