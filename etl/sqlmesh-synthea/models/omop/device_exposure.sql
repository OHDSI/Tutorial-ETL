MODEL (
  name omop.device_exposure,
  kind FULL,
  columns (
    device_exposure_id BIGINT,
    person_id BIGINT,
    device_concept_id INT,
    device_exposure_start_date DATE,
    device_exposure_start_datetime TIMESTAMP,
    device_exposure_end_date DATE,
    device_exposure_end_datetime TIMESTAMP,
    device_type_concept_id INT,
    unique_device_id TEXT,
    production_id TEXT,
    quantity DOUBLE,
    provider_id BIGINT,
    visit_occurrence_id BIGINT,
    visit_detail_id BIGINT,
    device_source_value TEXT,
    device_source_concept_id INT,
    unit_concept_id INT,
    unit_source_value TEXT,
    unit_source_concept_id INT
  ),
  depends_on (
    vocab.concept,
    omop.person,
    omop.provider,
    omop.visit_detail,
    omop.visit_occurrence,
  ),
  audits (
    person_completeness_device_exposure,
    device_exposure_device_concept_id_is_required,
    device_exposure_device_concept_id_is_foreign_key,
    device_exposure_device_concept_id_fk_domain,
    device_exposure_device_concept_id_is_standard_valid_concept,
    device_exposure_device_concept_id_standard_concept_record_completeness,
    device_exposure_device_exposure_end_date_after_birth,
    device_exposure_device_exposure_end_datetime_after_birth,
    device_exposure_device_exposure_id_is_required,
    device_exposure_device_exposure_id_is_primary_key,
    device_exposure_device_exposure_start_date_is_required,
    device_exposure_device_exposure_start_date_start_before_end,
    device_exposure_device_exposure_start_date_after_birth,
    device_exposure_device_exposure_start_datetime_start_before_end,
    device_exposure_device_exposure_start_datetime_after_birth,
    device_exposure_device_source_concept_id_is_foreign_key,
    device_exposure_device_type_concept_id_is_required,
    device_exposure_device_type_concept_id_is_foreign_key,
    device_exposure_device_type_concept_id_fk_domain,
    device_exposure_device_type_concept_id_is_standard_valid_concept,
  )
);

WITH encounter_providers AS (
  SELECT
    encounter_id,
    prov.provider_id
  FROM stg.encounters AS e
  LEFT JOIN stg.providers AS prov
    ON e.provider_source_value = prov.provider_source_value
),
base AS (
  SELECT
    ids.person_id,
    dev.encounter_id,
    dev.device_start_date,
    dev.device_start_datetime,
    dev.device_end_date,
    dev.device_end_datetime,
    dev.device_code,
    dev.device_description,
    dev.unique_device_id,
    std_map.target_concept_id,
    src_map.source_concept_id,
    prov.provider_id
  FROM stg.devices AS dev
  JOIN stg.patient_ids AS ids
    ON dev.patient_id = ids.patient_id
  LEFT JOIN stg.source_to_standard_map AS std_map
    ON std_map.source_code = dev.device_code
   AND std_map.source_vocabulary_id = dev.source_vocabulary_id
   AND std_map.target_domain_id = 'DEVICE'
  LEFT JOIN stg.source_to_source_map AS src_map
    ON src_map.source_code = dev.device_code
   AND src_map.source_vocabulary_id = dev.source_vocabulary_id
  LEFT JOIN encounter_providers AS prov
    ON prov.encounter_id = dev.encounter_id
),
visits AS (
  SELECT encounter_id, visit_occurrence_id FROM stg.final_visit_ids
)
SELECT
  ROW_NUMBER() OVER (ORDER BY person_id, device_start_datetime, device_code) AS device_exposure_id,
  person_id,
  COALESCE(target_concept_id, 0) AS device_concept_id,
  device_start_date AS device_exposure_start_date,
  TRY_CAST(device_start_datetime AS TIMESTAMP) AS device_exposure_start_datetime,
  device_end_date AS device_exposure_end_date,
  TRY_CAST(device_end_datetime AS TIMESTAMP) AS device_exposure_end_datetime,
  32827 AS device_type_concept_id,
  unique_device_id,
  CAST(NULL AS TEXT) AS production_id,
  CAST(NULL AS DOUBLE) AS quantity,
  provider_id,
  visits.visit_occurrence_id,
  CASE WHEN visits.visit_occurrence_id IS NOT NULL THEN visits.visit_occurrence_id + 1000000 ELSE NULL END AS visit_detail_id,
  device_code AS device_source_value,
  COALESCE(source_concept_id, 0) AS device_source_concept_id,
  CAST(NULL AS INTEGER) AS unit_concept_id,
  CAST(NULL AS TEXT) AS unit_source_value,
  CAST(NULL AS INTEGER) AS unit_source_concept_id
FROM base
LEFT JOIN visits
  ON base.encounter_id = visits.encounter_id;
