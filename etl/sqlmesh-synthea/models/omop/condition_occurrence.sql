MODEL (
  name omop.condition_occurrence,
  kind FULL,
  columns (
    condition_occurrence_id BIGINT,
    person_id BIGINT,
    condition_concept_id INT,
    condition_start_date DATE,
    condition_start_datetime TIMESTAMP,
    condition_end_date DATE,
    condition_end_datetime TIMESTAMP,
    condition_type_concept_id INT,
    stop_reason TEXT,
    visit_occurrence_id BIGINT,
    provider_id BIGINT,
    visit_detail_id BIGINT,
    condition_source_concept_id INT,
    condition_source_value TEXT,
    condition_status_source_value TEXT,
    condition_status_concept_id INT
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
    cond.patient_id,
    cond.encounter_id,
    CAST(cond.condition_start_ts AS DATE) AS condition_start_date,
    cond.condition_start_ts,
    CAST(cond.condition_end_ts AS DATE) AS condition_end_date,
    cond.condition_end_ts,
    cond.condition_code,
    cond.condition_description,
    CASE UPPER(cond.coding_system)
      WHEN 'SNOMED-CT' THEN 'SNOMED'
      WHEN 'ICD10' THEN 'ICD10CM'
      ELSE UPPER(cond.coding_system)
    END AS source_vocabulary_id,
    std_map.target_concept_id,
    std_map.source_concept_id,
    prov.provider_id
  FROM stg.conditions AS cond
  JOIN stg.patient_ids AS ids
    ON cond.patient_id = ids.patient_id
  LEFT JOIN stg.source_to_standard_map AS std_map
    ON std_map.source_code = cond.condition_code
   AND std_map.source_vocabulary_id = CASE UPPER(cond.coding_system)
      WHEN 'SNOMED-CT' THEN 'SNOMED'
      WHEN 'ICD10' THEN 'ICD10CM'
      ELSE UPPER(cond.coding_system)
    END
   AND std_map.target_domain_id = 'CONDITION'
  LEFT JOIN encounter_providers AS prov
    ON prov.encounter_id = cond.encounter_id
), visits AS (
  SELECT encounter_id, visit_occurrence_id
  FROM stg.final_visit_ids
)
SELECT
  ROW_NUMBER() OVER (ORDER BY person_id, condition_start_ts, condition_code) AS condition_occurrence_id,
  person_id,
  COALESCE(target_concept_id, 0) AS condition_concept_id,
  condition_start_date,
  TRY_CAST(condition_start_ts AS TIMESTAMP) AS condition_start_datetime,
  condition_end_date,
  TRY_CAST(condition_end_ts AS TIMESTAMP) AS condition_end_datetime,
  32827 AS condition_type_concept_id,
  CAST(NULL AS TEXT) AS stop_reason,
  visit_occurrence_id,
  provider_id,
  CASE WHEN visit_occurrence_id IS NOT NULL THEN visit_occurrence_id + 1000000 ELSE NULL END AS visit_detail_id,
  COALESCE(source_concept_id, 0) AS condition_source_concept_id,
  condition_code AS condition_source_value,
  CAST(NULL AS TEXT) AS condition_status_source_value,
  0 AS condition_status_concept_id
FROM base
LEFT JOIN visits USING (encounter_id);
