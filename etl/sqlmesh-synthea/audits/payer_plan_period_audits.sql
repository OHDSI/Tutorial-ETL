-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.payer_plan_period,
--   depends_on (
--     vocab.concept,
--     omop.person,
--   ),
--   audits (
--     person_completeness_payer_plan_period,
--     payer_plan_period_payer_concept_id_is_foreign_key,
--     payer_plan_period_payer_plan_period_end_date_is_required,
--     payer_plan_period_payer_plan_period_end_date_after_birth,
--     payer_plan_period_payer_plan_period_id_is_required,
--     payer_plan_period_payer_plan_period_id_is_primary_key,
--     payer_plan_period_payer_plan_period_start_date_is_required,
--     payer_plan_period_payer_plan_period_start_date_start_before_end,
--     payer_plan_period_payer_plan_period_start_date_after_birth,
--     payer_plan_period_payer_source_concept_id_is_foreign_key,
--     payer_plan_period_person_id_is_required,
--     payer_plan_period_person_id_is_foreign_key,
--     payer_plan_period_plan_concept_id_is_foreign_key,
--     payer_plan_period_plan_source_concept_id_is_foreign_key,
--     payer_plan_period_sponsor_concept_id_is_foreign_key,
--     payer_plan_period_sponsor_source_concept_id_is_foreign_key,
--     payer_plan_period_stop_reason_concept_id_is_foreign_key,
--     payer_plan_period_stop_reason_source_concept_id_is_foreign_key,
--   )
-- );

-- Description: Check for persons missing from table 'PAYER_PLAN_PERIOD'.
        AUDIT (
          name person_completeness_payer_plan_period,
          dialect duckdb,
          blocking FALSE
        );
        SELECT p.person_id
FROM omop.person p
LEFT JOIN omop.PAYER_PLAN_PERIOD e ON p.person_id = e.person_id
WHERE e.person_id IS NULL;;

-- Description: Check for orphaned foreign keys in 'PAYER_PLAN_PERIOD.PAYER_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name payer_plan_period_payer_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PAYER_PLAN_PERIOD c
LEFT JOIN vocab.concept p ON c.PAYER_CONCEPT_ID = p.CONCEPT_ID
WHERE c.PAYER_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'PAYER_PLAN_PERIOD.PAYER_PLAN_PERIOD_END_DATE'.
AUDIT (
  name payer_plan_period_payer_plan_period_end_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.PAYER_PLAN_PERIOD WHERE PAYER_PLAN_PERIOD_END_DATE IS NULL;

-- Description: Check that date 'PAYER_PLAN_PERIOD.PAYER_PLAN_PERIOD_END_DATE' is after person's birth date.
        AUDIT (
          name payer_plan_period_payer_plan_period_end_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PAYER_PLAN_PERIOD t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PAYER_PLAN_PERIOD_END_DATE < p.birth_datetime;;

-- Description: Check for NULLs in required field 'PAYER_PLAN_PERIOD.PAYER_PLAN_PERIOD_ID'.
AUDIT (
  name payer_plan_period_payer_plan_period_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.PAYER_PLAN_PERIOD WHERE PAYER_PLAN_PERIOD_ID IS NULL;

-- Description: Check for duplicate values in primary key field 'PAYER_PLAN_PERIOD.PAYER_PLAN_PERIOD_ID'.
        AUDIT (
          name payer_plan_period_payer_plan_period_id_is_primary_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT PAYER_PLAN_PERIOD_ID, COUNT(*)
FROM omop.PAYER_PLAN_PERIOD
WHERE PAYER_PLAN_PERIOD_ID IS NOT NULL
GROUP BY PAYER_PLAN_PERIOD_ID
HAVING COUNT(*) > 1;;

-- Description: Check for NULLs in required field 'PAYER_PLAN_PERIOD.PAYER_PLAN_PERIOD_START_DATE'.
AUDIT (
  name payer_plan_period_payer_plan_period_start_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.PAYER_PLAN_PERIOD WHERE PAYER_PLAN_PERIOD_START_DATE IS NULL;

-- Description: Check that 'PAYER_PLAN_PERIOD.PAYER_PLAN_PERIOD_START_DATE' occurs before 'PAYER_PLAN_PERIOD.PAYER_PLAN_PERIOD_END_DATE'.
AUDIT (
  name payer_plan_period_payer_plan_period_start_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.PAYER_PLAN_PERIOD WHERE PAYER_PLAN_PERIOD_START_DATE > PAYER_PLAN_PERIOD_END_DATE;

-- Description: Check that date 'PAYER_PLAN_PERIOD.PAYER_PLAN_PERIOD_START_DATE' is after person's birth date.
        AUDIT (
          name payer_plan_period_payer_plan_period_start_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PAYER_PLAN_PERIOD t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PAYER_PLAN_PERIOD_START_DATE < p.birth_datetime;;

-- Description: Check for orphaned foreign keys in 'PAYER_PLAN_PERIOD.PAYER_SOURCE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name payer_plan_period_payer_source_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PAYER_PLAN_PERIOD c
LEFT JOIN vocab.concept p ON c.PAYER_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.PAYER_SOURCE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'PAYER_PLAN_PERIOD.PERSON_ID'.
AUDIT (
  name payer_plan_period_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.PAYER_PLAN_PERIOD WHERE PERSON_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'PAYER_PLAN_PERIOD.PERSON_ID' pointing to 'PERSON.PERSON_ID'.
        AUDIT (
          name payer_plan_period_person_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PAYER_PLAN_PERIOD c
LEFT JOIN omop.PERSON p ON c.PERSON_ID = p.PERSON_ID
WHERE c.PERSON_ID IS NOT NULL AND p.PERSON_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'PAYER_PLAN_PERIOD.PLAN_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name payer_plan_period_plan_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PAYER_PLAN_PERIOD c
LEFT JOIN vocab.concept p ON c.PLAN_CONCEPT_ID = p.CONCEPT_ID
WHERE c.PLAN_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'PAYER_PLAN_PERIOD.PLAN_SOURCE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name payer_plan_period_plan_source_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PAYER_PLAN_PERIOD c
LEFT JOIN vocab.concept p ON c.PLAN_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.PLAN_SOURCE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'PAYER_PLAN_PERIOD.SPONSOR_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name payer_plan_period_sponsor_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PAYER_PLAN_PERIOD c
LEFT JOIN vocab.concept p ON c.SPONSOR_CONCEPT_ID = p.CONCEPT_ID
WHERE c.SPONSOR_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'PAYER_PLAN_PERIOD.SPONSOR_SOURCE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name payer_plan_period_sponsor_source_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PAYER_PLAN_PERIOD c
LEFT JOIN vocab.concept p ON c.SPONSOR_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.SPONSOR_SOURCE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'PAYER_PLAN_PERIOD.STOP_REASON_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name payer_plan_period_stop_reason_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PAYER_PLAN_PERIOD c
LEFT JOIN vocab.concept p ON c.STOP_REASON_CONCEPT_ID = p.CONCEPT_ID
WHERE c.STOP_REASON_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'PAYER_PLAN_PERIOD.STOP_REASON_SOURCE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name payer_plan_period_stop_reason_source_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PAYER_PLAN_PERIOD c
LEFT JOIN vocab.concept p ON c.STOP_REASON_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.STOP_REASON_SOURCE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

