MODEL (
  name stg.visit_dimension,
  kind FULL,
  description 'Aggregated visit facts aligned with ETL-Synthea AllVisitTable/final_visit_ids logic',
  columns (
    visit_occurrence_id BIGINT,
    representative_encounter_id TEXT,
    person_id BIGINT,
    encounter_class TEXT,
    encounter_start_date DATE,
    encounter_start_datetime TIMESTAMP,
    encounter_start_ts TIMESTAMP,
    encounter_end_date DATE,
    encounter_end_datetime TIMESTAMP,
    encounter_end_ts TIMESTAMP,
    source_code TEXT,
    encounter_code TEXT,
    source_vocabulary_id TEXT,
    description TEXT,
    provider_id BIGINT,
    target_concept_id INT,
    visit_concept_id INT,
    source_concept_id INT,
    visit_source_concept_id INT
  )
);

WITH visits AS (
  SELECT
    av.visit_occurrence_id,
    av.encounter_id AS representative_encounter_id,
    av.patient_id,
    ids.person_id,
    av.encounter_class,
    av.visit_start_date,
    av.visit_end_date
  FROM stg.all_visits AS av
  JOIN stg.patient_ids AS ids
    ON av.patient_id = ids.patient_id
),
visit_members AS (
  SELECT
    f.visit_occurrence_id,
    f.encounter_id,
    e.encounter_start_datetime,
    e.encounter_end_datetime,
    e.encounter_class AS member_encounter_class,
    e.source_code,
    e.source_vocabulary_id,
    e.description,
    prov.provider_id,
    ROW_NUMBER() OVER (
      PARTITION BY f.visit_occurrence_id
      ORDER BY e.encounter_start_datetime, e.encounter_id
    ) AS member_rank
  FROM stg.final_visit_ids AS f
  JOIN stg.encounters AS e
    ON f.encounter_id = e.encounter_id
  LEFT JOIN stg.providers AS prov
    ON e.provider_source_value = prov.provider_source_value
),
canonical_member AS (
  SELECT *
  FROM visit_members
  WHERE member_rank = 1
),
lookup AS (
  SELECT
    v.visit_occurrence_id,
    v.representative_encounter_id,
    v.person_id,
    v.encounter_class,
    v.visit_start_date,
    v.visit_end_date,
    cm.encounter_start_datetime,
    cm.encounter_end_datetime,
    cm.source_code,
    cm.source_vocabulary_id,
    cm.description,
    cm.provider_id,
    std_map.target_concept_id,
    std_map.source_concept_id
  FROM visits AS v
  LEFT JOIN canonical_member AS cm
    ON v.visit_occurrence_id = cm.visit_occurrence_id
  LEFT JOIN stg.source_to_standard_map AS std_map
    ON std_map.source_code = cm.source_code AND std_map.source_vocabulary_id = cm.source_vocabulary_id
)
SELECT
  visit_occurrence_id,
  representative_encounter_id,
  person_id,
  encounter_class,
  visit_start_date AS encounter_start_date,
  COALESCE(encounter_start_datetime, CAST(visit_start_date AS TIMESTAMP)) AS encounter_start_datetime,
  COALESCE(encounter_start_datetime, CAST(visit_start_date AS TIMESTAMP)) AS encounter_start_ts,
  visit_end_date AS encounter_end_date,
  COALESCE(encounter_end_datetime, CAST(visit_end_date AS TIMESTAMP)) AS encounter_end_datetime,
  COALESCE(encounter_end_datetime, CAST(visit_end_date AS TIMESTAMP)) AS encounter_end_ts,
  source_code,
  source_code AS encounter_code,
  source_vocabulary_id,
  description,
  provider_id,
  target_concept_id,
  target_concept_id AS visit_concept_id,
  source_concept_id,
  source_concept_id AS visit_source_concept_id
FROM lookup;

