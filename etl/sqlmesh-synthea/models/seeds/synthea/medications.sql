MODEL (
  name synthea.medications,
  kind SEED (
    path '$root/../../data/syntheaRaw/medications.csv'
  ),
  columns (
    START TIMESTAMP,
    STOP TIMESTAMP,
    PATIENT TEXT,
    PAYER TEXT,
    ENCOUNTER TEXT,
    CODE TEXT,
    DESCRIPTION TEXT,
    BASE_COST DOUBLE,
    PAYER_COVERAGE DOUBLE,
    DISPENSES DOUBLE,
    TOTALCOST DOUBLE,
    REASONCODE TEXT,
    REASONDESCRIPTION TEXT
  )
)
