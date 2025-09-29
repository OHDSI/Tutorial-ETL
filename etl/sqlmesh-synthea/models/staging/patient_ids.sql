MODEL (
  name stg.patient_ids,
  kind FULL,
  description 'Assigns deterministic OMOP person_ids to Synthea patient identifiers',
  columns (
    patient_id TEXT,
    person_id BIGINT
  )
);

SELECT
  patient_id,
  ROW_NUMBER() OVER (ORDER BY patient_id) AS person_id
FROM (
  SELECT DISTINCT patient_id FROM stg.patients
);
