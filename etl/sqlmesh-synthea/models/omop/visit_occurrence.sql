MODEL (
  name omop.visit_occurrence,
  kind FULL,
  columns (
    visit_occurrence_id BIGINT,
    person_id BIGINT,
    visit_concept_id INT,
    visit_start_date DATE,
    visit_start_datetime TIMESTAMP,
    visit_end_date DATE,
    visit_end_datetime TIMESTAMP,
    visit_type_concept_id INT,
    provider_id BIGINT,
    care_site_id INT,
    visit_source_value TEXT,
    visit_source_concept_id INT,
    admitted_from_concept_id INT,
    admitted_from_source_value TEXT,
    discharged_to_concept_id INT,
    discharged_to_source_value TEXT,
    preceding_visit_occurrence_id BIGINT
  ),
  depends_on (
    omop.care_site,
    vocab.concept,
    omop.person,
    omop.provider,
  ),
  audits (
    person_completeness_visit_occurrence,
    visit_occurrence_admitted_from_concept_id_is_foreign_key,
    visit_occurrence_admitted_from_concept_id_fk_domain,
    visit_occurrence_admitted_from_concept_id_is_standard_valid_concept,
    visit_occurrence_admitted_from_concept_id_standard_concept_record_completeness,
    visit_occurrence_care_site_id_is_foreign_key,
    visit_occurrence_discharged_to_concept_id_is_foreign_key,
    visit_occurrence_discharged_to_concept_id_fk_domain,
    visit_occurrence_discharged_to_concept_id_is_standard_valid_concept,
    visit_occurrence_discharged_to_concept_id_standard_concept_record_completeness,
    visit_occurrence_person_id_is_required,
    visit_occurrence_person_id_is_foreign_key,
    visit_occurrence_preceding_visit_occurrence_id_is_foreign_key,
    visit_occurrence_provider_id_is_foreign_key,
    visit_occurrence_visit_concept_id_is_required,
    visit_occurrence_visit_concept_id_is_foreign_key,
    visit_occurrence_visit_concept_id_fk_domain,
    visit_occurrence_visit_concept_id_is_standard_valid_concept,
    visit_occurrence_visit_concept_id_standard_concept_record_completeness,
    visit_occurrence_visit_end_date_is_required,
  )
);

WITH visits AS (
  SELECT
    visit_occurrence_id,
    person_id,
    LOWER(encounter_class) AS encounter_class,
    encounter_start_date,
    encounter_start_datetime,
    encounter_end_date,
    encounter_end_datetime,
    representative_encounter_id,
    source_code,
    provider_id,
    COALESCE(visit_concept_id, 0) AS mapped_visit_concept_id
  FROM stg.visit_dimension
)
SELECT
  visit_occurrence_id,
  person_id,
  CASE
    WHEN mapped_visit_concept_id <> 0 THEN mapped_visit_concept_id
    WHEN encounter_class IN ('ambulatory', 'wellness', 'outpatient') THEN 9202
    WHEN encounter_class IN ('emergency', 'urgent', 'urgentcare') THEN 9203
    WHEN encounter_class = 'inpatient' THEN 9201
    ELSE 0
  END AS visit_concept_id,
  encounter_start_date AS visit_start_date,
  TRY_CAST(encounter_start_datetime AS TIMESTAMP) AS visit_start_datetime,
  encounter_end_date AS visit_end_date,
  TRY_CAST(encounter_end_datetime AS TIMESTAMP) AS visit_end_datetime,
  32827 AS visit_type_concept_id,
  provider_id,
  CAST(NULL AS INTEGER) AS care_site_id,
  CAST(representative_encounter_id AS TEXT) AS visit_source_value,
  0 AS visit_source_concept_id,
  CAST(NULL AS INTEGER) AS admitted_from_concept_id,
  CAST(NULL AS TEXT) AS admitted_from_source_value,
  CAST(NULL AS INTEGER) AS discharged_to_concept_id,
  CAST(NULL AS TEXT) AS discharged_to_source_value,
  LAG(visit_occurrence_id) OVER (
    PARTITION BY person_id
    ORDER BY encounter_start_datetime, visit_occurrence_id
  ) AS preceding_visit_occurrence_id
FROM visits;
