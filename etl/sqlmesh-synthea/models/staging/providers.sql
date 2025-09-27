MODEL (
  name stg.providers,
  kind FULL,
  description 'Provider attributes with deterministic provider_id assignment',
  columns (
    provider_id BIGINT,
    provider_source_value TEXT,
    organization_id TEXT,
    provider_name TEXT,
    gender_source_value TEXT,
    specialty_source_value TEXT,
    gender_concept_id INT,
    specialty_concept_id INT
  )
);

WITH base AS (
  SELECT
    Id AS provider_source_value,
    ORGANIZATION AS organization_id,
    NAME AS provider_name,
    UPPER(TRIM(GENDER)) AS gender_source_value,
    SPECIALITY AS specialty_source_value
  FROM synthea.providers
)
SELECT
  ROW_NUMBER() OVER (ORDER BY provider_source_value) AS provider_id,
  provider_source_value,
  organization_id,
  provider_name,
  gender_source_value,
  specialty_source_value,
  CASE gender_source_value
    WHEN 'M' THEN 8507
    WHEN 'F' THEN 8532
    ELSE 0
  END AS gender_concept_id,
  38004446 AS specialty_concept_id
FROM base;
