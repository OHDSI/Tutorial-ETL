-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.observation_period,
--   audits (
--     observation_period_exists,
--     person_completeness_observation_period,
--     observation_period_observation_period_end_date_is_required,
--     observation_period_observation_period_end_date_after_birth,
--     observation_period_observation_period_id_is_required,
--     observation_period_observation_period_id_is_primary_key,
--     observation_period_observation_period_start_date_is_required,
--     observation_period_observation_period_start_date_start_before_end,
--     observation_period_observation_period_start_date_after_birth,
--     observation_period_period_type_concept_id_is_required,
--     observation_period_period_type_concept_id_is_foreign_key,
--     observation_period_period_type_concept_id_fk_domain,
--     observation_period_period_type_concept_id_is_standard_valid_concept,
--     observation_period_period_type_concept_id_standard_concept_record_completeness,
--     observation_period_person_id_is_required,
--     observation_period_person_id_is_foreign_key,
--   )
-- );

-- Description: Check if table 'OBSERVATION_PERIOD' exists.
AUDIT (
  name observation_period_exists,
  dialect duckdb,
  blocking FALSE
);
SELECT 1 FROM omop.OBSERVATION_PERIOD WHERE 1 = 0;

-- Description: Check for persons missing from table 'OBSERVATION_PERIOD'.
        AUDIT (
          name person_completeness_observation_period,
          dialect duckdb,
          blocking FALSE
        );
        SELECT p.person_id
FROM omop.person p
LEFT JOIN omop.OBSERVATION_PERIOD e ON p.person_id = e.person_id
WHERE e.person_id IS NULL;;

-- Description: Check for NULLs in required field 'OBSERVATION_PERIOD.OBSERVATION_PERIOD_END_DATE'.
AUDIT (
  name observation_period_observation_period_end_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.OBSERVATION_PERIOD WHERE OBSERVATION_PERIOD_END_DATE IS NULL;

-- Description: Check that date 'OBSERVATION_PERIOD.OBSERVATION_PERIOD_END_DATE' is after person's birth date.
        AUDIT (
          name observation_period_observation_period_end_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.OBSERVATION_PERIOD t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.OBSERVATION_PERIOD_END_DATE < p.birth_datetime;;

-- Description: Check for NULLs in required field 'OBSERVATION_PERIOD.OBSERVATION_PERIOD_ID'.
AUDIT (
  name observation_period_observation_period_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.OBSERVATION_PERIOD WHERE OBSERVATION_PERIOD_ID IS NULL;

-- Description: Check for duplicate values in primary key field 'OBSERVATION_PERIOD.OBSERVATION_PERIOD_ID'.
        AUDIT (
          name observation_period_observation_period_id_is_primary_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT OBSERVATION_PERIOD_ID, COUNT(*)
FROM omop.OBSERVATION_PERIOD
WHERE OBSERVATION_PERIOD_ID IS NOT NULL
GROUP BY OBSERVATION_PERIOD_ID
HAVING COUNT(*) > 1;;

-- Description: Check for NULLs in required field 'OBSERVATION_PERIOD.OBSERVATION_PERIOD_START_DATE'.
AUDIT (
  name observation_period_observation_period_start_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.OBSERVATION_PERIOD WHERE OBSERVATION_PERIOD_START_DATE IS NULL;

-- Description: Check that 'OBSERVATION_PERIOD.OBSERVATION_PERIOD_START_DATE' occurs before 'OBSERVATION_PERIOD.OBSERVATION_PERIOD_END_DATE'.
AUDIT (
  name observation_period_observation_period_start_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.OBSERVATION_PERIOD WHERE OBSERVATION_PERIOD_START_DATE > OBSERVATION_PERIOD_END_DATE;

-- Description: Check that date 'OBSERVATION_PERIOD.OBSERVATION_PERIOD_START_DATE' is after person's birth date.
        AUDIT (
          name observation_period_observation_period_start_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.OBSERVATION_PERIOD t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.OBSERVATION_PERIOD_START_DATE < p.birth_datetime;;

-- Description: Check for NULLs in required field 'OBSERVATION_PERIOD.PERIOD_TYPE_CONCEPT_ID'.
AUDIT (
  name observation_period_period_type_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.OBSERVATION_PERIOD WHERE PERIOD_TYPE_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'OBSERVATION_PERIOD.PERIOD_TYPE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name observation_period_period_type_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.OBSERVATION_PERIOD c
LEFT JOIN vocab.CONCEPT p ON c.PERIOD_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.PERIOD_TYPE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'OBSERVATION_PERIOD.PERIOD_TYPE_CONCEPT_ID' belong to the 'Type Concept' domain.
        AUDIT (
          name observation_period_period_type_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.OBSERVATION_PERIOD t
JOIN vocab.CONCEPT c ON t.PERIOD_TYPE_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Type Concept';;

-- Description: Check that concepts in 'OBSERVATION_PERIOD.PERIOD_TYPE_CONCEPT_ID' are standard and valid.
        AUDIT (
          name observation_period_period_type_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.OBSERVATION_PERIOD t
LEFT JOIN vocab.CONCEPT c ON t.PERIOD_TYPE_CONCEPT_ID = c.concept_id
WHERE t.PERIOD_TYPE_CONCEPT_ID IS NOT NULL
  AND t.PERIOD_TYPE_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'OBSERVATION_PERIOD.PERIOD_TYPE_CONCEPT_ID'.
AUDIT (
  name observation_period_period_type_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.OBSERVATION_PERIOD WHERE PERIOD_TYPE_CONCEPT_ID = 0;

-- Description: Check for NULLs in required field 'OBSERVATION_PERIOD.PERSON_ID'.
AUDIT (
  name observation_period_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.OBSERVATION_PERIOD WHERE PERSON_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'OBSERVATION_PERIOD.PERSON_ID' pointing to 'PERSON.PERSON_ID'.
        AUDIT (
          name observation_period_person_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.OBSERVATION_PERIOD c
LEFT JOIN omop.PERSON p ON c.PERSON_ID = p.PERSON_ID
WHERE c.PERSON_ID IS NOT NULL AND p.PERSON_ID IS NULL;;

