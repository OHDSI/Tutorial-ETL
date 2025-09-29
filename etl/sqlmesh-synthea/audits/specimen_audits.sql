-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.specimen,
--   depends_on (
--     vocab.concept,
--     omop.person,
--   ),
--   audits (
--     person_completeness_specimen,
--     specimen_anatomic_site_concept_id_is_foreign_key,
--     specimen_anatomic_site_concept_id_is_standard_valid_concept,
--     specimen_disease_status_concept_id_is_foreign_key,
--     specimen_disease_status_concept_id_is_standard_valid_concept,
--     specimen_person_id_is_required,
--     specimen_person_id_is_foreign_key,
--     specimen_specimen_concept_id_is_required,
--     specimen_specimen_concept_id_is_foreign_key,
--     specimen_specimen_concept_id_is_standard_valid_concept,
--     specimen_specimen_concept_id_standard_concept_record_completeness,
--     specimen_specimen_date_is_required,
--     specimen_specimen_date_after_birth,
--     specimen_specimen_datetime_after_birth,
--     specimen_specimen_id_is_required,
--     specimen_specimen_id_is_primary_key,
--     specimen_specimen_type_concept_id_is_required,
--     specimen_specimen_type_concept_id_is_foreign_key,
--     specimen_specimen_type_concept_id_fk_domain,
--     specimen_specimen_type_concept_id_is_standard_valid_concept,
--     specimen_specimen_type_concept_id_standard_concept_record_completeness,
--     specimen_unit_concept_id_is_foreign_key,
--     specimen_unit_concept_id_is_standard_valid_concept,
--     specimen_unit_concept_id_standard_concept_record_completeness,
--   )
-- );

-- Description: Check for persons missing from table 'SPECIMEN'.
        AUDIT (
          name person_completeness_specimen,
          dialect duckdb,
          blocking FALSE
        );
        SELECT p.person_id
FROM omop.person p
LEFT JOIN omop.SPECIMEN e ON p.person_id = e.person_id
WHERE e.person_id IS NULL;;

-- Description: Check for orphaned foreign keys in 'SPECIMEN.ANATOMIC_SITE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name specimen_anatomic_site_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.SPECIMEN c
LEFT JOIN vocab.concept p ON c.ANATOMIC_SITE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.ANATOMIC_SITE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'SPECIMEN.ANATOMIC_SITE_CONCEPT_ID' are standard and valid.
        AUDIT (
          name specimen_anatomic_site_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.SPECIMEN t
LEFT JOIN vocab.concept c ON t.ANATOMIC_SITE_CONCEPT_ID = c.concept_id
WHERE t.ANATOMIC_SITE_CONCEPT_ID IS NOT NULL
  AND t.ANATOMIC_SITE_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for orphaned foreign keys in 'SPECIMEN.DISEASE_STATUS_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name specimen_disease_status_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.SPECIMEN c
LEFT JOIN vocab.concept p ON c.DISEASE_STATUS_CONCEPT_ID = p.CONCEPT_ID
WHERE c.DISEASE_STATUS_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'SPECIMEN.DISEASE_STATUS_CONCEPT_ID' are standard and valid.
        AUDIT (
          name specimen_disease_status_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.SPECIMEN t
LEFT JOIN vocab.concept c ON t.DISEASE_STATUS_CONCEPT_ID = c.concept_id
WHERE t.DISEASE_STATUS_CONCEPT_ID IS NOT NULL
  AND t.DISEASE_STATUS_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for NULLs in required field 'SPECIMEN.PERSON_ID'.
AUDIT (
  name specimen_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.SPECIMEN WHERE PERSON_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'SPECIMEN.PERSON_ID' pointing to 'PERSON.PERSON_ID'.
        AUDIT (
          name specimen_person_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.SPECIMEN c
LEFT JOIN omop.PERSON p ON c.PERSON_ID = p.PERSON_ID
WHERE c.PERSON_ID IS NOT NULL AND p.PERSON_ID IS NULL;;

-- Description: Check for NULLs in required field 'SPECIMEN.SPECIMEN_CONCEPT_ID'.
AUDIT (
  name specimen_specimen_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.SPECIMEN WHERE SPECIMEN_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'SPECIMEN.SPECIMEN_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name specimen_specimen_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.SPECIMEN c
LEFT JOIN vocab.concept p ON c.SPECIMEN_CONCEPT_ID = p.CONCEPT_ID
WHERE c.SPECIMEN_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'SPECIMEN.SPECIMEN_CONCEPT_ID' are standard and valid.
        AUDIT (
          name specimen_specimen_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.SPECIMEN t
LEFT JOIN vocab.concept c ON t.SPECIMEN_CONCEPT_ID = c.concept_id
WHERE t.SPECIMEN_CONCEPT_ID IS NOT NULL
  AND t.SPECIMEN_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'SPECIMEN.SPECIMEN_CONCEPT_ID'.
AUDIT (
  name specimen_specimen_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.SPECIMEN WHERE SPECIMEN_CONCEPT_ID = 0;

-- Description: Check for NULLs in required field 'SPECIMEN.SPECIMEN_DATE'.
AUDIT (
  name specimen_specimen_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.SPECIMEN WHERE SPECIMEN_DATE IS NULL;

-- Description: Check that date 'SPECIMEN.SPECIMEN_DATE' is after person's birth date.
        AUDIT (
          name specimen_specimen_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.SPECIMEN t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.SPECIMEN_DATE < p.birth_datetime;;

-- Description: Check that date 'SPECIMEN.SPECIMEN_DATETIME' is after person's birth date.
        AUDIT (
          name specimen_specimen_datetime_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.SPECIMEN t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.SPECIMEN_DATETIME < p.birth_datetime;;

-- Description: Check for NULLs in required field 'SPECIMEN.SPECIMEN_ID'.
AUDIT (
  name specimen_specimen_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.SPECIMEN WHERE SPECIMEN_ID IS NULL;

-- Description: Check for duplicate values in primary key field 'SPECIMEN.SPECIMEN_ID'.
        AUDIT (
          name specimen_specimen_id_is_primary_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT SPECIMEN_ID, COUNT(*)
FROM omop.SPECIMEN
WHERE SPECIMEN_ID IS NOT NULL
GROUP BY SPECIMEN_ID
HAVING COUNT(*) > 1;;

-- Description: Check for NULLs in required field 'SPECIMEN.SPECIMEN_TYPE_CONCEPT_ID'.
AUDIT (
  name specimen_specimen_type_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.SPECIMEN WHERE SPECIMEN_TYPE_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'SPECIMEN.SPECIMEN_TYPE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name specimen_specimen_type_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.SPECIMEN c
LEFT JOIN vocab.concept p ON c.SPECIMEN_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.SPECIMEN_TYPE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'SPECIMEN.SPECIMEN_TYPE_CONCEPT_ID' belong to the 'Type Concept' domain.
        AUDIT (
          name specimen_specimen_type_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.SPECIMEN t
JOIN vocab.concept c ON t.SPECIMEN_TYPE_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Type Concept';;

-- Description: Check that concepts in 'SPECIMEN.SPECIMEN_TYPE_CONCEPT_ID' are standard and valid.
        AUDIT (
          name specimen_specimen_type_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.SPECIMEN t
LEFT JOIN vocab.concept c ON t.SPECIMEN_TYPE_CONCEPT_ID = c.concept_id
WHERE t.SPECIMEN_TYPE_CONCEPT_ID IS NOT NULL
  AND t.SPECIMEN_TYPE_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'SPECIMEN.SPECIMEN_TYPE_CONCEPT_ID'.
AUDIT (
  name specimen_specimen_type_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.SPECIMEN WHERE SPECIMEN_TYPE_CONCEPT_ID = 0;

-- Description: Check for orphaned foreign keys in 'SPECIMEN.UNIT_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name specimen_unit_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.SPECIMEN c
LEFT JOIN vocab.concept p ON c.UNIT_CONCEPT_ID = p.CONCEPT_ID
WHERE c.UNIT_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'SPECIMEN.UNIT_CONCEPT_ID' are standard and valid.
        AUDIT (
          name specimen_unit_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.SPECIMEN t
LEFT JOIN vocab.concept c ON t.UNIT_CONCEPT_ID = c.concept_id
WHERE t.UNIT_CONCEPT_ID IS NOT NULL
  AND t.UNIT_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'SPECIMEN.UNIT_CONCEPT_ID'.
AUDIT (
  name specimen_unit_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.SPECIMEN WHERE UNIT_CONCEPT_ID = 0;

