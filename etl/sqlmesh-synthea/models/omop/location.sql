MODEL (
  name omop.location,
  kind FULL,
  description 'OMOP location records derived from Synthea patient addresses',
  columns (
    location_id BIGINT,
    address_1 TEXT,
    address_2 TEXT,
    city TEXT,
    state TEXT,
    zip TEXT,
    county TEXT,
    location_source_value TEXT,
    country_concept_id INT,
    country_source_value TEXT,
    latitude DOUBLE,
    longitude DOUBLE
  ),
  depends_on (
    vocab.concept,
  ),
  audits (
    location_country_concept_id_is_foreign_key,
    location_country_concept_id_fk_domain,
    location_country_concept_id_is_standard_valid_concept,
    location_country_concept_id_standard_concept_record_completeness,
    location_location_id_is_required,
    location_location_id_is_primary_key,
  )
);

SELECT DISTINCT
  location_id,
  street_address AS address_1,
  NULL AS address_2,
  city,
  state,
  zip,
  county,
  zip AS location_source_value,
  4330442 AS country_concept_id,  -- Concept ID for 'US'
  'US' AS country_source_value,
  TRY_CAST(latitude AS DOUBLE) AS latitude,
  TRY_CAST(longitude AS DOUBLE) AS longitude
FROM stg.patient_locations;
