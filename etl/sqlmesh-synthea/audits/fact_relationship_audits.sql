-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.fact_relationship,
--   depends_on (
--     vocab.concept,
--   ),
--   audits (
--     fact_relationship_domain_concept_id_1_is_required,
--     fact_relationship_domain_concept_id_1_is_foreign_key,
--     fact_relationship_domain_concept_id_1_standard_concept_record_completeness,
--     fact_relationship_domain_concept_id_2_is_required,
--     fact_relationship_domain_concept_id_2_is_foreign_key,
--     fact_relationship_domain_concept_id_2_standard_concept_record_completeness,
--     fact_relationship_fact_id_1_is_required,
--     fact_relationship_fact_id_2_is_required,
--     fact_relationship_relationship_concept_id_is_required,
--     fact_relationship_relationship_concept_id_is_foreign_key,
--     fact_relationship_relationship_concept_id_standard_concept_record_completeness,
--   )
-- );

-- Description: Check for NULLs in required field 'FACT_RELATIONSHIP.DOMAIN_CONCEPT_ID_1'.
AUDIT (
  name fact_relationship_domain_concept_id_1_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.FACT_RELATIONSHIP WHERE DOMAIN_CONCEPT_ID_1 IS NULL;

-- Description: Check for orphaned foreign keys in 'FACT_RELATIONSHIP.DOMAIN_CONCEPT_ID_1' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name fact_relationship_domain_concept_id_1_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.FACT_RELATIONSHIP c
LEFT JOIN vocab.concept p ON c.DOMAIN_CONCEPT_ID_1 = p.CONCEPT_ID
WHERE c.DOMAIN_CONCEPT_ID_1 IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for concept ID 0 in standard concept field 'FACT_RELATIONSHIP.DOMAIN_CONCEPT_ID_1'.
AUDIT (
  name fact_relationship_domain_concept_id_1_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.FACT_RELATIONSHIP WHERE DOMAIN_CONCEPT_ID_1 = 0;

-- Description: Check for NULLs in required field 'FACT_RELATIONSHIP.DOMAIN_CONCEPT_ID_2'.
AUDIT (
  name fact_relationship_domain_concept_id_2_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.FACT_RELATIONSHIP WHERE DOMAIN_CONCEPT_ID_2 IS NULL;

-- Description: Check for orphaned foreign keys in 'FACT_RELATIONSHIP.DOMAIN_CONCEPT_ID_2' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name fact_relationship_domain_concept_id_2_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.FACT_RELATIONSHIP c
LEFT JOIN vocab.concept p ON c.DOMAIN_CONCEPT_ID_2 = p.CONCEPT_ID
WHERE c.DOMAIN_CONCEPT_ID_2 IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for concept ID 0 in standard concept field 'FACT_RELATIONSHIP.DOMAIN_CONCEPT_ID_2'.
AUDIT (
  name fact_relationship_domain_concept_id_2_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.FACT_RELATIONSHIP WHERE DOMAIN_CONCEPT_ID_2 = 0;

-- Description: Check for NULLs in required field 'FACT_RELATIONSHIP.FACT_ID_1'.
AUDIT (
  name fact_relationship_fact_id_1_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.FACT_RELATIONSHIP WHERE FACT_ID_1 IS NULL;

-- Description: Check for NULLs in required field 'FACT_RELATIONSHIP.FACT_ID_2'.
AUDIT (
  name fact_relationship_fact_id_2_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.FACT_RELATIONSHIP WHERE FACT_ID_2 IS NULL;

-- Description: Check for NULLs in required field 'FACT_RELATIONSHIP.RELATIONSHIP_CONCEPT_ID'.
AUDIT (
  name fact_relationship_relationship_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.FACT_RELATIONSHIP WHERE RELATIONSHIP_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'FACT_RELATIONSHIP.RELATIONSHIP_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name fact_relationship_relationship_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.FACT_RELATIONSHIP c
LEFT JOIN vocab.concept p ON c.RELATIONSHIP_CONCEPT_ID = p.CONCEPT_ID
WHERE c.RELATIONSHIP_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for concept ID 0 in standard concept field 'FACT_RELATIONSHIP.RELATIONSHIP_CONCEPT_ID'.
AUDIT (
  name fact_relationship_relationship_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.FACT_RELATIONSHIP WHERE RELATIONSHIP_CONCEPT_ID = 0;

