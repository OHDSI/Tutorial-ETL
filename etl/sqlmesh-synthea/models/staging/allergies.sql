MODEL (
  name stg.allergies,
  kind FULL,
  description 'Allergy records from Synthea allergies.csv',
  columns (
    patient_id TEXT,
    encounter_id TEXT,
    allergy_start_date DATE,
    allergy_start_datetime TIMESTAMP,
    allergy_end_date DATE,
    allergy_end_datetime TIMESTAMP,
    allergy_code TEXT,
    allergy_description TEXT,
    coding_system TEXT
  )
);

SELECT
  PATIENT AS patient_id,
  ENCOUNTER AS encounter_id,
  TRY_CAST(START AS DATE) AS allergy_start_date,
  TRY_CAST(START AS TIMESTAMP) AS allergy_start_datetime,
  TRY_CAST(STOP AS DATE) AS allergy_end_date,
  TRY_CAST(STOP AS TIMESTAMP) AS allergy_end_datetime,
  CODE AS allergy_code,
  DESCRIPTION AS allergy_description,
  UPPER(TRIM(SYSTEM)) AS source_system,
  CASE UPPER(TRIM(SYSTEM))
    WHEN 'SNOMED-CT' THEN 'SNOMED'
    ELSE UPPER(TRIM(SYSTEM))
  END AS coding_system
FROM synthea.allergies;
