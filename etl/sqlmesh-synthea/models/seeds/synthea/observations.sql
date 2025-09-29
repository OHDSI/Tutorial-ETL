MODEL (
  name synthea.observations,
  kind SEED (
    path '$root/../../data/syntheaRaw/observations.csv'
  ),
  columns (
    DATE TIMESTAMP,
    PATIENT TEXT,
    ENCOUNTER TEXT,
    CATEGORY TEXT,
    CODE TEXT,
    DESCRIPTION TEXT,
    VALUE TEXT,
    UNITS TEXT,
    TYPE TEXT
  )
)
