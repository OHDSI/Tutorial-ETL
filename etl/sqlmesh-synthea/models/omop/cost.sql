MODEL (
  name omop.cost,
  kind FULL,
  columns (
    cost_id BIGINT,
    cost_event_id BIGINT,
    cost_domain_id TEXT,
    cost_type_concept_id INT,
    currency_concept_id INT,
    total_charge DOUBLE,
    total_cost DOUBLE,
    total_paid DOUBLE,
    paid_copay DOUBLE,
    paid_coinsurance DOUBLE,
    paid_deductible DOUBLE,
    paid_by_payer DOUBLE,
    paid_by_patient DOUBLE,
    paid_patient_copay DOUBLE,
    paid_patient_coinsurance DOUBLE,
    paid_patient_deductible DOUBLE,
    paid_by_primary DOUBLE,
    paid_by_secondary DOUBLE,
    paid_by_tertiary DOUBLE,
    payer_plan_period_id DOUBLE,
    amount_allowed DOUBLE,
    revenue_code_concept_id DOUBLE,
    revenue_code_source_value TEXT,
    drg_concept_id DOUBLE,
    drg_source_value TEXT
  )
);

WITH visit_costs AS (
  SELECT
    v.visit_occurrence_id,
    TRY_CAST(e.base_cost AS DOUBLE) AS base_cost,
    TRY_CAST(e.total_cost AS DOUBLE) AS total_cost,
    TRY_CAST(e.payer_coverage AS DOUBLE) AS payer_coverage,
    e.patient_id
  FROM stg.encounters AS e
  JOIN stg.final_visit_ids AS v
    ON e.encounter_id = v.encounter_id
)
SELECT
  ROW_NUMBER() OVER (ORDER BY visit_occurrence_id) AS cost_id,
  visit_occurrence_id AS cost_event_id,
  'Visit Occurrence' AS cost_domain_id,
  50387063 AS cost_type_concept_id,
  0 AS currency_concept_id,
  base_cost AS total_charge,
  total_cost AS total_cost,
  payer_coverage AS total_paid,
  CAST(NULL AS DOUBLE) AS paid_copay,
  CASE
    WHEN total_cost IS NOT NULL AND payer_coverage IS NOT NULL THEN total_cost - payer_coverage
    ELSE NULL
  END AS paid_coinsurance,
  CAST(NULL AS DOUBLE) AS paid_deductible,
  CAST(NULL AS DOUBLE) AS paid_by_payer,
  CAST(NULL AS DOUBLE) AS paid_by_patient,
  CAST(NULL AS DOUBLE) AS paid_patient_copay,
  CAST(NULL AS DOUBLE) AS paid_patient_coinsurance,
  CAST(NULL AS DOUBLE) AS paid_patient_deductible,
  CAST(NULL AS DOUBLE) AS paid_by_primary,
  CAST(NULL AS DOUBLE) AS paid_by_secondary,
  CAST(NULL AS DOUBLE) AS paid_by_tertiary,
  CAST(NULL AS DOUBLE) AS payer_plan_period_id,
  CAST(NULL AS DOUBLE) AS amount_allowed,
  CAST(NULL AS DOUBLE) AS revenue_code_concept_id,
  CAST(NULL AS TEXT) AS revenue_code_source_value,
  CAST(NULL AS DOUBLE) AS drg_concept_id,
  CAST(NULL AS TEXT) AS drg_source_value
FROM visit_costs;
