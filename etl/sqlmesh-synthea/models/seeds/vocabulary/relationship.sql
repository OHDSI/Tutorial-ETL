MODEL (
  name vocab.relationship,
  kind SEED (
    path '$root/../../data/vocabulary/relationship.csv'
  ),
  columns (
    relationship_id TEXT,
    relationship_name TEXT,
    is_hierarchical TEXT,
    defines_ancestry TEXT,
    reverse_relationship_id TEXT,
    relationship_concept_id INT
  )
)