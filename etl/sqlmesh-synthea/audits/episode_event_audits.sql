-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.episode_event,
--   audits (
--     episode_event_episode_event_field_concept_id_is_required,
--     episode_event_episode_event_field_concept_id_is_foreign_key,
--     episode_event_episode_event_field_concept_id_fk_domain,
--     episode_event_episode_event_field_concept_id_is_standard_valid_concept,
--     episode_event_episode_id_is_required,
--     episode_event_episode_id_is_foreign_key,
--     episode_event_event_id_is_required,
--   )
-- );

-- Description: Check for NULLs in required field 'EPISODE_EVENT.EPISODE_EVENT_FIELD_CONCEPT_ID'.
AUDIT (
  name episode_event_episode_event_field_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.EPISODE_EVENT WHERE EPISODE_EVENT_FIELD_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'EPISODE_EVENT.EPISODE_EVENT_FIELD_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name episode_event_episode_event_field_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.EPISODE_EVENT c
LEFT JOIN vocab.CONCEPT p ON c.EPISODE_EVENT_FIELD_CONCEPT_ID = p.CONCEPT_ID
WHERE c.EPISODE_EVENT_FIELD_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'EPISODE_EVENT.EPISODE_EVENT_FIELD_CONCEPT_ID' belong to the 'Metadata' domain.
        AUDIT (
          name episode_event_episode_event_field_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.EPISODE_EVENT t
JOIN vocab.CONCEPT c ON t.EPISODE_EVENT_FIELD_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Metadata';;

-- Description: Check that concepts in 'EPISODE_EVENT.EPISODE_EVENT_FIELD_CONCEPT_ID' are standard and valid.
        AUDIT (
          name episode_event_episode_event_field_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.EPISODE_EVENT t
LEFT JOIN vocab.CONCEPT c ON t.EPISODE_EVENT_FIELD_CONCEPT_ID = c.concept_id
WHERE t.EPISODE_EVENT_FIELD_CONCEPT_ID IS NOT NULL
  AND t.EPISODE_EVENT_FIELD_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for NULLs in required field 'EPISODE_EVENT.EPISODE_ID'.
AUDIT (
  name episode_event_episode_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.EPISODE_EVENT WHERE EPISODE_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'EPISODE_EVENT.EPISODE_ID' pointing to 'EPISODE.EPISODE_ID'.
        AUDIT (
          name episode_event_episode_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.EPISODE_EVENT c
LEFT JOIN omop.EPISODE p ON c.EPISODE_ID = p.EPISODE_ID
WHERE c.EPISODE_ID IS NOT NULL AND p.EPISODE_ID IS NULL;;

-- Description: Check for NULLs in required field 'EPISODE_EVENT.EVENT_ID'.
AUDIT (
  name episode_event_event_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.EPISODE_EVENT WHERE EVENT_ID IS NULL;

