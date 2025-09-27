MODEL (
  name omop.visit_detail,
  kind FULL,
  columns (
    visit_detail_id BIGINT,
    person_id BIGINT,
    visit_detail_concept_id INT,
    visit_detail_start_date DATE,
    visit_detail_start_datetime TIMESTAMP,
    visit_detail_end_date DATE,
    visit_detail_end_datetime TIMESTAMP,
    visit_detail_type_concept_id INT,
    provider_id BIGINT,
    care_site_id INT,
    admitted_from_concept_id INT,
    discharged_to_concept_id INT,
    preceding_visit_detail_id BIGINT,
    visit_detail_source_value TEXT,
    visit_detail_source_concept_id INT,
    admitted_from_source_value TEXT,
    discharged_to_source_value TEXT,
    parent_visit_detail_id INT,
    visit_occurrence_id BIGINT
  )
);

WITH details AS (
  SELECT
    visit_occurrence_id,
    person_id,
    encounter_class,
    encounter_start_date,
    encounter_start_datetime,
    encounter_end_date,
    encounter_end_datetime,
    representative_encounter_id,
    provider_id
  FROM stg.visit_dimension
),
ordered AS (
  SELECT
    visit_occurrence_id,
    person_id,
    encounter_class,
    encounter_start_date,
    encounter_start_datetime,
    encounter_end_date,
    encounter_end_datetime,
    representative_encounter_id,
    provider_id,
    visit_occurrence_id + 1000000 AS visit_detail_id,
    LAG(visit_occurrence_id + 1000000) OVER (
      PARTITION BY person_id
      ORDER BY encounter_start_datetime, visit_occurrence_id
    ) AS preceding_visit_detail_id
  FROM details
)
SELECT
  visit_detail_id,
  person_id,
  CASE
    WHEN encounter_class IN ('ambulatory', 'wellness', 'outpatient') THEN 9202
    WHEN encounter_class IN ('emergency', 'urgent', 'urgentcare') THEN 9203
    WHEN encounter_class = 'inpatient' THEN 9201
    ELSE 0
  END AS visit_detail_concept_id,
  encounter_start_date AS visit_detail_start_date,
  TRY_CAST(encounter_start_datetime AS TIMESTAMP) AS visit_detail_start_datetime,
  encounter_end_date AS visit_detail_end_date,
  TRY_CAST(encounter_end_datetime AS TIMESTAMP) AS visit_detail_end_datetime,
  32827 AS visit_detail_type_concept_id,
  provider_id,
  CAST(NULL AS INTEGER) AS care_site_id,
  CAST(NULL AS INTEGER) AS admitted_from_concept_id,
  CAST(NULL AS INTEGER) AS discharged_to_concept_id,
  preceding_visit_detail_id,
  CAST(representative_encounter_id AS TEXT) AS visit_detail_source_value,
  0 AS visit_detail_source_concept_id,
  CAST(NULL AS TEXT) AS admitted_from_source_value,
  CAST(NULL AS TEXT) AS discharged_to_source_value,
  CAST(NULL AS INTEGER) AS parent_visit_detail_id,
  visit_occurrence_id
FROM ordered;
