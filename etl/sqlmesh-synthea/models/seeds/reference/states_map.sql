MODEL (
  name reference.states_map,
  kind SEED (
    path '$root/seeds/states_map.csv'
  ),
  columns (
    state TEXT,
    state_abbreviation TEXT
  )
)
