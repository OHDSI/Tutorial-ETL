-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.drug_era,
--   audits (
--     person_completeness_drug_era,
--     drug_era_drug_concept_id_is_required,
--     drug_era_drug_concept_id_is_foreign_key,
--     drug_era_drug_concept_id_fk_domain,
--     drug_era_drug_concept_id_is_standard_valid_concept,
--     drug_era_drug_concept_id_standard_concept_record_completeness,
--     drug_era_drug_era_end_date_is_required,
--     drug_era_drug_era_end_date_after_birth,
--     drug_era_drug_era_id_is_required,
--     drug_era_drug_era_id_is_primary_key,
--     drug_era_drug_era_start_date_is_required,
--     drug_era_drug_era_start_date_start_before_end,
--     drug_era_drug_era_start_date_after_birth,
--     drug_era_person_id_is_required,
--     drug_era_person_id_is_foreign_key,
--   )
-- );

-- Description: Check for persons missing from table 'DRUG_ERA'.
        AUDIT (
          name person_completeness_drug_era,
          dialect duckdb,
          blocking FALSE
        );
        SELECT p.person_id
FROM omop.person p
LEFT JOIN omop.DRUG_ERA e ON p.person_id = e.person_id
WHERE e.person_id IS NULL;;

-- Description: Check for NULLs in required field 'DRUG_ERA.DRUG_CONCEPT_ID'.
AUDIT (
  name drug_era_drug_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DRUG_ERA WHERE DRUG_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'DRUG_ERA.DRUG_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name drug_era_drug_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DRUG_ERA c
LEFT JOIN vocab.CONCEPT p ON c.DRUG_CONCEPT_ID = p.CONCEPT_ID
WHERE c.DRUG_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'DRUG_ERA.DRUG_CONCEPT_ID' belong to the 'Drug' domain.
        AUDIT (
          name drug_era_drug_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DRUG_ERA t
JOIN vocab.CONCEPT c ON t.DRUG_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Drug';;

-- Description: Check that concepts in 'DRUG_ERA.DRUG_CONCEPT_ID' are standard and valid.
        AUDIT (
          name drug_era_drug_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DRUG_ERA t
LEFT JOIN vocab.CONCEPT c ON t.DRUG_CONCEPT_ID = c.concept_id
WHERE t.DRUG_CONCEPT_ID IS NOT NULL
  AND t.DRUG_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'DRUG_ERA.DRUG_CONCEPT_ID'.
AUDIT (
  name drug_era_drug_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DRUG_ERA WHERE DRUG_CONCEPT_ID = 0;

-- Description: Check for NULLs in required field 'DRUG_ERA.DRUG_ERA_END_DATE'.
AUDIT (
  name drug_era_drug_era_end_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DRUG_ERA WHERE DRUG_ERA_END_DATE IS NULL;

-- Description: Check that date 'DRUG_ERA.DRUG_ERA_END_DATE' is after person's birth date.
        AUDIT (
          name drug_era_drug_era_end_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DRUG_ERA t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.DRUG_ERA_END_DATE < p.birth_datetime;;

-- Description: Check for NULLs in required field 'DRUG_ERA.DRUG_ERA_ID'.
AUDIT (
  name drug_era_drug_era_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DRUG_ERA WHERE DRUG_ERA_ID IS NULL;

-- Description: Check for duplicate values in primary key field 'DRUG_ERA.DRUG_ERA_ID'.
        AUDIT (
          name drug_era_drug_era_id_is_primary_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT DRUG_ERA_ID, COUNT(*)
FROM omop.DRUG_ERA
WHERE DRUG_ERA_ID IS NOT NULL
GROUP BY DRUG_ERA_ID
HAVING COUNT(*) > 1;;

-- Description: Check for NULLs in required field 'DRUG_ERA.DRUG_ERA_START_DATE'.
AUDIT (
  name drug_era_drug_era_start_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DRUG_ERA WHERE DRUG_ERA_START_DATE IS NULL;

-- Description: Check that 'DRUG_ERA.DRUG_ERA_START_DATE' occurs before 'DRUG_ERA.DRUG_ERA_END_DATE'.
AUDIT (
  name drug_era_drug_era_start_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DRUG_ERA WHERE DRUG_ERA_START_DATE > DRUG_ERA_END_DATE;

-- Description: Check that date 'DRUG_ERA.DRUG_ERA_START_DATE' is after person's birth date.
        AUDIT (
          name drug_era_drug_era_start_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DRUG_ERA t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.DRUG_ERA_START_DATE < p.birth_datetime;;

-- Description: Check for NULLs in required field 'DRUG_ERA.PERSON_ID'.
AUDIT (
  name drug_era_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DRUG_ERA WHERE PERSON_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'DRUG_ERA.PERSON_ID' pointing to 'PERSON.PERSON_ID'.
        AUDIT (
          name drug_era_person_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DRUG_ERA c
LEFT JOIN omop.PERSON p ON c.PERSON_ID = p.PERSON_ID
WHERE c.PERSON_ID IS NOT NULL AND p.PERSON_ID IS NULL;;

