MODEL (
  name stg.immunizations,
  kind FULL,
  description 'Immunization administrations from Synthea immunizations.csv',
  columns (
    patient_id TEXT,
    encounter_id TEXT,
    immunization_date DATE,
    immunization_datetime TIMESTAMP,
    source_code TEXT,
    immunization_code TEXT,
    source_description TEXT,
    immunization_description TEXT,
    base_cost DOUBLE,
    source_vocabulary_id TEXT
  )
);

WITH source AS (
  SELECT
    DATE,
    PATIENT,
    ENCOUNTER,
    CODE,
    DESCRIPTION,
    BASE_COST
  FROM synthea.immunizations
)
SELECT
  PATIENT AS patient_id,
  ENCOUNTER AS encounter_id,
  TRY_CAST(DATE AS DATE) AS immunization_date,
  TRY_CAST(DATE AS TIMESTAMP) AS immunization_datetime,
  CODE AS source_code,
  CODE AS immunization_code,
  DESCRIPTION AS source_description,
  DESCRIPTION AS immunization_description,
  TRY_CAST(BASE_COST AS DOUBLE) AS base_cost,
  'CVX' AS source_vocabulary_id
FROM source;
