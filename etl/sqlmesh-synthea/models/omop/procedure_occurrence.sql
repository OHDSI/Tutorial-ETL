MODEL (
  name omop.procedure_occurrence,
  kind FULL,
  columns (
    procedure_occurrence_id BIGINT,
    person_id BIGINT,
    procedure_concept_id INT,
    procedure_date DATE,
    procedure_datetime TIMESTAMP,
    procedure_end_date DATE,
    procedure_end_datetime TIMESTAMP,
    procedure_type_concept_id INT,
    modifier_concept_id INT,
    quantity INT,
    provider_id BIGINT,
    visit_occurrence_id BIGINT,
    visit_detail_id BIGINT,
    procedure_source_value TEXT,
    procedure_source_concept_id INT,
    modifier_source_value TEXT
  ),
  audits (
    person_completeness_procedure_occurrence,
    procedure_occurrence_modifier_concept_id_is_foreign_key,
    procedure_occurrence_modifier_concept_id_is_standard_valid_concept,
    procedure_occurrence_modifier_concept_id_standard_concept_record_completeness,
    procedure_occurrence_person_id_is_required,
    procedure_occurrence_person_id_is_foreign_key,
    procedure_occurrence_procedure_concept_id_is_required,
    procedure_occurrence_procedure_concept_id_is_foreign_key,
    procedure_occurrence_procedure_concept_id_fk_domain,
    procedure_occurrence_procedure_concept_id_is_standard_valid_concept,
    procedure_occurrence_procedure_concept_id_standard_concept_record_completeness,
    procedure_occurrence_procedure_date_is_required,
    procedure_occurrence_procedure_date_start_before_end,
    procedure_occurrence_procedure_date_after_birth,
    procedure_occurrence_procedure_datetime_start_before_end,
    procedure_occurrence_procedure_datetime_after_birth,
    procedure_occurrence_procedure_end_date_after_birth,
    procedure_occurrence_procedure_end_datetime_after_birth,
    procedure_occurrence_procedure_occurrence_id_is_required,
    procedure_occurrence_procedure_occurrence_id_is_primary_key,
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
    proc.encounter_id,
    proc.procedure_date,
    proc.procedure_datetime,
    proc.procedure_end_date,
    proc.procedure_end_datetime,
    proc.procedure_code,
    proc.procedure_description,
    std_map.target_concept_id,
    src_map.source_concept_id,
    prov.provider_id
  FROM stg.procedures AS proc
  JOIN stg.patient_ids AS ids
    ON proc.patient_id = ids.patient_id
  LEFT JOIN stg.source_to_standard_map AS std_map
    ON std_map.source_code = proc.procedure_code
   AND std_map.source_vocabulary_id = proc.source_vocabulary_id
   AND std_map.target_domain_id = 'PROCEDURE'
  LEFT JOIN stg.source_to_source_map AS src_map
    ON src_map.source_code = proc.procedure_code
   AND src_map.source_vocabulary_id = proc.source_vocabulary_id
  LEFT JOIN encounter_providers AS prov
    ON prov.encounter_id = proc.encounter_id
),
visits AS (
  SELECT encounter_id, visit_occurrence_id FROM stg.final_visit_ids
)
SELECT
  ROW_NUMBER() OVER (ORDER BY person_id, procedure_datetime, procedure_code) AS procedure_occurrence_id,
  person_id,
  COALESCE(target_concept_id, 0) AS procedure_concept_id,
  procedure_date,
  TRY_CAST(procedure_datetime AS TIMESTAMP) AS procedure_datetime,
  COALESCE(procedure_end_date, procedure_date) AS procedure_end_date,
  TRY_CAST(COALESCE(procedure_end_datetime, procedure_datetime) AS TIMESTAMP) AS procedure_end_datetime,
  32827 AS procedure_type_concept_id,
  0 AS modifier_concept_id,
  CAST(NULL AS INTEGER) AS quantity,
  provider_id,
  visits.visit_occurrence_id,
  CASE WHEN visits.visit_occurrence_id IS NOT NULL THEN visits.visit_occurrence_id + 1000000 ELSE NULL END AS visit_detail_id,
  procedure_code AS procedure_source_value,
  COALESCE(source_concept_id, 0) AS procedure_source_concept_id,
  CAST(NULL AS TEXT) AS modifier_source_value
FROM base
LEFT JOIN visits
  ON base.encounter_id = visits.encounter_id;
