MODEL (
  name stg.devices,
  kind FULL,
  description 'Device exposure records from Synthea devices.csv',
  columns (
    patient_id TEXT,
    encounter_id TEXT,
    device_start_date DATE,
    device_start_datetime TIMESTAMP,
    device_end_date DATE,
    device_end_datetime TIMESTAMP,
    device_code TEXT,
    device_description TEXT,
    unique_device_id TEXT,
    source_vocabulary_id TEXT
  )
);

SELECT
  PATIENT AS patient_id,
  ENCOUNTER AS encounter_id,
  TRY_CAST(START AS DATE) AS device_start_date,
  TRY_CAST(START AS TIMESTAMP) AS device_start_datetime,
  TRY_CAST(STOP AS DATE) AS device_end_date,
  TRY_CAST(STOP AS TIMESTAMP) AS device_end_datetime,
  CODE AS device_code,
  DESCRIPTION AS device_description,
  UDI AS unique_device_id,
  'SNOMED' AS source_vocabulary_id
FROM synthea.devices;
