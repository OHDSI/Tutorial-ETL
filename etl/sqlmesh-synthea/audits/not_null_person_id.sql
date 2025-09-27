AUDIT (
  name not_null_person_id,
  dialect duckdb
);

SELECT
  COUNT(*) AS failures
FROM omop.person
WHERE person_id IS NULL;
