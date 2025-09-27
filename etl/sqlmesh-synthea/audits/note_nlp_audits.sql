-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.note_nlp,
--   depends_on (
--     vocab.concept,
--   ),
--   audits (
--     note_nlp_lexical_variant_is_required,
--     note_nlp_nlp_date_is_required,
--     note_nlp_note_id_is_required,
--     note_nlp_note_nlp_concept_id_is_foreign_key,
--     note_nlp_note_nlp_concept_id_is_standard_valid_concept,
--     note_nlp_note_nlp_id_is_required,
--     note_nlp_note_nlp_id_is_primary_key,
--     note_nlp_note_nlp_source_concept_id_is_foreign_key,
--     note_nlp_section_concept_id_is_foreign_key,
--     note_nlp_section_concept_id_is_standard_valid_concept,
--   )
-- );

-- Description: Check for NULLs in required field 'NOTE_NLP.LEXICAL_VARIANT'.
AUDIT (
  name note_nlp_lexical_variant_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.NOTE_NLP WHERE LEXICAL_VARIANT IS NULL;

-- Description: Check for NULLs in required field 'NOTE_NLP.NLP_DATE'.
AUDIT (
  name note_nlp_nlp_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.NOTE_NLP WHERE NLP_DATE IS NULL;

-- Description: Check for NULLs in required field 'NOTE_NLP.NOTE_ID'.
AUDIT (
  name note_nlp_note_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.NOTE_NLP WHERE NOTE_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'NOTE_NLP.NOTE_NLP_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name note_nlp_note_nlp_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.NOTE_NLP c
LEFT JOIN vocab.concept p ON c.NOTE_NLP_CONCEPT_ID = p.CONCEPT_ID
WHERE c.NOTE_NLP_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'NOTE_NLP.NOTE_NLP_CONCEPT_ID' are standard and valid.
        AUDIT (
          name note_nlp_note_nlp_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.NOTE_NLP t
LEFT JOIN vocab.concept c ON t.NOTE_NLP_CONCEPT_ID = c.concept_id
WHERE t.NOTE_NLP_CONCEPT_ID IS NOT NULL
  AND t.NOTE_NLP_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for NULLs in required field 'NOTE_NLP.NOTE_NLP_ID'.
AUDIT (
  name note_nlp_note_nlp_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.NOTE_NLP WHERE NOTE_NLP_ID IS NULL;

-- Description: Check for duplicate values in primary key field 'NOTE_NLP.NOTE_NLP_ID'.
        AUDIT (
          name note_nlp_note_nlp_id_is_primary_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT NOTE_NLP_ID, COUNT(*)
FROM omop.NOTE_NLP
WHERE NOTE_NLP_ID IS NOT NULL
GROUP BY NOTE_NLP_ID
HAVING COUNT(*) > 1;;

-- Description: Check for orphaned foreign keys in 'NOTE_NLP.NOTE_NLP_SOURCE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name note_nlp_note_nlp_source_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.NOTE_NLP c
LEFT JOIN vocab.concept p ON c.NOTE_NLP_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.NOTE_NLP_SOURCE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'NOTE_NLP.SECTION_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name note_nlp_section_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.NOTE_NLP c
LEFT JOIN vocab.concept p ON c.SECTION_CONCEPT_ID = p.CONCEPT_ID
WHERE c.SECTION_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'NOTE_NLP.SECTION_CONCEPT_ID' are standard and valid.
        AUDIT (
          name note_nlp_section_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.NOTE_NLP t
LEFT JOIN vocab.concept c ON t.SECTION_CONCEPT_ID = c.concept_id
WHERE t.SECTION_CONCEPT_ID IS NOT NULL
  AND t.SECTION_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

