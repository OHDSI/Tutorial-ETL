MODEL (
  name synthea.conditions,
  kind SEED (
    path '$root/../../data/syntheaRaw/conditions.csv'
  ),
  columns (
    START TIMESTAMP,
    STOP TIMESTAMP,
    PATIENT TEXT,
    ENCOUNTER TEXT,
    SYSTEM TEXT,
    CODE TEXT,
    DESCRIPTION TEXT
  )
)
