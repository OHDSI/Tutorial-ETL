-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.cohort,
--   audits (
--     cohort_cohort_definition_id_is_required,
--     cohort_cohort_end_date_is_required,
--     cohort_cohort_start_date_is_required,
--     cohort_subject_id_is_required,
--   )
-- );

-- Description: Check for NULLs in required field 'COHORT.COHORT_DEFINITION_ID'.
AUDIT (
  name cohort_cohort_definition_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.COHORT WHERE COHORT_DEFINITION_ID IS NULL;

-- Description: Check for NULLs in required field 'COHORT.COHORT_END_DATE'.
AUDIT (
  name cohort_cohort_end_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.COHORT WHERE COHORT_END_DATE IS NULL;

-- Description: Check for NULLs in required field 'COHORT.COHORT_START_DATE'.
AUDIT (
  name cohort_cohort_start_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.COHORT WHERE COHORT_START_DATE IS NULL;

-- Description: Check for NULLs in required field 'COHORT.SUBJECT_ID'.
AUDIT (
  name cohort_subject_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.COHORT WHERE SUBJECT_ID IS NULL;

