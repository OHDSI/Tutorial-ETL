MODEL (
  name vocab.vocabulary,
  kind SEED (
    path '$root/../../data/vocabulary/vocabulary.csv'
  ),
  columns (
    vocabulary_id TEXT,
    vocabulary_name TEXT,
    vocabulary_reference TEXT,
    vocabulary_version TEXT,
    vocabulary_concept_id INTEGER
  )
)
