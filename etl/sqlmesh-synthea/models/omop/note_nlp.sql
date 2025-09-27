MODEL (
  name omop.note_nlp,
  kind FULL,
  description "The NOTE_NLP table encodes all output of NLP on clinical notes. Each row represents a single extracted term.",
  columns (
    note_nlp_id BIGINT,
    note_id BIGINT,
    section_concept_id INT,
    snippet TEXT,
    "offset" TEXT,
    lexical_variant TEXT,
    note_nlp_concept_id INT,
    note_nlp_source_concept_id INT,
    nlp_system TEXT,
    nlp_date DATE,
    nlp_datetime TIMESTAMP,
    term_exists TEXT,
    term_temporal TEXT,
    term_modifiers TEXT
  ),
  depends_on (
    vocab.concept,
  ),
  audits (
    note_nlp_lexical_variant_is_required,
    note_nlp_nlp_date_is_required,
    note_nlp_note_id_is_required,
    note_nlp_note_nlp_concept_id_is_foreign_key,
    note_nlp_note_nlp_concept_id_is_standard_valid_concept,
    note_nlp_note_nlp_id_is_required,
    note_nlp_note_nlp_id_is_primary_key,
    note_nlp_note_nlp_source_concept_id_is_foreign_key,
    note_nlp_section_concept_id_is_foreign_key,
    note_nlp_section_concept_id_is_standard_valid_concept
  )
);

/* Note: Requires NLP processing on the NOTE table, which is empty in this ETL. */ /* Creating an empty table structure for compatibility. */
SELECT
  NULL::BIGINT AS note_nlp_id,
  NULL::BIGINT AS note_id,
  NULL::INT AS section_concept_id,
  NULL::TEXT AS snippet,
  NULL::TEXT AS "offset",
  NULL::TEXT AS lexical_variant,
  NULL::INT AS note_nlp_concept_id,
  NULL::INT AS note_nlp_source_concept_id,
  NULL::TEXT AS nlp_system,
  NULL::DATE AS nlp_date,
  NULL::TIMESTAMP AS nlp_datetime,
  NULL::TEXT AS term_exists,
  NULL::TEXT AS term_temporal,
  NULL::TEXT AS term_modifiers
WHERE
  1 = 0