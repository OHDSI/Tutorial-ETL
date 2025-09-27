-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.measurement,
--   audits (
--     person_completeness_measurement,
--     measurement_meas_event_field_concept_id_is_foreign_key,
--     measurement_meas_event_field_concept_id_is_standard_valid_concept,
--     measurement_measurement_concept_id_is_required,
--     measurement_measurement_concept_id_is_foreign_key,
--     measurement_measurement_concept_id_fk_domain,
--     measurement_measurement_concept_id_is_standard_valid_concept,
--     measurement_measurement_concept_id_standard_concept_record_completeness,
--     measurement_measurement_date_is_required,
--     measurement_measurement_date_after_birth,
--     measurement_measurement_datetime_after_birth,
--     measurement_measurement_id_is_required,
--     measurement_measurement_id_is_primary_key,
--     measurement_measurement_source_concept_id_is_foreign_key,
--     measurement_measurement_type_concept_id_is_required,
--     measurement_measurement_type_concept_id_is_foreign_key,
--     measurement_measurement_type_concept_id_fk_domain,
--     measurement_measurement_type_concept_id_is_standard_valid_concept,
--     measurement_measurement_type_concept_id_standard_concept_record_completeness,
--     measurement_operator_concept_id_is_foreign_key,
--     measurement_operator_concept_id_fk_domain,
--     measurement_operator_concept_id_is_standard_valid_concept,
--     measurement_person_id_is_required,
--     measurement_person_id_is_foreign_key,
--     measurement_provider_id_is_foreign_key,
--     measurement_unit_concept_id_is_foreign_key,
--     measurement_unit_concept_id_fk_domain,
--     measurement_unit_concept_id_is_standard_valid_concept,
--     measurement_unit_concept_id_standard_concept_record_completeness,
--     measurement_unit_source_concept_id_is_foreign_key,
--     measurement_value_as_concept_id_is_foreign_key,
--     measurement_visit_detail_id_is_foreign_key,
--     measurement_visit_occurrence_id_is_foreign_key,
--     measurement_3006315_unit,
--     measurement_3004410_unit,
--     measurement_40487382_unit,
--     measurement_3013721_unit,
--     measurement_3019198_unit,
--     measurement_3034426_unit,
--     measurement_3043688_unit,
--     measurement_3046485_unit,
--     measurement_4216098_unit,
--     measurement_4245152_unit,
--     measurement_3006923_unit,
--     measurement_3021044_unit,
--     measurement_3024171_unit,
--     measurement_3027114_unit,
--     measurement_40762499_unit,
--     measurement_3000963_unit,
--     measurement_3001604_unit,
--     measurement_3019069_unit,
--     measurement_3022509_unit,
--     measurement_3028288_unit,
--     measurement_4148615_unit,
--     measurement_44806420_unit,
--     measurement_3028437_unit,
--     measurement_3016991_unit,
--     measurement_3026925_unit,
--     measurement_3028615_unit,
--     measurement_3051205_unit,
--     measurement_4098046_unit,
--     measurement_3005131_unit,
--     measurement_3011163_unit,
--     measurement_3044491_unit,
--     measurement_4017361_unit,
--     measurement_3006504_unit,
--     measurement_3000483_unit,
--     measurement_3033543_unit,
--     measurement_3045716_unit,
--     measurement_4101713_unit,
--     measurement_4103762_unit,
--     measurement_3001008_unit,
--     measurement_3009744_unit,
--     measurement_3013115_unit,
--     measurement_3019550_unit,
--     measurement_3020416_unit,
--     measurement_3035583_unit,
--     measurement_3035995_unit,
--     measurement_3038553_unit,
--     measurement_35610320_unit,
--     measurement_3001490_unit,
--     measurement_4195214_unit,
--     measurement_36306178_unit,
--     measurement_37393850_unit,
--     measurement_3004501_unit,
--     measurement_3008598_unit,
--     measurement_3018010_unit,
--     measurement_3022192_unit,
--     measurement_4151768_unit,
--     measurement_4197602_unit,
--     measurement_46236952_unit,
--     measurement_3006906_unit,
--     measurement_3007070_unit,
--     measurement_3020460_unit,
--     measurement_3023314_unit,
--     measurement_3035941_unit,
--     measurement_3037072_unit,
--     measurement_4151358_unit,
--     measurement_4194332_unit,
--     measurement_3001123_unit,
--     measurement_3012888_unit,
--     measurement_3013707_unit,
--     measurement_3037511_unit,
--     measurement_3040168_unit,
--     measurement_4097430_unit,
--     measurement_3005424_unit,
--     measurement_3013603_unit,
--     measurement_3020509_unit,
--     measurement_3036277_unit,
--     measurement_4301868_unit,
--     measurement_40762636_unit,
--     measurement_40765040_unit,
--     measurement_3024386_unit,
--     measurement_3009201_unit,
--     measurement_3024731_unit,
--     measurement_3050479_unit,
--     measurement_4012479_unit,
--     measurement_4152194_unit,
--     measurement_37393840_unit,
--     measurement_3000593_unit,
--     measurement_3002888_unit,
--     measurement_3010910_unit,
--     measurement_3013290_unit,
--     measurement_3027970_unit,
--     measurement_4239408_unit,
--     measurement_3010813_unit,
--     measurement_3023103_unit,
--     measurement_4030871_unit,
--     measurement_4154790_unit,
--     measurement_4217013_unit,
--     measurement_3001318_unit,
--     measurement_3004249_unit,
--     measurement_3009596_unit,
--     measurement_3025315_unit,
--     measurement_3053283_unit,
--     measurement_4008265_unit,
--     measurement_36303797_unit,
--     measurement_37398460_unit,
--     measurement_3013682_unit,
--     measurement_3026361_unit,
--     measurement_3027018_unit,
--     measurement_4013965_unit,
--     measurement_3013429_unit,
--     measurement_3023599_unit,
--     measurement_3036588_unit,
--     measurement_4298431_unit,
--     measurement_3017732_unit,
--     measurement_3024561_unit,
--     measurement_3034639_unit,
--     measurement_3013650_unit,
--     measurement_3021886_unit,
--     measurement_4254663_unit,
--     measurement_3001420_unit,
--     measurement_3007461_unit,
--     measurement_3012030_unit,
--     measurement_40764999_unit,
--     measurement_3008893_unit,
--     measurement_3016723_unit,
--     measurement_3026910_unit,
--     measurement_3033575_unit,
--     measurement_3041084_unit,
--     measurement_4184637_unit,
--     measurement_4313591_unit,
--     measurement_37393851_unit,
--     measurement_1619025_unit,
--     measurement_3013869_unit,
--     measurement_3035472_unit,
--     measurement_3039000_unit,
--     measurement_3000905_unit,
--     measurement_3015632_unit,
--     measurement_3032710_unit,
--     measurement_4197971_unit,
--     measurement_42869452_unit,
--     measurement_3002109_unit,
--     measurement_3004327_unit,
--     measurement_3006322_unit,
--     measurement_3008342_unit,
--     measurement_3020630_unit,
--     measurement_3001122_unit,
--     measurement_3009542_unit,
--     measurement_3010189_unit,
--     measurement_3010457_unit,
--     measurement_4192368_unit,
--     measurement_3014576_unit,
--     measurement_3024128_unit,
--     measurement_3018311_unit,
--     measurement_3020891_unit,
--     measurement_3037556_unit,
--     measurement_37399332_unit,
--     measurement_3011904_unit,
--     measurement_3019897_unit,
--     measurement_3025255_unit,
--     measurement_4076704_unit,
--     measurement_4172647_unit,
--     measurement_37393531_unit,
--     measurement_40771529_unit,
--     measurement_3000034_unit,
--     measurement_3035124_unit,
--     measurement_3002030_unit,
--     measurement_3019170_unit,
--     measurement_3020149_unit,
--     measurement_3022174_unit,
--     measurement_3024929_unit,
--     measurement_3049187_unit,
--     measurement_37398676_unit,
--     measurement_4112223_unit,
--     measurement_3017250_unit,
--     measurement_4191837_unit,
--     measurement_3022096_unit,
--     measurement_3034485_unit,
--     measurement_44790183_unit,
--     measurement_3002400_unit,
--     measurement_3003338_unit,
--   )
-- );

-- Description: Check for persons missing from table 'MEASUREMENT'.
        AUDIT (
          name person_completeness_measurement,
          dialect duckdb,
          blocking FALSE
        );
        SELECT p.person_id
FROM omop.person p
LEFT JOIN omop.MEASUREMENT e ON p.person_id = e.person_id
WHERE e.person_id IS NULL;;

-- Description: Check for orphaned foreign keys in 'MEASUREMENT.MEAS_EVENT_FIELD_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name measurement_meas_event_field_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.MEASUREMENT c
LEFT JOIN vocab.CONCEPT p ON c.MEAS_EVENT_FIELD_CONCEPT_ID = p.CONCEPT_ID
WHERE c.MEAS_EVENT_FIELD_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'MEASUREMENT.MEAS_EVENT_FIELD_CONCEPT_ID' are standard and valid.
        AUDIT (
          name measurement_meas_event_field_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.MEASUREMENT t
LEFT JOIN vocab.CONCEPT c ON t.MEAS_EVENT_FIELD_CONCEPT_ID = c.concept_id
WHERE t.MEAS_EVENT_FIELD_CONCEPT_ID IS NOT NULL
  AND t.MEAS_EVENT_FIELD_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for NULLs in required field 'MEASUREMENT.MEASUREMENT_CONCEPT_ID'.
AUDIT (
  name measurement_measurement_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.MEASUREMENT WHERE MEASUREMENT_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'MEASUREMENT.MEASUREMENT_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name measurement_measurement_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.MEASUREMENT c
LEFT JOIN vocab.CONCEPT p ON c.MEASUREMENT_CONCEPT_ID = p.CONCEPT_ID
WHERE c.MEASUREMENT_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'MEASUREMENT.MEASUREMENT_CONCEPT_ID' belong to the 'Measurement' domain.
        AUDIT (
          name measurement_measurement_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.MEASUREMENT t
JOIN vocab.CONCEPT c ON t.MEASUREMENT_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Measurement';;

-- Description: Check that concepts in 'MEASUREMENT.MEASUREMENT_CONCEPT_ID' are standard and valid.
        AUDIT (
          name measurement_measurement_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.MEASUREMENT t
LEFT JOIN vocab.CONCEPT c ON t.MEASUREMENT_CONCEPT_ID = c.concept_id
WHERE t.MEASUREMENT_CONCEPT_ID IS NOT NULL
  AND t.MEASUREMENT_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'MEASUREMENT.MEASUREMENT_CONCEPT_ID'.
AUDIT (
  name measurement_measurement_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.MEASUREMENT WHERE MEASUREMENT_CONCEPT_ID = 0;

-- Description: Check for NULLs in required field 'MEASUREMENT.MEASUREMENT_DATE'.
AUDIT (
  name measurement_measurement_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.MEASUREMENT WHERE MEASUREMENT_DATE IS NULL;

-- Description: Check that date 'MEASUREMENT.MEASUREMENT_DATE' is after person's birth date.
        AUDIT (
          name measurement_measurement_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.MEASUREMENT t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.MEASUREMENT_DATE < p.birth_datetime;;

-- Description: Check that date 'MEASUREMENT.MEASUREMENT_DATETIME' is after person's birth date.
        AUDIT (
          name measurement_measurement_datetime_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.MEASUREMENT t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.MEASUREMENT_DATETIME < p.birth_datetime;;

-- Description: Check for NULLs in required field 'MEASUREMENT.MEASUREMENT_ID'.
AUDIT (
  name measurement_measurement_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.MEASUREMENT WHERE MEASUREMENT_ID IS NULL;

-- Description: Check for duplicate values in primary key field 'MEASUREMENT.MEASUREMENT_ID'.
        AUDIT (
          name measurement_measurement_id_is_primary_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT MEASUREMENT_ID, COUNT(*)
FROM omop.MEASUREMENT
WHERE MEASUREMENT_ID IS NOT NULL
GROUP BY MEASUREMENT_ID
HAVING COUNT(*) > 1;;

-- Description: Check for orphaned foreign keys in 'MEASUREMENT.MEASUREMENT_SOURCE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name measurement_measurement_source_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.MEASUREMENT c
LEFT JOIN vocab.CONCEPT p ON c.MEASUREMENT_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.MEASUREMENT_SOURCE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'MEASUREMENT.MEASUREMENT_TYPE_CONCEPT_ID'.
AUDIT (
  name measurement_measurement_type_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.MEASUREMENT WHERE MEASUREMENT_TYPE_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'MEASUREMENT.MEASUREMENT_TYPE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name measurement_measurement_type_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.MEASUREMENT c
LEFT JOIN vocab.CONCEPT p ON c.MEASUREMENT_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.MEASUREMENT_TYPE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'MEASUREMENT.MEASUREMENT_TYPE_CONCEPT_ID' belong to the 'Type Concept' domain.
        AUDIT (
          name measurement_measurement_type_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.MEASUREMENT t
JOIN vocab.CONCEPT c ON t.MEASUREMENT_TYPE_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Type Concept';;

-- Description: Check that concepts in 'MEASUREMENT.MEASUREMENT_TYPE_CONCEPT_ID' are standard and valid.
        AUDIT (
          name measurement_measurement_type_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.MEASUREMENT t
LEFT JOIN vocab.CONCEPT c ON t.MEASUREMENT_TYPE_CONCEPT_ID = c.concept_id
WHERE t.MEASUREMENT_TYPE_CONCEPT_ID IS NOT NULL
  AND t.MEASUREMENT_TYPE_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'MEASUREMENT.MEASUREMENT_TYPE_CONCEPT_ID'.
AUDIT (
  name measurement_measurement_type_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.MEASUREMENT WHERE MEASUREMENT_TYPE_CONCEPT_ID = 0;

-- Description: Check for orphaned foreign keys in 'MEASUREMENT.OPERATOR_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name measurement_operator_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.MEASUREMENT c
LEFT JOIN vocab.CONCEPT p ON c.OPERATOR_CONCEPT_ID = p.CONCEPT_ID
WHERE c.OPERATOR_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'MEASUREMENT.OPERATOR_CONCEPT_ID' belong to the 'Meas Value Operator' domain.
        AUDIT (
          name measurement_operator_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.MEASUREMENT t
JOIN vocab.CONCEPT c ON t.OPERATOR_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Meas Value Operator';;

-- Description: Check that concepts in 'MEASUREMENT.OPERATOR_CONCEPT_ID' are standard and valid.
        AUDIT (
          name measurement_operator_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.MEASUREMENT t
LEFT JOIN vocab.CONCEPT c ON t.OPERATOR_CONCEPT_ID = c.concept_id
WHERE t.OPERATOR_CONCEPT_ID IS NOT NULL
  AND t.OPERATOR_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for NULLs in required field 'MEASUREMENT.PERSON_ID'.
AUDIT (
  name measurement_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.MEASUREMENT WHERE PERSON_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'MEASUREMENT.PERSON_ID' pointing to 'PERSON.PERSON_ID'.
        AUDIT (
          name measurement_person_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.MEASUREMENT c
LEFT JOIN omop.PERSON p ON c.PERSON_ID = p.PERSON_ID
WHERE c.PERSON_ID IS NOT NULL AND p.PERSON_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'MEASUREMENT.PROVIDER_ID' pointing to 'PROVIDER.PROVIDER_ID'.
        AUDIT (
          name measurement_provider_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.MEASUREMENT c
LEFT JOIN omop.PROVIDER p ON c.PROVIDER_ID = p.PROVIDER_ID
WHERE c.PROVIDER_ID IS NOT NULL AND p.PROVIDER_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'MEASUREMENT.UNIT_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name measurement_unit_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.MEASUREMENT c
LEFT JOIN vocab.CONCEPT p ON c.UNIT_CONCEPT_ID = p.CONCEPT_ID
WHERE c.UNIT_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'MEASUREMENT.UNIT_CONCEPT_ID' belong to the 'Unit' domain.
        AUDIT (
          name measurement_unit_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.MEASUREMENT t
JOIN vocab.CONCEPT c ON t.UNIT_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Unit';;

-- Description: Check that concepts in 'MEASUREMENT.UNIT_CONCEPT_ID' are standard and valid.
        AUDIT (
          name measurement_unit_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.MEASUREMENT t
LEFT JOIN vocab.CONCEPT c ON t.UNIT_CONCEPT_ID = c.concept_id
WHERE t.UNIT_CONCEPT_ID IS NOT NULL
  AND t.UNIT_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'MEASUREMENT.UNIT_CONCEPT_ID'.
AUDIT (
  name measurement_unit_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.MEASUREMENT WHERE UNIT_CONCEPT_ID = 0;

-- Description: Check for orphaned foreign keys in 'MEASUREMENT.UNIT_SOURCE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name measurement_unit_source_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.MEASUREMENT c
LEFT JOIN vocab.CONCEPT p ON c.UNIT_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.UNIT_SOURCE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'MEASUREMENT.VALUE_AS_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name measurement_value_as_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.MEASUREMENT c
LEFT JOIN vocab.CONCEPT p ON c.VALUE_AS_CONCEPT_ID = p.CONCEPT_ID
WHERE c.VALUE_AS_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'MEASUREMENT.VISIT_DETAIL_ID' pointing to 'VISIT_DETAIL.VISIT_DETAIL_ID'.
        AUDIT (
          name measurement_visit_detail_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.MEASUREMENT c
LEFT JOIN omop.VISIT_DETAIL p ON c.VISIT_DETAIL_ID = p.VISIT_DETAIL_ID
WHERE c.VISIT_DETAIL_ID IS NOT NULL AND p.VISIT_DETAIL_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'MEASUREMENT.VISIT_OCCURRENCE_ID' pointing to 'VISIT_OCCURRENCE.VISIT_OCCURRENCE_ID'.
        AUDIT (
          name measurement_visit_occurrence_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.MEASUREMENT c
LEFT JOIN omop.VISIT_OCCURRENCE p ON c.VISIT_OCCURRENCE_ID = p.VISIT_OCCURRENCE_ID
WHERE c.VISIT_OCCURRENCE_ID IS NOT NULL AND p.VISIT_OCCURRENCE_ID IS NULL;;

-- Description: Plausible unit check for concept 'Basophils [#/volume] in Blood'.
        AUDIT (
          name measurement_3006315_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3006315
  AND unit_concept_id NOT IN (8784, 8848, 8961, 9444);;

-- Description: Plausible unit check for concept 'Hemoglobin A1c/Hemoglobin.total in Blood'.
        AUDIT (
          name measurement_3004410_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3004410
  AND unit_concept_id NOT IN (8554, 8737, 9225, 9579);;

-- Description: Plausible unit check for concept 'Total lymphocyte count'.
        AUDIT (
          name measurement_40487382_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 40487382
  AND unit_concept_id NOT IN (8784, 8848, 8961, 9444);;

-- Description: Plausible unit check for concept 'Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3013721_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3013721
  AND unit_concept_id NOT IN (8645, 8923);;

-- Description: Plausible unit check for concept 'Lymphocytes [#/volume] in Blood'.
        AUDIT (
          name measurement_3019198_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3019198
  AND unit_concept_id NOT IN (8784, 8848, 8961, 9444);;

-- Description: Plausible unit check for concept 'Prothrombin time (PT)'.
        AUDIT (
          name measurement_3034426_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3034426
  AND unit_concept_id NOT IN (8555);;

-- Description: Plausible unit check for concept 'Hemoglobin [Mass/volume] in Body fluid'.
        AUDIT (
          name measurement_3043688_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3043688
  AND unit_concept_id NOT IN (8713);;

-- Description: Plausible unit check for concept 'Urea nitrogen/Creatinine [Mass Ratio] in Blood'.
        AUDIT (
          name measurement_3046485_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3046485
  AND unit_concept_id NOT IN (8523, 8554, 8596);;

-- Description: Plausible unit check for concept 'Eosinophil count'.
        AUDIT (
          name measurement_4216098_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4216098
  AND unit_concept_id NOT IN (8784, 8848, 8961, 9444);;

-- Description: Plausible unit check for concept 'Potassium measurement'.
        AUDIT (
          name measurement_4245152_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4245152
  AND unit_concept_id NOT IN (8736, 8753, 9557);;

-- Description: Plausible unit check for concept 'Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3006923_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3006923
  AND unit_concept_id NOT IN (8645, 8923);;

-- Description: Plausible unit check for concept 'Iron binding capacity [Mass/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3021044_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3021044
  AND unit_concept_id NOT IN (8837);;

-- Description: Plausible unit check for concept 'Respiratory rate'.
        AUDIT (
          name measurement_3024171_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3024171
  AND unit_concept_id NOT IN (8483, 8541);;

-- Description: Plausible unit check for concept 'Cholesterol [Mass/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3027114_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3027114
  AND unit_concept_id NOT IN (8840);;

-- Description: Plausible unit check for concept 'Oxygen saturation in Arterial blood by Pulse oximetry'.
        AUDIT (
          name measurement_40762499_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 40762499
  AND unit_concept_id NOT IN (8554);;

-- Description: Plausible unit check for concept 'Hemoglobin [Mass/volume] in Blood'.
        AUDIT (
          name measurement_3000963_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3000963
  AND unit_concept_id NOT IN (8636, 8713);;

-- Description: Plausible unit check for concept 'Monocytes [#/volume] in Blood'.
        AUDIT (
          name measurement_3001604_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3001604
  AND unit_concept_id NOT IN (8848, 8961, 9444);;

-- Description: Plausible unit check for concept 'Monocytes/100 leukocytes in Blood'.
        AUDIT (
          name measurement_3019069_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3019069
  AND unit_concept_id NOT IN (8554);;

-- Description: Plausible unit check for concept 'Hyaline casts [#/area] in Urine sediment by Microscopy low power field'.
        AUDIT (
          name measurement_3022509_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3022509
  AND unit_concept_id NOT IN (8765);;

-- Description: Plausible unit check for concept 'Cholesterol in LDL [Mass/volume] in Serum or Plasma by calculation'.
        AUDIT (
          name measurement_3028288_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3028288
  AND unit_concept_id NOT IN (8840, 9028);;

-- Description: Plausible unit check for concept 'Neutrophil count'.
        AUDIT (
          name measurement_4148615_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4148615
  AND unit_concept_id NOT IN (8784, 8848, 8961, 8848, 9444);;

-- Description: Plausible unit check for concept 'Estimation of glomerular filtration rate'.
        AUDIT (
          name measurement_44806420_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 44806420
  AND unit_concept_id NOT IN (720870, 8795);;

-- Description: Plausible unit check for concept 'Cholesterol in LDL [Mass/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3028437_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3028437
  AND unit_concept_id NOT IN (8840, 9028);;

-- Description: Plausible unit check for concept 'Thyroxine (T4) [Mass/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3016991_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3016991
  AND unit_concept_id NOT IN (8837);;

-- Description: Plausible unit check for concept 'Triiodothyronine (T3) Free [Mass/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3026925_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3026925
  AND unit_concept_id NOT IN (8820, 8845);;

-- Description: Plausible unit check for concept 'Eosinophils [#/volume] in Blood by Automated count'.
        AUDIT (
          name measurement_3028615_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3028615
  AND unit_concept_id NOT IN (8784, 8816, 8848, 8961, 9436, 9444);;

-- Description: Plausible unit check for concept 'Crystals [#/area] in Urine sediment by Microscopy high power field'.
        AUDIT (
          name measurement_3051205_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3051205
  AND unit_concept_id NOT IN (8786);;

-- Description: Plausible unit check for concept 'Pulse oximetry'.
        AUDIT (
          name measurement_4098046_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4098046
  AND unit_concept_id NOT IN (8554);;

-- Description: Plausible unit check for concept 'Glucose mean value [Mass/volume] in Blood Estimated from glycated hemoglobin'.
        AUDIT (
          name measurement_3005131_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3005131
  AND unit_concept_id NOT IN (8840, 9028);;

-- Description: Plausible unit check for concept 'Cholesterol.total/Cholesterol in HDL [Mass Ratio] in Serum or Plasma'.
        AUDIT (
          name measurement_3011163_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3011163
  AND unit_concept_id NOT IN (8523, 8529, 8554, 8596, 8606);;

-- Description: Plausible unit check for concept 'Cholesterol non HDL [Mass/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3044491_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3044491
  AND unit_concept_id NOT IN (8576, 8840, 9028);;

-- Description: Plausible unit check for concept 'Blood urea nitrogen measurement'.
        AUDIT (
          name measurement_4017361_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4017361
  AND unit_concept_id NOT IN (8753, 8840);;

-- Description: Plausible unit check for concept 'Eosinophils/100 leukocytes in Blood'.
        AUDIT (
          name measurement_3006504_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3006504
  AND unit_concept_id NOT IN (8554);;

-- Description: Plausible unit check for concept 'Glucose [Mass/volume] in Blood'.
        AUDIT (
          name measurement_3000483_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3000483
  AND unit_concept_id NOT IN (8840);;

-- Description: Plausible unit check for concept 'Specific gravity of Urine'.
        AUDIT (
          name measurement_3033543_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3033543
  AND unit_concept_id NOT IN (8523);;

-- Description: Plausible unit check for concept 'Anion gap in Serum or Plasma'.
        AUDIT (
          name measurement_3045716_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3045716
  AND unit_concept_id NOT IN (8753, 9557);;

-- Description: Plausible unit check for concept 'High density lipoprotein cholesterol measurement'.
        AUDIT (
          name measurement_4101713_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4101713
  AND unit_concept_id NOT IN (8636, 8736, 8753, 8840);;

-- Description: Plausible unit check for concept 'Anion gap measurement'.
        AUDIT (
          name measurement_4103762_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4103762
  AND unit_concept_id NOT IN (8753, 9557);;

-- Description: Plausible unit check for concept 'Epithelial cells.squamous [#/area] in Urine sediment by Microscopy high power field'.
        AUDIT (
          name measurement_3001008_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3001008
  AND unit_concept_id NOT IN (8765, 8786, 8889);;

-- Description: Plausible unit check for concept 'MCHC [Mass/volume] by Automated count'.
        AUDIT (
          name measurement_3009744_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3009744
  AND unit_concept_id NOT IN (8564, 8636, 8713);;

-- Description: Plausible unit check for concept 'Eosinophils [#/volume] in Blood'.
        AUDIT (
          name measurement_3013115_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3013115
  AND unit_concept_id NOT IN (8848, 8961, 9444);;

-- Description: Plausible unit check for concept 'Sodium [Moles/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3019550_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3019550
  AND unit_concept_id NOT IN (8753, 9557);;

-- Description: Plausible unit check for concept 'Erythrocytes [#/volume] in Blood by Automated count'.
        AUDIT (
          name measurement_3020416_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3020416
  AND unit_concept_id NOT IN (44777575, 8734, 8815);;

-- Description: Plausible unit check for concept 'Leukocytes [#/area] in Urine sediment by Microscopy high power field'.
        AUDIT (
          name measurement_3035583_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3035583
  AND unit_concept_id NOT IN (8786, 8889);;

-- Description: Plausible unit check for concept 'Alkaline phosphatase [Enzymatic activity/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3035995_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3035995
  AND unit_concept_id NOT IN (8645, 8923);;

-- Description: Plausible unit check for concept 'Body mass index (BMI) [Ratio]'.
        AUDIT (
          name measurement_3038553_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3038553
  AND unit_concept_id NOT IN (9531);;

-- Description: Plausible unit check for concept 'Diastolic arterial pressure'.
        AUDIT (
          name measurement_35610320_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 35610320
  AND unit_concept_id NOT IN (8876);;

-- Description: Plausible unit check for concept 'Nucleated erythrocytes [#/volume] in Blood'.
        AUDIT (
          name measurement_3001490_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3001490
  AND unit_concept_id NOT IN (8784, 8848, 8961, 9444);;

-- Description: Plausible unit check for concept 'Cholesterol/HDL ratio measurement'.
        AUDIT (
          name measurement_4195214_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4195214
  AND unit_concept_id NOT IN (8523, 8554, 8596);;

-- Description: Plausible unit check for concept 'Glomerular filtration rate/1.73 sq M.predicted among blacks [Volume Rate/Area] in Serum, Plasma or Blood by Creatinine-based formula (CKD-EPI)'.
        AUDIT (
          name measurement_36306178_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 36306178
  AND unit_concept_id NOT IN (720870, 8795);;

-- Description: Plausible unit check for concept 'MCHC - Mean corpuscular haemoglobin concentration'.
        AUDIT (
          name measurement_37393850_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 37393850
  AND unit_concept_id NOT IN (8636, 8713, 8554, 8753);;

-- Description: Plausible unit check for concept 'Glucose [Mass/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3004501_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3004501
  AND unit_concept_id NOT IN (8840, 8753);;

-- Description: Plausible unit check for concept 'Thyroxine (T4) free [Mass/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3008598_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3008598
  AND unit_concept_id NOT IN (8817);;

-- Description: Plausible unit check for concept 'Neutrophils/100 leukocytes in Blood'.
        AUDIT (
          name measurement_3018010_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3018010
  AND unit_concept_id NOT IN (8554);;

-- Description: Plausible unit check for concept 'Triglyceride [Mass/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3022192_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3022192
  AND unit_concept_id NOT IN (8840, 8753);;

-- Description: Plausible unit check for concept 'Pack years'.
        AUDIT (
          name measurement_4151768_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4151768
  AND unit_concept_id NOT IN (9448);;

-- Description: Plausible unit check for concept 'Serum TSH measurement'.
        AUDIT (
          name measurement_4197602_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4197602
  AND unit_concept_id NOT IN (8719, 9040, 9093, 44777578, 8750, 8923, 44777583);;

-- Description: Plausible unit check for concept 'Glomerular filtration rate/1.73 sq M.predicted [Volume Rate/Area] in Serum, Plasma or Blood by Creatinine-based formula (MDRD)'.
        AUDIT (
          name measurement_46236952_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 46236952
  AND unit_concept_id NOT IN (720870, 8795);;

-- Description: Plausible unit check for concept 'Calcium [Mass/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3006906_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3006906
  AND unit_concept_id NOT IN (8840);;

-- Description: Plausible unit check for concept 'Cholesterol in HDL [Mass/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3007070_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3007070
  AND unit_concept_id NOT IN (8840);;

-- Description: Plausible unit check for concept 'C reactive protein [Mass/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3020460_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3020460
  AND unit_concept_id NOT IN (8751, 8840);;

-- Description: Plausible unit check for concept 'Hematocrit [Volume Fraction] of Blood by Automated count'.
        AUDIT (
          name measurement_3023314_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3023314
  AND unit_concept_id NOT IN (44777604, 8554);;

-- Description: Plausible unit check for concept 'MCH [Entitic mass]'.
        AUDIT (
          name measurement_3035941_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3035941
  AND unit_concept_id NOT IN (8564, 9655);;

-- Description: Plausible unit check for concept 'Urobilinogen [Mass/volume] in Urine by Test strip'.
        AUDIT (
          name measurement_3037072_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3037072
  AND unit_concept_id NOT IN (8840);;

-- Description: Plausible unit check for concept 'Hematocrit determination'.
        AUDIT (
          name measurement_4151358_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4151358
  AND unit_concept_id NOT IN (44777604, 8554, 8523);;

-- Description: Plausible unit check for concept 'Monocyte count'.
        AUDIT (
          name measurement_4194332_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4194332
  AND unit_concept_id NOT IN (8784, 8848, 8961, 9444);;

-- Description: Plausible unit check for concept 'Platelet mean volume [Entitic volume] in Blood'.
        AUDIT (
          name measurement_3001123_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3001123
  AND unit_concept_id NOT IN (8583);;

-- Description: Plausible unit check for concept 'Diastolic blood pressure'.
        AUDIT (
          name measurement_3012888_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3012888
  AND unit_concept_id NOT IN (8876);;

-- Description: Plausible unit check for concept 'Erythrocyte sedimentation rate by Westergren method'.
        AUDIT (
          name measurement_3013707_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3013707
  AND unit_concept_id NOT IN (8752);;

-- Description: Plausible unit check for concept 'Lymphocytes/100 leukocytes in Blood by Automated count'.
        AUDIT (
          name measurement_3037511_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3037511
  AND unit_concept_id NOT IN (8554);;

-- Description: Plausible unit check for concept 'Immature granulocytes [#/volume] in Blood'.
        AUDIT (
          name measurement_3040168_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3040168
  AND unit_concept_id NOT IN (8848, 8961, 9444);;

-- Description: Plausible unit check for concept 'Sodium measurement'.
        AUDIT (
          name measurement_4097430_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4097430
  AND unit_concept_id NOT IN (8753, 9557);;

-- Description: Plausible unit check for concept 'Body surface area'.
        AUDIT (
          name measurement_3005424_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3005424
  AND unit_concept_id NOT IN (8617);;

-- Description: Plausible unit check for concept 'Prostate specific Ag [Mass/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3013603_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3013603
  AND unit_concept_id NOT IN (8748, 8842);;

-- Description: Plausible unit check for concept 'Albumin/Globulin [Mass Ratio] in Serum or Plasma'.
        AUDIT (
          name measurement_3020509_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3020509
  AND unit_concept_id NOT IN (8523, 8554, 8596);;

-- Description: Plausible unit check for concept 'Body height'.
        AUDIT (
          name measurement_3036277_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3036277
  AND unit_concept_id NOT IN (8582, 9327, 9330, 9546);;

-- Description: Plausible unit check for concept 'Pulse rate'.
        AUDIT (
          name measurement_4301868_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4301868
  AND unit_concept_id NOT IN (8483, 8541, 8581);;

-- Description: Plausible unit check for concept 'Body mass index (BMI) [Percentile]'.
        AUDIT (
          name measurement_40762636_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 40762636
  AND unit_concept_id NOT IN (8554);;

-- Description: Plausible unit check for concept '25-Hydroxyvitamin D3+25-Hydroxyvitamin D2 [Mass/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_40765040_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 40765040
  AND unit_concept_id NOT IN (8842, 8845);;

-- Description: Plausible unit check for concept 'Platelet mean volume [Entitic volume] in Blood by Rees-Ecker'.
        AUDIT (
          name measurement_3024386_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3024386
  AND unit_concept_id NOT IN (8583);;

-- Description: Plausible unit check for concept 'Thyrotropin [Units/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3009201_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3009201
  AND unit_concept_id NOT IN (44777578, 8719, 9040, 9093, 8860);;

-- Description: Plausible unit check for concept 'MCV [Entitic volume]'.
        AUDIT (
          name measurement_3024731_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3024731
  AND unit_concept_id NOT IN (8583);;

-- Description: Plausible unit check for concept 'Immature granulocytes/100 leukocytes in Blood'.
        AUDIT (
          name measurement_3050479_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3050479
  AND unit_concept_id NOT IN (8554);;

-- Description: Plausible unit check for concept 'Low density lipoprotein cholesterol measurement'.
        AUDIT (
          name measurement_4012479_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4012479
  AND unit_concept_id NOT IN (8636, 8753, 8840);;

-- Description: Plausible unit check for concept 'Systolic blood pressure'.
        AUDIT (
          name measurement_4152194_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4152194
  AND unit_concept_id NOT IN (8876);;

-- Description: Plausible unit check for concept 'Haematocrit'.
        AUDIT (
          name measurement_37393840_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 37393840
  AND unit_concept_id NOT IN (44777604, 8523, 8554);;

-- Description: Plausible unit check for concept 'Cobalamin (Vitamin B12) [Mass/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3000593_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3000593
  AND unit_concept_id NOT IN (8845);;

-- Description: Plausible unit check for concept 'Erythrocyte distribution width [Entitic volume]'.
        AUDIT (
          name measurement_3002888_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3002888
  AND unit_concept_id NOT IN (8583);;

-- Description: Plausible unit check for concept 'Erythrocytes [#/volume] in Body fluid'.
        AUDIT (
          name measurement_3010910_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3010910
  AND unit_concept_id NOT IN (8647, 8785, 8815, 8931);;

-- Description: Plausible unit check for concept 'Carbon dioxide [Partial pressure] in Blood'.
        AUDIT (
          name measurement_3013290_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3013290
  AND unit_concept_id NOT IN (8876);;

-- Description: Plausible unit check for concept 'Globulin [Mass/volume] in Serum by calculation'.
        AUDIT (
          name measurement_3027970_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3027970
  AND unit_concept_id NOT IN (8636, 8713, 8950);;

-- Description: Plausible unit check for concept 'Heart rate'.
        AUDIT (
          name measurement_4239408_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4239408
  AND unit_concept_id NOT IN (8483, 8541, 8581);;

-- Description: Plausible unit check for concept 'Leukocytes [#/volume] in Blood'.
        AUDIT (
          name measurement_3010813_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3010813
  AND unit_concept_id NOT IN (44777588, 8848, 8961, 9444, 8647);;

-- Description: Plausible unit check for concept 'Potassium [Moles/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3023103_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3023103
  AND unit_concept_id NOT IN (8753, 9557);;

-- Description: Plausible unit check for concept 'Red blood cell count'.
        AUDIT (
          name measurement_4030871_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4030871
  AND unit_concept_id NOT IN (8734, 8815, 8931, 9444, 9445);;

-- Description: Plausible unit check for concept 'Diastolic blood pressure'.
        AUDIT (
          name measurement_4154790_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4154790
  AND unit_concept_id NOT IN (8876);;

-- Description: Plausible unit check for concept 'Systolic arterial pressure'.
        AUDIT (
          name measurement_4217013_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4217013
  AND unit_concept_id NOT IN (8876);;

-- Description: Plausible unit check for concept 'Cholesterol.total/Cholesterol in HDL [Percentile]'.
        AUDIT (
          name measurement_3001318_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3001318
  AND unit_concept_id NOT IN (8554, 8596);;

-- Description: Plausible unit check for concept 'Systolic blood pressure'.
        AUDIT (
          name measurement_3004249_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3004249
  AND unit_concept_id NOT IN (8876);;

-- Description: Plausible unit check for concept 'Cholesterol in VLDL [Mass/volume] in Serum or Plasma by calculation'.
        AUDIT (
          name measurement_3009596_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3009596
  AND unit_concept_id NOT IN (8576, 8840);;

-- Description: Plausible unit check for concept 'Body weight'.
        AUDIT (
          name measurement_3025315_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3025315
  AND unit_concept_id NOT IN (8739, 9346, 9373, 9529);;

-- Description: Plausible unit check for concept 'Glomerular filtration rate/1.73 sq M.predicted among blacks [Volume Rate/Area] in Serum, Plasma or Blood by Creatinine-based formula (MDRD)'.
        AUDIT (
          name measurement_3053283_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3053283
  AND unit_concept_id NOT IN (720870, 8795);;

-- Description: Plausible unit check for concept 'Total cholesterol measurement'.
        AUDIT (
          name measurement_4008265_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4008265
  AND unit_concept_id NOT IN (8736, 8753, 8840);;

-- Description: Plausible unit check for concept 'Glomerular filtration rate/1.73 sq M.predicted among non-blacks [Volume Rate/Area] in Serum, Plasma or Blood by Creatinine-based formula (CKD-EPI)'.
        AUDIT (
          name measurement_36303797_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 36303797
  AND unit_concept_id NOT IN (720870, 8795);;

-- Description: Plausible unit check for concept 'Serum alkaline phosphatase level'.
        AUDIT (
          name measurement_37398460_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 37398460
  AND unit_concept_id NOT IN (32995, 8645, 8923);;

-- Description: Plausible unit check for concept 'Urea nitrogen [Mass/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3013682_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3013682
  AND unit_concept_id NOT IN (8840);;

-- Description: Plausible unit check for concept 'Erythrocytes [#/volume] in Blood'.
        AUDIT (
          name measurement_3026361_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3026361
  AND unit_concept_id NOT IN (32706, 8785, 8815, 8931);;

-- Description: Plausible unit check for concept 'Heart rate'.
        AUDIT (
          name measurement_3027018_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3027018
  AND unit_concept_id NOT IN (8483, 8541);;

-- Description: Plausible unit check for concept 'Oxygen saturation measurement, arterial'.
        AUDIT (
          name measurement_4013965_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4013965
  AND unit_concept_id NOT IN (8554);;

-- Description: Plausible unit check for concept 'Basophils [#/volume] in Blood by Automated count'.
        AUDIT (
          name measurement_3013429_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3013429
  AND unit_concept_id NOT IN (8784, 8816, 8848, 8961, 9436, 9444);;

-- Description: Plausible unit check for concept 'MCV [Entitic volume] by Automated count'.
        AUDIT (
          name measurement_3023599_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3023599
  AND unit_concept_id NOT IN (8583);;

-- Description: Plausible unit check for concept 'Neutrophil cytoplasmic Ab.perinuclear [Presence] in Serum'.
        AUDIT (
          name measurement_3036588_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3036588
  AND unit_concept_id NOT IN (8525);;

-- Description: Plausible unit check for concept 'White blood cell count'.
        AUDIT (
          name measurement_4298431_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4298431
  AND unit_concept_id NOT IN (8848, 8961, 9444);;

-- Description: Plausible unit check for concept 'Neutrophils [#/volume] in Blood'.
        AUDIT (
          name measurement_3017732_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3017732
  AND unit_concept_id NOT IN (8848, 8961, 9444);;

-- Description: Plausible unit check for concept 'Albumin [Mass/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3024561_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3024561
  AND unit_concept_id NOT IN (8636, 8713);;

-- Description: Plausible unit check for concept 'Hemoglobin A1c [Mass/volume] in Blood'.
        AUDIT (
          name measurement_3034639_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3034639
  AND unit_concept_id NOT IN (8713, 8840, 9579, 8923);;

-- Description: Plausible unit check for concept 'Neutrophils [#/volume] in Blood by Automated count'.
        AUDIT (
          name measurement_3013650_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3013650
  AND unit_concept_id NOT IN (8784, 8848, 8961, 9444);;

-- Description: Plausible unit check for concept 'Globulin [Mass/volume] in Serum'.
        AUDIT (
          name measurement_3021886_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3021886
  AND unit_concept_id NOT IN (8636, 8713, 8950);;

-- Description: Plausible unit check for concept 'Lymphocyte count'.
        AUDIT (
          name measurement_4254663_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4254663
  AND unit_concept_id NOT IN (8848, 9444);;

-- Description: Plausible unit check for concept 'Magnesium [Mass/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3001420_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3001420
  AND unit_concept_id NOT IN (8840);;

-- Description: Plausible unit check for concept 'Platelets [#/volume] in Blood'.
        AUDIT (
          name measurement_3007461_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3007461
  AND unit_concept_id NOT IN (8848, 8961, 9444, 32706);;

-- Description: Plausible unit check for concept 'MCH [Entitic mass] by Automated count'.
        AUDIT (
          name measurement_3012030_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3012030
  AND unit_concept_id NOT IN (8564);;

-- Description: Plausible unit check for concept 'Glomerular filtration rate/1.73 sq M.predicted [Volume Rate/Area] in Serum, Plasma or Blood by Creatinine-based formula (CKD-EPI)'.
        AUDIT (
          name measurement_40764999_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 40764999
  AND unit_concept_id NOT IN (720870, 8795);;

-- Description: Plausible unit check for concept 'Testosterone [Mass/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3008893_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3008893
  AND unit_concept_id NOT IN (8817);;

-- Description: Plausible unit check for concept 'Creatinine [Mass/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3016723_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3016723
  AND unit_concept_id NOT IN (8840, 8749);;

-- Description: Plausible unit check for concept 'Gamma glutamyl transferase [Enzymatic activity/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3026910_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3026910
  AND unit_concept_id NOT IN (8645, 8923);;

-- Description: Plausible unit check for concept 'Monocytes [#/volume] in Blood by Automated count'.
        AUDIT (
          name measurement_3033575_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3033575
  AND unit_concept_id NOT IN (8784, 8816, 8848, 8961, 9436, 9444);;

-- Description: Plausible unit check for concept 'Immature granulocytes [#/volume] in Blood by Automated count'.
        AUDIT (
          name measurement_3041084_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3041084
  AND unit_concept_id NOT IN (8848, 8961, 9444);;

-- Description: Plausible unit check for concept 'Hemoglobin A1c measurement'.
        AUDIT (
          name measurement_4184637_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4184637
  AND unit_concept_id NOT IN (8554, 8632, 8737, 9579);;

-- Description: Plausible unit check for concept 'Respiratory rate'.
        AUDIT (
          name measurement_4313591_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4313591
  AND unit_concept_id NOT IN (8483, 8541);;

-- Description: Plausible unit check for concept 'MCV - Mean corpuscular volume'.
        AUDIT (
          name measurement_37393851_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 37393851
  AND unit_concept_id NOT IN (8583);;

-- Description: Plausible unit check for concept 'Glomerular filtration rate/1.73 sq M.predicted [Volume Rate/Area] in Serum, Plasma or Blood by Creatinine-based formula (CKD-EPI 2021)'.
        AUDIT (
          name measurement_1619025_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 1619025
  AND unit_concept_id NOT IN (720870, 8795);;

-- Description: Plausible unit check for concept 'Basophils/100 leukocytes in Blood by Automated count'.
        AUDIT (
          name measurement_3013869_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3013869
  AND unit_concept_id NOT IN (8554);;

-- Description: Plausible unit check for concept 'Albumin/Protein.total in Serum or Plasma'.
        AUDIT (
          name measurement_3035472_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3035472
  AND unit_concept_id NOT IN (8554);;

-- Description: Plausible unit check for concept 'Anion gap in Blood'.
        AUDIT (
          name measurement_3039000_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3039000
  AND unit_concept_id NOT IN (8753, 9557);;

-- Description: Plausible unit check for concept 'Leukocytes [#/volume] in Blood by Automated count'.
        AUDIT (
          name measurement_3000905_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3000905
  AND unit_concept_id NOT IN (8816, 8848, 8961, 9436, 9444);;

-- Description: Plausible unit check for concept 'Carbon dioxide, total [Moles/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3015632_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3015632
  AND unit_concept_id NOT IN (8753, 9557);;

-- Description: Plausible unit check for concept 'Calcium.ionized/Calcium.total corrected for albumin in Blood'.
        AUDIT (
          name measurement_3032710_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3032710
  AND unit_concept_id NOT IN (8554);;

-- Description: Plausible unit check for concept 'HbA1c measurement (DCCT aligned)'.
        AUDIT (
          name measurement_4197971_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4197971
  AND unit_concept_id NOT IN (8554, 8632, 8737);;

-- Description: Plausible unit check for concept 'Immature granulocytes/100 leukocytes in Blood by Automated count'.
        AUDIT (
          name measurement_42869452_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 42869452
  AND unit_concept_id NOT IN (8554);;

-- Description: Plausible unit check for concept 'Cholesterol in LDL/Cholesterol in HDL [Mass Ratio] in Serum or Plasma'.
        AUDIT (
          name measurement_3002109_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3002109
  AND unit_concept_id NOT IN (8523, 8596, 8606);;

-- Description: Plausible unit check for concept 'Lymphocytes [#/volume] in Blood by Automated count'.
        AUDIT (
          name measurement_3004327_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3004327
  AND unit_concept_id NOT IN (8784, 8816, 8848, 8961, 9436, 9444);;

-- Description: Plausible unit check for concept 'Oral temperature'.
        AUDIT (
          name measurement_3006322_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3006322
  AND unit_concept_id NOT IN (586323);;

-- Description: Plausible unit check for concept 'Neutrophils/100 leukocytes in Blood by Automated count'.
        AUDIT (
          name measurement_3008342_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3008342
  AND unit_concept_id NOT IN (8554);;

-- Description: Plausible unit check for concept 'Protein [Mass/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3020630_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3020630
  AND unit_concept_id NOT IN (8636, 8713);;

-- Description: Plausible unit check for concept 'Ferritin [Mass/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3001122_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3001122
  AND unit_concept_id NOT IN (8748, 8842);;

-- Description: Plausible unit check for concept 'Hematocrit [Volume Fraction] of Blood'.
        AUDIT (
          name measurement_3009542_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3009542
  AND unit_concept_id NOT IN (8554);;

-- Description: Plausible unit check for concept 'Epithelial cells [#/area] in Urine sediment by Microscopy high power field'.
        AUDIT (
          name measurement_3010189_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3010189
  AND unit_concept_id NOT IN (8765, 8786);;

-- Description: Plausible unit check for concept 'Eosinophils/100 leukocytes in Blood by Automated count'.
        AUDIT (
          name measurement_3010457_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3010457
  AND unit_concept_id NOT IN (8554);;

-- Description: Plausible unit check for concept 'Platelet mean volume determination'.
        AUDIT (
          name measurement_4192368_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4192368
  AND unit_concept_id NOT IN (8583);;

-- Description: Plausible unit check for concept 'Chloride [Moles/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3014576_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3014576
  AND unit_concept_id NOT IN (8753, 9557);;

-- Description: Plausible unit check for concept 'Bilirubin.total [Mass/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3024128_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3024128
  AND unit_concept_id NOT IN (8840, 8749);;

-- Description: Plausible unit check for concept 'Urea nitrogen/Creatinine [Mass Ratio] in Serum or Plasma'.
        AUDIT (
          name measurement_3018311_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3018311
  AND unit_concept_id NOT IN (8523, 8554, 8596);;

-- Description: Plausible unit check for concept 'Body temperature'.
        AUDIT (
          name measurement_3020891_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3020891
  AND unit_concept_id NOT IN (586323, 9289);;

-- Description: Plausible unit check for concept 'Urate [Mass/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3037556_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3037556
  AND unit_concept_id NOT IN (8840, 8923);;

-- Description: Plausible unit check for concept 'Serum TSH (thyroid stimulating hormone) level'.
        AUDIT (
          name measurement_37399332_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 37399332
  AND unit_concept_id NOT IN (44777578, 9040);;

-- Description: Plausible unit check for concept 'Phosphate [Mass/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3011904_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3011904
  AND unit_concept_id NOT IN (8840);;

-- Description: Plausible unit check for concept 'Erythrocyte distribution width [Ratio] by Automated count'.
        AUDIT (
          name measurement_3019897_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3019897
  AND unit_concept_id NOT IN (8554);;

-- Description: Plausible unit check for concept 'Bacteria [#/area] in Urine sediment by Microscopy high power field'.
        AUDIT (
          name measurement_3025255_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3025255
  AND unit_concept_id NOT IN (8786);;

-- Description: Plausible unit check for concept 'High density lipoprotein measurement'.
        AUDIT (
          name measurement_4076704_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4076704
  AND unit_concept_id NOT IN (8753, 8840);;

-- Description: Plausible unit check for concept 'Basophil count'.
        AUDIT (
          name measurement_4172647_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4172647
  AND unit_concept_id NOT IN (8848, 8961, 9444);;

-- Description: Plausible unit check for concept 'Serum alanine aminotransferase level'.
        AUDIT (
          name measurement_37393531_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 37393531
  AND unit_concept_id NOT IN (32995, 8645, 8923);;

-- Description: Plausible unit check for concept 'Immature granulocytes/100 leukocytes in Body fluid'.
        AUDIT (
          name measurement_40771529_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 40771529
  AND unit_concept_id NOT IN (8554);;

-- Description: Plausible unit check for concept 'Microalbumin [Mass/volume] in Urine'.
        AUDIT (
          name measurement_3000034_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3000034
  AND unit_concept_id NOT IN (8576, 8723, 8751, 8840, 8859, 8636);;

-- Description: Plausible unit check for concept 'Erythrocytes [#/area] in Urine sediment by Microscopy high power field'.
        AUDIT (
          name measurement_3035124_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3035124
  AND unit_concept_id NOT IN (8786, 8889);;

-- Description: Plausible unit check for concept 'Lymphocytes/100 leukocytes in Blood'.
        AUDIT (
          name measurement_3002030_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3002030
  AND unit_concept_id NOT IN (8554, 8848);;

-- Description: Plausible unit check for concept 'Thyrotropin [Units/volume] in Serum or Plasma by Detection limit <= 0.005 mIU/L'.
        AUDIT (
          name measurement_3019170_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3019170
  AND unit_concept_id NOT IN (44777578, 8719, 8860, 9040, 9093, 9550);;

-- Description: Plausible unit check for concept '25-hydroxyvitamin D3 [Mass/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3020149_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3020149
  AND unit_concept_id NOT IN (8842);;

-- Description: Plausible unit check for concept 'Leukocytes [#/volume] in Body fluid'.
        AUDIT (
          name measurement_3022174_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3022174
  AND unit_concept_id NOT IN (8647, 8784, 8785, 8848, 8961);;

-- Description: Plausible unit check for concept 'Platelets [#/volume] in Blood by Automated count'.
        AUDIT (
          name measurement_3024929_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3024929
  AND unit_concept_id NOT IN (8816, 8848, 8961, 9436, 9444);;

-- Description: Plausible unit check for concept 'Glomerular filtration rate/1.73 sq M.predicted among non-blacks [Volume Rate/Area] in Serum, Plasma or Blood by Creatinine-based formula (MDRD)'.
        AUDIT (
          name measurement_3049187_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3049187
  AND unit_concept_id NOT IN (720870, 8795);;

-- Description: Plausible unit check for concept 'Basophil count'.
        AUDIT (
          name measurement_37398676_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 37398676
  AND unit_concept_id NOT IN (8848);;

-- Description: Plausible unit check for concept 'BUN/Creatinine ratio'.
        AUDIT (
          name measurement_4112223_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4112223
  AND unit_concept_id NOT IN (8523, 8596);;

-- Description: Plausible unit check for concept 'Creatinine [Mass/volume] in Urine'.
        AUDIT (
          name measurement_3017250_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3017250
  AND unit_concept_id NOT IN (8576, 8840);;

-- Description: Plausible unit check for concept 'Calculated LDL cholesterol level'.
        AUDIT (
          name measurement_4191837_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 4191837
  AND unit_concept_id NOT IN (8840, 8753);;

-- Description: Plausible unit check for concept 'Basophils/100 leukocytes in Blood'.
        AUDIT (
          name measurement_3022096_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3022096
  AND unit_concept_id NOT IN (8554);;

-- Description: Plausible unit check for concept 'Albumin/Creatinine [Mass Ratio] in Urine'.
        AUDIT (
          name measurement_3034485_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3034485
  AND unit_concept_id NOT IN (8523, 8723, 8838, 9017, 9072);;

-- Description: Plausible unit check for concept 'Glomerular filtration rate testing'.
        AUDIT (
          name measurement_44790183_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 44790183
  AND unit_concept_id NOT IN (720870, 8795);;

-- Description: Plausible unit check for concept 'Iron [Mass/volume] in Serum or Plasma'.
        AUDIT (
          name measurement_3002400_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3002400
  AND unit_concept_id NOT IN (8749, 8837);;

-- Description: Plausible unit check for concept 'MCHC [Mass/volume]'.
        AUDIT (
          name measurement_3003338_unit,
          dialect duckdb,
          blocking FALSE
        );
        SELECT *
FROM omop.MEASUREMENT
WHERE MEASUREMENT_CONCEPT_ID = 3003338
  AND unit_concept_id NOT IN (8713, 8753);;

