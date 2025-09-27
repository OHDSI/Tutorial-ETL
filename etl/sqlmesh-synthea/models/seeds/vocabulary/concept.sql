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
  ),
  audits (
    concept_concept_class_id_is_required,
    concept_concept_class_id_is_foreign_key,
    concept_concept_code_is_required,
    concept_concept_id_is_required,
    concept_concept_id_is_primary_key,
    concept_concept_name_is_required,
    concept_domain_id_is_required,
    concept_domain_id_is_foreign_key,
    concept_valid_end_date_is_required,
    concept_valid_start_date_is_required,
    concept_valid_start_date_start_before_end,
    concept_vocabulary_id_is_required,
    concept_vocabulary_id_is_foreign_key,
  )
)
