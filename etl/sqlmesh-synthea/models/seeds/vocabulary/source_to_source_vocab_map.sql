MODEL (
  name vocab.source_to_source_vocab_map,
  kind SEED (
    path '$root/../../data/vocabulary/source_to_source_vocab_map.csv'
  ),
  columns (
    source_code TEXT,
    source_concept_id INTEGER,
    source_code_description TEXT,
    source_vocabulary_id TEXT,
    source_domain_id TEXT,
    source_concept_class_id TEXT,
    source_valid_start_date DATE,
    source_valid_end_date DATE,
    source_invalid_reason TEXT,
    target_concept_id INTEGER,
    target_concept_name TEXT,
    target_vocabulary_id TEXT,
    target_domain_id TEXT,
    target_concept_class_id TEXT,
    target_invalid_reason TEXT
  )
)
