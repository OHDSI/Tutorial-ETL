MODEL (
  name omop.payer_plan_period,
  kind FULL,
  columns (
    payer_plan_period_id BIGINT,
    person_id BIGINT,
    payer_plan_period_start_date DATE,
    payer_plan_period_end_date DATE,
    payer_concept_id INT,
    payer_source_value TEXT,
    payer_source_concept_id INT,
    plan_concept_id INT,
    plan_source_value TEXT,
    plan_source_concept_id INT,
    sponsor_concept_id INT,
    sponsor_source_value TEXT,
    sponsor_source_concept_id INT,
    family_source_value TEXT,
    stop_reason_concept_id INT,
    stop_reason_source_value TEXT,
    stop_reason_source_concept_id INT
  ),
  depends_on (
    vocab.concept,
    omop.person,
  ),
  audits (
    person_completeness_payer_plan_period,
    payer_plan_period_payer_concept_id_is_foreign_key,
    payer_plan_period_payer_plan_period_end_date_is_required,
    payer_plan_period_payer_plan_period_end_date_after_birth,
    payer_plan_period_payer_plan_period_id_is_required,
    payer_plan_period_payer_plan_period_id_is_primary_key,
    payer_plan_period_payer_plan_period_start_date_is_required,
    payer_plan_period_payer_plan_period_start_date_start_before_end,
    payer_plan_period_payer_plan_period_start_date_after_birth,
    payer_plan_period_payer_source_concept_id_is_foreign_key,
    payer_plan_period_person_id_is_required,
    payer_plan_period_person_id_is_foreign_key,
    payer_plan_period_plan_concept_id_is_foreign_key,
    payer_plan_period_plan_source_concept_id_is_foreign_key,
    payer_plan_period_sponsor_concept_id_is_foreign_key,
    payer_plan_period_sponsor_source_concept_id_is_foreign_key,
    payer_plan_period_stop_reason_concept_id_is_foreign_key,
    payer_plan_period_stop_reason_source_concept_id_is_foreign_key
  )
);

WITH transitions AS (
  SELECT
    pt.patient_id,
    ids.person_id,
    pt.start_date,
    pt.end_date,
    pt.payer_id,
    pay.name AS plan_name
  FROM stg.payer_transitions AS pt
  JOIN stg.patient_ids AS ids
    ON pt.patient_id = ids.patient_id
  LEFT JOIN stg.payers AS pay
    ON pt.payer_id = pay.payer_id
)
SELECT
  ROW_NUMBER() OVER (ORDER BY person_id, start_date) AS payer_plan_period_id,
  person_id,
  start_date AS payer_plan_period_start_date,
  COALESCE(end_date, start_date) AS payer_plan_period_end_date,
  0 AS payer_concept_id,
  payer_id AS payer_source_value,
  0 AS payer_source_concept_id,
  0 AS plan_concept_id,
  plan_name AS plan_source_value,
  0 AS plan_source_concept_id,
  0 AS sponsor_concept_id,
  CAST(NULL AS TEXT) AS sponsor_source_value,
  0 AS sponsor_source_concept_id,
  CAST(NULL AS TEXT) AS family_source_value,
  0 AS stop_reason_concept_id,
  CAST(NULL AS TEXT) AS stop_reason_source_value,
  0 AS stop_reason_source_concept_id
FROM transitions;
