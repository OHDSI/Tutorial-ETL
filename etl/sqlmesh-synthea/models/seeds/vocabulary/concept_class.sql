MODEL (
  name vocab.concept_class,
  kind SEED (
    path '$root/../../data/vocabulary/concept_class.csv'
  ),
  columns (
    concept_class_id TEXT,
    concept_class_name TEXT,
    concept_class_concept_id INT
  )
)