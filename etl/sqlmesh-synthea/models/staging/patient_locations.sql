MODEL (
  name stg.patient_locations,
  kind FULL,
  description 'Derives a unique location_id per distinct patient address',
  columns (
    patient_id TEXT,
    location_id BIGINT,
    city TEXT,
    state TEXT,
    state_name TEXT,
    zip TEXT,
    street_address TEXT,
    latitude DOUBLE,
    longitude DOUBLE,
    county TEXT
  )
);

WITH base AS (
  SELECT DISTINCT
    p.patient_id,
    COALESCE(p.city, 'Unknown') AS city,
    COALESCE(p.state_name, 'Unknown') AS state_name,
    p.zip,
    p.street_address,
    p.latitude,
    p.longitude,
    p.county
  FROM stg.patients AS p
), dedup AS (
  SELECT DISTINCT
    city,
    state_name,
    zip,
    street_address,
    latitude,
    longitude,
    county
  FROM base
), numbered AS (
  SELECT
    ROW_NUMBER() OVER (ORDER BY state_name, city, COALESCE(zip, ''), COALESCE(street_address, '')) AS location_id,
    city,
    state_name,
    zip,
    street_address,
    latitude,
    longitude,
    county
  FROM dedup
)
SELECT
  b.patient_id,
  n.location_id,
  n.city,
  sm.state_abbreviation AS state,
  n.state_name,
  n.zip,
  n.street_address,
  n.latitude,
  n.longitude,
  n.county
FROM base AS b
JOIN numbered AS n
  ON b.city = n.city
 AND b.state_name = n.state_name
 AND (b.zip IS NOT DISTINCT FROM n.zip)
 AND (b.street_address IS NOT DISTINCT FROM n.street_address)
LEFT JOIN stg.states_map AS sm
  ON n.state_name = sm.state_name;
