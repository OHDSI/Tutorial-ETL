MODEL (
  name omop.death,
  kind FULL,
  columns (
    person_id BIGINT,
    death_date DATE,
    death_datetime TIMESTAMP,
    death_type_concept_id INT,
    cause_concept_id INT,
    cause_source_value TEXT,
    cause_source_concept_id INT
  ),
  audits (
    person_completeness_death,
    death_cause_concept_id_is_foreign_key,
    death_cause_concept_id_is_standard_valid_concept,
    death_cause_concept_id_standard_concept_record_completeness,
    death_cause_source_concept_id_is_foreign_key,
    death_death_date_is_required,
    death_death_date_after_birth,
    death_death_datetime_after_birth,
    death_death_type_concept_id_is_foreign_key,
    death_death_type_concept_id_fk_domain,
    death_death_type_concept_id_is_standard_valid_concept,
    death_death_type_concept_id_standard_concept_record_completeness,
    death_person_id_is_required,
    death_person_id_is_foreign_key
  )
);

WITH death_encounters AS (
  SELECT
    e.patient_id,
    e.encounter_start_date,
    e.encounter_start_datetime,
    e.reason_code,
    ids.person_id
  FROM stg.encounters AS e
  JOIN stg.patient_ids AS ids
    ON e.patient_id = ids.patient_id
  WHERE e.encounter_code = '308646001'
    AND e.reason_code IS NOT NULL
),
causes AS (
  SELECT
    source_code,
    target_concept_id,
    source_concept_id
  FROM stg.source_to_standard_map
  WHERE target_domain_id = 'CONDITION'
    AND source_vocabulary_id = 'SNOMED'
    AND target_vocabulary_id = 'SNOMED'
)
SELECT
  person_id,
  encounter_start_date AS death_date,
  TRY_CAST(encounter_start_datetime AS TIMESTAMP) AS death_datetime,
  32817 AS death_type_concept_id,
  COALESCE(causes.target_concept_id, 0) AS cause_concept_id,
  reason_code AS cause_source_value,
  COALESCE(causes.source_concept_id, 0) AS cause_source_concept_id
FROM death_encounters
LEFT JOIN causes
  ON UPPER(death_encounters.reason_code) = causes.source_code;
