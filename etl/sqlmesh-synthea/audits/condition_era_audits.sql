-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.condition_era,
--   audits (
--     person_completeness_condition_era,
--     condition_era_condition_concept_id_is_required,
--     condition_era_condition_concept_id_is_foreign_key,
--     condition_era_condition_concept_id_fk_domain,
--     condition_era_condition_concept_id_is_standard_valid_concept,
--     condition_era_condition_concept_id_standard_concept_record_completeness,
--     condition_era_condition_era_end_date_is_required,
--     condition_era_condition_era_end_date_after_birth,
--     condition_era_condition_era_id_is_required,
--     condition_era_condition_era_id_is_primary_key,
--     condition_era_condition_era_start_date_is_required,
--     condition_era_condition_era_start_date_start_before_end,
--     condition_era_condition_era_start_date_after_birth,
--     condition_era_person_id_is_required,
--     condition_era_person_id_is_foreign_key,
--   )
-- );

-- Description: Check for persons missing from table 'CONDITION_ERA'.
        AUDIT (
          name person_completeness_condition_era,
          dialect duckdb,
          blocking FALSE
        );
        SELECT p.person_id
FROM omop.person p
LEFT JOIN omop.CONDITION_ERA e ON p.person_id = e.person_id
WHERE e.person_id IS NULL;;

-- Description: Check for NULLs in required field 'CONDITION_ERA.CONDITION_CONCEPT_ID'.
AUDIT (
  name condition_era_condition_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CONDITION_ERA WHERE CONDITION_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'CONDITION_ERA.CONDITION_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name condition_era_condition_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.CONDITION_ERA c
LEFT JOIN vocab.CONCEPT p ON c.CONDITION_CONCEPT_ID = p.CONCEPT_ID
WHERE c.CONDITION_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'CONDITION_ERA.CONDITION_CONCEPT_ID' belong to the 'Condition' domain.
        AUDIT (
          name condition_era_condition_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_ERA t
JOIN vocab.CONCEPT c ON t.CONDITION_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Condition';;

-- Description: Check that concepts in 'CONDITION_ERA.CONDITION_CONCEPT_ID' are standard and valid.
        AUDIT (
          name condition_era_condition_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_ERA t
LEFT JOIN vocab.CONCEPT c ON t.CONDITION_CONCEPT_ID = c.concept_id
WHERE t.CONDITION_CONCEPT_ID IS NOT NULL
  AND t.CONDITION_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'CONDITION_ERA.CONDITION_CONCEPT_ID'.
AUDIT (
  name condition_era_condition_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CONDITION_ERA WHERE CONDITION_CONCEPT_ID = 0;

-- Description: Check for NULLs in required field 'CONDITION_ERA.CONDITION_ERA_END_DATE'.
AUDIT (
  name condition_era_condition_era_end_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CONDITION_ERA WHERE CONDITION_ERA_END_DATE IS NULL;

-- Description: Check that date 'CONDITION_ERA.CONDITION_ERA_END_DATE' is after person's birth date.
        AUDIT (
          name condition_era_condition_era_end_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_ERA t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_ERA_END_DATE < p.birth_datetime;;

-- Description: Check for NULLs in required field 'CONDITION_ERA.CONDITION_ERA_ID'.
AUDIT (
  name condition_era_condition_era_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CONDITION_ERA WHERE CONDITION_ERA_ID IS NULL;

-- Description: Check for duplicate values in primary key field 'CONDITION_ERA.CONDITION_ERA_ID'.
        AUDIT (
          name condition_era_condition_era_id_is_primary_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT CONDITION_ERA_ID, COUNT(*)
FROM omop.CONDITION_ERA
WHERE CONDITION_ERA_ID IS NOT NULL
GROUP BY CONDITION_ERA_ID
HAVING COUNT(*) > 1;;

-- Description: Check for NULLs in required field 'CONDITION_ERA.CONDITION_ERA_START_DATE'.
AUDIT (
  name condition_era_condition_era_start_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CONDITION_ERA WHERE CONDITION_ERA_START_DATE IS NULL;

-- Description: Check that 'CONDITION_ERA.CONDITION_ERA_START_DATE' occurs before 'CONDITION_ERA.CONDITION_ERA_END_DATE'.
AUDIT (
  name condition_era_condition_era_start_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CONDITION_ERA WHERE CONDITION_ERA_START_DATE > CONDITION_ERA_END_DATE;

-- Description: Check that date 'CONDITION_ERA.CONDITION_ERA_START_DATE' is after person's birth date.
        AUDIT (
          name condition_era_condition_era_start_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_ERA t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_ERA_START_DATE < p.birth_datetime;;

-- Description: Check for NULLs in required field 'CONDITION_ERA.PERSON_ID'.
AUDIT (
  name condition_era_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CONDITION_ERA WHERE PERSON_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'CONDITION_ERA.PERSON_ID' pointing to 'PERSON.PERSON_ID'.
        AUDIT (
          name condition_era_person_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.CONDITION_ERA c
LEFT JOIN omop.PERSON p ON c.PERSON_ID = p.PERSON_ID
WHERE c.PERSON_ID IS NOT NULL AND p.PERSON_ID IS NULL;;

