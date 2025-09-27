-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.care_site,
--   audits (
--     care_site_care_site_id_is_required,
--     care_site_care_site_id_is_primary_key,
--     care_site_location_id_is_foreign_key,
--     care_site_place_of_service_concept_id_is_foreign_key,
--     care_site_place_of_service_concept_id_is_standard_valid_concept,
--     care_site_place_of_service_concept_id_standard_concept_record_completeness,
--   )
-- );

-- Description: Check for NULLs in required field 'CARE_SITE.CARE_SITE_ID'.
AUDIT (
  name care_site_care_site_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CARE_SITE WHERE CARE_SITE_ID IS NULL;

-- Description: Check for duplicate values in primary key field 'CARE_SITE.CARE_SITE_ID'.
        AUDIT (
          name care_site_care_site_id_is_primary_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT CARE_SITE_ID, COUNT(*)
FROM omop.CARE_SITE
WHERE CARE_SITE_ID IS NOT NULL
GROUP BY CARE_SITE_ID
HAVING COUNT(*) > 1;;

-- Description: Check for orphaned foreign keys in 'CARE_SITE.LOCATION_ID' pointing to 'LOCATION.LOCATION_ID'.
        AUDIT (
          name care_site_location_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.CARE_SITE c
LEFT JOIN omop.LOCATION p ON c.LOCATION_ID = p.LOCATION_ID
WHERE c.LOCATION_ID IS NOT NULL AND p.LOCATION_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'CARE_SITE.PLACE_OF_SERVICE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name care_site_place_of_service_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.CARE_SITE c
LEFT JOIN vocab.CONCEPT p ON c.PLACE_OF_SERVICE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.PLACE_OF_SERVICE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'CARE_SITE.PLACE_OF_SERVICE_CONCEPT_ID' are standard and valid.
        AUDIT (
          name care_site_place_of_service_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CARE_SITE t
LEFT JOIN vocab.CONCEPT c ON t.PLACE_OF_SERVICE_CONCEPT_ID = c.concept_id
WHERE t.PLACE_OF_SERVICE_CONCEPT_ID IS NOT NULL
  AND t.PLACE_OF_SERVICE_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'CARE_SITE.PLACE_OF_SERVICE_CONCEPT_ID'.
AUDIT (
  name care_site_place_of_service_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CARE_SITE WHERE PLACE_OF_SERVICE_CONCEPT_ID = 0;

