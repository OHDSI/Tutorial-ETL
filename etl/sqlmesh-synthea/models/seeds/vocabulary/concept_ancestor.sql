MODEL (
  name vocab.concept_ancestor,
  kind SEED (
    path '$root/../../data/vocabulary/concept_ancestor.csv'
  ),
  columns (
    ancestor_concept_id INTEGER,
    descendant_concept_id INTEGER,
    min_levels_of_separation INTEGER,
    max_levels_of_separation INTEGER
  )
)
