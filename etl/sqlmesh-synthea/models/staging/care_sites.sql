MODEL (
  name stg.care_sites,
  kind FULL,
  description 'Deterministic care site identifiers derived from organizations',
  columns (
    care_site_id BIGINT,
    organization_id TEXT,
    name TEXT,
    city TEXT,
    state_name TEXT,
    zip TEXT
  )
);

SELECT
  ROW_NUMBER() OVER (ORDER BY organization_id) AS care_site_id,
  organization_id,
  name,
  city,
  state_name,
  zip
FROM stg.organizations;
