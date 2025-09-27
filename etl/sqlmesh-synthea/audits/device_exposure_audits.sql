-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.device_exposure,
--   audits (
--     person_completeness_device_exposure,
--     device_exposure_device_concept_id_is_required,
--     device_exposure_device_concept_id_is_foreign_key,
--     device_exposure_device_concept_id_fk_domain,
--     device_exposure_device_concept_id_is_standard_valid_concept,
--     device_exposure_device_concept_id_standard_concept_record_completeness,
--     device_exposure_device_exposure_end_date_after_birth,
--     device_exposure_device_exposure_end_datetime_after_birth,
--     device_exposure_device_exposure_id_is_required,
--     device_exposure_device_exposure_id_is_primary_key,
--     device_exposure_device_exposure_start_date_is_required,
--     device_exposure_device_exposure_start_date_start_before_end,
--     device_exposure_device_exposure_start_date_after_birth,
--     device_exposure_device_exposure_start_datetime_start_before_end,
--     device_exposure_device_exposure_start_datetime_after_birth,
--     device_exposure_device_source_concept_id_is_foreign_key,
--     device_exposure_device_type_concept_id_is_required,
--     device_exposure_device_type_concept_id_is_foreign_key,
--     device_exposure_device_type_concept_id_fk_domain,
--     device_exposure_device_type_concept_id_is_standard_valid_concept,
--     device_exposure_device_type_concept_id_standard_concept_record_completeness,
--     device_exposure_person_id_is_required,
--     device_exposure_person_id_is_foreign_key,
--     device_exposure_provider_id_is_foreign_key,
--     device_exposure_unit_concept_id_is_foreign_key,
--     device_exposure_unit_concept_id_fk_domain,
--     device_exposure_unit_concept_id_is_standard_valid_concept,
--     device_exposure_unit_concept_id_standard_concept_record_completeness,
--     device_exposure_unit_source_concept_id_is_foreign_key,
--     device_exposure_visit_detail_id_is_foreign_key,
--     device_exposure_visit_occurrence_id_is_foreign_key,
--   )
-- );

-- Description: Check for persons missing from table 'DEVICE_EXPOSURE'.
        AUDIT (
          name person_completeness_device_exposure,
          dialect duckdb,
          blocking FALSE
        );
        SELECT p.person_id
FROM omop.person p
LEFT JOIN omop.DEVICE_EXPOSURE e ON p.person_id = e.person_id
WHERE e.person_id IS NULL;;

-- Description: Check for NULLs in required field 'DEVICE_EXPOSURE.DEVICE_CONCEPT_ID'.
AUDIT (
  name device_exposure_device_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DEVICE_EXPOSURE WHERE DEVICE_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'DEVICE_EXPOSURE.DEVICE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name device_exposure_device_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DEVICE_EXPOSURE c
LEFT JOIN vocab.CONCEPT p ON c.DEVICE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.DEVICE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'DEVICE_EXPOSURE.DEVICE_CONCEPT_ID' belong to the 'Device' domain.
        AUDIT (
          name device_exposure_device_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DEVICE_EXPOSURE t
JOIN vocab.CONCEPT c ON t.DEVICE_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Device';;

-- Description: Check that concepts in 'DEVICE_EXPOSURE.DEVICE_CONCEPT_ID' are standard and valid.
        AUDIT (
          name device_exposure_device_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DEVICE_EXPOSURE t
LEFT JOIN vocab.CONCEPT c ON t.DEVICE_CONCEPT_ID = c.concept_id
WHERE t.DEVICE_CONCEPT_ID IS NOT NULL
  AND t.DEVICE_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'DEVICE_EXPOSURE.DEVICE_CONCEPT_ID'.
AUDIT (
  name device_exposure_device_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DEVICE_EXPOSURE WHERE DEVICE_CONCEPT_ID = 0;

-- Description: Check that date 'DEVICE_EXPOSURE.DEVICE_EXPOSURE_END_DATE' is after person's birth date.
        AUDIT (
          name device_exposure_device_exposure_end_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DEVICE_EXPOSURE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.DEVICE_EXPOSURE_END_DATE < p.birth_datetime;;

-- Description: Check that date 'DEVICE_EXPOSURE.DEVICE_EXPOSURE_END_DATETIME' is after person's birth date.
        AUDIT (
          name device_exposure_device_exposure_end_datetime_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DEVICE_EXPOSURE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.DEVICE_EXPOSURE_END_DATETIME < p.birth_datetime;;

-- Description: Check for NULLs in required field 'DEVICE_EXPOSURE.DEVICE_EXPOSURE_ID'.
AUDIT (
  name device_exposure_device_exposure_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DEVICE_EXPOSURE WHERE DEVICE_EXPOSURE_ID IS NULL;

-- Description: Check for duplicate values in primary key field 'DEVICE_EXPOSURE.DEVICE_EXPOSURE_ID'.
        AUDIT (
          name device_exposure_device_exposure_id_is_primary_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT DEVICE_EXPOSURE_ID, COUNT(*)
FROM omop.DEVICE_EXPOSURE
WHERE DEVICE_EXPOSURE_ID IS NOT NULL
GROUP BY DEVICE_EXPOSURE_ID
HAVING COUNT(*) > 1;;

-- Description: Check for NULLs in required field 'DEVICE_EXPOSURE.DEVICE_EXPOSURE_START_DATE'.
AUDIT (
  name device_exposure_device_exposure_start_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DEVICE_EXPOSURE WHERE DEVICE_EXPOSURE_START_DATE IS NULL;

-- Description: Check that 'DEVICE_EXPOSURE.DEVICE_EXPOSURE_START_DATE' occurs before 'DEVICE_EXPOSURE.DEVICE_EXPOSURE_END_DATE'.
AUDIT (
  name device_exposure_device_exposure_start_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DEVICE_EXPOSURE WHERE DEVICE_EXPOSURE_START_DATE > DEVICE_EXPOSURE_END_DATE;

-- Description: Check that date 'DEVICE_EXPOSURE.DEVICE_EXPOSURE_START_DATE' is after person's birth date.
        AUDIT (
          name device_exposure_device_exposure_start_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DEVICE_EXPOSURE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.DEVICE_EXPOSURE_START_DATE < p.birth_datetime;;

-- Description: Check that 'DEVICE_EXPOSURE.DEVICE_EXPOSURE_START_DATETIME' occurs before 'DEVICE_EXPOSURE.DEVICE_EXPOSURE_END_DATETIME'.
AUDIT (
  name device_exposure_device_exposure_start_datetime_start_before_end,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DEVICE_EXPOSURE WHERE DEVICE_EXPOSURE_START_DATETIME > DEVICE_EXPOSURE_END_DATETIME;

-- Description: Check that date 'DEVICE_EXPOSURE.DEVICE_EXPOSURE_START_DATETIME' is after person's birth date.
        AUDIT (
          name device_exposure_device_exposure_start_datetime_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DEVICE_EXPOSURE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.DEVICE_EXPOSURE_START_DATETIME < p.birth_datetime;;

-- Description: Check for orphaned foreign keys in 'DEVICE_EXPOSURE.DEVICE_SOURCE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name device_exposure_device_source_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DEVICE_EXPOSURE c
LEFT JOIN vocab.CONCEPT p ON c.DEVICE_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.DEVICE_SOURCE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'DEVICE_EXPOSURE.DEVICE_TYPE_CONCEPT_ID'.
AUDIT (
  name device_exposure_device_type_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DEVICE_EXPOSURE WHERE DEVICE_TYPE_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'DEVICE_EXPOSURE.DEVICE_TYPE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name device_exposure_device_type_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DEVICE_EXPOSURE c
LEFT JOIN vocab.CONCEPT p ON c.DEVICE_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.DEVICE_TYPE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'DEVICE_EXPOSURE.DEVICE_TYPE_CONCEPT_ID' belong to the 'Type Concept' domain.
        AUDIT (
          name device_exposure_device_type_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DEVICE_EXPOSURE t
JOIN vocab.CONCEPT c ON t.DEVICE_TYPE_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Type Concept';;

-- Description: Check that concepts in 'DEVICE_EXPOSURE.DEVICE_TYPE_CONCEPT_ID' are standard and valid.
        AUDIT (
          name device_exposure_device_type_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DEVICE_EXPOSURE t
LEFT JOIN vocab.CONCEPT c ON t.DEVICE_TYPE_CONCEPT_ID = c.concept_id
WHERE t.DEVICE_TYPE_CONCEPT_ID IS NOT NULL
  AND t.DEVICE_TYPE_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'DEVICE_EXPOSURE.DEVICE_TYPE_CONCEPT_ID'.
AUDIT (
  name device_exposure_device_type_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DEVICE_EXPOSURE WHERE DEVICE_TYPE_CONCEPT_ID = 0;

-- Description: Check for NULLs in required field 'DEVICE_EXPOSURE.PERSON_ID'.
AUDIT (
  name device_exposure_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DEVICE_EXPOSURE WHERE PERSON_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'DEVICE_EXPOSURE.PERSON_ID' pointing to 'PERSON.PERSON_ID'.
        AUDIT (
          name device_exposure_person_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DEVICE_EXPOSURE c
LEFT JOIN omop.PERSON p ON c.PERSON_ID = p.PERSON_ID
WHERE c.PERSON_ID IS NOT NULL AND p.PERSON_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'DEVICE_EXPOSURE.PROVIDER_ID' pointing to 'PROVIDER.PROVIDER_ID'.
        AUDIT (
          name device_exposure_provider_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DEVICE_EXPOSURE c
LEFT JOIN omop.PROVIDER p ON c.PROVIDER_ID = p.PROVIDER_ID
WHERE c.PROVIDER_ID IS NOT NULL AND p.PROVIDER_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'DEVICE_EXPOSURE.UNIT_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name device_exposure_unit_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DEVICE_EXPOSURE c
LEFT JOIN vocab.CONCEPT p ON c.UNIT_CONCEPT_ID = p.CONCEPT_ID
WHERE c.UNIT_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'DEVICE_EXPOSURE.UNIT_CONCEPT_ID' belong to the 'Unit' domain.
        AUDIT (
          name device_exposure_unit_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DEVICE_EXPOSURE t
JOIN vocab.CONCEPT c ON t.UNIT_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Unit';;

-- Description: Check that concepts in 'DEVICE_EXPOSURE.UNIT_CONCEPT_ID' are standard and valid.
        AUDIT (
          name device_exposure_unit_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DEVICE_EXPOSURE t
LEFT JOIN vocab.CONCEPT c ON t.UNIT_CONCEPT_ID = c.concept_id
WHERE t.UNIT_CONCEPT_ID IS NOT NULL
  AND t.UNIT_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'DEVICE_EXPOSURE.UNIT_CONCEPT_ID'.
AUDIT (
  name device_exposure_unit_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DEVICE_EXPOSURE WHERE UNIT_CONCEPT_ID = 0;

-- Description: Check for orphaned foreign keys in 'DEVICE_EXPOSURE.UNIT_SOURCE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name device_exposure_unit_source_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DEVICE_EXPOSURE c
LEFT JOIN vocab.CONCEPT p ON c.UNIT_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.UNIT_SOURCE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'DEVICE_EXPOSURE.VISIT_DETAIL_ID' pointing to 'VISIT_DETAIL.VISIT_DETAIL_ID'.
        AUDIT (
          name device_exposure_visit_detail_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DEVICE_EXPOSURE c
LEFT JOIN omop.VISIT_DETAIL p ON c.VISIT_DETAIL_ID = p.VISIT_DETAIL_ID
WHERE c.VISIT_DETAIL_ID IS NOT NULL AND p.VISIT_DETAIL_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'DEVICE_EXPOSURE.VISIT_OCCURRENCE_ID' pointing to 'VISIT_OCCURRENCE.VISIT_OCCURRENCE_ID'.
        AUDIT (
          name device_exposure_visit_occurrence_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DEVICE_EXPOSURE c
LEFT JOIN omop.VISIT_OCCURRENCE p ON c.VISIT_OCCURRENCE_ID = p.VISIT_OCCURRENCE_ID
WHERE c.VISIT_OCCURRENCE_ID IS NOT NULL AND p.VISIT_OCCURRENCE_ID IS NULL;;

