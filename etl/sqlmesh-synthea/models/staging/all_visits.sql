MODEL (
  name stg.all_visits,
  kind FULL,
  description 'Collapsed visit windows derived from Synthea encounters mirroring ETL-Synthea visit rollups',
  columns (
    encounter_id TEXT,
    patient_id TEXT,
    encounter_class TEXT,
    visit_start_date DATE,
    visit_end_date DATE,
    visit_occurrence_id BIGINT
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
ranked_inpatient AS (
  SELECT
    *,
    CASE
      WHEN LAG(encounter_end_date) OVER (PARTITION BY patient_id ORDER BY encounter_start_date) IS NULL
        OR DATEDIFF('day', LAG(encounter_end_date) OVER (PARTITION BY patient_id ORDER BY encounter_start_date), encounter_start_date) > 1
      THEN 1
      ELSE 0
    END AS new_stay
  FROM encounters
  WHERE encounter_class = 'inpatient'
),
inpatient_groups AS (
  SELECT
    *,
    SUM(new_stay) OVER (PARTITION BY patient_id ORDER BY encounter_start_date ROWS UNBOUNDED PRECEDING) AS grp
  FROM ranked_inpatient
),
inpatient_visits AS (
  SELECT
    MIN(encounter_id) AS encounter_id,
    patient_id,
    'inpatient' AS encounter_class,
    MIN(encounter_start_date) AS visit_start_date,
    MAX(encounter_end_date) AS visit_end_date
  FROM inpatient_groups
  GROUP BY patient_id, grp
),
er_visits AS (
  SELECT
    MIN(encounter_id) AS encounter_id,
    patient_id,
    encounter_class,
    encounter_start_date AS visit_start_date,
    MAX(encounter_end_date) AS visit_end_date
  FROM encounters
  WHERE encounter_class IN ('emergency', 'urgent', 'urgentcare')
  GROUP BY patient_id, encounter_class, encounter_start_date
),
op_visits AS (
  SELECT
    MIN(encounter_id) AS encounter_id,
    patient_id,
    encounter_class,
    encounter_start_date AS visit_start_date,
    MAX(encounter_end_date) AS visit_end_date
  FROM encounters
  WHERE encounter_class IN ('ambulatory', 'wellness', 'outpatient')
  GROUP BY patient_id, encounter_class, encounter_start_date
),
all_visits AS (
  SELECT * FROM inpatient_visits
  UNION ALL
  SELECT * FROM er_visits
  UNION ALL
  SELECT * FROM op_visits
)
SELECT
  encounter_id,
  patient_id,
  encounter_class,
  visit_start_date,
  visit_end_date,
  ROW_NUMBER() OVER (ORDER BY patient_id, visit_start_date, encounter_id) AS visit_occurrence_id
FROM all_visits;
