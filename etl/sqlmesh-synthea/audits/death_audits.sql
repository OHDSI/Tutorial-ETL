-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.death,
--   audits (
--     person_completeness_death,
--     death_cause_concept_id_is_foreign_key,
--     death_cause_concept_id_is_standard_valid_concept,
--     death_cause_concept_id_standard_concept_record_completeness,
--     death_cause_source_concept_id_is_foreign_key,
--     death_death_date_is_required,
--     death_death_date_after_birth,
--     death_death_datetime_after_birth,
--     death_death_type_concept_id_is_foreign_key,
--     death_death_type_concept_id_fk_domain,
--     death_death_type_concept_id_is_standard_valid_concept,
--     death_death_type_concept_id_standard_concept_record_completeness,
--     death_person_id_is_required,
--     death_person_id_is_foreign_key,
--   )
-- );

-- Description: Check for persons missing from table 'DEATH'.
        AUDIT (
          name person_completeness_death,
          dialect duckdb,
          blocking FALSE
        );
        SELECT p.person_id
FROM omop.person p
LEFT JOIN omop.DEATH e ON p.person_id = e.person_id
WHERE e.person_id IS NULL;;

-- Description: Check for orphaned foreign keys in 'DEATH.CAUSE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name death_cause_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DEATH c
LEFT JOIN vocab.CONCEPT p ON c.CAUSE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.CAUSE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'DEATH.CAUSE_CONCEPT_ID' are standard and valid.
        AUDIT (
          name death_cause_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DEATH t
LEFT JOIN vocab.CONCEPT c ON t.CAUSE_CONCEPT_ID = c.concept_id
WHERE t.CAUSE_CONCEPT_ID IS NOT NULL
  AND t.CAUSE_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'DEATH.CAUSE_CONCEPT_ID'.
AUDIT (
  name death_cause_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DEATH WHERE CAUSE_CONCEPT_ID = 0;

-- Description: Check for orphaned foreign keys in 'DEATH.CAUSE_SOURCE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name death_cause_source_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DEATH c
LEFT JOIN vocab.CONCEPT p ON c.CAUSE_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.CAUSE_SOURCE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'DEATH.DEATH_DATE'.
AUDIT (
  name death_death_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DEATH WHERE DEATH_DATE IS NULL;

-- Description: Check that date 'DEATH.DEATH_DATE' is after person's birth date.
        AUDIT (
          name death_death_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DEATH t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.DEATH_DATE < p.birth_datetime;;

-- Description: Check that date 'DEATH.DEATH_DATETIME' is after person's birth date.
        AUDIT (
          name death_death_datetime_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DEATH t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.DEATH_DATETIME < p.birth_datetime;;

-- Description: Check for orphaned foreign keys in 'DEATH.DEATH_TYPE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name death_death_type_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DEATH c
LEFT JOIN vocab.CONCEPT p ON c.DEATH_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.DEATH_TYPE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'DEATH.DEATH_TYPE_CONCEPT_ID' belong to the 'Type Concept' domain.
        AUDIT (
          name death_death_type_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DEATH t
JOIN vocab.CONCEPT c ON t.DEATH_TYPE_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Type Concept';;

-- Description: Check that concepts in 'DEATH.DEATH_TYPE_CONCEPT_ID' are standard and valid.
        AUDIT (
          name death_death_type_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DEATH t
LEFT JOIN vocab.CONCEPT c ON t.DEATH_TYPE_CONCEPT_ID = c.concept_id
WHERE t.DEATH_TYPE_CONCEPT_ID IS NOT NULL
  AND t.DEATH_TYPE_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'DEATH.DEATH_TYPE_CONCEPT_ID'.
AUDIT (
  name death_death_type_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DEATH WHERE DEATH_TYPE_CONCEPT_ID = 0;

-- Description: Check for NULLs in required field 'DEATH.PERSON_ID'.
AUDIT (
  name death_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DEATH WHERE PERSON_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'DEATH.PERSON_ID' pointing to 'PERSON.PERSON_ID'.
        AUDIT (
          name death_person_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DEATH c
LEFT JOIN omop.PERSON p ON c.PERSON_ID = p.PERSON_ID
WHERE c.PERSON_ID IS NOT NULL AND p.PERSON_ID IS NULL;;

