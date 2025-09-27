MODEL (
  name omop.measurement,
  kind FULL,
  columns (
    measurement_id BIGINT,
    person_id BIGINT,
    measurement_concept_id INT,
    measurement_date DATE,
    measurement_datetime TIMESTAMP,
    measurement_time TIME,
    measurement_type_concept_id INT,
    operator_concept_id INT,
    value_as_number DOUBLE,
    value_as_concept_id INT,
    unit_concept_id INT,
    range_low DOUBLE,
    range_high DOUBLE,
    provider_id BIGINT,
    visit_occurrence_id BIGINT,
    visit_detail_id BIGINT,
    measurement_source_value TEXT,
    measurement_source_concept_id INT,
    unit_source_value TEXT,
    value_source_value TEXT,
    unit_source_concept_id INT,
    measurement_event_id BIGINT,
    meas_event_field_concept_id INT
  ),
  depends_on (
    vocab.concept,
    omop.person,
    omop.provider,
    omop.visit_detail,
    omop.visit_occurrence,
  ),
  audits (
    person_completeness_measurement,
    measurement_meas_event_field_concept_id_is_foreign_key,
    measurement_meas_event_field_concept_id_is_standard_valid_concept,
    measurement_measurement_concept_id_is_required,
    measurement_measurement_concept_id_is_foreign_key,
    measurement_measurement_concept_id_fk_domain,
    measurement_measurement_concept_id_is_standard_valid_concept,
    measurement_measurement_concept_id_standard_concept_record_completeness,
    measurement_measurement_date_is_required,
    measurement_measurement_date_after_birth,
    measurement_measurement_datetime_after_birth,
    measurement_measurement_id_is_required,
    measurement_measurement_id_is_primary_key,
    measurement_measurement_source_concept_id_is_foreign_key,
    measurement_measurement_type_concept_id_is_required,
    measurement_measurement_type_concept_id_is_foreign_key,
    measurement_measurement_type_concept_id_fk_domain,
    measurement_measurement_type_concept_id_is_standard_valid_concept,
    measurement_measurement_type_concept_id_standard_concept_record_completeness,
    measurement_operator_concept_id_is_foreign_key,
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
observation_base AS (
  SELECT
    ids.person_id,
    obs.encounter_id,
    CAST(obs.observation_datetime AS DATE) AS measurement_date,
    obs.observation_datetime AS measurement_datetime,
    obs.observation_code AS source_code,
    obs.source_description,
    obs.numeric_value AS value_as_number,
    obs.value_source_value,
    obs.observation_units,
    std_map.target_concept_id,
    std_map.source_concept_id,
    unit_map.target_concept_id AS unit_concept_id,
    value_map.target_concept_id AS value_concept_id,
    prov.provider_id,
    'observation' AS record_type
  FROM stg.observations AS obs
  JOIN stg.patient_ids AS ids
    ON obs.patient_id = ids.patient_id
  LEFT JOIN stg.source_to_standard_map AS std_map
    ON std_map.source_code = obs.observation_code
   AND std_map.source_vocabulary_id = 'LOINC'
   AND std_map.target_domain_id = 'MEASUREMENT'
  LEFT JOIN stg.source_to_standard_map AS unit_map
    ON unit_map.source_code = obs.observation_units
   AND unit_map.source_vocabulary_id = 'UCUM'
   AND unit_map.target_vocabulary_id = 'UCUM'
   AND unit_map.target_domain_id = 'UNIT'
  LEFT JOIN stg.source_to_standard_map AS value_map
    ON value_map.source_code = obs.value_source_value
   AND value_map.target_domain_id = 'MEAS VALUE'
  LEFT JOIN encounter_providers AS prov
    ON prov.encounter_id = obs.encounter_id
), procedure_base AS (
  SELECT
    ids.person_id,
    proc.encounter_id,
    proc.procedure_date AS measurement_date,
    proc.procedure_datetime AS measurement_datetime,
    proc.procedure_code AS source_code,
    proc.procedure_description AS source_description,
    CAST(NULL AS DOUBLE) AS value_as_number,
    CAST(NULL AS TEXT) AS value_source_value,
    CAST(NULL AS TEXT) AS observation_units,
    std_map.target_concept_id,
    std_map.source_concept_id,
    CAST(NULL AS INTEGER) AS unit_concept_id,
    CAST(NULL AS INTEGER) AS value_concept_id,
    prov.provider_id,
    'procedure' AS record_type
  FROM stg.procedures AS proc
  JOIN stg.patient_ids AS ids
    ON proc.patient_id = ids.patient_id
  LEFT JOIN stg.source_to_standard_map AS std_map
    ON std_map.source_code = proc.procedure_code
   AND std_map.source_vocabulary_id = 'SNOMED'
   AND std_map.target_domain_id = 'MEASUREMENT'
  LEFT JOIN encounter_providers AS prov
    ON prov.encounter_id = proc.encounter_id
), combined AS (
  SELECT * FROM observation_base
  UNION ALL
  SELECT * FROM procedure_base
), visits AS (
  SELECT encounter_id, visit_occurrence_id
  FROM stg.final_visit_ids
)
SELECT
  ROW_NUMBER() OVER (ORDER BY person_id, measurement_datetime, source_code) AS measurement_id,
  person_id,
  COALESCE(target_concept_id, 0) AS measurement_concept_id,
  measurement_date,
  TRY_CAST(measurement_datetime AS TIMESTAMP) AS measurement_datetime,
  CAST(NULL AS TIME) AS measurement_time,
  32827 AS measurement_type_concept_id,
  CAST(NULL AS INTEGER) AS operator_concept_id,
  value_as_number,
  COALESCE(value_concept_id, 0) AS value_as_concept_id,
  COALESCE(unit_concept_id, 0) AS unit_concept_id,
  CAST(NULL AS DOUBLE) AS range_low,
  CAST(NULL AS DOUBLE) AS range_high,
  provider_id,
  visits.visit_occurrence_id,
  CASE WHEN visits.visit_occurrence_id IS NOT NULL THEN visits.visit_occurrence_id + 1000000 ELSE NULL END AS visit_detail_id,
  source_code AS measurement_source_value,
  COALESCE(source_concept_id, 0) AS measurement_source_concept_id,
  observation_units AS unit_source_value,
  value_source_value,
  CAST(NULL AS INTEGER) AS unit_source_concept_id,
  CAST(NULL AS BIGINT) AS measurement_event_id,
  CAST(NULL AS INTEGER) AS meas_event_field_concept_id
FROM combined
LEFT JOIN visits USING (encounter_id);
