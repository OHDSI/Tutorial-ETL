-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.provider,
--   depends_on (
--     omop.care_site,
--     vocab.concept,
--   ),
--   audits (
--     provider_care_site_id_is_foreign_key,
--     provider_gender_concept_id_is_foreign_key,
--     provider_gender_concept_id_fk_domain,
--     provider_gender_concept_id_is_standard_valid_concept,
--     provider_gender_concept_id_standard_concept_record_completeness,
--     provider_gender_source_concept_id_is_foreign_key,
--     provider_provider_id_is_required,
--     provider_provider_id_is_primary_key,
--     provider_specialty_concept_id_is_foreign_key,
--     provider_specialty_concept_id_is_standard_valid_concept,
--     provider_specialty_concept_id_standard_concept_record_completeness,
--     provider_specialty_source_concept_id_is_foreign_key,
--   )
-- );

-- Description: Check for orphaned foreign keys in 'PROVIDER.CARE_SITE_ID' pointing to 'CARE_SITE.CARE_SITE_ID'.
        AUDIT (
          name provider_care_site_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PROVIDER c
LEFT JOIN omop.CARE_SITE p ON c.CARE_SITE_ID = p.CARE_SITE_ID
WHERE c.CARE_SITE_ID IS NOT NULL AND p.CARE_SITE_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'PROVIDER.GENDER_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name provider_gender_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PROVIDER c
LEFT JOIN vocab.concept p ON c.GENDER_CONCEPT_ID = p.CONCEPT_ID
WHERE c.GENDER_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'PROVIDER.GENDER_CONCEPT_ID' belong to the 'Gender' domain.
        AUDIT (
          name provider_gender_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROVIDER t
JOIN vocab.concept c ON t.GENDER_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Gender';;

-- Description: Check that concepts in 'PROVIDER.GENDER_CONCEPT_ID' are standard and valid.
        AUDIT (
          name provider_gender_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROVIDER t
LEFT JOIN vocab.concept c ON t.GENDER_CONCEPT_ID = c.concept_id
WHERE t.GENDER_CONCEPT_ID IS NOT NULL
  AND t.GENDER_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'PROVIDER.GENDER_CONCEPT_ID'.
AUDIT (
  name provider_gender_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.PROVIDER WHERE GENDER_CONCEPT_ID = 0;

-- Description: Check for orphaned foreign keys in 'PROVIDER.GENDER_SOURCE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name provider_gender_source_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PROVIDER c
LEFT JOIN vocab.concept p ON c.GENDER_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.GENDER_SOURCE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'PROVIDER.PROVIDER_ID'.
AUDIT (
  name provider_provider_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.PROVIDER WHERE PROVIDER_ID IS NULL;

-- Description: Check for duplicate values in primary key field 'PROVIDER.PROVIDER_ID'.
        AUDIT (
          name provider_provider_id_is_primary_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT PROVIDER_ID, COUNT(*)
FROM omop.PROVIDER
WHERE PROVIDER_ID IS NOT NULL
GROUP BY PROVIDER_ID
HAVING COUNT(*) > 1;;

-- Description: Check for orphaned foreign keys in 'PROVIDER.SPECIALTY_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name provider_specialty_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PROVIDER c
LEFT JOIN vocab.concept p ON c.SPECIALTY_CONCEPT_ID = p.CONCEPT_ID
WHERE c.SPECIALTY_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'PROVIDER.SPECIALTY_CONCEPT_ID' are standard and valid.
        AUDIT (
          name provider_specialty_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROVIDER t
LEFT JOIN vocab.concept c ON t.SPECIALTY_CONCEPT_ID = c.concept_id
WHERE t.SPECIALTY_CONCEPT_ID IS NOT NULL
  AND t.SPECIALTY_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'PROVIDER.SPECIALTY_CONCEPT_ID'.
AUDIT (
  name provider_specialty_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.PROVIDER WHERE SPECIALTY_CONCEPT_ID = 0;

-- Description: Check for orphaned foreign keys in 'PROVIDER.SPECIALTY_SOURCE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name provider_specialty_source_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PROVIDER c
LEFT JOIN vocab.concept p ON c.SPECIALTY_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.SPECIALTY_SOURCE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

