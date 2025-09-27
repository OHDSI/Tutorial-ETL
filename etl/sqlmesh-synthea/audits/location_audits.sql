-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.location,
--   audits (
--     location_country_concept_id_is_foreign_key,
--     location_country_concept_id_fk_domain,
--     location_country_concept_id_is_standard_valid_concept,
--     location_country_concept_id_standard_concept_record_completeness,
--     location_location_id_is_required,
--     location_location_id_is_primary_key,
--   )
-- );

-- Description: Check for orphaned foreign keys in 'LOCATION.COUNTRY_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name location_country_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.LOCATION c
LEFT JOIN vocab.CONCEPT p ON c.COUNTRY_CONCEPT_ID = p.CONCEPT_ID
WHERE c.COUNTRY_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'LOCATION.COUNTRY_CONCEPT_ID' belong to the 'Geography' domain.
        AUDIT (
          name location_country_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.LOCATION t
JOIN vocab.CONCEPT c ON t.COUNTRY_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Geography';;

-- Description: Check that concepts in 'LOCATION.COUNTRY_CONCEPT_ID' are standard and valid.
        AUDIT (
          name location_country_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.LOCATION t
LEFT JOIN vocab.CONCEPT c ON t.COUNTRY_CONCEPT_ID = c.concept_id
WHERE t.COUNTRY_CONCEPT_ID IS NOT NULL
  AND t.COUNTRY_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'LOCATION.COUNTRY_CONCEPT_ID'.
AUDIT (
  name location_country_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.LOCATION WHERE COUNTRY_CONCEPT_ID = 0;

-- Description: Check for NULLs in required field 'LOCATION.LOCATION_ID'.
AUDIT (
  name location_location_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.LOCATION WHERE LOCATION_ID IS NULL;

-- Description: Check for duplicate values in primary key field 'LOCATION.LOCATION_ID'.
        AUDIT (
          name location_location_id_is_primary_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT LOCATION_ID, COUNT(*)
FROM omop.LOCATION
WHERE LOCATION_ID IS NOT NULL
GROUP BY LOCATION_ID
HAVING COUNT(*) > 1;;

