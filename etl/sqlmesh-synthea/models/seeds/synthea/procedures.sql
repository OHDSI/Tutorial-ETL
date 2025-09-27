MODEL (
  name synthea.procedures,
  kind SEED (
    path '$root/../../data/syntheaRaw/procedures.csv'
  ),
  columns (
    START TIMESTAMP,
    STOP TIMESTAMP,
    PATIENT TEXT,
    ENCOUNTER TEXT,
    SYSTEM TEXT,
    CODE TEXT,
    DESCRIPTION TEXT,
    BASE_COST DOUBLE,
    REASONCODE TEXT,
    REASONDESCRIPTION TEXT
  )
)
