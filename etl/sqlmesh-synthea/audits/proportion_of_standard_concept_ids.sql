AUDIT (
  name PROPORTION_OF_STANDARD_CONCEPT_IDS,
  defaults (
    threshold = 0.8 /* Default threshold is 80% */
  )
);

SELECT
  1
FROM (
    SELECT
      SUM(CASE WHEN @column <> 0 AND NOT @column IS NULL THEN 1 ELSE 0 END)::REAL / COUNT(*) AS proportion
    FROM @this_model
)
WHERE
  proportion < @threshold