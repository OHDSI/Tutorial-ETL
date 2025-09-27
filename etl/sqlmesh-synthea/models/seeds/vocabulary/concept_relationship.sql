MODEL (
  name vocab.concept_relationship,
  kind SEED (
    path '$root/../../data/vocabulary/concept_relationship.csv'
  ),
  columns (
    concept_id_1 INTEGER,
    concept_id_2 INTEGER,
    relationship_id TEXT,
    valid_start_date DATE,
    valid_end_date DATE,
    invalid_reason TEXT
  )
)
