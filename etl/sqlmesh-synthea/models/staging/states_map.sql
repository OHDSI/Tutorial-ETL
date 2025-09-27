MODEL (
  name stg.states_map,
  kind FULL,
  description 'Reference mapping between US state name and postal abbreviation',
  columns (
    state_name TEXT,
    state_abbreviation TEXT
  )
);

SELECT
  UPPER(TRIM(state)) AS state_name,
  UPPER(TRIM(state_abbreviation)) AS state_abbreviation
FROM reference.states_map;
