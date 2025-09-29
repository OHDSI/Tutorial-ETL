-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.visit_detail,
--   depends_on (
--     omop.care_site,
--     vocab.concept,
--     omop.person,
--     omop.provider,
--     omop.visit_occurrence,
--   ),
--   audits (
--     person_completeness_visit_detail,
--     visit_detail_admitted_from_concept_id_is_foreign_key,
--     visit_detail_admitted_from_concept_id_fk_domain,
--     visit_detail_admitted_from_concept_id_is_standard_valid_concept,
--     visit_detail_admitted_from_concept_id_standard_concept_record_completeness,
--     visit_detail_care_site_id_is_foreign_key,
--     visit_detail_discharged_to_concept_id_is_foreign_key,
--     visit_detail_discharged_to_concept_id_fk_domain,
--     visit_detail_discharged_to_concept_id_is_standard_valid_concept,
--     visit_detail_discharged_to_concept_id_standard_concept_record_completeness,
--     visit_detail_parent_visit_detail_id_is_foreign_key,
--     visit_detail_person_id_is_required,
--     visit_detail_person_id_is_foreign_key,
--     visit_detail_preceding_visit_detail_id_is_foreign_key,
--     visit_detail_provider_id_is_foreign_key,
--     visit_detail_visit_detail_concept_id_is_required,
--     visit_detail_visit_detail_concept_id_is_foreign_key,
--     visit_detail_visit_detail_concept_id_fk_domain,
--     visit_detail_visit_detail_concept_id_is_standard_valid_concept,
--     visit_detail_visit_detail_concept_id_standard_concept_record_completeness,
--     visit_detail_visit_detail_end_date_is_required,
--     visit_detail_visit_detail_end_date_after_birth,
--     visit_detail_visit_detail_end_datetime_after_birth,
--     visit_detail_visit_detail_id_is_required,
--     visit_detail_visit_detail_id_is_primary_key,
--     visit_detail_visit_detail_source_concept_id_is_foreign_key,
--     visit_detail_visit_detail_start_date_is_required,
--     visit_detail_visit_detail_start_date_start_before_end,
--     visit_detail_visit_detail_start_date_after_birth,
--     visit_detail_visit_detail_start_datetime_start_before_end,
--     visit_detail_visit_detail_start_datetime_after_birth,
--     visit_detail_visit_detail_type_concept_id_is_required,
--     visit_detail_visit_detail_type_concept_id_is_foreign_key,
--     visit_detail_visit_detail_type_concept_id_fk_domain,
--     visit_detail_visit_detail_type_concept_id_is_standard_valid_concept,
--     visit_detail_visit_detail_type_concept_id_standard_concept_record_completeness,
--     visit_detail_visit_occurrence_id_is_required,
--     visit_detail_visit_occurrence_id_is_foreign_key,
--   )
-- );

-- Description: Check for persons missing from table 'VISIT_DETAIL'.
        AUDIT (
          name person_completeness_visit_detail,
          dialect duckdb,
          blocking FALSE
        );
        SELECT p.person_id
FROM omop.person p
LEFT JOIN omop.VISIT_DETAIL e ON p.person_id = e.person_id
WHERE e.person_id IS NULL;;

-- Description: Check for orphaned foreign keys in 'VISIT_DETAIL.ADMITTED_FROM_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name visit_detail_admitted_from_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.VISIT_DETAIL c
LEFT JOIN vocab.concept p ON c.ADMITTED_FROM_CONCEPT_ID = p.CONCEPT_ID
WHERE c.ADMITTED_FROM_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'VISIT_DETAIL.ADMITTED_FROM_CONCEPT_ID' belong to the 'Visit' domain.
        AUDIT (
          name visit_detail_admitted_from_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.VISIT_DETAIL t
JOIN vocab.concept c ON t.ADMITTED_FROM_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Visit';;

-- Description: Check that concepts in 'VISIT_DETAIL.ADMITTED_FROM_CONCEPT_ID' are standard and valid.
        AUDIT (
          name visit_detail_admitted_from_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.VISIT_DETAIL t
LEFT JOIN vocab.concept c ON t.ADMITTED_FROM_CONCEPT_ID = c.concept_id
WHERE t.ADMITTED_FROM_CONCEPT_ID IS NOT NULL
  AND t.ADMITTED_FROM_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'VISIT_DETAIL.ADMITTED_FROM_CONCEPT_ID'.
AUDIT (
  name visit_detail_admitted_from_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.VISIT_DETAIL WHERE ADMITTED_FROM_CONCEPT_ID = 0;

-- Description: Check for orphaned foreign keys in 'VISIT_DETAIL.CARE_SITE_ID' pointing to 'CARE_SITE.CARE_SITE_ID'.
        AUDIT (
          name visit_detail_care_site_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.VISIT_DETAIL c
LEFT JOIN omop.CARE_SITE p ON c.CARE_SITE_ID = p.CARE_SITE_ID
WHERE c.CARE_SITE_ID IS NOT NULL AND p.CARE_SITE_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'VISIT_DETAIL.DISCHARGED_TO_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name visit_detail_discharged_to_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.VISIT_DETAIL c
LEFT JOIN vocab.concept p ON c.DISCHARGED_TO_CONCEPT_ID = p.CONCEPT_ID
WHERE c.DISCHARGED_TO_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'VISIT_DETAIL.DISCHARGED_TO_CONCEPT_ID' belong to the 'Visit' domain.
        AUDIT (
          name visit_detail_discharged_to_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.VISIT_DETAIL t
JOIN vocab.concept c ON t.DISCHARGED_TO_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Visit';;

-- Description: Check that concepts in 'VISIT_DETAIL.DISCHARGED_TO_CONCEPT_ID' are standard and valid.
        AUDIT (
          name visit_detail_discharged_to_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.VISIT_DETAIL t
LEFT JOIN vocab.concept c ON t.DISCHARGED_TO_CONCEPT_ID = c.concept_id
WHERE t.DISCHARGED_TO_CONCEPT_ID IS NOT NULL
  AND t.DISCHARGED_TO_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'VISIT_DETAIL.DISCHARGED_TO_CONCEPT_ID'.
AUDIT (
  name visit_detail_discharged_to_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.VISIT_DETAIL WHERE DISCHARGED_TO_CONCEPT_ID = 0;

-- Description: Check for orphaned foreign keys in 'VISIT_DETAIL.PARENT_VISIT_DETAIL_ID' pointing to 'VISIT_DETAIL.VISIT_DETAIL_ID'.
        AUDIT (
          name visit_detail_parent_visit_detail_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.VISIT_DETAIL c
LEFT JOIN omop.VISIT_DETAIL p ON c.PARENT_VISIT_DETAIL_ID = p.VISIT_DETAIL_ID
WHERE c.PARENT_VISIT_DETAIL_ID IS NOT NULL AND p.VISIT_DETAIL_ID IS NULL;;

-- Description: Check for NULLs in required field 'VISIT_DETAIL.PERSON_ID'.
AUDIT (
  name visit_detail_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.VISIT_DETAIL WHERE PERSON_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'VISIT_DETAIL.PERSON_ID' pointing to 'PERSON.PERSON_ID'.
        AUDIT (
          name visit_detail_person_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.VISIT_DETAIL c
LEFT JOIN omop.PERSON p ON c.PERSON_ID = p.PERSON_ID
WHERE c.PERSON_ID IS NOT NULL AND p.PERSON_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'VISIT_DETAIL.PRECEDING_VISIT_DETAIL_ID' pointing to 'VISIT_DETAIL.VISIT_DETAIL_ID'.
        AUDIT (
          name visit_detail_preceding_visit_detail_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.VISIT_DETAIL c
LEFT JOIN omop.VISIT_DETAIL p ON c.PRECEDING_VISIT_DETAIL_ID = p.VISIT_DETAIL_ID
WHERE c.PRECEDING_VISIT_DETAIL_ID IS NOT NULL AND p.VISIT_DETAIL_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'VISIT_DETAIL.PROVIDER_ID' pointing to 'PROVIDER.PROVIDER_ID'.
        AUDIT (
          name visit_detail_provider_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.VISIT_DETAIL c
LEFT JOIN omop.PROVIDER p ON c.PROVIDER_ID = p.PROVIDER_ID
WHERE c.PROVIDER_ID IS NOT NULL AND p.PROVIDER_ID IS NULL;;

-- Description: Check for NULLs in required field 'VISIT_DETAIL.VISIT_DETAIL_CONCEPT_ID'.
AUDIT (
  name visit_detail_visit_detail_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.VISIT_DETAIL WHERE VISIT_DETAIL_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'VISIT_DETAIL.VISIT_DETAIL_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name visit_detail_visit_detail_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.VISIT_DETAIL c
LEFT JOIN vocab.concept p ON c.VISIT_DETAIL_CONCEPT_ID = p.CONCEPT_ID
WHERE c.VISIT_DETAIL_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'VISIT_DETAIL.VISIT_DETAIL_CONCEPT_ID' belong to the 'Visit' domain.
        AUDIT (
          name visit_detail_visit_detail_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.VISIT_DETAIL t
JOIN vocab.concept c ON t.VISIT_DETAIL_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Visit';;

-- Description: Check that concepts in 'VISIT_DETAIL.VISIT_DETAIL_CONCEPT_ID' are standard and valid.
        AUDIT (
          name visit_detail_visit_detail_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.VISIT_DETAIL t
LEFT JOIN vocab.concept c ON t.VISIT_DETAIL_CONCEPT_ID = c.concept_id
WHERE t.VISIT_DETAIL_CONCEPT_ID IS NOT NULL
  AND t.VISIT_DETAIL_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'VISIT_DETAIL.VISIT_DETAIL_CONCEPT_ID'.
AUDIT (
  name visit_detail_visit_detail_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.VISIT_DETAIL WHERE VISIT_DETAIL_CONCEPT_ID = 0;

-- Description: Check for NULLs in required field 'VISIT_DETAIL.VISIT_DETAIL_END_DATE'.
AUDIT (
  name visit_detail_visit_detail_end_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.VISIT_DETAIL WHERE VISIT_DETAIL_END_DATE IS NULL;

-- Description: Check that date 'VISIT_DETAIL.VISIT_DETAIL_END_DATE' is after person's birth date.
        AUDIT (
          name visit_detail_visit_detail_end_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.VISIT_DETAIL t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.VISIT_DETAIL_END_DATE < p.birth_datetime;;

-- Description: Check that date 'VISIT_DETAIL.VISIT_DETAIL_END_DATETIME' is after person's birth date.
        AUDIT (
          name visit_detail_visit_detail_end_datetime_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.VISIT_DETAIL t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.VISIT_DETAIL_END_DATETIME < p.birth_datetime;;

-- Description: Check for NULLs in required field 'VISIT_DETAIL.VISIT_DETAIL_ID'.
AUDIT (
  name visit_detail_visit_detail_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.VISIT_DETAIL WHERE VISIT_DETAIL_ID IS NULL;

-- Description: Check for duplicate values in primary key field 'VISIT_DETAIL.VISIT_DETAIL_ID'.
        AUDIT (
          name visit_detail_visit_detail_id_is_primary_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT VISIT_DETAIL_ID, COUNT(*)
FROM omop.VISIT_DETAIL
WHERE VISIT_DETAIL_ID IS NOT NULL
GROUP BY VISIT_DETAIL_ID
HAVING COUNT(*) > 1;;

-- Description: Check for orphaned foreign keys in 'VISIT_DETAIL.VISIT_DETAIL_SOURCE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name visit_detail_visit_detail_source_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.VISIT_DETAIL c
LEFT JOIN vocab.concept p ON c.VISIT_DETAIL_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.VISIT_DETAIL_SOURCE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'VISIT_DETAIL.VISIT_DETAIL_START_DATE'.
AUDIT (
  name visit_detail_visit_detail_start_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.VISIT_DETAIL WHERE VISIT_DETAIL_START_DATE IS NULL;

-- Description: Check that 'VISIT_DETAIL.VISIT_DETAIL_START_DATE' occurs before 'VISIT_DETAIL.VISIT_DETAIL_END_DATE'.
AUDIT (
  name visit_detail_visit_detail_start_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.VISIT_DETAIL WHERE VISIT_DETAIL_START_DATE > VISIT_DETAIL_END_DATE;

-- Description: Check that date 'VISIT_DETAIL.VISIT_DETAIL_START_DATE' is after person's birth date.
        AUDIT (
          name visit_detail_visit_detail_start_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.VISIT_DETAIL t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.VISIT_DETAIL_START_DATE < p.birth_datetime;;

-- Description: Check that 'VISIT_DETAIL.VISIT_DETAIL_START_DATETIME' occurs before 'VISIT_DETAIL.VISIT_DETAIL_END_DATETIME'.
AUDIT (
  name visit_detail_visit_detail_start_datetime_start_before_end,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.VISIT_DETAIL WHERE VISIT_DETAIL_START_DATETIME > VISIT_DETAIL_END_DATETIME;

-- Description: Check that date 'VISIT_DETAIL.VISIT_DETAIL_START_DATETIME' is after person's birth date.
        AUDIT (
          name visit_detail_visit_detail_start_datetime_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.VISIT_DETAIL t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.VISIT_DETAIL_START_DATETIME < p.birth_datetime;;

-- Description: Check for NULLs in required field 'VISIT_DETAIL.VISIT_DETAIL_TYPE_CONCEPT_ID'.
AUDIT (
  name visit_detail_visit_detail_type_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.VISIT_DETAIL WHERE VISIT_DETAIL_TYPE_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'VISIT_DETAIL.VISIT_DETAIL_TYPE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name visit_detail_visit_detail_type_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.VISIT_DETAIL c
LEFT JOIN vocab.concept p ON c.VISIT_DETAIL_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.VISIT_DETAIL_TYPE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'VISIT_DETAIL.VISIT_DETAIL_TYPE_CONCEPT_ID' belong to the 'Type Concept' domain.
        AUDIT (
          name visit_detail_visit_detail_type_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.VISIT_DETAIL t
JOIN vocab.concept c ON t.VISIT_DETAIL_TYPE_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Type Concept';;

-- Description: Check that concepts in 'VISIT_DETAIL.VISIT_DETAIL_TYPE_CONCEPT_ID' are standard and valid.
        AUDIT (
          name visit_detail_visit_detail_type_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.VISIT_DETAIL t
LEFT JOIN vocab.concept c ON t.VISIT_DETAIL_TYPE_CONCEPT_ID = c.concept_id
WHERE t.VISIT_DETAIL_TYPE_CONCEPT_ID IS NOT NULL
  AND t.VISIT_DETAIL_TYPE_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'VISIT_DETAIL.VISIT_DETAIL_TYPE_CONCEPT_ID'.
AUDIT (
  name visit_detail_visit_detail_type_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.VISIT_DETAIL WHERE VISIT_DETAIL_TYPE_CONCEPT_ID = 0;

-- Description: Check for NULLs in required field 'VISIT_DETAIL.VISIT_OCCURRENCE_ID'.
AUDIT (
  name visit_detail_visit_occurrence_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.VISIT_DETAIL WHERE VISIT_OCCURRENCE_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'VISIT_DETAIL.VISIT_OCCURRENCE_ID' pointing to 'VISIT_OCCURRENCE.VISIT_OCCURRENCE_ID'.
        AUDIT (
          name visit_detail_visit_occurrence_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.VISIT_DETAIL c
LEFT JOIN omop.VISIT_OCCURRENCE p ON c.VISIT_OCCURRENCE_ID = p.VISIT_OCCURRENCE_ID
WHERE c.VISIT_OCCURRENCE_ID IS NOT NULL AND p.VISIT_OCCURRENCE_ID IS NULL;;

