MODEL (
  name omop.drug_era,
  kind FULL,
  columns (
    drug_era_id BIGINT,
    person_id BIGINT,
    drug_concept_id INT,
    drug_era_start_date DATE,
    drug_era_end_date DATE,
    drug_exposure_count BIGINT,
    gap_days BIGINT
  )
);

WITH ingredient_exposures AS (
  SELECT
    de.person_id,
    ca.ancestor_concept_id AS ingredient_concept_id,
    de.drug_exposure_start_date AS exposure_start_date,
    CASE
      WHEN de.drug_exposure_end_date IS NOT NULL THEN de.drug_exposure_end_date
      WHEN COALESCE(de.days_supply, 0) > 0 THEN de.drug_exposure_start_date + CAST(de.days_supply AS INTEGER) * INTERVAL '1 day'
      ELSE de.drug_exposure_start_date + INTERVAL '1 day'
    END AS exposure_end_date
  FROM omop.drug_exposure AS de
  JOIN vocab.concept_ancestor AS ca
    ON ca.descendant_concept_id = de.drug_concept_id
  JOIN vocab.concept AS c
    ON c.concept_id = ca.ancestor_concept_id
  WHERE c.vocabulary_id = 'RxNorm'
    AND c.concept_class_id = 'Ingredient'
    AND de.drug_concept_id <> 0
),
normalized AS (
  SELECT
    person_id,
    ingredient_concept_id,
    exposure_start_date,
    GREATEST(exposure_start_date, exposure_end_date) AS exposure_end_date
  FROM ingredient_exposures
),
ordered AS (
  SELECT
    *,
    CASE
      WHEN LAG(exposure_end_date) OVER (PARTITION BY person_id, ingredient_concept_id ORDER BY exposure_start_date, exposure_end_date) IS NULL THEN 1
      WHEN DATEDIFF('day', LAG(exposure_end_date) OVER (PARTITION BY person_id, ingredient_concept_id ORDER BY exposure_start_date, exposure_end_date), exposure_start_date) > 30 THEN 1
      ELSE 0
    END AS new_era_flag
  FROM normalized
),
era_assignment AS (
  SELECT
    *,
    SUM(new_era_flag) OVER (
      PARTITION BY person_id, ingredient_concept_id
      ORDER BY exposure_start_date, exposure_end_date
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS era_group
  FROM ordered
),
eras AS (
  SELECT
    person_id,
    ingredient_concept_id,
    era_group,
    MIN(exposure_start_date) AS drug_era_start_date,
    MAX(exposure_end_date) AS drug_era_end_date,
    COUNT(*) AS drug_exposure_count,
    SUM(DATEDIFF('day', exposure_start_date, exposure_end_date)) AS days_exposed
  FROM era_assignment
  GROUP BY person_id, ingredient_concept_id, era_group
)
SELECT
  ROW_NUMBER() OVER (ORDER BY person_id, ingredient_concept_id, drug_era_start_date) AS drug_era_id,
  person_id,
  ingredient_concept_id AS drug_concept_id,
  drug_era_start_date,
  drug_era_end_date,
  drug_exposure_count,
  GREATEST(DATEDIFF('day', drug_era_start_date, drug_era_end_date) - days_exposed, 0) AS gap_days
FROM eras;
