MODEL (
  name stg.organizations,
  kind FULL,
  description 'Healthcare organizations from Synthea organizations.csv',
  columns (
    organization_id TEXT,
    name TEXT,
    city TEXT,
    state_name TEXT,
    zip TEXT,
    address TEXT,
    latitude DOUBLE,
    longitude DOUBLE,
    phone TEXT,
    revenue DOUBLE,
    utilization DOUBLE
  )
);

SELECT
  Id AS organization_id,
  NAME AS name,
  TRIM(CITY) AS city,
  UPPER(TRIM(STATE)) AS state_name,
  ZIP AS zip,
  ADDRESS AS address,
  TRY_CAST(LAT AS DOUBLE) AS latitude,
  TRY_CAST(LON AS DOUBLE) AS longitude,
  PHONE AS phone,
  TRY_CAST(REVENUE AS DOUBLE) AS revenue,
  TRY_CAST(UTILIZATION AS DOUBLE) AS utilization
FROM synthea.organizations;
