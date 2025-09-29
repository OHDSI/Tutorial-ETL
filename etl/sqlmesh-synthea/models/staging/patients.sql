MODEL (
  name stg.patients,
  kind FULL,
  description 'Normalized patient attributes sourced from Synthea patients.csv',
  columns (
    patient_id TEXT,
    birth_date DATE,
    death_date DATE,
    gender TEXT,
    gender_source_value TEXT,
    race TEXT,
    race_source_value TEXT,
    ethnicity TEXT,
    ethnicity_source_value TEXT,
    city TEXT,
    state_name TEXT,
    zip TEXT,
    street_address TEXT,
    county TEXT,
    latitude DOUBLE,
    longitude DOUBLE,
    patient_source_value TEXT,
    healthcare_expenses DOUBLE,
    healthcare_coverage DOUBLE,
    income DOUBLE
  )
);

WITH source AS (
  SELECT * FROM synthea.patients
)
SELECT
  Id AS patient_id,
  TRY_CAST(BIRTHDATE AS DATE) AS birth_date,
  TRY_CAST(DEATHDATE AS DATE) AS death_date,
  UPPER(TRIM(GENDER)) AS gender,
  UPPER(TRIM(GENDER)) AS gender_source_value,
  UPPER(TRIM(RACE)) AS race,
  UPPER(TRIM(RACE)) AS race_source_value,
  UPPER(TRIM(ETHNICITY)) AS ethnicity,
  UPPER(TRIM(ETHNICITY)) AS ethnicity_source_value,
  TRIM(CITY) AS city,
  UPPER(TRIM(STATE)) AS state_name,
  TRIM(ZIP) AS zip,
  TRIM(ADDRESS) AS street_address,
  TRIM(COUNTY) AS county,
  TRY_CAST(LAT AS DOUBLE) AS latitude,
  TRY_CAST(LON AS DOUBLE) AS longitude,
  Id AS patient_source_value,
  TRY_CAST(HEALTHCARE_EXPENSES AS DOUBLE) AS healthcare_expenses,
  TRY_CAST(HEALTHCARE_COVERAGE AS DOUBLE) AS healthcare_coverage,
  TRY_CAST(INCOME AS DOUBLE) AS income
FROM source;
