-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.episode,
--   depends_on (
--     vocab.concept,
--     omop.person,
--   ),
--   audits (
--     episode_episode_concept_id_is_required,
--     episode_episode_concept_id_is_foreign_key,
--     episode_episode_concept_id_fk_domain,
--     episode_episode_concept_id_is_standard_valid_concept,
--     episode_episode_concept_id_standard_concept_record_completeness,
--     episode_episode_end_date_after_birth,
--     episode_episode_end_datetime_after_birth,
--     episode_episode_id_is_required,
--     episode_episode_id_is_primary_key,
--     episode_episode_object_concept_id_is_required,
--     episode_episode_object_concept_id_is_foreign_key,
--     episode_episode_source_concept_id_is_foreign_key,
--     episode_episode_start_date_is_required,
--     episode_episode_start_date_start_before_end,
--     episode_episode_start_date_after_birth,
--     episode_episode_start_datetime_start_before_end,
--     episode_episode_start_datetime_after_birth,
--     episode_episode_type_concept_id_is_required,
--     episode_episode_type_concept_id_is_foreign_key,
--     episode_episode_type_concept_id_fk_domain,
--     episode_episode_type_concept_id_is_standard_valid_concept,
--     episode_person_id_is_required,
--     episode_person_id_is_foreign_key,
--   )
-- );

-- Description: Check for NULLs in required field 'EPISODE.EPISODE_CONCEPT_ID'.
AUDIT (
  name episode_episode_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.EPISODE WHERE EPISODE_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'EPISODE.EPISODE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name episode_episode_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.EPISODE c
LEFT JOIN vocab.concept p ON c.EPISODE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.EPISODE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'EPISODE.EPISODE_CONCEPT_ID' belong to the 'Episode' domain.
        AUDIT (
          name episode_episode_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.EPISODE t
JOIN vocab.concept c ON t.EPISODE_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Episode';;

-- Description: Check that concepts in 'EPISODE.EPISODE_CONCEPT_ID' are standard and valid.
        AUDIT (
          name episode_episode_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.EPISODE t
LEFT JOIN vocab.concept c ON t.EPISODE_CONCEPT_ID = c.concept_id
WHERE t.EPISODE_CONCEPT_ID IS NOT NULL
  AND t.EPISODE_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'EPISODE.EPISODE_CONCEPT_ID'.
AUDIT (
  name episode_episode_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.EPISODE WHERE EPISODE_CONCEPT_ID = 0;

-- Description: Check that date 'EPISODE.EPISODE_END_DATE' is after person's birth date.
        AUDIT (
          name episode_episode_end_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.EPISODE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.EPISODE_END_DATE < p.birth_datetime;;

-- Description: Check that date 'EPISODE.EPISODE_END_DATETIME' is after person's birth date.
        AUDIT (
          name episode_episode_end_datetime_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.EPISODE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.EPISODE_END_DATETIME < p.birth_datetime;;

-- Description: Check for NULLs in required field 'EPISODE.EPISODE_ID'.
AUDIT (
  name episode_episode_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.EPISODE WHERE EPISODE_ID IS NULL;

-- Description: Check for duplicate values in primary key field 'EPISODE.EPISODE_ID'.
        AUDIT (
          name episode_episode_id_is_primary_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT EPISODE_ID, COUNT(*)
FROM omop.EPISODE
WHERE EPISODE_ID IS NOT NULL
GROUP BY EPISODE_ID
HAVING COUNT(*) > 1;;

-- Description: Check for NULLs in required field 'EPISODE.EPISODE_OBJECT_CONCEPT_ID'.
AUDIT (
  name episode_episode_object_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.EPISODE WHERE EPISODE_OBJECT_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'EPISODE.EPISODE_OBJECT_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name episode_episode_object_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.EPISODE c
LEFT JOIN vocab.concept p ON c.EPISODE_OBJECT_CONCEPT_ID = p.CONCEPT_ID
WHERE c.EPISODE_OBJECT_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'EPISODE.EPISODE_SOURCE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name episode_episode_source_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.EPISODE c
LEFT JOIN vocab.concept p ON c.EPISODE_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.EPISODE_SOURCE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'EPISODE.EPISODE_START_DATE'.
AUDIT (
  name episode_episode_start_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.EPISODE WHERE EPISODE_START_DATE IS NULL;

-- Description: Check that 'EPISODE.EPISODE_START_DATE' occurs before 'EPISODE.EPISODE_END_DATE'.
AUDIT (
  name episode_episode_start_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.EPISODE WHERE EPISODE_START_DATE > EPISODE_END_DATE;

-- Description: Check that date 'EPISODE.EPISODE_START_DATE' is after person's birth date.
        AUDIT (
          name episode_episode_start_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.EPISODE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.EPISODE_START_DATE < p.birth_datetime;;

-- Description: Check that 'EPISODE.EPISODE_START_DATETIME' occurs before 'EPISODE.EPISODE_END_DATETIME'.
AUDIT (
  name episode_episode_start_datetime_start_before_end,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.EPISODE WHERE EPISODE_START_DATETIME > EPISODE_END_DATETIME;

-- Description: Check that date 'EPISODE.EPISODE_START_DATETIME' is after person's birth date.
        AUDIT (
          name episode_episode_start_datetime_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.EPISODE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.EPISODE_START_DATETIME < p.birth_datetime;;

-- Description: Check for NULLs in required field 'EPISODE.EPISODE_TYPE_CONCEPT_ID'.
AUDIT (
  name episode_episode_type_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.EPISODE WHERE EPISODE_TYPE_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'EPISODE.EPISODE_TYPE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name episode_episode_type_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.EPISODE c
LEFT JOIN vocab.concept p ON c.EPISODE_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.EPISODE_TYPE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'EPISODE.EPISODE_TYPE_CONCEPT_ID' belong to the 'Type Concept' domain.
        AUDIT (
          name episode_episode_type_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.EPISODE t
JOIN vocab.concept c ON t.EPISODE_TYPE_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Type Concept';;

-- Description: Check that concepts in 'EPISODE.EPISODE_TYPE_CONCEPT_ID' are standard and valid.
        AUDIT (
          name episode_episode_type_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.EPISODE t
LEFT JOIN vocab.concept c ON t.EPISODE_TYPE_CONCEPT_ID = c.concept_id
WHERE t.EPISODE_TYPE_CONCEPT_ID IS NOT NULL
  AND t.EPISODE_TYPE_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for NULLs in required field 'EPISODE.PERSON_ID'.
AUDIT (
  name episode_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.EPISODE WHERE PERSON_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'EPISODE.PERSON_ID' pointing to 'PERSON.PERSON_ID'.
        AUDIT (
          name episode_person_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.EPISODE c
LEFT JOIN omop.PERSON p ON c.PERSON_ID = p.PERSON_ID
WHERE c.PERSON_ID IS NOT NULL AND p.PERSON_ID IS NULL;;

