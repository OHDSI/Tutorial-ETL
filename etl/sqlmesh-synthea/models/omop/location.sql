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
    latitude DOUBLE,
    longitude DOUBLE
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
  TRY_CAST(latitude AS DOUBLE) AS latitude,
  TRY_CAST(longitude AS DOUBLE) AS longitude
FROM stg.patient_locations;
