MODEL (
  name stg.payers,
  kind FULL,
  description 'Payer reference data from Synthea payers.csv',
  columns (
    payer_id TEXT,
    name TEXT,
    ownership TEXT,
    city TEXT,
    state TEXT,
    zip TEXT,
    phone TEXT
  )
);

SELECT
  Id AS payer_id,
  NAME AS name,
  OWNERSHIP AS ownership,
  CITY,
  STATE_HEADQUARTERED AS state,
  ZIP,
  PHONE
FROM synthea.payers;
