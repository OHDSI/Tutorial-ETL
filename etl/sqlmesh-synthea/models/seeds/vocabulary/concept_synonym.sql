MODEL (
  name vocab.concept_synonym,
  kind SEED (
    path '$root/../../data/vocabulary/concept_synonym.csv'
  ),
  columns (
    concept_id INT,
    concept_synonym_name TEXT,
    language_concept_id INT
  )
)