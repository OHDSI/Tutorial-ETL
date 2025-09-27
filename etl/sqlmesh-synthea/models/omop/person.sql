MODEL (
  name omop.person,
  kind FULL,
  columns (
    person_id BIGINT,
    gender_concept_id INT,
    year_of_birth INT,
    month_of_birth INT,
    day_of_birth INT,
    birth_datetime TIMESTAMP,
    race_concept_id INT,
    ethnicity_concept_id INT,
    location_id BIGINT,
    provider_id INT,
    care_site_id INT,
    person_source_value TEXT,
    gender_source_value TEXT,
    gender_source_concept_id INT,
    race_source_value TEXT,
    race_source_concept_id INT,
    ethnicity_source_value TEXT,
    ethnicity_source_concept_id INT
  ),
  audits (
    person_exists,
    person_care_site_id_is_foreign_key,
    person_ethnicity_concept_id_is_required,
    person_ethnicity_concept_id_is_foreign_key,
    person_ethnicity_concept_id_fk_domain,
    person_ethnicity_concept_id_is_standard_valid_concept,
    person_ethnicity_concept_id_standard_concept_record_completeness,
    person_ethnicity_source_concept_id_is_foreign_key,
    person_gender_concept_id_is_required,
    person_gender_concept_id_is_foreign_key,
    person_gender_concept_id_fk_domain,
    person_gender_concept_id_is_standard_valid_concept,
    person_gender_concept_id_standard_concept_record_completeness,
    person_gender_source_concept_id_is_foreign_key,
    person_location_id_is_foreign_key,
    person_person_id_is_required,
    person_person_id_is_primary_key,
    person_provider_id_is_foreign_key,
    person_race_concept_id_is_required,
    person_race_concept_id_is_foreign_key,
    person_race_concept_id_fk_domain,
    person_race_concept_id_is_standard_valid_concept,
    person_race_concept_id_standard_concept_record_completeness,
    person_race_source_concept_id_is_foreign_key,
    person_year_of_birth_is_required,
  )
);

WITH ids AS (
  SELECT *
  FROM stg.patient_ids
)
SELECT
  ids.person_id,
  CASE UPPER(p.gender_source_value)
    WHEN 'M' THEN 8507
    WHEN 'MALE' THEN 8507
    WHEN 'F' THEN 8532
    WHEN 'FEMALE' THEN 8532
    ELSE 0
  END AS gender_concept_id,
  CAST(EXTRACT(YEAR FROM p.birth_date) AS INTEGER) AS year_of_birth,
  CAST(EXTRACT(MONTH FROM p.birth_date) AS INTEGER) AS month_of_birth,
  CAST(EXTRACT(DAY FROM p.birth_date) AS INTEGER) AS day_of_birth,
  CAST(p.birth_date AS TIMESTAMP) AS birth_datetime,
  CASE UPPER(p.race_source_value)
    WHEN 'WHITE' THEN 8527
    WHEN 'BLACK' THEN 8516
    WHEN 'ASIAN' THEN 8515
    WHEN 'NATIVE' THEN 8657
    ELSE 0
  END AS race_concept_id,
  CASE UPPER(p.ethnicity_source_value)
    WHEN 'HISPANIC' THEN 38003563
    WHEN 'NONHISPANIC' THEN 38003564
    ELSE 0
  END AS ethnicity_concept_id,
  loc.location_id,
  CAST(NULL AS INTEGER) AS provider_id,
  CAST(NULL AS INTEGER) AS care_site_id,
  p.patient_id AS person_source_value,
  p.gender_source_value,
  0 AS gender_source_concept_id,
  p.race_source_value,
  0 AS race_source_concept_id,
  p.ethnicity_source_value,
  0 AS ethnicity_source_concept_id
FROM stg.patients AS p
JOIN ids
  ON p.patient_id = ids.patient_id
LEFT JOIN stg.patient_locations AS loc
  ON p.patient_id = loc.patient_id;
