MODEL (
  name vocab.concept,
  kind SEED (
    path '$root/../../data/vocabulary/concept.csv'
  ),
  columns (
    concept_id INTEGER,
    concept_name TEXT,
    domain_id TEXT,
    vocabulary_id TEXT,
    concept_class_id TEXT,
    standard_concept TEXT,
    concept_code TEXT,
    valid_start_date DATE,
    valid_end_date DATE,
    invalid_reason TEXT
  )
)
