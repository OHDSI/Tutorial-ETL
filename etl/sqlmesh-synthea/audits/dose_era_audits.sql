-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.dose_era,
--   depends_on (
--     vocab.concept,
--     omop.person,
--   ),
--   audits (
--     person_completeness_dose_era,
--     dose_era_dose_era_end_date_is_required,
--     dose_era_dose_era_end_date_after_birth,
--     dose_era_dose_era_id_is_required,
--     dose_era_dose_era_id_is_primary_key,
--     dose_era_dose_era_start_date_is_required,
--     dose_era_dose_era_start_date_start_before_end,
--     dose_era_dose_era_start_date_after_birth,
--     dose_era_dose_value_is_required,
--     dose_era_drug_concept_id_is_required,
--     dose_era_drug_concept_id_is_foreign_key,
--     dose_era_drug_concept_id_fk_domain,
--     dose_era_drug_concept_id_is_standard_valid_concept,
--     dose_era_drug_concept_id_standard_concept_record_completeness,
--     dose_era_person_id_is_required,
--     dose_era_person_id_is_foreign_key,
--     dose_era_unit_concept_id_is_required,
--     dose_era_unit_concept_id_is_foreign_key,
--     dose_era_unit_concept_id_fk_domain,
--     dose_era_unit_concept_id_is_standard_valid_concept,
--     dose_era_unit_concept_id_standard_concept_record_completeness,
--   )
-- );

-- Description: Check for persons missing from table 'DOSE_ERA'.
        AUDIT (
          name person_completeness_dose_era,
          dialect duckdb,
          blocking FALSE
        );
        SELECT p.person_id
FROM omop.person p
LEFT JOIN omop.DOSE_ERA e ON p.person_id = e.person_id
WHERE e.person_id IS NULL;;

-- Description: Check for NULLs in required field 'DOSE_ERA.DOSE_ERA_END_DATE'.
AUDIT (
  name dose_era_dose_era_end_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DOSE_ERA WHERE DOSE_ERA_END_DATE IS NULL;

-- Description: Check that date 'DOSE_ERA.DOSE_ERA_END_DATE' is after person's birth date.
        AUDIT (
          name dose_era_dose_era_end_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DOSE_ERA t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.DOSE_ERA_END_DATE < p.birth_datetime;;

-- Description: Check for NULLs in required field 'DOSE_ERA.DOSE_ERA_ID'.
AUDIT (
  name dose_era_dose_era_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DOSE_ERA WHERE DOSE_ERA_ID IS NULL;

-- Description: Check for duplicate values in primary key field 'DOSE_ERA.DOSE_ERA_ID'.
        AUDIT (
          name dose_era_dose_era_id_is_primary_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT DOSE_ERA_ID, COUNT(*)
FROM omop.DOSE_ERA
WHERE DOSE_ERA_ID IS NOT NULL
GROUP BY DOSE_ERA_ID
HAVING COUNT(*) > 1;;

-- Description: Check for NULLs in required field 'DOSE_ERA.DOSE_ERA_START_DATE'.
AUDIT (
  name dose_era_dose_era_start_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DOSE_ERA WHERE DOSE_ERA_START_DATE IS NULL;

-- Description: Check that 'DOSE_ERA.DOSE_ERA_START_DATE' occurs before 'DOSE_ERA.DOSE_ERA_END_DATE'.
AUDIT (
  name dose_era_dose_era_start_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DOSE_ERA WHERE DOSE_ERA_START_DATE > DOSE_ERA_END_DATE;

-- Description: Check that date 'DOSE_ERA.DOSE_ERA_START_DATE' is after person's birth date.
        AUDIT (
          name dose_era_dose_era_start_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DOSE_ERA t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.DOSE_ERA_START_DATE < p.birth_datetime;;

-- Description: Check for NULLs in required field 'DOSE_ERA.DOSE_VALUE'.
AUDIT (
  name dose_era_dose_value_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DOSE_ERA WHERE DOSE_VALUE IS NULL;

-- Description: Check for NULLs in required field 'DOSE_ERA.DRUG_CONCEPT_ID'.
AUDIT (
  name dose_era_drug_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DOSE_ERA WHERE DRUG_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'DOSE_ERA.DRUG_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name dose_era_drug_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DOSE_ERA c
LEFT JOIN vocab.concept p ON c.DRUG_CONCEPT_ID = p.CONCEPT_ID
WHERE c.DRUG_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'DOSE_ERA.DRUG_CONCEPT_ID' belong to the 'Drug' domain.
        AUDIT (
          name dose_era_drug_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DOSE_ERA t
JOIN vocab.concept c ON t.DRUG_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Drug';;

-- Description: Check that concepts in 'DOSE_ERA.DRUG_CONCEPT_ID' are standard and valid.
        AUDIT (
          name dose_era_drug_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DOSE_ERA t
LEFT JOIN vocab.concept c ON t.DRUG_CONCEPT_ID = c.concept_id
WHERE t.DRUG_CONCEPT_ID IS NOT NULL
  AND t.DRUG_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'DOSE_ERA.DRUG_CONCEPT_ID'.
AUDIT (
  name dose_era_drug_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DOSE_ERA WHERE DRUG_CONCEPT_ID = 0;

-- Description: Check for NULLs in required field 'DOSE_ERA.PERSON_ID'.
AUDIT (
  name dose_era_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DOSE_ERA WHERE PERSON_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'DOSE_ERA.PERSON_ID' pointing to 'PERSON.PERSON_ID'.
        AUDIT (
          name dose_era_person_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DOSE_ERA c
LEFT JOIN omop.PERSON p ON c.PERSON_ID = p.PERSON_ID
WHERE c.PERSON_ID IS NOT NULL AND p.PERSON_ID IS NULL;;

-- Description: Check for NULLs in required field 'DOSE_ERA.UNIT_CONCEPT_ID'.
AUDIT (
  name dose_era_unit_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DOSE_ERA WHERE UNIT_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'DOSE_ERA.UNIT_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name dose_era_unit_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DOSE_ERA c
LEFT JOIN vocab.concept p ON c.UNIT_CONCEPT_ID = p.CONCEPT_ID
WHERE c.UNIT_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'DOSE_ERA.UNIT_CONCEPT_ID' belong to the 'Unit' domain.
        AUDIT (
          name dose_era_unit_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DOSE_ERA t
JOIN vocab.concept c ON t.UNIT_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Unit';;

-- Description: Check that concepts in 'DOSE_ERA.UNIT_CONCEPT_ID' are standard and valid.
        AUDIT (
          name dose_era_unit_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DOSE_ERA t
LEFT JOIN vocab.concept c ON t.UNIT_CONCEPT_ID = c.concept_id
WHERE t.UNIT_CONCEPT_ID IS NOT NULL
  AND t.UNIT_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'DOSE_ERA.UNIT_CONCEPT_ID'.
AUDIT (
  name dose_era_unit_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DOSE_ERA WHERE UNIT_CONCEPT_ID = 0;

