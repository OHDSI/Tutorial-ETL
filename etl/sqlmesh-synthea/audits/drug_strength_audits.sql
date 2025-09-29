-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.drug_strength,
--   depends_on (
--     vocab.concept,
--   ),
--   audits (
--     drug_strength_amount_unit_concept_id_is_foreign_key,
--     drug_strength_denominator_unit_concept_id_is_foreign_key,
--     drug_strength_drug_concept_id_is_required,
--     drug_strength_drug_concept_id_is_foreign_key,
--     drug_strength_drug_concept_id_fk_domain,
--     drug_strength_ingredient_concept_id_is_required,
--     drug_strength_ingredient_concept_id_is_foreign_key,
--     drug_strength_numerator_unit_concept_id_is_foreign_key,
--     drug_strength_valid_end_date_is_required,
--     drug_strength_valid_start_date_is_required,
--     drug_strength_valid_start_date_start_before_end,
--   )
-- );

-- Description: Check for orphaned foreign keys in 'DRUG_STRENGTH.AMOUNT_UNIT_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name drug_strength_amount_unit_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DRUG_STRENGTH c
LEFT JOIN vocab.concept p ON c.AMOUNT_UNIT_CONCEPT_ID = p.CONCEPT_ID
WHERE c.AMOUNT_UNIT_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'DRUG_STRENGTH.DENOMINATOR_UNIT_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name drug_strength_denominator_unit_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DRUG_STRENGTH c
LEFT JOIN vocab.concept p ON c.DENOMINATOR_UNIT_CONCEPT_ID = p.CONCEPT_ID
WHERE c.DENOMINATOR_UNIT_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'DRUG_STRENGTH.DRUG_CONCEPT_ID'.
AUDIT (
  name drug_strength_drug_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DRUG_STRENGTH WHERE DRUG_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'DRUG_STRENGTH.DRUG_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name drug_strength_drug_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DRUG_STRENGTH c
LEFT JOIN vocab.concept p ON c.DRUG_CONCEPT_ID = p.CONCEPT_ID
WHERE c.DRUG_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'DRUG_STRENGTH.DRUG_CONCEPT_ID' belong to the 'Drug' domain.
        AUDIT (
          name drug_strength_drug_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.DRUG_STRENGTH t
JOIN vocab.concept c ON t.DRUG_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Drug';;

-- Description: Check for NULLs in required field 'DRUG_STRENGTH.INGREDIENT_CONCEPT_ID'.
AUDIT (
  name drug_strength_ingredient_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DRUG_STRENGTH WHERE INGREDIENT_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'DRUG_STRENGTH.INGREDIENT_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name drug_strength_ingredient_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DRUG_STRENGTH c
LEFT JOIN vocab.concept p ON c.INGREDIENT_CONCEPT_ID = p.CONCEPT_ID
WHERE c.INGREDIENT_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'DRUG_STRENGTH.NUMERATOR_UNIT_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name drug_strength_numerator_unit_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.DRUG_STRENGTH c
LEFT JOIN vocab.concept p ON c.NUMERATOR_UNIT_CONCEPT_ID = p.CONCEPT_ID
WHERE c.NUMERATOR_UNIT_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'DRUG_STRENGTH.VALID_END_DATE'.
AUDIT (
  name drug_strength_valid_end_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DRUG_STRENGTH WHERE VALID_END_DATE IS NULL;

-- Description: Check for NULLs in required field 'DRUG_STRENGTH.VALID_START_DATE'.
AUDIT (
  name drug_strength_valid_start_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DRUG_STRENGTH WHERE VALID_START_DATE IS NULL;

-- Description: Check that 'DRUG_STRENGTH.VALID_START_DATE' occurs before 'DRUG_STRENGTH.VALID_END_DATE'.
AUDIT (
  name drug_strength_valid_start_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.DRUG_STRENGTH WHERE VALID_START_DATE > VALID_END_DATE;

