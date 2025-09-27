MODEL (
  name synthea.immunizations,
  kind SEED (
    path '$root/../../data/syntheaRaw/immunizations.csv'
  ),
  columns (
    DATE TIMESTAMP,
    PATIENT TEXT,
    ENCOUNTER TEXT,
    CODE TEXT,
    DESCRIPTION TEXT,
    BASE_COST DOUBLE
  )
)
