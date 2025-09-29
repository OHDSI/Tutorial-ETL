-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.observation,
--   depends_on (
--     vocab.concept,
--     omop.person,
--     omop.provider,
--     omop.visit_detail,
--     omop.visit_occurrence,
--   ),
--   audits (
--     person_completeness_observation,
--     observation_obs_event_field_concept_id_is_foreign_key,
--     observation_obs_event_field_concept_id_is_standard_valid_concept,
--     observation_observation_concept_id_is_required,
--     observation_observation_concept_id_is_foreign_key,
--     observation_observation_concept_id_is_standard_valid_concept,
--     observation_observation_concept_id_standard_concept_record_completeness,
--     observation_observation_date_is_required,
--     observation_observation_date_after_birth,
--     observation_observation_datetime_after_birth,
--     observation_observation_id_is_required,
--     observation_observation_id_is_primary_key,
--     observation_observation_source_concept_id_is_foreign_key,
--     observation_observation_type_concept_id_is_required,
--     observation_observation_type_concept_id_is_foreign_key,
--     observation_observation_type_concept_id_fk_domain,
--     observation_observation_type_concept_id_is_standard_valid_concept,
--     observation_observation_type_concept_id_standard_concept_record_completeness,
--     observation_person_id_is_required,
--     observation_person_id_is_foreign_key,
--     observation_provider_id_is_foreign_key,
--     observation_qualifier_concept_id_is_foreign_key,
--     observation_qualifier_concept_id_is_standard_valid_concept,
--     observation_unit_concept_id_is_foreign_key,
--     observation_unit_concept_id_fk_domain,
--     observation_unit_concept_id_is_standard_valid_concept,
--     observation_unit_concept_id_standard_concept_record_completeness,
--     observation_value_as_concept_id_is_foreign_key,
--     observation_visit_detail_id_is_foreign_key,
--     observation_visit_occurrence_id_is_foreign_key,
--     observation_37393449_8840_0_low,
--     observation_37393449_8840_0_high,
--     observation_37393449_8753_0_low,
--     observation_37393449_8753_0_high,
--     observation_37397989_8840_0_low,
--     observation_37397989_8840_0_high,
--     observation_37397989_8753_0_low,
--     observation_37397989_8753_0_high,
--     observation_44809580_8840_0_low,
--     observation_44809580_8840_0_high,
--     observation_44809580_8753_0_low,
--     observation_44809580_8753_0_high,
--     observation_37392176_8749_0_low,
--     observation_37392176_8749_0_high,
--     observation_37392176_8840_0_low,
--     observation_37392176_8840_0_high,
--     observation_37392176_8751_0_low,
--     observation_37392176_8751_0_high,
--   )
-- );

-- Description: Check for persons missing from table 'OBSERVATION'.
        AUDIT (
          name person_completeness_observation,
          dialect duckdb,
          blocking FALSE
        );
        SELECT p.person_id
FROM omop.person p
LEFT JOIN omop.OBSERVATION e ON p.person_id = e.person_id
WHERE e.person_id IS NULL;;

-- Description: Check for orphaned foreign keys in 'OBSERVATION.OBS_EVENT_FIELD_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name observation_obs_event_field_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.OBSERVATION c
LEFT JOIN vocab.concept p ON c.OBS_EVENT_FIELD_CONCEPT_ID = p.CONCEPT_ID
WHERE c.OBS_EVENT_FIELD_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'OBSERVATION.OBS_EVENT_FIELD_CONCEPT_ID' are standard and valid.
        AUDIT (
          name observation_obs_event_field_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.OBSERVATION t
LEFT JOIN vocab.concept c ON t.OBS_EVENT_FIELD_CONCEPT_ID = c.concept_id
WHERE t.OBS_EVENT_FIELD_CONCEPT_ID IS NOT NULL
  AND t.OBS_EVENT_FIELD_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for NULLs in required field 'OBSERVATION.OBSERVATION_CONCEPT_ID'.
AUDIT (
  name observation_observation_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.OBSERVATION WHERE OBSERVATION_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'OBSERVATION.OBSERVATION_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name observation_observation_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.OBSERVATION c
LEFT JOIN vocab.concept p ON c.OBSERVATION_CONCEPT_ID = p.CONCEPT_ID
WHERE c.OBSERVATION_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'OBSERVATION.OBSERVATION_CONCEPT_ID' are standard and valid.
        AUDIT (
          name observation_observation_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.OBSERVATION t
LEFT JOIN vocab.concept c ON t.OBSERVATION_CONCEPT_ID = c.concept_id
WHERE t.OBSERVATION_CONCEPT_ID IS NOT NULL
  AND t.OBSERVATION_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'OBSERVATION.OBSERVATION_CONCEPT_ID'.
AUDIT (
  name observation_observation_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.OBSERVATION WHERE OBSERVATION_CONCEPT_ID = 0;

-- Description: Check for NULLs in required field 'OBSERVATION.OBSERVATION_DATE'.
AUDIT (
  name observation_observation_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.OBSERVATION WHERE OBSERVATION_DATE IS NULL;

-- Description: Check that date 'OBSERVATION.OBSERVATION_DATE' is after person's birth date.
        AUDIT (
          name observation_observation_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.OBSERVATION t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.OBSERVATION_DATE < p.birth_datetime;;

-- Description: Check that date 'OBSERVATION.OBSERVATION_DATETIME' is after person's birth date.
        AUDIT (
          name observation_observation_datetime_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.OBSERVATION t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.OBSERVATION_DATETIME < p.birth_datetime;;

-- Description: Check for NULLs in required field 'OBSERVATION.OBSERVATION_ID'.
AUDIT (
  name observation_observation_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.OBSERVATION WHERE OBSERVATION_ID IS NULL;

-- Description: Check for duplicate values in primary key field 'OBSERVATION.OBSERVATION_ID'.
        AUDIT (
          name observation_observation_id_is_primary_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT OBSERVATION_ID, COUNT(*)
FROM omop.OBSERVATION
WHERE OBSERVATION_ID IS NOT NULL
GROUP BY OBSERVATION_ID
HAVING COUNT(*) > 1;;

-- Description: Check for orphaned foreign keys in 'OBSERVATION.OBSERVATION_SOURCE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name observation_observation_source_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.OBSERVATION c
LEFT JOIN vocab.concept p ON c.OBSERVATION_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.OBSERVATION_SOURCE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'OBSERVATION.OBSERVATION_TYPE_CONCEPT_ID'.
AUDIT (
  name observation_observation_type_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.OBSERVATION WHERE OBSERVATION_TYPE_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'OBSERVATION.OBSERVATION_TYPE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name observation_observation_type_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.OBSERVATION c
LEFT JOIN vocab.concept p ON c.OBSERVATION_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.OBSERVATION_TYPE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'OBSERVATION.OBSERVATION_TYPE_CONCEPT_ID' belong to the 'Type Concept' domain.
        AUDIT (
          name observation_observation_type_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.OBSERVATION t
JOIN vocab.concept c ON t.OBSERVATION_TYPE_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Type Concept';;

-- Description: Check that concepts in 'OBSERVATION.OBSERVATION_TYPE_CONCEPT_ID' are standard and valid.
        AUDIT (
          name observation_observation_type_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.OBSERVATION t
LEFT JOIN vocab.concept c ON t.OBSERVATION_TYPE_CONCEPT_ID = c.concept_id
WHERE t.OBSERVATION_TYPE_CONCEPT_ID IS NOT NULL
  AND t.OBSERVATION_TYPE_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'OBSERVATION.OBSERVATION_TYPE_CONCEPT_ID'.
AUDIT (
  name observation_observation_type_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.OBSERVATION WHERE OBSERVATION_TYPE_CONCEPT_ID = 0;

-- Description: Check for NULLs in required field 'OBSERVATION.PERSON_ID'.
AUDIT (
  name observation_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.OBSERVATION WHERE PERSON_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'OBSERVATION.PERSON_ID' pointing to 'PERSON.PERSON_ID'.
        AUDIT (
          name observation_person_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.OBSERVATION c
LEFT JOIN omop.PERSON p ON c.PERSON_ID = p.PERSON_ID
WHERE c.PERSON_ID IS NOT NULL AND p.PERSON_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'OBSERVATION.PROVIDER_ID' pointing to 'PROVIDER.PROVIDER_ID'.
        AUDIT (
          name observation_provider_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.OBSERVATION c
LEFT JOIN omop.PROVIDER p ON c.PROVIDER_ID = p.PROVIDER_ID
WHERE c.PROVIDER_ID IS NOT NULL AND p.PROVIDER_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'OBSERVATION.QUALIFIER_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name observation_qualifier_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.OBSERVATION c
LEFT JOIN vocab.concept p ON c.QUALIFIER_CONCEPT_ID = p.CONCEPT_ID
WHERE c.QUALIFIER_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'OBSERVATION.QUALIFIER_CONCEPT_ID' are standard and valid.
        AUDIT (
          name observation_qualifier_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.OBSERVATION t
LEFT JOIN vocab.concept c ON t.QUALIFIER_CONCEPT_ID = c.concept_id
WHERE t.QUALIFIER_CONCEPT_ID IS NOT NULL
  AND t.QUALIFIER_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for orphaned foreign keys in 'OBSERVATION.UNIT_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name observation_unit_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.OBSERVATION c
LEFT JOIN vocab.concept p ON c.UNIT_CONCEPT_ID = p.CONCEPT_ID
WHERE c.UNIT_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'OBSERVATION.UNIT_CONCEPT_ID' belong to the 'Unit' domain.
        AUDIT (
          name observation_unit_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.OBSERVATION t
JOIN vocab.concept c ON t.UNIT_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Unit';;

-- Description: Check that concepts in 'OBSERVATION.UNIT_CONCEPT_ID' are standard and valid.
        AUDIT (
          name observation_unit_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.OBSERVATION t
LEFT JOIN vocab.concept c ON t.UNIT_CONCEPT_ID = c.concept_id
WHERE t.UNIT_CONCEPT_ID IS NOT NULL
  AND t.UNIT_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'OBSERVATION.UNIT_CONCEPT_ID'.
AUDIT (
  name observation_unit_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.OBSERVATION WHERE UNIT_CONCEPT_ID = 0;

-- Description: Check for orphaned foreign keys in 'OBSERVATION.VALUE_AS_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name observation_value_as_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.OBSERVATION c
LEFT JOIN vocab.concept p ON c.VALUE_AS_CONCEPT_ID = p.CONCEPT_ID
WHERE c.VALUE_AS_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'OBSERVATION.VISIT_DETAIL_ID' pointing to 'VISIT_DETAIL.VISIT_DETAIL_ID'.
        AUDIT (
          name observation_visit_detail_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.OBSERVATION c
LEFT JOIN omop.VISIT_DETAIL p ON c.VISIT_DETAIL_ID = p.VISIT_DETAIL_ID
WHERE c.VISIT_DETAIL_ID IS NOT NULL AND p.VISIT_DETAIL_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'OBSERVATION.VISIT_OCCURRENCE_ID' pointing to 'VISIT_OCCURRENCE.VISIT_OCCURRENCE_ID'.
        AUDIT (
          name observation_visit_occurrence_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.OBSERVATION c
LEFT JOIN omop.VISIT_OCCURRENCE p ON c.VISIT_OCCURRENCE_ID = p.VISIT_OCCURRENCE_ID
WHERE c.VISIT_OCCURRENCE_ID IS NOT NULL AND p.VISIT_OCCURRENCE_ID IS NULL;;

-- Description: Plausible value for 'Plasma total cholesterol level' is below 50.0.
        AUDIT (
          name observation_37393449_8840_0_low,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.OBSERVATION
WHERE OBSERVATION_CONCEPT_ID = 37393449
  AND unit_concept_id = 8840
  AND value_as_number < 50.0;;

-- Description: Plausible value for 'Plasma total cholesterol level' is above 500.0.
        AUDIT (
          name observation_37393449_8840_0_high,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.OBSERVATION
WHERE OBSERVATION_CONCEPT_ID = 37393449
  AND unit_concept_id = 8840
  AND value_as_number > 500.0;;

-- Description: Plausible value for 'Plasma total cholesterol level' is below 1.0.
        AUDIT (
          name observation_37393449_8753_0_low,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.OBSERVATION
WHERE OBSERVATION_CONCEPT_ID = 37393449
  AND unit_concept_id = 8753
  AND value_as_number < 1.0;;

-- Description: Plausible value for 'Plasma total cholesterol level' is above 15.0.
        AUDIT (
          name observation_37393449_8753_0_high,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.OBSERVATION
WHERE OBSERVATION_CONCEPT_ID = 37393449
  AND unit_concept_id = 8753
  AND value_as_number > 15.0;;

-- Description: Plausible value for 'Serum total cholesterol level' is below 50.0.
        AUDIT (
          name observation_37397989_8840_0_low,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.OBSERVATION
WHERE OBSERVATION_CONCEPT_ID = 37397989
  AND unit_concept_id = 8840
  AND value_as_number < 50.0;;

-- Description: Plausible value for 'Serum total cholesterol level' is above 500.0.
        AUDIT (
          name observation_37397989_8840_0_high,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.OBSERVATION
WHERE OBSERVATION_CONCEPT_ID = 37397989
  AND unit_concept_id = 8840
  AND value_as_number > 500.0;;

-- Description: Plausible value for 'Serum total cholesterol level' is below 1.0.
        AUDIT (
          name observation_37397989_8753_0_low,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.OBSERVATION
WHERE OBSERVATION_CONCEPT_ID = 37397989
  AND unit_concept_id = 8753
  AND value_as_number < 1.0;;

-- Description: Plausible value for 'Serum total cholesterol level' is above 15.0.
        AUDIT (
          name observation_37397989_8753_0_high,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.OBSERVATION
WHERE OBSERVATION_CONCEPT_ID = 37397989
  AND unit_concept_id = 8753
  AND value_as_number > 15.0;;

-- Description: Plausible value for 'Total cholesterol level' is below 50.0.
        AUDIT (
          name observation_44809580_8840_0_low,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.OBSERVATION
WHERE OBSERVATION_CONCEPT_ID = 44809580
  AND unit_concept_id = 8840
  AND value_as_number < 50.0;;

-- Description: Plausible value for 'Total cholesterol level' is above 500.0.
        AUDIT (
          name observation_44809580_8840_0_high,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.OBSERVATION
WHERE OBSERVATION_CONCEPT_ID = 44809580
  AND unit_concept_id = 8840
  AND value_as_number > 500.0;;

-- Description: Plausible value for 'Total cholesterol level' is below 1.0.
        AUDIT (
          name observation_44809580_8753_0_low,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.OBSERVATION
WHERE OBSERVATION_CONCEPT_ID = 44809580
  AND unit_concept_id = 8753
  AND value_as_number < 1.0;;

-- Description: Plausible value for 'Total cholesterol level' is above 15.0.
        AUDIT (
          name observation_44809580_8753_0_high,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.OBSERVATION
WHERE OBSERVATION_CONCEPT_ID = 44809580
  AND unit_concept_id = 8753
  AND value_as_number > 15.0;;

-- Description: Plausible value for 'Serum creatinine level' is below 10.0.
        AUDIT (
          name observation_37392176_8749_0_low,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.OBSERVATION
WHERE OBSERVATION_CONCEPT_ID = 37392176
  AND unit_concept_id = 8749
  AND value_as_number < 10.0;;

-- Description: Plausible value for 'Serum creatinine level' is above 200.0.
        AUDIT (
          name observation_37392176_8749_0_high,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.OBSERVATION
WHERE OBSERVATION_CONCEPT_ID = 37392176
  AND unit_concept_id = 8749
  AND value_as_number > 200.0;;

-- Description: Plausible value for 'Serum creatinine level' is below 0.1.
        AUDIT (
          name observation_37392176_8840_0_low,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.OBSERVATION
WHERE OBSERVATION_CONCEPT_ID = 37392176
  AND unit_concept_id = 8840
  AND value_as_number < 0.1;;

-- Description: Plausible value for 'Serum creatinine level' is above 5.0.
        AUDIT (
          name observation_37392176_8840_0_high,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.OBSERVATION
WHERE OBSERVATION_CONCEPT_ID = 37392176
  AND unit_concept_id = 8840
  AND value_as_number > 5.0;;

-- Description: Plausible value for 'Serum creatinine level' is below 10.0.
        AUDIT (
          name observation_37392176_8751_0_low,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.OBSERVATION
WHERE OBSERVATION_CONCEPT_ID = 37392176
  AND unit_concept_id = 8751
  AND value_as_number < 10.0;;

-- Description: Plausible value for 'Serum creatinine level' is above 30.0.
        AUDIT (
          name observation_37392176_8751_0_high,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.OBSERVATION
WHERE OBSERVATION_CONCEPT_ID = 37392176
  AND unit_concept_id = 8751
  AND value_as_number > 30.0;;

