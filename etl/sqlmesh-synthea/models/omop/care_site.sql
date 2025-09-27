MODEL (
  name omop.care_site,
  kind FULL,
  columns (
    care_site_id BIGINT,
    care_site_name TEXT,
    place_of_service_concept_id INT,
    location_id INT,
    care_site_source_value TEXT,
    place_of_service_source_value TEXT
  ),
  audits (
    care_site_care_site_id_is_required,
    care_site_care_site_id_is_primary_key,
    care_site_location_id_is_foreign_key,
    care_site_place_of_service_concept_id_is_foreign_key,
    care_site_place_of_service_concept_id_is_standard_valid_concept,
    care_site_place_of_service_concept_id_standard_concept_record_completeness,
  )
);

SELECT
  care_site_id,
  name AS care_site_name,
  0 AS place_of_service_concept_id,
  CAST(NULL AS INTEGER) AS location_id,
  organization_id AS care_site_source_value,
  CAST(NULL AS TEXT) AS place_of_service_source_value
FROM stg.care_sites;
