MODEL (
  name stg.medications,
  kind FULL,
  description 'Medication exposures from Synthea medications.csv',
  columns (
    patient_id TEXT,
    encounter_id TEXT,
    drug_exposure_start_date DATE,
    drug_exposure_start_datetime TIMESTAMP,
    medication_start_ts TIMESTAMP,
    drug_exposure_end_date DATE,
    drug_exposure_end_datetime TIMESTAMP,
    medication_end_ts TIMESTAMP,
    source_code TEXT,
    medication_code TEXT,
    source_description TEXT,
    medication_description TEXT,
    quantity DOUBLE,
    base_cost DOUBLE,
    total_cost DOUBLE,
    source_vocabulary_id TEXT
  )
);

WITH source AS (
  SELECT
    START,
    STOP,
    PATIENT,
    PAYER,
    ENCOUNTER,
    CODE,
    DESCRIPTION,
    BASE_COST,
    PAYER_COVERAGE,
    DISPENSES,
    TOTALCOST
  FROM synthea.medications
)
SELECT
  PATIENT AS patient_id,
  ENCOUNTER AS encounter_id,
  TRY_CAST(START AS DATE) AS drug_exposure_start_date,
  TRY_CAST(START AS TIMESTAMP) AS drug_exposure_start_datetime,
  TRY_CAST(START AS TIMESTAMP) AS medication_start_ts,
  TRY_CAST(STOP AS DATE) AS drug_exposure_end_date,
  TRY_CAST(STOP AS TIMESTAMP) AS drug_exposure_end_datetime,
  TRY_CAST(STOP AS TIMESTAMP) AS medication_end_ts,
  CODE AS source_code,
  CODE AS medication_code,
  DESCRIPTION AS source_description,
  DESCRIPTION AS medication_description,
  TRY_CAST(DISPENSES AS DOUBLE) AS quantity,
  TRY_CAST(BASE_COST AS DOUBLE) AS base_cost,
  TRY_CAST(TOTALCOST AS DOUBLE) AS total_cost,
  'RXNORM' AS source_vocabulary_id
FROM source;
