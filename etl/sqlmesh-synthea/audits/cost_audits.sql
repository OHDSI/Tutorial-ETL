-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.cost,
--   audits (
--     cost_cost_domain_id_is_required,
--     cost_cost_domain_id_is_foreign_key,
--     cost_cost_event_id_is_required,
--     cost_cost_id_is_required,
--     cost_cost_id_is_primary_key,
--     cost_cost_type_concept_id_is_required,
--     cost_cost_type_concept_id_is_foreign_key,
--     cost_cost_type_concept_id_is_standard_valid_concept,
--     cost_cost_type_concept_id_standard_concept_record_completeness,
--     cost_currency_concept_id_is_foreign_key,
--     cost_drg_concept_id_is_foreign_key,
--     cost_revenue_code_concept_id_is_foreign_key,
--   )
-- );

-- Description: Check for NULLs in required field 'COST.COST_DOMAIN_ID'.
AUDIT (
  name cost_cost_domain_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.COST WHERE COST_DOMAIN_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'COST.COST_DOMAIN_ID' pointing to 'DOMAIN.DOMAIN_ID'.
        AUDIT (
          name cost_cost_domain_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.COST c
LEFT JOIN vocab.DOMAIN p ON c.COST_DOMAIN_ID = p.DOMAIN_ID
WHERE c.COST_DOMAIN_ID IS NOT NULL AND p.DOMAIN_ID IS NULL;;

-- Description: Check for NULLs in required field 'COST.COST_EVENT_ID'.
AUDIT (
  name cost_cost_event_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.COST WHERE COST_EVENT_ID IS NULL;

-- Description: Check for NULLs in required field 'COST.COST_ID'.
AUDIT (
  name cost_cost_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.COST WHERE COST_ID IS NULL;

-- Description: Check for duplicate values in primary key field 'COST.COST_ID'.
        AUDIT (
          name cost_cost_id_is_primary_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT COST_ID, COUNT(*)
FROM omop.COST
WHERE COST_ID IS NOT NULL
GROUP BY COST_ID
HAVING COUNT(*) > 1;;

-- Description: Check for NULLs in required field 'COST.COST_TYPE_CONCEPT_ID'.
AUDIT (
  name cost_cost_type_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.COST WHERE COST_TYPE_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'COST.COST_TYPE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name cost_cost_type_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.COST c
LEFT JOIN vocab.CONCEPT p ON c.COST_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.COST_TYPE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'COST.COST_TYPE_CONCEPT_ID' are standard and valid.
        AUDIT (
          name cost_cost_type_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.COST t
LEFT JOIN vocab.CONCEPT c ON t.COST_TYPE_CONCEPT_ID = c.concept_id
WHERE t.COST_TYPE_CONCEPT_ID IS NOT NULL
  AND t.COST_TYPE_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'COST.COST_TYPE_CONCEPT_ID'.
AUDIT (
  name cost_cost_type_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.COST WHERE COST_TYPE_CONCEPT_ID = 0;

-- Description: Check for orphaned foreign keys in 'COST.CURRENCY_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name cost_currency_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.COST c
LEFT JOIN vocab.CONCEPT p ON c.CURRENCY_CONCEPT_ID = p.CONCEPT_ID
WHERE c.CURRENCY_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'COST.DRG_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name cost_drg_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.COST c
LEFT JOIN vocab.CONCEPT p ON c.DRG_CONCEPT_ID = p.CONCEPT_ID
WHERE c.DRG_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'COST.REVENUE_CODE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name cost_revenue_code_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.COST c
LEFT JOIN vocab.CONCEPT p ON c.REVENUE_CODE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.REVENUE_CODE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

