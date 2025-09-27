MODEL (
  name stg.payer_transitions,
  kind FULL,
  description 'Payer enrollment spans per patient',
  columns (
    patient_id TEXT,
    member_id TEXT,
    start_date DATE,
    end_date DATE,
    payer_id TEXT,
    secondary_payer_id TEXT,
    plan_ownership TEXT,
    owner_name TEXT
  )
);

SELECT
  PATIENT AS patient_id,
  MEMBERID AS member_id,
  TRY_CAST(START_DATE AS DATE) AS start_date,
  TRY_CAST(END_DATE AS DATE) AS end_date,
  PAYER AS payer_id,
  SECONDARY_PAYER AS secondary_payer_id,
  PLAN_OWNERSHIP AS plan_ownership,
  OWNER_NAME AS owner_name
FROM synthea.payer_transitions;
