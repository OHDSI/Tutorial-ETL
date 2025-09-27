-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.cdm_source,
--   audits (
--     cdm_source_cdm_holder_is_required,
--     cdm_source_cdm_release_date_is_required,
--     cdm_source_cdm_source_abbreviation_is_required,
--     cdm_source_cdm_source_name_is_required,
--     cdm_source_cdm_version_concept_id_is_required,
--     cdm_source_cdm_version_concept_id_is_foreign_key,
--     cdm_source_cdm_version_concept_id_fk_domain,
--     cdm_source_cdm_version_concept_id_is_standard_valid_concept,
--     cdm_source_source_release_date_is_required,
--     cdm_source_source_release_date_start_before_end,
--     cdm_source_vocabulary_version_is_required,
--   )
-- );

-- Description: Check for NULLs in required field 'CDM_SOURCE.CDM_HOLDER'.
AUDIT (
  name cdm_source_cdm_holder_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CDM_SOURCE WHERE CDM_HOLDER IS NULL;

-- Description: Check for NULLs in required field 'CDM_SOURCE.CDM_RELEASE_DATE'.
AUDIT (
  name cdm_source_cdm_release_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CDM_SOURCE WHERE CDM_RELEASE_DATE IS NULL;

-- Description: Check for NULLs in required field 'CDM_SOURCE.CDM_SOURCE_ABBREVIATION'.
AUDIT (
  name cdm_source_cdm_source_abbreviation_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CDM_SOURCE WHERE CDM_SOURCE_ABBREVIATION IS NULL;

-- Description: Check for NULLs in required field 'CDM_SOURCE.CDM_SOURCE_NAME'.
AUDIT (
  name cdm_source_cdm_source_name_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CDM_SOURCE WHERE CDM_SOURCE_NAME IS NULL;

-- Description: Check for NULLs in required field 'CDM_SOURCE.CDM_VERSION_CONCEPT_ID'.
AUDIT (
  name cdm_source_cdm_version_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CDM_SOURCE WHERE CDM_VERSION_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'CDM_SOURCE.CDM_VERSION_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name cdm_source_cdm_version_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.CDM_SOURCE c
LEFT JOIN vocab.CONCEPT p ON c.CDM_VERSION_CONCEPT_ID = p.CONCEPT_ID
WHERE c.CDM_VERSION_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'CDM_SOURCE.CDM_VERSION_CONCEPT_ID' belong to the 'Metadata' domain.
        AUDIT (
          name cdm_source_cdm_version_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CDM_SOURCE t
JOIN vocab.CONCEPT c ON t.CDM_VERSION_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Metadata';;

-- Description: Check that concepts in 'CDM_SOURCE.CDM_VERSION_CONCEPT_ID' are standard and valid.
        AUDIT (
          name cdm_source_cdm_version_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CDM_SOURCE t
LEFT JOIN vocab.CONCEPT c ON t.CDM_VERSION_CONCEPT_ID = c.concept_id
WHERE t.CDM_VERSION_CONCEPT_ID IS NOT NULL
  AND t.CDM_VERSION_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for NULLs in required field 'CDM_SOURCE.SOURCE_RELEASE_DATE'.
AUDIT (
  name cdm_source_source_release_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CDM_SOURCE WHERE SOURCE_RELEASE_DATE IS NULL;

-- Description: Check that 'CDM_SOURCE.SOURCE_RELEASE_DATE' occurs before 'CDM_SOURCE.SOURCE_RELEASE_DATE'.
AUDIT (
  name cdm_source_source_release_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CDM_SOURCE WHERE SOURCE_RELEASE_DATE > SOURCE_RELEASE_DATE;

-- Description: Check for NULLs in required field 'CDM_SOURCE.VOCABULARY_VERSION'.
AUDIT (
  name cdm_source_vocabulary_version_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CDM_SOURCE WHERE VOCABULARY_VERSION IS NULL;

