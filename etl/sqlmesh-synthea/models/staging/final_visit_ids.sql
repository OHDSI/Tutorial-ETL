MODEL (
  name stg.final_visit_ids,
  kind FULL,
  description 'Chosen visit identifiers per encounter aligning with ETL-Synthea final_visit_ids',
  columns (
    encounter_id TEXT,
    visit_occurrence_id BIGINT
  )
);

SELECT
  encounter_id,
  visit_occurrence_id
FROM stg.assign_all_visit_ids
WHERE visit_rank = 1;
