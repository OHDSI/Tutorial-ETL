-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.visit_occurrence,
--   depends_on (
--     omop.care_site,
--     vocab.concept,
--     omop.person,
--     omop.provider,
--   ),
--   audits (
--     person_completeness_visit_occurrence,
--     visit_occurrence_admitted_from_concept_id_is_foreign_key,
--     visit_occurrence_admitted_from_concept_id_fk_domain,
--     visit_occurrence_admitted_from_concept_id_is_standard_valid_concept,
--     visit_occurrence_admitted_from_concept_id_standard_concept_record_completeness,
--     visit_occurrence_care_site_id_is_foreign_key,
--     visit_occurrence_discharged_to_concept_id_is_foreign_key,
--     visit_occurrence_discharged_to_concept_id_fk_domain,
--     visit_occurrence_discharged_to_concept_id_is_standard_valid_concept,
--     visit_occurrence_discharged_to_concept_id_standard_concept_record_completeness,
--     visit_occurrence_person_id_is_required,
--     visit_occurrence_person_id_is_foreign_key,
--     visit_occurrence_preceding_visit_occurrence_id_is_foreign_key,
--     visit_occurrence_provider_id_is_foreign_key,
--     visit_occurrence_visit_concept_id_is_required,
--     visit_occurrence_visit_concept_id_is_foreign_key,
--     visit_occurrence_visit_concept_id_fk_domain,
--     visit_occurrence_visit_concept_id_is_standard_valid_concept,
--     visit_occurrence_visit_concept_id_standard_concept_record_completeness,
--     visit_occurrence_visit_end_date_is_required,
--     visit_occurrence_visit_end_date_after_birth,
--     visit_occurrence_visit_end_datetime_after_birth,
--     visit_occurrence_visit_occurrence_id_is_required,
--     visit_occurrence_visit_occurrence_id_is_primary_key,
--     visit_occurrence_visit_source_concept_id_is_foreign_key,
--     visit_occurrence_visit_start_date_is_required,
--     visit_occurrence_visit_start_date_start_before_end,
--     visit_occurrence_visit_start_date_after_birth,
--     visit_occurrence_visit_start_datetime_start_before_end,
--     visit_occurrence_visit_start_datetime_after_birth,
--     visit_occurrence_visit_type_concept_id_is_required,
--     visit_occurrence_visit_type_concept_id_is_foreign_key,
--     visit_occurrence_visit_type_concept_id_fk_domain,
--     visit_occurrence_visit_type_concept_id_is_standard_valid_concept,
--     visit_occurrence_visit_type_concept_id_standard_concept_record_completeness,
--     visit_occurrence_9201_temp,
--     visit_occurrence_9202_temp,
--     visit_occurrence_9203_temp,
--   )
-- );

-- Description: Check for persons missing from table 'VISIT_OCCURRENCE'.
        AUDIT (
          name person_completeness_visit_occurrence,
          dialect duckdb,
          blocking FALSE
        );
        SELECT p.person_id
FROM omop.person p
LEFT JOIN omop.VISIT_OCCURRENCE e ON p.person_id = e.person_id
WHERE e.person_id IS NULL;;

-- Description: Check for orphaned foreign keys in 'VISIT_OCCURRENCE.ADMITTED_FROM_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name visit_occurrence_admitted_from_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.VISIT_OCCURRENCE c
LEFT JOIN vocab.concept p ON c.ADMITTED_FROM_CONCEPT_ID = p.CONCEPT_ID
WHERE c.ADMITTED_FROM_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'VISIT_OCCURRENCE.ADMITTED_FROM_CONCEPT_ID' belong to the 'Visit' domain.
        AUDIT (
          name visit_occurrence_admitted_from_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.VISIT_OCCURRENCE t
JOIN vocab.concept c ON t.ADMITTED_FROM_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Visit';;

-- Description: Check that concepts in 'VISIT_OCCURRENCE.ADMITTED_FROM_CONCEPT_ID' are standard and valid.
        AUDIT (
          name visit_occurrence_admitted_from_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.VISIT_OCCURRENCE t
LEFT JOIN vocab.concept c ON t.ADMITTED_FROM_CONCEPT_ID = c.concept_id
WHERE t.ADMITTED_FROM_CONCEPT_ID IS NOT NULL
  AND t.ADMITTED_FROM_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'VISIT_OCCURRENCE.ADMITTED_FROM_CONCEPT_ID'.
AUDIT (
  name visit_occurrence_admitted_from_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.VISIT_OCCURRENCE WHERE ADMITTED_FROM_CONCEPT_ID = 0;

-- Description: Check for orphaned foreign keys in 'VISIT_OCCURRENCE.CARE_SITE_ID' pointing to 'CARE_SITE.CARE_SITE_ID'.
        AUDIT (
          name visit_occurrence_care_site_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.VISIT_OCCURRENCE c
LEFT JOIN omop.CARE_SITE p ON c.CARE_SITE_ID = p.CARE_SITE_ID
WHERE c.CARE_SITE_ID IS NOT NULL AND p.CARE_SITE_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'VISIT_OCCURRENCE.DISCHARGED_TO_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name visit_occurrence_discharged_to_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.VISIT_OCCURRENCE c
LEFT JOIN vocab.concept p ON c.DISCHARGED_TO_CONCEPT_ID = p.CONCEPT_ID
WHERE c.DISCHARGED_TO_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'VISIT_OCCURRENCE.DISCHARGED_TO_CONCEPT_ID' belong to the 'Visit' domain.
        AUDIT (
          name visit_occurrence_discharged_to_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.VISIT_OCCURRENCE t
JOIN vocab.concept c ON t.DISCHARGED_TO_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Visit';;

-- Description: Check that concepts in 'VISIT_OCCURRENCE.DISCHARGED_TO_CONCEPT_ID' are standard and valid.
        AUDIT (
          name visit_occurrence_discharged_to_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.VISIT_OCCURRENCE t
LEFT JOIN vocab.concept c ON t.DISCHARGED_TO_CONCEPT_ID = c.concept_id
WHERE t.DISCHARGED_TO_CONCEPT_ID IS NOT NULL
  AND t.DISCHARGED_TO_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'VISIT_OCCURRENCE.DISCHARGED_TO_CONCEPT_ID'.
AUDIT (
  name visit_occurrence_discharged_to_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.VISIT_OCCURRENCE WHERE DISCHARGED_TO_CONCEPT_ID = 0;

-- Description: Check for NULLs in required field 'VISIT_OCCURRENCE.PERSON_ID'.
AUDIT (
  name visit_occurrence_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.VISIT_OCCURRENCE WHERE PERSON_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'VISIT_OCCURRENCE.PERSON_ID' pointing to 'PERSON.PERSON_ID'.
        AUDIT (
          name visit_occurrence_person_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.VISIT_OCCURRENCE c
LEFT JOIN omop.PERSON p ON c.PERSON_ID = p.PERSON_ID
WHERE c.PERSON_ID IS NOT NULL AND p.PERSON_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'VISIT_OCCURRENCE.PRECEDING_VISIT_OCCURRENCE_ID' pointing to 'VISIT_OCCURRENCE.VISIT_OCCURRENCE_ID'.
        AUDIT (
          name visit_occurrence_preceding_visit_occurrence_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.VISIT_OCCURRENCE c
LEFT JOIN omop.VISIT_OCCURRENCE p ON c.PRECEDING_VISIT_OCCURRENCE_ID = p.VISIT_OCCURRENCE_ID
WHERE c.PRECEDING_VISIT_OCCURRENCE_ID IS NOT NULL AND p.VISIT_OCCURRENCE_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'VISIT_OCCURRENCE.PROVIDER_ID' pointing to 'PROVIDER.PROVIDER_ID'.
        AUDIT (
          name visit_occurrence_provider_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.VISIT_OCCURRENCE c
LEFT JOIN omop.PROVIDER p ON c.PROVIDER_ID = p.PROVIDER_ID
WHERE c.PROVIDER_ID IS NOT NULL AND p.PROVIDER_ID IS NULL;;

-- Description: Check for NULLs in required field 'VISIT_OCCURRENCE.VISIT_CONCEPT_ID'.
AUDIT (
  name visit_occurrence_visit_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.VISIT_OCCURRENCE WHERE VISIT_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'VISIT_OCCURRENCE.VISIT_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name visit_occurrence_visit_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.VISIT_OCCURRENCE c
LEFT JOIN vocab.concept p ON c.VISIT_CONCEPT_ID = p.CONCEPT_ID
WHERE c.VISIT_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'VISIT_OCCURRENCE.VISIT_CONCEPT_ID' belong to the 'Visit' domain.
        AUDIT (
          name visit_occurrence_visit_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.VISIT_OCCURRENCE t
JOIN vocab.concept c ON t.VISIT_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Visit';;

-- Description: Check that concepts in 'VISIT_OCCURRENCE.VISIT_CONCEPT_ID' are standard and valid.
        AUDIT (
          name visit_occurrence_visit_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.VISIT_OCCURRENCE t
LEFT JOIN vocab.concept c ON t.VISIT_CONCEPT_ID = c.concept_id
WHERE t.VISIT_CONCEPT_ID IS NOT NULL
  AND t.VISIT_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'VISIT_OCCURRENCE.VISIT_CONCEPT_ID'.
AUDIT (
  name visit_occurrence_visit_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.VISIT_OCCURRENCE WHERE VISIT_CONCEPT_ID = 0;

-- Description: Check for NULLs in required field 'VISIT_OCCURRENCE.VISIT_END_DATE'.
AUDIT (
  name visit_occurrence_visit_end_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.VISIT_OCCURRENCE WHERE VISIT_END_DATE IS NULL;

-- Description: Check that date 'VISIT_OCCURRENCE.VISIT_END_DATE' is after person's birth date.
        AUDIT (
          name visit_occurrence_visit_end_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.VISIT_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.VISIT_END_DATE < p.birth_datetime;;

-- Description: Check that date 'VISIT_OCCURRENCE.VISIT_END_DATETIME' is after person's birth date.
        AUDIT (
          name visit_occurrence_visit_end_datetime_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.VISIT_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.VISIT_END_DATETIME < p.birth_datetime;;

-- Description: Check for NULLs in required field 'VISIT_OCCURRENCE.VISIT_OCCURRENCE_ID'.
AUDIT (
  name visit_occurrence_visit_occurrence_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.VISIT_OCCURRENCE WHERE VISIT_OCCURRENCE_ID IS NULL;

-- Description: Check for duplicate values in primary key field 'VISIT_OCCURRENCE.VISIT_OCCURRENCE_ID'.
        AUDIT (
          name visit_occurrence_visit_occurrence_id_is_primary_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT VISIT_OCCURRENCE_ID, COUNT(*)
FROM omop.VISIT_OCCURRENCE
WHERE VISIT_OCCURRENCE_ID IS NOT NULL
GROUP BY VISIT_OCCURRENCE_ID
HAVING COUNT(*) > 1;;

-- Description: Check for orphaned foreign keys in 'VISIT_OCCURRENCE.VISIT_SOURCE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name visit_occurrence_visit_source_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.VISIT_OCCURRENCE c
LEFT JOIN vocab.concept p ON c.VISIT_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.VISIT_SOURCE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'VISIT_OCCURRENCE.VISIT_START_DATE'.
AUDIT (
  name visit_occurrence_visit_start_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.VISIT_OCCURRENCE WHERE VISIT_START_DATE IS NULL;

-- Description: Check that 'VISIT_OCCURRENCE.VISIT_START_DATE' occurs before 'VISIT_OCCURRENCE.VISIT_END_DATE'.
AUDIT (
  name visit_occurrence_visit_start_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.VISIT_OCCURRENCE WHERE VISIT_START_DATE > VISIT_END_DATE;

-- Description: Check that date 'VISIT_OCCURRENCE.VISIT_START_DATE' is after person's birth date.
        AUDIT (
          name visit_occurrence_visit_start_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.VISIT_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.VISIT_START_DATE < p.birth_datetime;;

-- Description: Check that 'VISIT_OCCURRENCE.VISIT_START_DATETIME' occurs before 'VISIT_OCCURRENCE.VISIT_END_DATETIME'.
AUDIT (
  name visit_occurrence_visit_start_datetime_start_before_end,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.VISIT_OCCURRENCE WHERE VISIT_START_DATETIME > VISIT_END_DATETIME;

-- Description: Check that date 'VISIT_OCCURRENCE.VISIT_START_DATETIME' is after person's birth date.
        AUDIT (
          name visit_occurrence_visit_start_datetime_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.VISIT_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.VISIT_START_DATETIME < p.birth_datetime;;

-- Description: Check for NULLs in required field 'VISIT_OCCURRENCE.VISIT_TYPE_CONCEPT_ID'.
AUDIT (
  name visit_occurrence_visit_type_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.VISIT_OCCURRENCE WHERE VISIT_TYPE_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'VISIT_OCCURRENCE.VISIT_TYPE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name visit_occurrence_visit_type_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.VISIT_OCCURRENCE c
LEFT JOIN vocab.concept p ON c.VISIT_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.VISIT_TYPE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'VISIT_OCCURRENCE.VISIT_TYPE_CONCEPT_ID' belong to the 'Type Concept' domain.
        AUDIT (
          name visit_occurrence_visit_type_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.VISIT_OCCURRENCE t
JOIN vocab.concept c ON t.VISIT_TYPE_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Type Concept';;

-- Description: Check that concepts in 'VISIT_OCCURRENCE.VISIT_TYPE_CONCEPT_ID' are standard and valid.
        AUDIT (
          name visit_occurrence_visit_type_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.VISIT_OCCURRENCE t
LEFT JOIN vocab.concept c ON t.VISIT_TYPE_CONCEPT_ID = c.concept_id
WHERE t.VISIT_TYPE_CONCEPT_ID IS NOT NULL
  AND t.VISIT_TYPE_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'VISIT_OCCURRENCE.VISIT_TYPE_CONCEPT_ID'.
AUDIT (
  name visit_occurrence_visit_type_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.VISIT_OCCURRENCE WHERE VISIT_TYPE_CONCEPT_ID = 0;

-- Description: Temporal constancy check for concept 'Inpatient visit'.
        AUDIT (
          name visit_occurrence_9201_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.VISIT_OCCURRENCE
WHERE VISIT_CONCEPT_ID = 9201
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Temporal constancy check for concept 'Outpatient visit'.
        AUDIT (
          name visit_occurrence_9202_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.VISIT_OCCURRENCE
WHERE VISIT_CONCEPT_ID = 9202
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Temporal constancy check for concept 'ER visit'.
        AUDIT (
          name visit_occurrence_9203_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.VISIT_OCCURRENCE
WHERE VISIT_CONCEPT_ID = 9203
GROUP BY person_id
HAVING COUNT(*) > 1;;

