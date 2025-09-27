AUDIT (
  name non_empty_visit_occurrence,
  dialect duckdb
);

SELECT
  CASE WHEN COUNT(*) = 0 THEN 1 ELSE 0 END AS failures
FROM omop.visit_occurrence;
