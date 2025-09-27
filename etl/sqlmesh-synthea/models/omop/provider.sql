MODEL (
  name omop.provider,
  kind FULL,
  columns (
    provider_id BIGINT,
    provider_name TEXT,
    npi TEXT,
    dea TEXT,
    specialty_concept_id INT,
    care_site_id BIGINT,
    year_of_birth INT,
    gender_concept_id INT,
    provider_source_value TEXT,
    specialty_source_value TEXT,
    specialty_source_concept_id INT,
    gender_source_value TEXT,
    gender_source_concept_id INT
  )
);

WITH providers AS (
  SELECT
    p.provider_id,
    p.provider_source_value,
    p.provider_name,
    p.gender_concept_id,
    p.gender_source_value,
    p.specialty_concept_id,
    p.specialty_source_value,
    cs.care_site_id
  FROM stg.providers AS p
  LEFT JOIN stg.care_sites AS cs
    ON p.organization_id = cs.organization_id
)
SELECT
  provider_id,
  provider_name,
  CAST(NULL AS TEXT) AS npi,
  CAST(NULL AS TEXT) AS dea,
  specialty_concept_id,
  care_site_id,
  CAST(NULL AS INTEGER) AS year_of_birth,
  gender_concept_id,
  provider_source_value,
  specialty_source_value,
  specialty_concept_id AS specialty_source_concept_id,
  gender_source_value,
  gender_concept_id AS gender_source_concept_id
FROM providers;
