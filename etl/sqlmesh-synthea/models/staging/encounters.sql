MODEL (
  name stg.encounters,
  kind FULL,
  description 'Encounter level facts from Synthea encounters.csv',
  columns (
    encounter_id TEXT,
    patient_id TEXT,
    provider_source_value TEXT,
    organization_id TEXT,
    payer_id TEXT,
    encounter_start_date DATE,
    encounter_start_datetime TIMESTAMP,
    encounter_start_ts TIMESTAMP,
    encounter_end_date DATE,
    encounter_end_datetime TIMESTAMP,
    encounter_end_ts TIMESTAMP,
    encounter_class TEXT,
    source_code TEXT,
    encounter_code TEXT,
    source_vocabulary_id TEXT,
    description TEXT,
    base_cost DOUBLE,
    total_cost DOUBLE,
    payer_coverage DOUBLE,
    reason_code TEXT,
    reason_description TEXT
  )
);

WITH source AS (
  SELECT
    *,
    TRY_CAST(START AS TIMESTAMP) AS start_ts,
    TRY_CAST(STOP AS TIMESTAMP) AS stop_ts
  FROM synthea.encounters
)
SELECT
  Id AS encounter_id,
  PATIENT AS patient_id,
  PROVIDER AS provider_source_value,
  ORGANIZATION AS organization_id,
  PAYER AS payer_id,
  CAST(start_ts AS DATE) AS encounter_start_date,
  start_ts AS encounter_start_datetime,
  start_ts AS encounter_start_ts,
  CAST(stop_ts AS DATE) AS encounter_end_date,
  stop_ts AS encounter_end_datetime,
  stop_ts AS encounter_end_ts,
  LOWER(TRIM(ENCOUNTERCLASS)) AS encounter_class,
  CODE AS source_code,
  CODE AS encounter_code,
  'SNOMED' AS source_vocabulary_id,
  DESCRIPTION AS description,
  TRY_CAST(BASE_ENCOUNTER_COST AS DOUBLE) AS base_cost,
  TRY_CAST(TOTAL_CLAIM_COST AS DOUBLE) AS total_cost,
  TRY_CAST(PAYER_COVERAGE AS DOUBLE) AS payer_coverage,
  REASONCODE AS reason_code,
  REASONDESCRIPTION AS reason_description
FROM source;
