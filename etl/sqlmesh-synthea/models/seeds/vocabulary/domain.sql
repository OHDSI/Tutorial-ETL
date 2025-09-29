MODEL (
  name vocab.domain,
  kind SEED (
    path '$root/../../data/vocabulary/domain.csv'
  ),
  columns (
    domain_id TEXT,
    domain_name TEXT,
    domain_concept_id INT
  )
)