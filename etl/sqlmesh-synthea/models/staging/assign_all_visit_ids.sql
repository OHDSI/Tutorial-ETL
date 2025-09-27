MODEL (
  name stg.assign_all_visit_ids,
  kind FULL,
  description 'Assigns encounters to aggregated visits using ETL-Synthea priority logic',
  columns (
    encounter_id TEXT,
    visit_occurrence_id BIGINT,
    visit_type TEXT,
    visit_rank BIGINT
  )
);

WITH encounters AS (
  SELECT
    encounter_id,
    patient_id,
    LOWER(encounter_class) AS encounter_class,
    encounter_start_date,
    COALESCE(encounter_end_date, encounter_start_date) AS encounter_end_date
  FROM stg.encounters
),
candidate_visits AS (
  SELECT
    e.encounter_id,
    e.patient_id,
    e.encounter_class,
    v.encounter_class AS visit_type,
    v.visit_occurrence_id,
    v.visit_start_date,
    v.visit_end_date,
    CASE
      WHEN e.encounter_class = 'inpatient' AND v.encounter_class = 'inpatient' THEN 1
      WHEN e.encounter_class IN ('emergency', 'urgent', 'urgentcare') THEN
        CASE
          WHEN v.encounter_class = 'inpatient' AND e.encounter_start_date > v.visit_start_date THEN 1
          WHEN v.encounter_class IN ('emergency', 'urgent', 'urgentcare') AND e.encounter_start_date = v.visit_start_date THEN 2
          ELSE 99
        END
      WHEN e.encounter_class IN ('ambulatory', 'wellness', 'outpatient') THEN
        CASE
          WHEN v.encounter_class = 'inpatient' AND e.encounter_start_date >= v.visit_start_date THEN 1
          WHEN v.encounter_class IN ('ambulatory', 'wellness', 'outpatient') THEN 2
          ELSE 99
        END
      ELSE 99
    END AS priority
  FROM encounters AS e
  JOIN stg.all_visits AS v
    ON e.patient_id = v.patient_id
   AND e.encounter_start_date BETWEEN v.visit_start_date AND v.visit_end_date
)
SELECT
  encounter_id,
  visit_occurrence_id,
  visit_type,
  ROW_NUMBER() OVER (
    PARTITION BY encounter_id
    ORDER BY priority, visit_start_date, visit_end_date, visit_occurrence_id
  ) AS visit_rank
FROM candidate_visits
WHERE priority < 99;
