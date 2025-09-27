MODEL (
  name omop.observation_period,
  kind FULL,
  columns (
    observation_period_id BIGINT,
    person_id BIGINT,
    observation_period_start_date DATE,
    observation_period_end_date DATE,
    period_type_concept_id INT
  ),
  audits (
    observation_period_exists,
    person_completeness_observation_period,
    observation_period_observation_period_end_date_is_required,
    observation_period_observation_period_end_date_after_birth,
    observation_period_observation_period_id_is_required,
    observation_period_observation_period_id_is_primary_key,
    observation_period_observation_period_start_date_is_required,
    observation_period_observation_period_start_date_start_before_end,
    observation_period_observation_period_start_date_after_birth,
    observation_period_period_type_concept_id_is_required,
    observation_period_period_type_concept_id_is_foreign_key,
    observation_period_period_type_concept_id_fk_domain,
    observation_period_period_type_concept_id_is_standard_valid_concept,
    observation_period_period_type_concept_id_standard_concept_record_completeness,
    observation_period_person_id_is_required,
    observation_period_person_id_is_foreign_key,
  )
);

WITH base AS (
  SELECT
    ids.person_id,
    MIN(enc.encounter_start_date) AS period_start,
    MAX(COALESCE(enc.encounter_end_date, enc.encounter_start_date)) AS period_end
  FROM stg.patient_ids AS ids
  JOIN stg.encounters AS enc
    ON ids.patient_id = enc.patient_id
  GROUP BY ids.person_id
)
SELECT
  ROW_NUMBER() OVER (ORDER BY person_id) AS observation_period_id,
  person_id,
  period_start AS observation_period_start_date,
  period_end AS observation_period_end_date,
  32882 AS period_type_concept_id
FROM base;
