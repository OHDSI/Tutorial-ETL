-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.person,
--   audits (
--     person_exists,
--     person_care_site_id_is_foreign_key,
--     person_ethnicity_concept_id_is_required,
--     person_ethnicity_concept_id_is_foreign_key,
--     person_ethnicity_concept_id_fk_domain,
--     person_ethnicity_concept_id_is_standard_valid_concept,
--     person_ethnicity_concept_id_standard_concept_record_completeness,
--     person_ethnicity_source_concept_id_is_foreign_key,
--     person_gender_concept_id_is_required,
--     person_gender_concept_id_is_foreign_key,
--     person_gender_concept_id_fk_domain,
--     person_gender_concept_id_is_standard_valid_concept,
--     person_gender_concept_id_standard_concept_record_completeness,
--     person_gender_source_concept_id_is_foreign_key,
--     person_location_id_is_foreign_key,
--     person_person_id_is_required,
--     person_person_id_is_primary_key,
--     person_provider_id_is_foreign_key,
--     person_race_concept_id_is_required,
--     person_race_concept_id_is_foreign_key,
--     person_race_concept_id_fk_domain,
--     person_race_concept_id_is_standard_valid_concept,
--     person_race_concept_id_standard_concept_record_completeness,
--     person_race_source_concept_id_is_foreign_key,
--     person_year_of_birth_is_required,
--   )
-- );

-- Description: Check if table 'PERSON' exists.
AUDIT (
  name person_exists,
  dialect duckdb,
  blocking FALSE
);
SELECT 1 FROM omop.PERSON WHERE 1 = 0;

-- Description: Check for orphaned foreign keys in 'PERSON.CARE_SITE_ID' pointing to 'CARE_SITE.CARE_SITE_ID'.
        AUDIT (
          name person_care_site_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PERSON c
LEFT JOIN omop.CARE_SITE p ON c.CARE_SITE_ID = p.CARE_SITE_ID
WHERE c.CARE_SITE_ID IS NOT NULL AND p.CARE_SITE_ID IS NULL;;

-- Description: Check for NULLs in required field 'PERSON.ETHNICITY_CONCEPT_ID'.
AUDIT (
  name person_ethnicity_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.PERSON WHERE ETHNICITY_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'PERSON.ETHNICITY_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name person_ethnicity_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PERSON c
LEFT JOIN vocab.CONCEPT p ON c.ETHNICITY_CONCEPT_ID = p.CONCEPT_ID
WHERE c.ETHNICITY_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'PERSON.ETHNICITY_CONCEPT_ID' belong to the 'Ethnicity' domain.
        AUDIT (
          name person_ethnicity_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PERSON t
JOIN vocab.CONCEPT c ON t.ETHNICITY_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Ethnicity';;

-- Description: Check that concepts in 'PERSON.ETHNICITY_CONCEPT_ID' are standard and valid.
        AUDIT (
          name person_ethnicity_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PERSON t
LEFT JOIN vocab.CONCEPT c ON t.ETHNICITY_CONCEPT_ID = c.concept_id
WHERE t.ETHNICITY_CONCEPT_ID IS NOT NULL
  AND t.ETHNICITY_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'PERSON.ETHNICITY_CONCEPT_ID'.
AUDIT (
  name person_ethnicity_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.PERSON WHERE ETHNICITY_CONCEPT_ID = 0;

-- Description: Check for orphaned foreign keys in 'PERSON.ETHNICITY_SOURCE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name person_ethnicity_source_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PERSON c
LEFT JOIN vocab.CONCEPT p ON c.ETHNICITY_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.ETHNICITY_SOURCE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'PERSON.GENDER_CONCEPT_ID'.
AUDIT (
  name person_gender_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.PERSON WHERE GENDER_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'PERSON.GENDER_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name person_gender_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PERSON c
LEFT JOIN vocab.CONCEPT p ON c.GENDER_CONCEPT_ID = p.CONCEPT_ID
WHERE c.GENDER_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'PERSON.GENDER_CONCEPT_ID' belong to the 'Gender' domain.
        AUDIT (
          name person_gender_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PERSON t
JOIN vocab.CONCEPT c ON t.GENDER_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Gender';;

-- Description: Check that concepts in 'PERSON.GENDER_CONCEPT_ID' are standard and valid.
        AUDIT (
          name person_gender_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PERSON t
LEFT JOIN vocab.CONCEPT c ON t.GENDER_CONCEPT_ID = c.concept_id
WHERE t.GENDER_CONCEPT_ID IS NOT NULL
  AND t.GENDER_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'PERSON.GENDER_CONCEPT_ID'.
AUDIT (
  name person_gender_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.PERSON WHERE GENDER_CONCEPT_ID = 0;

-- Description: Check for orphaned foreign keys in 'PERSON.GENDER_SOURCE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name person_gender_source_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PERSON c
LEFT JOIN vocab.CONCEPT p ON c.GENDER_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.GENDER_SOURCE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'PERSON.LOCATION_ID' pointing to 'LOCATION.LOCATION_ID'.
        AUDIT (
          name person_location_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PERSON c
LEFT JOIN omop.LOCATION p ON c.LOCATION_ID = p.LOCATION_ID
WHERE c.LOCATION_ID IS NOT NULL AND p.LOCATION_ID IS NULL;;

-- Description: Check for NULLs in required field 'PERSON.PERSON_ID'.
AUDIT (
  name person_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.PERSON WHERE PERSON_ID IS NULL;

-- Description: Check for duplicate values in primary key field 'PERSON.PERSON_ID'.
        AUDIT (
          name person_person_id_is_primary_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT PERSON_ID, COUNT(*)
FROM omop.PERSON
WHERE PERSON_ID IS NOT NULL
GROUP BY PERSON_ID
HAVING COUNT(*) > 1;;

-- Description: Check for orphaned foreign keys in 'PERSON.PROVIDER_ID' pointing to 'PROVIDER.PROVIDER_ID'.
        AUDIT (
          name person_provider_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PERSON c
LEFT JOIN omop.PROVIDER p ON c.PROVIDER_ID = p.PROVIDER_ID
WHERE c.PROVIDER_ID IS NOT NULL AND p.PROVIDER_ID IS NULL;;

-- Description: Check for NULLs in required field 'PERSON.RACE_CONCEPT_ID'.
AUDIT (
  name person_race_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.PERSON WHERE RACE_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'PERSON.RACE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name person_race_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PERSON c
LEFT JOIN vocab.CONCEPT p ON c.RACE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.RACE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'PERSON.RACE_CONCEPT_ID' belong to the 'Race' domain.
        AUDIT (
          name person_race_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PERSON t
JOIN vocab.CONCEPT c ON t.RACE_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Race';;

-- Description: Check that concepts in 'PERSON.RACE_CONCEPT_ID' are standard and valid.
        AUDIT (
          name person_race_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PERSON t
LEFT JOIN vocab.CONCEPT c ON t.RACE_CONCEPT_ID = c.concept_id
WHERE t.RACE_CONCEPT_ID IS NOT NULL
  AND t.RACE_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'PERSON.RACE_CONCEPT_ID'.
AUDIT (
  name person_race_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.PERSON WHERE RACE_CONCEPT_ID = 0;

-- Description: Check for orphaned foreign keys in 'PERSON.RACE_SOURCE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name person_race_source_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PERSON c
LEFT JOIN vocab.CONCEPT p ON c.RACE_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.RACE_SOURCE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'PERSON.YEAR_OF_BIRTH'.
AUDIT (
  name person_year_of_birth_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.PERSON WHERE YEAR_OF_BIRTH IS NULL;

