-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.drug_exposure,
--   audits (
--     person_completeness_drug_exposure,
--     drug_exposure_drug_concept_id_is_required,
--     drug_exposure_drug_concept_id_is_foreign_key,
--     drug_exposure_drug_concept_id_fk_domain,
--     drug_exposure_drug_concept_id_is_standard_valid_concept,
--     drug_exposure_drug_concept_id_standard_concept_record_completeness,
--     drug_exposure_drug_exposure_end_date_is_required,
--     drug_exposure_drug_exposure_end_date_after_birth,
--     drug_exposure_drug_exposure_end_datetime_after_birth,
--     drug_exposure_drug_exposure_id_is_required,
--     drug_exposure_drug_exposure_id_is_primary_key,
--     drug_exposure_drug_exposure_start_date_is_required,
--     drug_exposure_drug_exposure_start_date_start_before_end,
--     drug_exposure_drug_exposure_start_date_after_birth,
--     drug_exposure_drug_exposure_start_datetime_start_before_end,
--     drug_exposure_drug_exposure_start_datetime_after_birth,
--     drug_exposure_drug_source_concept_id_is_foreign_key,
--     drug_exposure_drug_type_concept_id_is_required,
--     drug_exposure_drug_type_concept_id_is_foreign_key,
--     drug_exposure_drug_type_concept_id_fk_domain,
--     drug_exposure_drug_type_concept_id_is_standard_valid_concept,
--     drug_exposure_drug_type_concept_id_standard_concept_record_completeness,
--     drug_exposure_person_id_is_required,
--     drug_exposure_person_id_is_foreign_key,
--     drug_exposure_provider_id_is_foreign_key,
--     drug_exposure_route_concept_id_is_foreign_key,
--     drug_exposure_route_concept_id_fk_domain,
--     drug_exposure_route_concept_id_is_standard_valid_concept,
--     drug_exposure_route_concept_id_standard_concept_record_completeness,
--     drug_exposure_verbatim_end_date_after_birth,
--     drug_exposure_visit_detail_id_is_foreign_key,
--     drug_exposure_visit_occurrence_id_is_foreign_key,
--   )
-- );

-- Description: Check for persons missing from table 'DRUG_EXPOSURE'.
        AUDIT (
          name person_completeness_drug_exposure,
          dialect duckdb,
          blocking FALSE
        );
        SELECT p.person_id
FROM omop.person p
LEFT JOIN omop.DRUG_EXPOSURE e ON p.person_id = e.person_id
WHERE e.person_id IS NULL;;

-- Description: Check for NULLs in required field 'DRUG_EXPOSURE.DRUG_CONCEPT_ID'.
AUDIT (
  name drug_exposure_drug_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DRUG_EXPOSURE WHERE DRUG_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'DRUG_EXPOSURE.DRUG_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name drug_exposure_drug_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DRUG_EXPOSURE c
LEFT JOIN vocab.CONCEPT p ON c.DRUG_CONCEPT_ID = p.CONCEPT_ID
WHERE c.DRUG_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'DRUG_EXPOSURE.DRUG_CONCEPT_ID' belong to the 'Drug' domain.
        AUDIT (
          name drug_exposure_drug_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DRUG_EXPOSURE t
JOIN vocab.CONCEPT c ON t.DRUG_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Drug';;

-- Description: Check that concepts in 'DRUG_EXPOSURE.DRUG_CONCEPT_ID' are standard and valid.
        AUDIT (
          name drug_exposure_drug_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DRUG_EXPOSURE t
LEFT JOIN vocab.CONCEPT c ON t.DRUG_CONCEPT_ID = c.concept_id
WHERE t.DRUG_CONCEPT_ID IS NOT NULL
  AND t.DRUG_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'DRUG_EXPOSURE.DRUG_CONCEPT_ID'.
AUDIT (
  name drug_exposure_drug_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DRUG_EXPOSURE WHERE DRUG_CONCEPT_ID = 0;

-- Description: Check for NULLs in required field 'DRUG_EXPOSURE.DRUG_EXPOSURE_END_DATE'.
AUDIT (
  name drug_exposure_drug_exposure_end_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DRUG_EXPOSURE WHERE DRUG_EXPOSURE_END_DATE IS NULL;

-- Description: Check that date 'DRUG_EXPOSURE.DRUG_EXPOSURE_END_DATE' is after person's birth date.
        AUDIT (
          name drug_exposure_drug_exposure_end_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DRUG_EXPOSURE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.DRUG_EXPOSURE_END_DATE < p.birth_datetime;;

-- Description: Check that date 'DRUG_EXPOSURE.DRUG_EXPOSURE_END_DATETIME' is after person's birth date.
        AUDIT (
          name drug_exposure_drug_exposure_end_datetime_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DRUG_EXPOSURE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.DRUG_EXPOSURE_END_DATETIME < p.birth_datetime;;

-- Description: Check for NULLs in required field 'DRUG_EXPOSURE.DRUG_EXPOSURE_ID'.
AUDIT (
  name drug_exposure_drug_exposure_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DRUG_EXPOSURE WHERE DRUG_EXPOSURE_ID IS NULL;

-- Description: Check for duplicate values in primary key field 'DRUG_EXPOSURE.DRUG_EXPOSURE_ID'.
        AUDIT (
          name drug_exposure_drug_exposure_id_is_primary_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT DRUG_EXPOSURE_ID, COUNT(*)
FROM omop.DRUG_EXPOSURE
WHERE DRUG_EXPOSURE_ID IS NOT NULL
GROUP BY DRUG_EXPOSURE_ID
HAVING COUNT(*) > 1;;

-- Description: Check for NULLs in required field 'DRUG_EXPOSURE.DRUG_EXPOSURE_START_DATE'.
AUDIT (
  name drug_exposure_drug_exposure_start_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DRUG_EXPOSURE WHERE DRUG_EXPOSURE_START_DATE IS NULL;

-- Description: Check that 'DRUG_EXPOSURE.DRUG_EXPOSURE_START_DATE' occurs before 'DRUG_EXPOSURE.DRUG_EXPOSURE_END_DATE'.
AUDIT (
  name drug_exposure_drug_exposure_start_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DRUG_EXPOSURE WHERE DRUG_EXPOSURE_START_DATE > DRUG_EXPOSURE_END_DATE;

-- Description: Check that date 'DRUG_EXPOSURE.DRUG_EXPOSURE_START_DATE' is after person's birth date.
        AUDIT (
          name drug_exposure_drug_exposure_start_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DRUG_EXPOSURE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.DRUG_EXPOSURE_START_DATE < p.birth_datetime;;

-- Description: Check that 'DRUG_EXPOSURE.DRUG_EXPOSURE_START_DATETIME' occurs before 'DRUG_EXPOSURE.DRUG_EXPOSURE_END_DATETIME'.
AUDIT (
  name drug_exposure_drug_exposure_start_datetime_start_before_end,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DRUG_EXPOSURE WHERE DRUG_EXPOSURE_START_DATETIME > DRUG_EXPOSURE_END_DATETIME;

-- Description: Check that date 'DRUG_EXPOSURE.DRUG_EXPOSURE_START_DATETIME' is after person's birth date.
        AUDIT (
          name drug_exposure_drug_exposure_start_datetime_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DRUG_EXPOSURE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.DRUG_EXPOSURE_START_DATETIME < p.birth_datetime;;

-- Description: Check for orphaned foreign keys in 'DRUG_EXPOSURE.DRUG_SOURCE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name drug_exposure_drug_source_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DRUG_EXPOSURE c
LEFT JOIN vocab.CONCEPT p ON c.DRUG_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.DRUG_SOURCE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'DRUG_EXPOSURE.DRUG_TYPE_CONCEPT_ID'.
AUDIT (
  name drug_exposure_drug_type_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DRUG_EXPOSURE WHERE DRUG_TYPE_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'DRUG_EXPOSURE.DRUG_TYPE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name drug_exposure_drug_type_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DRUG_EXPOSURE c
LEFT JOIN vocab.CONCEPT p ON c.DRUG_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.DRUG_TYPE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'DRUG_EXPOSURE.DRUG_TYPE_CONCEPT_ID' belong to the 'Type Concept' domain.
        AUDIT (
          name drug_exposure_drug_type_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DRUG_EXPOSURE t
JOIN vocab.CONCEPT c ON t.DRUG_TYPE_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Type Concept';;

-- Description: Check that concepts in 'DRUG_EXPOSURE.DRUG_TYPE_CONCEPT_ID' are standard and valid.
        AUDIT (
          name drug_exposure_drug_type_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DRUG_EXPOSURE t
LEFT JOIN vocab.CONCEPT c ON t.DRUG_TYPE_CONCEPT_ID = c.concept_id
WHERE t.DRUG_TYPE_CONCEPT_ID IS NOT NULL
  AND t.DRUG_TYPE_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'DRUG_EXPOSURE.DRUG_TYPE_CONCEPT_ID'.
AUDIT (
  name drug_exposure_drug_type_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DRUG_EXPOSURE WHERE DRUG_TYPE_CONCEPT_ID = 0;

-- Description: Check for NULLs in required field 'DRUG_EXPOSURE.PERSON_ID'.
AUDIT (
  name drug_exposure_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DRUG_EXPOSURE WHERE PERSON_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'DRUG_EXPOSURE.PERSON_ID' pointing to 'PERSON.PERSON_ID'.
        AUDIT (
          name drug_exposure_person_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DRUG_EXPOSURE c
LEFT JOIN omop.PERSON p ON c.PERSON_ID = p.PERSON_ID
WHERE c.PERSON_ID IS NOT NULL AND p.PERSON_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'DRUG_EXPOSURE.PROVIDER_ID' pointing to 'PROVIDER.PROVIDER_ID'.
        AUDIT (
          name drug_exposure_provider_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DRUG_EXPOSURE c
LEFT JOIN omop.PROVIDER p ON c.PROVIDER_ID = p.PROVIDER_ID
WHERE c.PROVIDER_ID IS NOT NULL AND p.PROVIDER_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'DRUG_EXPOSURE.ROUTE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name drug_exposure_route_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DRUG_EXPOSURE c
LEFT JOIN vocab.CONCEPT p ON c.ROUTE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.ROUTE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'DRUG_EXPOSURE.ROUTE_CONCEPT_ID' belong to the 'Route' domain.
        AUDIT (
          name drug_exposure_route_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DRUG_EXPOSURE t
JOIN vocab.CONCEPT c ON t.ROUTE_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Route';;

-- Description: Check that concepts in 'DRUG_EXPOSURE.ROUTE_CONCEPT_ID' are standard and valid.
        AUDIT (
          name drug_exposure_route_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DRUG_EXPOSURE t
LEFT JOIN vocab.CONCEPT c ON t.ROUTE_CONCEPT_ID = c.concept_id
WHERE t.ROUTE_CONCEPT_ID IS NOT NULL
  AND t.ROUTE_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'DRUG_EXPOSURE.ROUTE_CONCEPT_ID'.
AUDIT (
  name drug_exposure_route_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DRUG_EXPOSURE WHERE ROUTE_CONCEPT_ID = 0;

-- Description: Check that date 'DRUG_EXPOSURE.VERBATIM_END_DATE' is after person's birth date.
        AUDIT (
          name drug_exposure_verbatim_end_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DRUG_EXPOSURE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.VERBATIM_END_DATE < p.birth_datetime;;

-- Description: Check for orphaned foreign keys in 'DRUG_EXPOSURE.VISIT_DETAIL_ID' pointing to 'VISIT_DETAIL.VISIT_DETAIL_ID'.
        AUDIT (
          name drug_exposure_visit_detail_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DRUG_EXPOSURE c
LEFT JOIN omop.VISIT_DETAIL p ON c.VISIT_DETAIL_ID = p.VISIT_DETAIL_ID
WHERE c.VISIT_DETAIL_ID IS NOT NULL AND p.VISIT_DETAIL_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'DRUG_EXPOSURE.VISIT_OCCURRENCE_ID' pointing to 'VISIT_OCCURRENCE.VISIT_OCCURRENCE_ID'.
        AUDIT (
          name drug_exposure_visit_occurrence_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DRUG_EXPOSURE c
LEFT JOIN omop.VISIT_OCCURRENCE p ON c.VISIT_OCCURRENCE_ID = p.VISIT_OCCURRENCE_ID
WHERE c.VISIT_OCCURRENCE_ID IS NOT NULL AND p.VISIT_OCCURRENCE_ID IS NULL;;

