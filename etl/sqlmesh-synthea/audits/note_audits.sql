-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.note,
--   audits (
--     person_completeness_note,
--     note_encoding_concept_id_is_required,
--     note_encoding_concept_id_is_foreign_key,
--     note_encoding_concept_id_is_standard_valid_concept,
--     note_language_concept_id_is_required,
--     note_language_concept_id_is_foreign_key,
--     note_language_concept_id_is_standard_valid_concept,
--     note_note_class_concept_id_is_required,
--     note_note_class_concept_id_is_foreign_key,
--     note_note_class_concept_id_is_standard_valid_concept,
--     note_note_date_is_required,
--     note_note_date_after_birth,
--     note_note_datetime_after_birth,
--     note_note_event_field_concept_id_is_foreign_key,
--     note_note_event_field_concept_id_is_standard_valid_concept,
--     note_note_id_is_required,
--     note_note_id_is_primary_key,
--     note_note_text_is_required,
--     note_note_type_concept_id_is_required,
--     note_note_type_concept_id_is_foreign_key,
--     note_note_type_concept_id_fk_domain,
--     note_note_type_concept_id_is_standard_valid_concept,
--     note_person_id_is_required,
--     note_person_id_is_foreign_key,
--     note_provider_id_is_foreign_key,
--     note_visit_detail_id_is_foreign_key,
--     note_visit_occurrence_id_is_foreign_key,
--   )
-- );

-- Description: Check for persons missing from table 'NOTE'.
        AUDIT (
          name person_completeness_note,
          dialect duckdb,
          blocking FALSE
        );
        SELECT p.person_id
FROM omop.person p
LEFT JOIN omop.NOTE e ON p.person_id = e.person_id
WHERE e.person_id IS NULL;;

-- Description: Check for NULLs in required field 'NOTE.ENCODING_CONCEPT_ID'.
AUDIT (
  name note_encoding_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.NOTE WHERE ENCODING_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'NOTE.ENCODING_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name note_encoding_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.NOTE c
LEFT JOIN vocab.CONCEPT p ON c.ENCODING_CONCEPT_ID = p.CONCEPT_ID
WHERE c.ENCODING_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'NOTE.ENCODING_CONCEPT_ID' are standard and valid.
        AUDIT (
          name note_encoding_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.NOTE t
LEFT JOIN vocab.CONCEPT c ON t.ENCODING_CONCEPT_ID = c.concept_id
WHERE t.ENCODING_CONCEPT_ID IS NOT NULL
  AND t.ENCODING_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for NULLs in required field 'NOTE.LANGUAGE_CONCEPT_ID'.
AUDIT (
  name note_language_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.NOTE WHERE LANGUAGE_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'NOTE.LANGUAGE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name note_language_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.NOTE c
LEFT JOIN vocab.CONCEPT p ON c.LANGUAGE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.LANGUAGE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'NOTE.LANGUAGE_CONCEPT_ID' are standard and valid.
        AUDIT (
          name note_language_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.NOTE t
LEFT JOIN vocab.CONCEPT c ON t.LANGUAGE_CONCEPT_ID = c.concept_id
WHERE t.LANGUAGE_CONCEPT_ID IS NOT NULL
  AND t.LANGUAGE_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for NULLs in required field 'NOTE.NOTE_CLASS_CONCEPT_ID'.
AUDIT (
  name note_note_class_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.NOTE WHERE NOTE_CLASS_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'NOTE.NOTE_CLASS_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name note_note_class_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.NOTE c
LEFT JOIN vocab.CONCEPT p ON c.NOTE_CLASS_CONCEPT_ID = p.CONCEPT_ID
WHERE c.NOTE_CLASS_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'NOTE.NOTE_CLASS_CONCEPT_ID' are standard and valid.
        AUDIT (
          name note_note_class_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.NOTE t
LEFT JOIN vocab.CONCEPT c ON t.NOTE_CLASS_CONCEPT_ID = c.concept_id
WHERE t.NOTE_CLASS_CONCEPT_ID IS NOT NULL
  AND t.NOTE_CLASS_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for NULLs in required field 'NOTE.NOTE_DATE'.
AUDIT (
  name note_note_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.NOTE WHERE NOTE_DATE IS NULL;

-- Description: Check that date 'NOTE.NOTE_DATE' is after person's birth date.
        AUDIT (
          name note_note_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.NOTE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.NOTE_DATE < p.birth_datetime;;

-- Description: Check that date 'NOTE.NOTE_DATETIME' is after person's birth date.
        AUDIT (
          name note_note_datetime_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.NOTE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.NOTE_DATETIME < p.birth_datetime;;

-- Description: Check for orphaned foreign keys in 'NOTE.NOTE_EVENT_FIELD_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name note_note_event_field_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.NOTE c
LEFT JOIN vocab.CONCEPT p ON c.NOTE_EVENT_FIELD_CONCEPT_ID = p.CONCEPT_ID
WHERE c.NOTE_EVENT_FIELD_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'NOTE.NOTE_EVENT_FIELD_CONCEPT_ID' are standard and valid.
        AUDIT (
          name note_note_event_field_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.NOTE t
LEFT JOIN vocab.CONCEPT c ON t.NOTE_EVENT_FIELD_CONCEPT_ID = c.concept_id
WHERE t.NOTE_EVENT_FIELD_CONCEPT_ID IS NOT NULL
  AND t.NOTE_EVENT_FIELD_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for NULLs in required field 'NOTE.NOTE_ID'.
AUDIT (
  name note_note_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.NOTE WHERE NOTE_ID IS NULL;

-- Description: Check for duplicate values in primary key field 'NOTE.NOTE_ID'.
        AUDIT (
          name note_note_id_is_primary_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT NOTE_ID, COUNT(*)
FROM omop.NOTE
WHERE NOTE_ID IS NOT NULL
GROUP BY NOTE_ID
HAVING COUNT(*) > 1;;

-- Description: Check for NULLs in required field 'NOTE.NOTE_TEXT'.
AUDIT (
  name note_note_text_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.NOTE WHERE NOTE_TEXT IS NULL;

-- Description: Check for NULLs in required field 'NOTE.NOTE_TYPE_CONCEPT_ID'.
AUDIT (
  name note_note_type_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.NOTE WHERE NOTE_TYPE_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'NOTE.NOTE_TYPE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name note_note_type_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.NOTE c
LEFT JOIN vocab.CONCEPT p ON c.NOTE_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.NOTE_TYPE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'NOTE.NOTE_TYPE_CONCEPT_ID' belong to the 'Type Concept' domain.
        AUDIT (
          name note_note_type_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.NOTE t
JOIN vocab.CONCEPT c ON t.NOTE_TYPE_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Type Concept';;

-- Description: Check that concepts in 'NOTE.NOTE_TYPE_CONCEPT_ID' are standard and valid.
        AUDIT (
          name note_note_type_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.NOTE t
LEFT JOIN vocab.CONCEPT c ON t.NOTE_TYPE_CONCEPT_ID = c.concept_id
WHERE t.NOTE_TYPE_CONCEPT_ID IS NOT NULL
  AND t.NOTE_TYPE_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for NULLs in required field 'NOTE.PERSON_ID'.
AUDIT (
  name note_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.NOTE WHERE PERSON_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'NOTE.PERSON_ID' pointing to 'PERSON.PERSON_ID'.
        AUDIT (
          name note_person_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.NOTE c
LEFT JOIN omop.PERSON p ON c.PERSON_ID = p.PERSON_ID
WHERE c.PERSON_ID IS NOT NULL AND p.PERSON_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'NOTE.PROVIDER_ID' pointing to 'PROVIDER.PROVIDER_ID'.
        AUDIT (
          name note_provider_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.NOTE c
LEFT JOIN omop.PROVIDER p ON c.PROVIDER_ID = p.PROVIDER_ID
WHERE c.PROVIDER_ID IS NOT NULL AND p.PROVIDER_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'NOTE.VISIT_DETAIL_ID' pointing to 'VISIT_DETAIL.VISIT_DETAIL_ID'.
        AUDIT (
          name note_visit_detail_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.NOTE c
LEFT JOIN omop.VISIT_DETAIL p ON c.VISIT_DETAIL_ID = p.VISIT_DETAIL_ID
WHERE c.VISIT_DETAIL_ID IS NOT NULL AND p.VISIT_DETAIL_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'NOTE.VISIT_OCCURRENCE_ID' pointing to 'VISIT_OCCURRENCE.VISIT_OCCURRENCE_ID'.
        AUDIT (
          name note_visit_occurrence_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.NOTE c
LEFT JOIN omop.VISIT_OCCURRENCE p ON c.VISIT_OCCURRENCE_ID = p.VISIT_OCCURRENCE_ID
WHERE c.VISIT_OCCURRENCE_ID IS NOT NULL AND p.VISIT_OCCURRENCE_ID IS NULL;;

