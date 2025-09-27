MODEL (
  name stg.observations,
  kind FULL,
  description 'Clinical observations from Synthea observations.csv',
  columns (
    patient_id TEXT,
    encounter_id TEXT,
    observation_date DATE,
    observation_datetime TIMESTAMP,
    observation_ts TIMESTAMP,
    observation_start_ts TIMESTAMP,
    category TEXT,
    source_code TEXT,
    observation_code TEXT,
    source_description TEXT,
    unit_source_value TEXT,
    observation_units TEXT,
    value_type TEXT,
    numeric_value DOUBLE,
    value_source_value TEXT,
    source_vocabulary_id TEXT
  )
);

WITH source AS (
  SELECT
    DATE,
    PATIENT,
    ENCOUNTER,
    CATEGORY,
    CODE,
    DESCRIPTION,
    VALUE,
    UNITS,
    TYPE
  FROM synthea.observations
), typed AS (
  SELECT
    PATIENT AS patient_id,
    ENCOUNTER AS encounter_id,
    TRY_CAST(DATE AS TIMESTAMP) AS observation_ts,
    LOWER(TRIM(CATEGORY)) AS category,
    CODE AS source_code,
    DESCRIPTION AS source_description,
    TRIM(UNITS) AS unit_source_value,
    TRIM(TYPE) AS value_type,
    TRY_CAST(VALUE AS DOUBLE) AS numeric_value,
    VALUE AS value_source_value,
    VALUE AS observation_value,
    'LOINC' AS source_vocabulary_id
  FROM source
)
SELECT
  patient_id,
  encounter_id,
  CAST(observation_ts AS DATE) AS observation_date,
  observation_ts AS observation_datetime,
  observation_ts,
  observation_ts AS observation_start_ts,
  category,
  source_code,
  source_code AS observation_code,
  source_description,
  unit_source_value,
  unit_source_value AS observation_units,
  value_type,
  numeric_value,
  value_source_value,
  source_vocabulary_id
FROM typed;
