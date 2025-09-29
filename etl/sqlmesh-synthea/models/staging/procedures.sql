MODEL (
  name stg.procedures,
  kind FULL,
  description 'Procedure records from Synthea procedures.csv',
  columns (
    patient_id TEXT,
    encounter_id TEXT,
    procedure_date DATE,
    procedure_datetime TIMESTAMP,
    procedure_end_date DATE,
    procedure_end_datetime TIMESTAMP,
    source_code TEXT,
    procedure_code TEXT,
    procedure_description TEXT,
    source_description TEXT,
    source_vocabulary_id TEXT
  )
);

WITH source AS (
  SELECT
    START,
    STOP,
    PATIENT,
    ENCOUNTER,
    SYSTEM,
    CODE,
    DESCRIPTION
  FROM synthea.procedures
)
SELECT
  PATIENT AS patient_id,
  ENCOUNTER AS encounter_id,
  TRY_CAST(START AS DATE) AS procedure_date,
  TRY_CAST(START AS TIMESTAMP) AS procedure_datetime,
  TRY_CAST(STOP AS DATE) AS procedure_end_date,
  TRY_CAST(STOP AS TIMESTAMP) AS procedure_end_datetime,
  CODE AS source_code,
  CODE AS procedure_code,
  DESCRIPTION AS source_description,
  DESCRIPTION AS procedure_description,
  'SNOMED' AS source_vocabulary_id
FROM source;
