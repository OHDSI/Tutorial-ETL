MODEL (
  name stg.conditions,
  kind FULL,
  description 'Condition records sourced from Synthea conditions.csv',
  columns (
    patient_id TEXT,
    encounter_id TEXT,
    condition_start_date DATE,
    condition_start_datetime TIMESTAMP,
    condition_start_ts TIMESTAMP,
    condition_end_date DATE,
    condition_end_datetime TIMESTAMP,
    condition_end_ts TIMESTAMP,
    source_system TEXT,
    source_code TEXT,
    condition_code TEXT,
    source_description TEXT,
    condition_description TEXT,
    coding_system TEXT
  )
);

WITH source AS (
  SELECT
    PATIENT,
    ENCOUNTER,
    START,
    STOP,
    SYSTEM,
    CODE,
    DESCRIPTION
  FROM synthea.conditions
)
SELECT
  PATIENT AS patient_id,
  ENCOUNTER AS encounter_id,
  TRY_CAST(START AS DATE) AS condition_start_date,
  TRY_CAST(START AS TIMESTAMP) AS condition_start_datetime,
  TRY_CAST(START AS TIMESTAMP) AS condition_start_ts,
  TRY_CAST(STOP AS DATE) AS condition_end_date,
  TRY_CAST(STOP AS TIMESTAMP) AS condition_end_datetime,
  TRY_CAST(STOP AS TIMESTAMP) AS condition_end_ts,
  UPPER(TRIM(SYSTEM)) AS source_system,
  CODE AS source_code,
  CODE AS condition_code,
  DESCRIPTION AS source_description,
  DESCRIPTION AS condition_description,
  CASE UPPER(TRIM(SYSTEM))
    WHEN 'SNOMED-CT' THEN 'SNOMED'
    WHEN 'ICD-10-CM' THEN 'ICD10CM'
    WHEN 'ICD10CM' THEN 'ICD10CM'
    ELSE UPPER(TRIM(SYSTEM))
  END AS coding_system
FROM source;
