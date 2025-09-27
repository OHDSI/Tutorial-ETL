MODEL (
  name omop.condition_era,
  kind FULL,
  columns (
    condition_era_id BIGINT,
    person_id BIGINT,
    condition_concept_id INT,
    condition_era_start_date DATE,
    condition_era_end_date DATE,
    condition_occurrence_count BIGINT
  ),
  depends_on (
    vocab.concept,
    omop.person,
  ),
  audits (
    person_completeness_condition_era,
    condition_era_condition_concept_id_is_required,
    condition_era_condition_concept_id_is_foreign_key,
    condition_era_condition_concept_id_fk_domain,
    condition_era_condition_concept_id_is_standard_valid_concept,
    condition_era_condition_concept_id_standard_concept_record_completeness,
    condition_era_condition_era_end_date_is_required,
    condition_era_condition_era_end_date_after_birth,
    condition_era_condition_era_id_is_required,
    condition_era_condition_era_id_is_primary_key,
    condition_era_condition_era_start_date_is_required,
    condition_era_condition_era_start_date_start_before_end,
    condition_era_condition_era_start_date_after_birth,
    condition_era_person_id_is_required,
    condition_era_person_id_is_foreign_key,
  )
);

WITH condition_events AS (
  SELECT
    person_id,
    condition_concept_id,
    condition_start_date AS event_start_date,
    CASE
      WHEN condition_end_date IS NOT NULL THEN condition_end_date
      ELSE condition_start_date + INTERVAL '1 day'
    END AS event_end_date
  FROM omop.condition_occurrence
  WHERE condition_concept_id <> 0
),
normalized AS (
  SELECT
    person_id,
    condition_concept_id,
    event_start_date,
    GREATEST(event_start_date, event_end_date) AS event_end_date
  FROM condition_events
),
ordered AS (
  SELECT
    *,
    CASE
      WHEN LAG(event_end_date) OVER (PARTITION BY person_id, condition_concept_id ORDER BY event_start_date, event_end_date) IS NULL THEN 1
      WHEN DATEDIFF('day', LAG(event_end_date) OVER (PARTITION BY person_id, condition_concept_id ORDER BY event_start_date, event_end_date), event_start_date) > 30 THEN 1
      ELSE 0
    END AS new_era_flag
  FROM normalized
),
era_assignment AS (
  SELECT
    *,
    SUM(new_era_flag) OVER (
      PARTITION BY person_id, condition_concept_id
      ORDER BY event_start_date, event_end_date
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS era_group
  FROM ordered
),
eras AS (
  SELECT
    person_id,
    condition_concept_id,
    era_group,
    MIN(event_start_date) AS condition_era_start_date,
    MAX(event_end_date) AS condition_era_end_date,
    COUNT(*) AS condition_occurrence_count
  FROM era_assignment
  GROUP BY person_id, condition_concept_id, era_group
)
SELECT
  ROW_NUMBER() OVER (ORDER BY person_id, condition_concept_id, condition_era_start_date) AS condition_era_id,
  person_id,
  condition_concept_id,
  condition_era_start_date,
  condition_era_end_date,
  condition_occurrence_count
FROM eras;
