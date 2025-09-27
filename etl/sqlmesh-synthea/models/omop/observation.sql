MODEL (
  name omop.observation,
  kind FULL,
  columns (
    observation_id BIGINT,
    person_id BIGINT,
    observation_date DATE,
    observation_datetime TIMESTAMP,
    observation_concept_id INT,
    observation_type_concept_id INT,
    value_as_number DOUBLE,
    value_as_string TEXT,
    value_as_concept_id INT,
    qualifier_concept_id INT,
    unit_concept_id INT,
    provider_id BIGINT,
    visit_occurrence_id BIGINT,
    visit_detail_id BIGINT,
    observation_source_value TEXT,
    observation_source_concept_id INT,
    unit_source_value TEXT,
    qualifier_source_value TEXT,
    value_source_value TEXT,
    observation_event_id BIGINT,
    obs_event_field_concept_id INT
  ),
  audits (
    person_completeness_observation,
    observation_obs_event_field_concept_id_is_foreign_key,
    observation_obs_event_field_concept_id_is_standard_valid_concept,
    observation_observation_concept_id_is_required,
    observation_observation_concept_id_is_foreign_key,
    observation_observation_concept_id_is_standard_valid_concept,
    observation_observation_concept_id_standard_concept_record_completeness,
    observation_observation_date_is_required,
    observation_observation_date_after_birth,
    observation_observation_datetime_after_birth,
    observation_observation_id_is_required,
    observation_observation_id_is_primary_key,
    observation_observation_source_concept_id_is_foreign_key,
    observation_observation_type_concept_id_is_required,
    observation_observation_type_concept_id_is_foreign_key,
    observation_observation_type_concept_id_fk_domain,
    observation_observation_type_concept_id_is_standard_valid_concept,
    observation_observation_type_concept_id_standard_concept_record_completeness,
    observation_person_id_is_required,
    observation_person_id_is_foreign_key,
  )
);

WITH visits AS (
  SELECT encounter_id, visit_occurrence_id FROM stg.final_visit_ids
),
encounter_providers AS (
  SELECT
    encounter_id,
    prov.provider_id
  FROM stg.encounters AS e
  LEFT JOIN stg.providers AS prov
    ON e.provider_source_value = prov.provider_source_value
),
allergy_obs AS (
  SELECT
    ids.person_id,
    a.encounter_id,
    a.allergy_start_date AS observation_date,
    a.allergy_start_datetime AS observation_datetime,
    std_map.target_concept_id AS observation_concept_id,
    32827 AS observation_type_concept_id,
    CAST(NULL AS DOUBLE) AS value_as_number,
    CAST(NULL AS TEXT) AS value_as_string,
    0 AS value_as_concept_id,
    0 AS qualifier_concept_id,
    0 AS unit_concept_id,
    prov.provider_id,
    a.allergy_code AS observation_source_value,
    COALESCE(src_map.source_concept_id, 0) AS observation_source_concept_id,
    CAST(NULL AS TEXT) AS unit_source_value,
    CAST(NULL AS TEXT) AS qualifier_source_value,
    CAST(NULL AS TEXT) AS value_source_value
  FROM stg.allergies AS a
  JOIN stg.patient_ids AS ids
    ON a.patient_id = ids.patient_id
  LEFT JOIN stg.source_to_standard_map AS std_map
    ON std_map.source_code = a.allergy_code
   AND std_map.source_vocabulary_id = a.coding_system
   AND std_map.target_domain_id = 'OBSERVATION'
  LEFT JOIN stg.source_to_source_map AS src_map
    ON src_map.source_code = a.allergy_code
   AND src_map.source_vocabulary_id = a.coding_system
  LEFT JOIN encounter_providers AS prov
    ON prov.encounter_id = a.encounter_id
),
condition_obs AS (
  SELECT
    ids.person_id,
    cond.encounter_id,
    CAST(cond.condition_start_datetime AS DATE) AS observation_date,
    cond.condition_start_datetime AS observation_datetime,
    std_map.target_concept_id AS observation_concept_id,
    38000280 AS observation_type_concept_id,
    CAST(NULL AS DOUBLE) AS value_as_number,
    CAST(NULL AS TEXT) AS value_as_string,
    0 AS value_as_concept_id,
    0 AS qualifier_concept_id,
    0 AS unit_concept_id,
    prov.provider_id,
    cond.condition_code AS observation_source_value,
    COALESCE(src_map.source_concept_id, 0) AS observation_source_concept_id,
    CAST(NULL AS TEXT) AS unit_source_value,
    CAST(NULL AS TEXT) AS qualifier_source_value,
    CAST(NULL AS TEXT) AS value_source_value
  FROM stg.conditions AS cond
  JOIN stg.patient_ids AS ids
    ON cond.patient_id = ids.patient_id
  LEFT JOIN stg.source_to_standard_map AS std_map
    ON std_map.source_code = cond.condition_code
   AND std_map.source_vocabulary_id = cond.coding_system
   AND std_map.target_domain_id = 'OBSERVATION'
  LEFT JOIN stg.source_to_source_map AS src_map
    ON src_map.source_code = cond.condition_code
   AND src_map.source_vocabulary_id = cond.coding_system
  LEFT JOIN encounter_providers AS prov
    ON prov.encounter_id = cond.encounter_id
),
clinical_obs AS (
  SELECT
    ids.person_id,
    obs.encounter_id,
    CAST(obs.observation_datetime AS DATE) AS observation_date,
    obs.observation_datetime AS observation_datetime,
    std_map.target_concept_id AS observation_concept_id,
    38000280 AS observation_type_concept_id,
    CAST(NULL AS DOUBLE) AS value_as_number,
    LEFT(obs.value_source_value, 50) AS value_as_string,
    0 AS value_as_concept_id,
    0 AS qualifier_concept_id,
    0 AS unit_concept_id,
    prov.provider_id,
    obs.observation_code AS observation_source_value,
    COALESCE(src_map.source_concept_id, 0) AS observation_source_concept_id,
    obs.observation_units AS unit_source_value,
    CAST(NULL AS TEXT) AS qualifier_source_value,
    LEFT(obs.value_source_value, 50) AS value_source_value
  FROM stg.observations AS obs
  JOIN stg.patient_ids AS ids
    ON obs.patient_id = ids.patient_id
  LEFT JOIN stg.source_to_standard_map AS std_map
    ON std_map.source_code = obs.observation_code
   AND std_map.source_vocabulary_id = 'LOINC'
   AND std_map.target_domain_id = 'OBSERVATION'
  LEFT JOIN stg.source_to_source_map AS src_map
    ON src_map.source_code = obs.observation_code
   AND src_map.source_vocabulary_id = 'LOINC'
  LEFT JOIN encounter_providers AS prov
    ON prov.encounter_id = obs.encounter_id
)
SELECT
  ROW_NUMBER() OVER (ORDER BY person_id, observation_datetime, observation_concept_id) AS observation_id,
  person_id,
  COALESCE(observation_concept_id, 0) AS observation_concept_id,
  observation_date,
  TRY_CAST(observation_datetime AS TIMESTAMP) AS observation_datetime,
  observation_type_concept_id,
  value_as_number,
  value_as_string,
  value_as_concept_id,
  qualifier_concept_id,
  unit_concept_id,
  provider_id,
  visits.visit_occurrence_id,
  CASE WHEN visits.visit_occurrence_id IS NOT NULL THEN visits.visit_occurrence_id + 1000000 ELSE NULL END AS visit_detail_id,
  observation_source_value,
  COALESCE(observation_source_concept_id, 0) AS observation_source_concept_id,
  unit_source_value,
  qualifier_source_value,
  value_source_value,
  CAST(NULL AS BIGINT) AS observation_event_id,
  CAST(NULL AS INTEGER) AS obs_event_field_concept_id
FROM (
  SELECT * FROM allergy_obs
  UNION ALL
  SELECT * FROM condition_obs
  UNION ALL
  SELECT * FROM clinical_obs
) AS obs
LEFT JOIN visits
  ON obs.encounter_id = visits.encounter_id;
