MODEL (
  name synthea.payer_transitions,
  kind SEED (
    path '$root/../../data/syntheaRaw/payer_transitions.csv'
  ),
  columns (
    PATIENT TEXT,
    MEMBERID TEXT,
    START_DATE DATE,
    END_DATE DATE,
    PAYER TEXT,
    SECONDARY_PAYER TEXT,
    PLAN_OWNERSHIP TEXT,
    OWNER_NAME TEXT
  )
)
