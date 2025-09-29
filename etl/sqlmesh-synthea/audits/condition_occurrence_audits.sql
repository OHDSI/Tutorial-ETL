-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.condition_occurrence,
--   depends_on (
--     vocab.concept,
--     vocab.concept_ancestor,
--     omop.person,
--     omop.provider,
--     omop.visit_detail,
--     omop.visit_occurrence,
--   ),
--   audits (
--     person_completeness_condition_occurrence,
--     condition_occurrence_condition_concept_id_is_required,
--     condition_occurrence_condition_concept_id_is_foreign_key,
--     condition_occurrence_condition_concept_id_fk_domain,
--     condition_occurrence_condition_concept_id_is_standard_valid_concept,
--     condition_occurrence_condition_concept_id_standard_concept_record_completeness,
--     condition_occurrence_condition_end_date_after_birth,
--     condition_occurrence_condition_end_datetime_after_birth,
--     condition_occurrence_condition_occurrence_id_is_required,
--     condition_occurrence_condition_occurrence_id_is_primary_key,
--     condition_occurrence_condition_source_concept_id_is_foreign_key,
--     condition_occurrence_condition_start_date_is_required,
--     condition_occurrence_condition_start_date_start_before_end,
--     condition_occurrence_condition_start_date_after_birth,
--     condition_occurrence_condition_start_datetime_start_before_end,
--     condition_occurrence_condition_start_datetime_after_birth,
--     condition_occurrence_condition_status_concept_id_is_foreign_key,
--     condition_occurrence_condition_status_concept_id_fk_domain,
--     condition_occurrence_condition_status_concept_id_is_standard_valid_concept,
--     condition_occurrence_condition_status_concept_id_standard_concept_record_completeness,
--     condition_occurrence_condition_type_concept_id_is_required,
--     condition_occurrence_condition_type_concept_id_is_foreign_key,
--     condition_occurrence_condition_type_concept_id_fk_domain,
--     condition_occurrence_condition_type_concept_id_is_standard_valid_concept,
--     condition_occurrence_condition_type_concept_id_standard_concept_record_completeness,
--     condition_occurrence_person_id_is_required,
--     condition_occurrence_person_id_is_foreign_key,
--     condition_occurrence_provider_id_is_foreign_key,
--     condition_occurrence_visit_detail_id_is_foreign_key,
--     condition_occurrence_visit_occurrence_id_is_foreign_key,
--     condition_occurrence_26662_gender,
--     condition_occurrence_26935_gender,
--     condition_occurrence_30969_gender,
--     condition_occurrence_73801_gender,
--     condition_occurrence_74322_gender,
--     condition_occurrence_78193_gender,
--     condition_occurrence_79758_gender,
--     condition_occurrence_80180_valid_low,
--     condition_occurrence_80180_valid_high,
--     condition_occurrence_80180_temp,
--     condition_occurrence_80809_valid_low,
--     condition_occurrence_80809_valid_high,
--     condition_occurrence_80809_temp,
--     condition_occurrence_81893_valid_low,
--     condition_occurrence_81893_valid_high,
--     condition_occurrence_81893_temp,
--     condition_occurrence_81902_valid_low,
--     condition_occurrence_81902_valid_high,
--     condition_occurrence_81902_temp,
--     condition_occurrence_140168_valid_low,
--     condition_occurrence_140168_valid_high,
--     condition_occurrence_140168_temp,
--     condition_occurrence_141917_gender,
--     condition_occurrence_192367_gender,
--     condition_occurrence_192671_valid_low,
--     condition_occurrence_192671_valid_high,
--     condition_occurrence_192671_temp,
--     condition_occurrence_192676_gender,
--     condition_occurrence_192683_gender,
--     condition_occurrence_192854_gender,
--     condition_occurrence_192858_gender,
--     condition_occurrence_193254_gender,
--     condition_occurrence_193261_gender,
--     condition_occurrence_193262_gender,
--     condition_occurrence_193277_gender,
--     condition_occurrence_193437_gender,
--     condition_occurrence_193439_gender,
--     condition_occurrence_193522_gender,
--     condition_occurrence_193530_gender,
--     condition_occurrence_193739_gender,
--     condition_occurrence_193818_gender,
--     condition_occurrence_194092_gender,
--     condition_occurrence_194286_gender,
--     condition_occurrence_194412_gender,
--     condition_occurrence_194420_gender,
--     condition_occurrence_194611_gender,
--     condition_occurrence_194696_gender,
--     condition_occurrence_194871_gender,
--     condition_occurrence_194997_gender,
--     condition_occurrence_195009_gender,
--     condition_occurrence_195012_gender,
--     condition_occurrence_195197_gender,
--     condition_occurrence_195316_gender,
--     condition_occurrence_195321_gender,
--     condition_occurrence_195483_gender,
--     condition_occurrence_195500_gender,
--     condition_occurrence_195501_gender,
--     condition_occurrence_195683_gender,
--     condition_occurrence_195769_gender,
--     condition_occurrence_195770_gender,
--     condition_occurrence_195793_gender,
--     condition_occurrence_195867_gender,
--     condition_occurrence_195873_gender,
--     condition_occurrence_196048_gender,
--     condition_occurrence_196051_gender,
--     condition_occurrence_196068_gender,
--     condition_occurrence_196157_gender,
--     condition_occurrence_196158_gender,
--     condition_occurrence_196163_gender,
--     condition_occurrence_196165_gender,
--     condition_occurrence_196168_gender,
--     condition_occurrence_196359_gender,
--     condition_occurrence_196364_gender,
--     condition_occurrence_196473_gender,
--     condition_occurrence_196734_gender,
--     condition_occurrence_196738_gender,
--     condition_occurrence_196758_gender,
--     condition_occurrence_197032_gender,
--     condition_occurrence_197039_gender,
--     condition_occurrence_197044_gender,
--     condition_occurrence_197236_gender,
--     condition_occurrence_197237_gender,
--     condition_occurrence_197494_valid_low,
--     condition_occurrence_197494_valid_high,
--     condition_occurrence_197494_temp,
--     condition_occurrence_197507_gender,
--     condition_occurrence_197508_valid_low,
--     condition_occurrence_197508_valid_high,
--     condition_occurrence_197508_temp,
--     condition_occurrence_197601_gender,
--     condition_occurrence_197605_gender,
--     condition_occurrence_197606_gender,
--     condition_occurrence_197607_gender,
--     condition_occurrence_197609_gender,
--     condition_occurrence_197610_gender,
--     condition_occurrence_197938_gender,
--     condition_occurrence_198082_gender,
--     condition_occurrence_198108_gender,
--     condition_occurrence_198194_gender,
--     condition_occurrence_198197_gender,
--     condition_occurrence_198198_gender,
--     condition_occurrence_198202_gender,
--     condition_occurrence_198212_gender,
--     condition_occurrence_198363_gender,
--     condition_occurrence_198471_gender,
--     condition_occurrence_198483_gender,
--     condition_occurrence_198803_gender,
--     condition_occurrence_198806_gender,
--     condition_occurrence_199067_gender,
--     condition_occurrence_199078_gender,
--     condition_occurrence_199752_gender,
--     condition_occurrence_199764_gender,
--     condition_occurrence_199876_gender,
--     condition_occurrence_199877_gender,
--     condition_occurrence_199878_gender,
--     condition_occurrence_199881_gender,
--     condition_occurrence_200051_gender,
--     condition_occurrence_200052_gender,
--     condition_occurrence_200147_gender,
--     condition_occurrence_200445_gender,
--     condition_occurrence_200452_gender,
--     condition_occurrence_200461_gender,
--     condition_occurrence_200670_gender,
--     condition_occurrence_200675_gender,
--     condition_occurrence_200775_gender,
--     condition_occurrence_200779_gender,
--     condition_occurrence_200780_gender,
--     condition_occurrence_200962_valid_low,
--     condition_occurrence_200962_valid_high,
--     condition_occurrence_200962_gender,
--     condition_occurrence_200962_temp,
--     condition_occurrence_200970_gender,
--     condition_occurrence_201072_gender,
--     condition_occurrence_201078_gender,
--     condition_occurrence_201211_gender,
--     condition_occurrence_201238_gender,
--     condition_occurrence_201244_gender,
--     condition_occurrence_201257_gender,
--     condition_occurrence_201346_gender,
--     condition_occurrence_201355_gender,
--     condition_occurrence_201527_gender,
--     condition_occurrence_201606_valid_low,
--     condition_occurrence_201606_valid_high,
--     condition_occurrence_201606_temp,
--     condition_occurrence_201617_gender,
--     condition_occurrence_201625_gender,
--     condition_occurrence_201801_gender,
--     condition_occurrence_201817_gender,
--     condition_occurrence_201820_valid_low,
--     condition_occurrence_201820_valid_high,
--     condition_occurrence_201820_temp,
--     condition_occurrence_201823_gender,
--     condition_occurrence_201907_gender,
--     condition_occurrence_201909_gender,
--     condition_occurrence_201913_gender,
--     condition_occurrence_255573_valid_low,
--     condition_occurrence_255573_valid_high,
--     condition_occurrence_255573_temp,
--     condition_occurrence_255848_valid_low,
--     condition_occurrence_255848_valid_high,
--     condition_occurrence_255848_temp,
--     condition_occurrence_313217_valid_low,
--     condition_occurrence_313217_valid_high,
--     condition_occurrence_313217_temp,
--     condition_occurrence_314409_gender,
--     condition_occurrence_315586_gender,
--     condition_occurrence_316139_valid_low,
--     condition_occurrence_316139_valid_high,
--     condition_occurrence_316139_temp,
--     condition_occurrence_316866_valid_low,
--     condition_occurrence_316866_valid_high,
--     condition_occurrence_316866_temp,
--     condition_occurrence_317576_valid_low,
--     condition_occurrence_317576_valid_high,
--     condition_occurrence_317576_temp,
--     condition_occurrence_318800_valid_low,
--     condition_occurrence_318800_valid_high,
--     condition_occurrence_318800_temp,
--     condition_occurrence_321052_valid_low,
--     condition_occurrence_321052_valid_high,
--     condition_occurrence_321052_temp,
--     condition_occurrence_321588_valid_low,
--     condition_occurrence_321588_valid_high,
--     condition_occurrence_321588_temp,
--     condition_occurrence_381591_valid_low,
--     condition_occurrence_381591_valid_high,
--     condition_occurrence_381591_temp,
--     condition_occurrence_432571_valid_low,
--     condition_occurrence_432571_valid_high,
--     condition_occurrence_432571_temp,
--     condition_occurrence_432867_valid_low,
--     condition_occurrence_432867_valid_high,
--     condition_occurrence_432867_temp,
--     condition_occurrence_433716_gender,
--     condition_occurrence_433736_valid_low,
--     condition_occurrence_433736_valid_high,
--     condition_occurrence_433736_temp,
--     condition_occurrence_434251_gender,
--     condition_occurrence_435315_gender,
--     condition_occurrence_435648_gender,
--     condition_occurrence_435783_valid_low,
--     condition_occurrence_435783_valid_high,
--     condition_occurrence_435783_temp,
--     condition_occurrence_436155_gender,
--     condition_occurrence_436358_gender,
--     condition_occurrence_436366_gender,
--     condition_occurrence_436466_gender,
--     condition_occurrence_437501_gender,
--     condition_occurrence_437655_gender,
--     condition_occurrence_438409_valid_low,
--     condition_occurrence_438409_valid_high,
--     condition_occurrence_438409_temp,
--     condition_occurrence_438477_gender,
--     condition_occurrence_439727_valid_low,
--     condition_occurrence_439727_valid_high,
--     condition_occurrence_439727_temp,
--     condition_occurrence_439871_gender,
--     condition_occurrence_440383_valid_low,
--     condition_occurrence_440383_valid_high,
--     condition_occurrence_440383_temp,
--     condition_occurrence_440417_valid_low,
--     condition_occurrence_440417_valid_high,
--     condition_occurrence_440417_temp,
--     condition_occurrence_440971_gender,
--     condition_occurrence_441068_gender,
--     condition_occurrence_441077_gender,
--     condition_occurrence_441805_gender,
--     condition_occurrence_442781_gender,
--     condition_occurrence_443211_gender,
--     condition_occurrence_443388_valid_low,
--     condition_occurrence_443388_valid_high,
--     condition_occurrence_443388_temp,
--     condition_occurrence_443392_valid_low,
--     condition_occurrence_443392_valid_high,
--     condition_occurrence_443392_temp,
--     condition_occurrence_443435_gender,
--     condition_occurrence_443800_gender,
--     condition_occurrence_444078_gender,
--     condition_occurrence_444106_gender,
--     condition_occurrence_444247_valid_low,
--     condition_occurrence_444247_valid_high,
--     condition_occurrence_444247_temp,
--     condition_occurrence_4005743_gender,
--     condition_occurrence_4005933_gender,
--     condition_occurrence_4006969_valid_low,
--     condition_occurrence_4006969_valid_high,
--     condition_occurrence_4006969_temp,
--     condition_occurrence_4012343_gender,
--     condition_occurrence_4016155_gender,
--     condition_occurrence_4030518_valid_low,
--     condition_occurrence_4030518_valid_high,
--     condition_occurrence_4030518_temp,
--     condition_occurrence_4032594_gender,
--     condition_occurrence_4044013_valid_low,
--     condition_occurrence_4044013_valid_high,
--     condition_occurrence_4044013_temp,
--     condition_occurrence_4048225_gender,
--     condition_occurrence_4050091_gender,
--     condition_occurrence_4051956_gender,
--     condition_occurrence_4054550_gender,
--     condition_occurrence_4056903_gender,
--     condition_occurrence_4060207_gender,
--     condition_occurrence_4060556_gender,
--     condition_occurrence_4060558_gender,
--     condition_occurrence_4060559_gender,
--     condition_occurrence_4061050_gender,
--     condition_occurrence_4071874_gender,
--     condition_occurrence_4081648_gender,
--     condition_occurrence_4090039_gender,
--     condition_occurrence_4092515_gender,
--     condition_occurrence_4093346_gender,
--     condition_occurrence_4095940_gender,
--     condition_occurrence_4104000_valid_low,
--     condition_occurrence_4104000_valid_high,
--     condition_occurrence_4104000_temp,
--     condition_occurrence_4109081_gender,
--     condition_occurrence_4112853_valid_low,
--     condition_occurrence_4112853_valid_high,
--     condition_occurrence_4112853_temp,
--     condition_occurrence_4128329_gender,
--     condition_occurrence_4129155_gender,
--     condition_occurrence_4134440_valid_low,
--     condition_occurrence_4134440_valid_high,
--     condition_occurrence_4134440_temp,
--     condition_occurrence_4140828_gender,
--     condition_occurrence_4143116_gender,
--     condition_occurrence_4147021_gender,
--     condition_occurrence_4149084_gender,
--     condition_occurrence_4150042_gender,
--     condition_occurrence_4150816_gender,
--     condition_occurrence_4155529_gender,
--     condition_occurrence_4156113_gender,
--     condition_occurrence_4162860_gender,
--     condition_occurrence_4163261_gender,
--     condition_occurrence_4171394_gender,
--     condition_occurrence_4171915_gender,
--     condition_occurrence_4180790_valid_low,
--     condition_occurrence_4180790_valid_high,
--     condition_occurrence_4180790_temp,
--     condition_occurrence_4180978_gender,
--     condition_occurrence_4182210_valid_low,
--     condition_occurrence_4182210_valid_high,
--     condition_occurrence_4182210_temp,
--     condition_occurrence_4185932_valid_low,
--     condition_occurrence_4185932_valid_high,
--     condition_occurrence_4185932_temp,
--     condition_occurrence_4194652_gender,
--     condition_occurrence_4199600_gender,
--     condition_occurrence_4212540_valid_low,
--     condition_occurrence_4212540_valid_high,
--     condition_occurrence_4212540_temp,
--     condition_occurrence_4235215_gender,
--     condition_occurrence_4260520_gender,
--     condition_occurrence_4270932_gender,
--     condition_occurrence_4279309_valid_low,
--     condition_occurrence_4279309_valid_high,
--     condition_occurrence_4279309_temp,
--     condition_occurrence_4279913_gender,
--     condition_occurrence_4281030_gender,
--     condition_occurrence_4294393_gender,
--     condition_occurrence_4295261_gender,
--     condition_occurrence_4303258_gender,
--     condition_occurrence_4320332_gender,
--     condition_occurrence_4339088_gender,
--     condition_occurrence_40481080_gender,
--     condition_occurrence_40481902_valid_low,
--     condition_occurrence_40481902_valid_high,
--     condition_occurrence_40481902_temp,
--     condition_occurrence_40482030_gender,
--     condition_occurrence_40482406_gender,
--     condition_occurrence_40483613_gender,
--     condition_occurrence_40490888_gender,
--     condition_occurrence_42709954_gender,
--     condition_occurrence_45757415_gender,
--     condition_occurrence_45766654_gender,
--     condition_occurrence_45770892_gender,
--     condition_occurrence_45772671_gender,
--     condition_occurrence_4090861_gender_desc,
--     condition_occurrence_4025213_gender_desc,
--     condition_occurrence_4095793_gender_desc,
--     condition_occurrence_443343_gender_desc,
--     condition_occurrence_4024004_gender_desc,
--     condition_occurrence_4172857_gender_desc,
--     condition_occurrence_444094_gender_desc,
--     condition_occurrence_197810_gender_desc,
--     condition_occurrence_4158481_gender_desc,
--   )
-- );

-- Description: Check for persons missing from table 'CONDITION_OCCURRENCE'.
        AUDIT (
          name person_completeness_condition_occurrence,
          dialect duckdb,
          blocking FALSE
        );
        SELECT p.person_id
FROM omop.person p
LEFT JOIN omop.CONDITION_OCCURRENCE e ON p.person_id = e.person_id
WHERE e.person_id IS NULL;;

-- Description: Check for NULLs in required field 'CONDITION_OCCURRENCE.CONDITION_CONCEPT_ID'.
AUDIT (
  name condition_occurrence_condition_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'CONDITION_OCCURRENCE.CONDITION_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name condition_occurrence_condition_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.CONDITION_OCCURRENCE c
LEFT JOIN vocab.concept p ON c.CONDITION_CONCEPT_ID = p.CONCEPT_ID
WHERE c.CONDITION_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'CONDITION_OCCURRENCE.CONDITION_CONCEPT_ID' belong to the 'Condition' domain.
        AUDIT (
          name condition_occurrence_condition_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN vocab.concept c ON t.CONDITION_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Condition';;

-- Description: Check that concepts in 'CONDITION_OCCURRENCE.CONDITION_CONCEPT_ID' are standard and valid.
        AUDIT (
          name condition_occurrence_condition_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
LEFT JOIN vocab.concept c ON t.CONDITION_CONCEPT_ID = c.concept_id
WHERE t.CONDITION_CONCEPT_ID IS NOT NULL
  AND t.CONDITION_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'CONDITION_OCCURRENCE.CONDITION_CONCEPT_ID'.
AUDIT (
  name condition_occurrence_condition_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 0;

-- Description: Check that date 'CONDITION_OCCURRENCE.CONDITION_END_DATE' is after person's birth date.
        AUDIT (
          name condition_occurrence_condition_end_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_END_DATE < p.birth_datetime;;

-- Description: Check that date 'CONDITION_OCCURRENCE.CONDITION_END_DATETIME' is after person's birth date.
        AUDIT (
          name condition_occurrence_condition_end_datetime_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_END_DATETIME < p.birth_datetime;;

-- Description: Check for NULLs in required field 'CONDITION_OCCURRENCE.CONDITION_OCCURRENCE_ID'.
AUDIT (
  name condition_occurrence_condition_occurrence_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_OCCURRENCE_ID IS NULL;

-- Description: Check for duplicate values in primary key field 'CONDITION_OCCURRENCE.CONDITION_OCCURRENCE_ID'.
        AUDIT (
          name condition_occurrence_condition_occurrence_id_is_primary_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT CONDITION_OCCURRENCE_ID, COUNT(*)
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_OCCURRENCE_ID IS NOT NULL
GROUP BY CONDITION_OCCURRENCE_ID
HAVING COUNT(*) > 1;;

-- Description: Check for orphaned foreign keys in 'CONDITION_OCCURRENCE.CONDITION_SOURCE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name condition_occurrence_condition_source_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.CONDITION_OCCURRENCE c
LEFT JOIN vocab.concept p ON c.CONDITION_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.CONDITION_SOURCE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'CONDITION_OCCURRENCE.CONDITION_START_DATE'.
AUDIT (
  name condition_occurrence_condition_start_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_START_DATE IS NULL;

-- Description: Check that 'CONDITION_OCCURRENCE.CONDITION_START_DATE' occurs before 'CONDITION_OCCURRENCE.CONDITION_END_DATE'.
AUDIT (
  name condition_occurrence_condition_start_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_START_DATE > CONDITION_END_DATE;

-- Description: Check that date 'CONDITION_OCCURRENCE.CONDITION_START_DATE' is after person's birth date.
        AUDIT (
          name condition_occurrence_condition_start_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_START_DATE < p.birth_datetime;;

-- Description: Check that 'CONDITION_OCCURRENCE.CONDITION_START_DATETIME' occurs before 'CONDITION_OCCURRENCE.CONDITION_END_DATETIME'.
AUDIT (
  name condition_occurrence_condition_start_datetime_start_before_end,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_START_DATETIME > CONDITION_END_DATETIME;

-- Description: Check that date 'CONDITION_OCCURRENCE.CONDITION_START_DATETIME' is after person's birth date.
        AUDIT (
          name condition_occurrence_condition_start_datetime_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_START_DATETIME < p.birth_datetime;;

-- Description: Check for orphaned foreign keys in 'CONDITION_OCCURRENCE.CONDITION_STATUS_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name condition_occurrence_condition_status_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.CONDITION_OCCURRENCE c
LEFT JOIN vocab.concept p ON c.CONDITION_STATUS_CONCEPT_ID = p.CONCEPT_ID
WHERE c.CONDITION_STATUS_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'CONDITION_OCCURRENCE.CONDITION_STATUS_CONCEPT_ID' belong to the 'Condition Status' domain.
        AUDIT (
          name condition_occurrence_condition_status_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN vocab.concept c ON t.CONDITION_STATUS_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Condition Status';;

-- Description: Check that concepts in 'CONDITION_OCCURRENCE.CONDITION_STATUS_CONCEPT_ID' are standard and valid.
        AUDIT (
          name condition_occurrence_condition_status_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
LEFT JOIN vocab.concept c ON t.CONDITION_STATUS_CONCEPT_ID = c.concept_id
WHERE t.CONDITION_STATUS_CONCEPT_ID IS NOT NULL
  AND t.CONDITION_STATUS_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'CONDITION_OCCURRENCE.CONDITION_STATUS_CONCEPT_ID'.
AUDIT (
  name condition_occurrence_condition_status_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_STATUS_CONCEPT_ID = 0;

-- Description: Check for NULLs in required field 'CONDITION_OCCURRENCE.CONDITION_TYPE_CONCEPT_ID'.
AUDIT (
  name condition_occurrence_condition_type_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_TYPE_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'CONDITION_OCCURRENCE.CONDITION_TYPE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name condition_occurrence_condition_type_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.CONDITION_OCCURRENCE c
LEFT JOIN vocab.concept p ON c.CONDITION_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.CONDITION_TYPE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'CONDITION_OCCURRENCE.CONDITION_TYPE_CONCEPT_ID' belong to the 'Type Concept' domain.
        AUDIT (
          name condition_occurrence_condition_type_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN vocab.concept c ON t.CONDITION_TYPE_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Type Concept';;

-- Description: Check that concepts in 'CONDITION_OCCURRENCE.CONDITION_TYPE_CONCEPT_ID' are standard and valid.
        AUDIT (
          name condition_occurrence_condition_type_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
LEFT JOIN vocab.concept c ON t.CONDITION_TYPE_CONCEPT_ID = c.concept_id
WHERE t.CONDITION_TYPE_CONCEPT_ID IS NOT NULL
  AND t.CONDITION_TYPE_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'CONDITION_OCCURRENCE.CONDITION_TYPE_CONCEPT_ID'.
AUDIT (
  name condition_occurrence_condition_type_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_TYPE_CONCEPT_ID = 0;

-- Description: Check for NULLs in required field 'CONDITION_OCCURRENCE.PERSON_ID'.
AUDIT (
  name condition_occurrence_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.CONDITION_OCCURRENCE WHERE PERSON_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'CONDITION_OCCURRENCE.PERSON_ID' pointing to 'PERSON.PERSON_ID'.
        AUDIT (
          name condition_occurrence_person_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.CONDITION_OCCURRENCE c
LEFT JOIN omop.PERSON p ON c.PERSON_ID = p.PERSON_ID
WHERE c.PERSON_ID IS NOT NULL AND p.PERSON_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'CONDITION_OCCURRENCE.PROVIDER_ID' pointing to 'PROVIDER.PROVIDER_ID'.
        AUDIT (
          name condition_occurrence_provider_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.CONDITION_OCCURRENCE c
LEFT JOIN omop.PROVIDER p ON c.PROVIDER_ID = p.PROVIDER_ID
WHERE c.PROVIDER_ID IS NOT NULL AND p.PROVIDER_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'CONDITION_OCCURRENCE.VISIT_DETAIL_ID' pointing to 'VISIT_DETAIL.VISIT_DETAIL_ID'.
        AUDIT (
          name condition_occurrence_visit_detail_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.CONDITION_OCCURRENCE c
LEFT JOIN omop.VISIT_DETAIL p ON c.VISIT_DETAIL_ID = p.VISIT_DETAIL_ID
WHERE c.VISIT_DETAIL_ID IS NOT NULL AND p.VISIT_DETAIL_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'CONDITION_OCCURRENCE.VISIT_OCCURRENCE_ID' pointing to 'VISIT_OCCURRENCE.VISIT_OCCURRENCE_ID'.
        AUDIT (
          name condition_occurrence_visit_occurrence_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.CONDITION_OCCURRENCE c
LEFT JOIN omop.VISIT_OCCURRENCE p ON c.VISIT_OCCURRENCE_ID = p.VISIT_OCCURRENCE_ID
WHERE c.VISIT_OCCURRENCE_ID IS NOT NULL AND p.VISIT_OCCURRENCE_ID IS NULL;;

-- Description: Gender check for concept 'Testicular hypofunction'.
        AUDIT (
          name condition_occurrence_26662_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 26662
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Disorder of endocrine testis'.
        AUDIT (
          name condition_occurrence_26935_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 26935
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Testicular hyperfunction'.
        AUDIT (
          name condition_occurrence_30969_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 30969
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Scrotal varices'.
        AUDIT (
          name condition_occurrence_73801_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 73801
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Benign neoplasm of scrotum'.
        AUDIT (
          name condition_occurrence_74322_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 74322
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Orchitis and epididymitis'.
        AUDIT (
          name condition_occurrence_78193_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 78193
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Primary malignant neoplasm of scrotum'.
        AUDIT (
          name condition_occurrence_79758_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 79758
  AND p.gender_concept_id <> 8507;;

-- Description: Prevalence of concept 'Osteoarthritis' in 'CONDITION_OCCURRENCE' is below 0.0584.
        AUDIT (
          name condition_occurrence_80180_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 80180
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 80180 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0584;;

-- Description: Prevalence of concept 'Osteoarthritis' in 'CONDITION_OCCURRENCE' is above 0.5252.
        AUDIT (
          name condition_occurrence_80180_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 80180
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 80180 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.5252;;

-- Description: Temporal constancy check for concept 'Osteoarthritis'.
        AUDIT (
          name condition_occurrence_80180_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 80180
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Prevalence of concept 'Rheumatoid arthritis' in 'CONDITION_OCCURRENCE' is below 0.0045.
        AUDIT (
          name condition_occurrence_80809_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 80809
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 80809 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0045;;

-- Description: Prevalence of concept 'Rheumatoid arthritis' in 'CONDITION_OCCURRENCE' is above 0.0405.
        AUDIT (
          name condition_occurrence_80809_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 80809
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 80809 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.0405;;

-- Description: Temporal constancy check for concept 'Rheumatoid arthritis'.
        AUDIT (
          name condition_occurrence_80809_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 80809
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Prevalence of concept 'Ulcerative colitis' in 'CONDITION_OCCURRENCE' is below 0.0014.
        AUDIT (
          name condition_occurrence_81893_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 81893
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 81893 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0014;;

-- Description: Prevalence of concept 'Ulcerative colitis' in 'CONDITION_OCCURRENCE' is above 0.0128.
        AUDIT (
          name condition_occurrence_81893_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 81893
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 81893 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.0128;;

-- Description: Temporal constancy check for concept 'Ulcerative colitis'.
        AUDIT (
          name condition_occurrence_81893_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 81893
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Prevalence of concept 'Urinary tract infectious disease' in 'CONDITION_OCCURRENCE' is below 0.0412.
        AUDIT (
          name condition_occurrence_81902_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 81902
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 81902 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0412;;

-- Description: Prevalence of concept 'Urinary tract infectious disease' in 'CONDITION_OCCURRENCE' is above 0.371.
        AUDIT (
          name condition_occurrence_81902_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 81902
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 81902 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.371;;

-- Description: Temporal constancy check for concept 'Urinary tract infectious disease'.
        AUDIT (
          name condition_occurrence_81902_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 81902
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Prevalence of concept 'Psoriasis' in 'CONDITION_OCCURRENCE' is below 0.0055.
        AUDIT (
          name condition_occurrence_140168_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 140168
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 140168 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0055;;

-- Description: Prevalence of concept 'Psoriasis' in 'CONDITION_OCCURRENCE' is above 0.0494.
        AUDIT (
          name condition_occurrence_140168_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 140168
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 140168 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.0494;;

-- Description: Temporal constancy check for concept 'Psoriasis'.
        AUDIT (
          name condition_occurrence_140168_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 140168
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Gender check for concept 'Balanitis xerotica obliterans'.
        AUDIT (
          name condition_occurrence_141917_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 141917
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Dysplasia of cervix'.
        AUDIT (
          name condition_occurrence_192367_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 192367
  AND p.gender_concept_id <> 8532;;

-- Description: Prevalence of concept 'Gastrointestinal hemorrhage' in 'CONDITION_OCCURRENCE' is below 0.0135.
        AUDIT (
          name condition_occurrence_192671_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 192671
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 192671 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0135;;

-- Description: Prevalence of concept 'Gastrointestinal hemorrhage' in 'CONDITION_OCCURRENCE' is above 0.1219.
        AUDIT (
          name condition_occurrence_192671_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 192671
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 192671 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.1219;;

-- Description: Temporal constancy check for concept 'Gastrointestinal hemorrhage'.
        AUDIT (
          name condition_occurrence_192671_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 192671
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Gender check for concept 'Cervical intraepithelial neoplasia grade 1'.
        AUDIT (
          name condition_occurrence_192676_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 192676
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Uterovaginal prolapse'.
        AUDIT (
          name condition_occurrence_192683_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 192683
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Intramural leiomyoma of uterus'.
        AUDIT (
          name condition_occurrence_192854_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 192854
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Ovarian hyperfunction'.
        AUDIT (
          name condition_occurrence_192858_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 192858
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Disorder of vagina'.
        AUDIT (
          name condition_occurrence_193254_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 193254
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Vaginospasm'.
        AUDIT (
          name condition_occurrence_193261_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 193261
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Inflammatory disorder of penis'.
        AUDIT (
          name condition_occurrence_193262_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 193262
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Deliveries by cesarean'.
        AUDIT (
          name condition_occurrence_193277_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 193277
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Neoplasm of uncertain behavior of female genital organ'.
        AUDIT (
          name condition_occurrence_193437_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 193437
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Benign neoplasm of body of uterus'.
        AUDIT (
          name condition_occurrence_193439_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 193439
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Acute prostatitis'.
        AUDIT (
          name condition_occurrence_193522_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 193522
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Follicular cyst of ovary'.
        AUDIT (
          name condition_occurrence_193530_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 193530
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Ovarian failure'.
        AUDIT (
          name condition_occurrence_193739_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 193739
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Calculus of prostate'.
        AUDIT (
          name condition_occurrence_193818_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 193818
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Uterine prolapse without vaginal wall prolapse'.
        AUDIT (
          name condition_occurrence_194092_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 194092
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Malignant neoplasm of corpus uteri, excluding isthmus'.
        AUDIT (
          name condition_occurrence_194286_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 194286
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Dysplasia of vagina'.
        AUDIT (
          name condition_occurrence_194412_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 194412
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Endometriosis of fallopian tube'.
        AUDIT (
          name condition_occurrence_194420_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 194420
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Carcinoma in situ of uterine cervix'.
        AUDIT (
          name condition_occurrence_194611_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 194611
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Dysmenorrhea'.
        AUDIT (
          name condition_occurrence_194696_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 194696
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Trichomonal vulvovaginitis'.
        AUDIT (
          name condition_occurrence_194871_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 194871
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Prostatitis'.
        AUDIT (
          name condition_occurrence_194997_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 194997
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Leukoplakia of penis'.
        AUDIT (
          name condition_occurrence_195009_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 195009
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Intermenstrual bleeding - irregular'.
        AUDIT (
          name condition_occurrence_195012_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 195012
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Primary malignant neoplasm of vulva'.
        AUDIT (
          name condition_occurrence_195197_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 195197
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Atypical endometrial hyperplasia'.
        AUDIT (
          name condition_occurrence_195316_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 195316
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Postmenopausal bleeding'.
        AUDIT (
          name condition_occurrence_195321_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 195321
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Primary malignant neoplasm of penis'.
        AUDIT (
          name condition_occurrence_195483_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 195483
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Benign neoplasm of uterus'.
        AUDIT (
          name condition_occurrence_195500_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 195500
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Polycystic ovaries'.
        AUDIT (
          name condition_occurrence_195501_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 195501
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Open wound of penis without complication'.
        AUDIT (
          name condition_occurrence_195683_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 195683
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Submucous leiomyoma of uterus'.
        AUDIT (
          name condition_occurrence_195769_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 195769
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Subserous leiomyoma of uterus'.
        AUDIT (
          name condition_occurrence_195770_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 195770
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Neoplasm of uncertain behavior of uterus'.
        AUDIT (
          name condition_occurrence_195793_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 195793
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Noninflammatory disorder of the vagina'.
        AUDIT (
          name condition_occurrence_195867_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 195867
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Leukorrhea'.
        AUDIT (
          name condition_occurrence_195873_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 195873
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Primary malignant neoplasm of vagina'.
        AUDIT (
          name condition_occurrence_196048_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 196048
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Overlapping malignant neoplasm of female genital organs'.
        AUDIT (
          name condition_occurrence_196051_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 196051
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Carcinoma in situ of male genital organ'.
        AUDIT (
          name condition_occurrence_196068_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 196068
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Induratio penis plastica'.
        AUDIT (
          name condition_occurrence_196157_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 196157
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Disorder of penis'.
        AUDIT (
          name condition_occurrence_196158_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 196158
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Cervicitis and endocervicitis'.
        AUDIT (
          name condition_occurrence_196163_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 196163
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Cervical intraepithelial neoplasia grade 2'.
        AUDIT (
          name condition_occurrence_196165_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 196165
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Irregular periods'.
        AUDIT (
          name condition_occurrence_196168_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 196168
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Primary malignant neoplasm of uterine cervix'.
        AUDIT (
          name condition_occurrence_196359_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 196359
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Benign neoplasm of uterine cervix'.
        AUDIT (
          name condition_occurrence_196364_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 196364
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Hypertrophy of uterus'.
        AUDIT (
          name condition_occurrence_196473_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 196473
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Disorder of prostate'.
        AUDIT (
          name condition_occurrence_196734_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 196734
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Disorder of male genital organ'.
        AUDIT (
          name condition_occurrence_196738_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 196738
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Tumor of body of uterus affecting pregnancy'.
        AUDIT (
          name condition_occurrence_196758_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 196758
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Hyperplasia of prostate'.
        AUDIT (
          name condition_occurrence_197032_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 197032
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Male genital organ vascular diseases'.
        AUDIT (
          name condition_occurrence_197039_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 197039
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Female infertility associated with anovulation'.
        AUDIT (
          name condition_occurrence_197044_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 197044
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Uterine leiomyoma'.
        AUDIT (
          name condition_occurrence_197236_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 197236
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Benign neoplasm of prostate'.
        AUDIT (
          name condition_occurrence_197237_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 197237
  AND p.gender_concept_id <> 8507;;

-- Description: Prevalence of concept 'Viral hepatitis C' in 'CONDITION_OCCURRENCE' is below 0.0017.
        AUDIT (
          name condition_occurrence_197494_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 197494
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 197494 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0017;;

-- Description: Prevalence of concept 'Viral hepatitis C' in 'CONDITION_OCCURRENCE' is above 0.0155.
        AUDIT (
          name condition_occurrence_197494_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 197494
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 197494 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.0155;;

-- Description: Temporal constancy check for concept 'Viral hepatitis C'.
        AUDIT (
          name condition_occurrence_197494_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 197494
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Gender check for concept 'Primary malignant neoplasm of male genital organ'.
        AUDIT (
          name condition_occurrence_197507_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 197507
  AND p.gender_concept_id <> 8507;;

-- Description: Prevalence of concept 'Malignant tumor of urinary bladder' in 'CONDITION_OCCURRENCE' is below 0.0013.
        AUDIT (
          name condition_occurrence_197508_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 197508
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 197508 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0013;;

-- Description: Prevalence of concept 'Malignant tumor of urinary bladder' in 'CONDITION_OCCURRENCE' is above 0.0113.
        AUDIT (
          name condition_occurrence_197508_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 197508
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 197508 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.0113;;

-- Description: Temporal constancy check for concept 'Malignant tumor of urinary bladder'.
        AUDIT (
          name condition_occurrence_197508_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 197508
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Gender check for concept 'Spermatocele'.
        AUDIT (
          name condition_occurrence_197601_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 197601
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Inflammatory disorder of male genital organ'.
        AUDIT (
          name condition_occurrence_197605_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 197605
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Female infertility of tubal origin'.
        AUDIT (
          name condition_occurrence_197606_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 197606
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Excessive and frequent menstruation'.
        AUDIT (
          name condition_occurrence_197607_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 197607
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Cervical, vaginal and vulval inflammatory diseases'.
        AUDIT (
          name condition_occurrence_197609_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 197609
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Cyst of ovary'.
        AUDIT (
          name condition_occurrence_197610_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 197610
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Uterine inertia'.
        AUDIT (
          name condition_occurrence_197938_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 197938
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Overlapping malignant neoplasm of body of uterus'.
        AUDIT (
          name condition_occurrence_198082_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 198082
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Benign neoplasm of fallopian tubes and uterine ligaments'.
        AUDIT (
          name condition_occurrence_198108_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 198108
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Female genital organ symptoms'.
        AUDIT (
          name condition_occurrence_198194_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 198194
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Male infertility'.
        AUDIT (
          name condition_occurrence_198197_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 198197
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Polyp of vagina'.
        AUDIT (
          name condition_occurrence_198198_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 198198
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Cystocele'.
        AUDIT (
          name condition_occurrence_198202_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 198202
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Spotting per vagina in pregnancy'.
        AUDIT (
          name condition_occurrence_198212_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 198212
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Candidiasis of vagina'.
        AUDIT (
          name condition_occurrence_198363_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 198363
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Complex endometrial hyperplasia'.
        AUDIT (
          name condition_occurrence_198471_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 198471
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Stricture or atresia of the vagina'.
        AUDIT (
          name condition_occurrence_198483_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 198483
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Benign prostatic hyperplasia'.
        AUDIT (
          name condition_occurrence_198803_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 198803
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Abscess of prostate'.
        AUDIT (
          name condition_occurrence_198806_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 198806
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Female pelvic inflammatory disease'.
        AUDIT (
          name condition_occurrence_199067_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 199067
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Vaginal wall prolapse'.
        AUDIT (
          name condition_occurrence_199078_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 199078
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Secondary malignant neoplasm of ovary'.
        AUDIT (
          name condition_occurrence_199752_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 199752
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Benign neoplasm of ovary'.
        AUDIT (
          name condition_occurrence_199764_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 199764
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Prolapse of female genital organs'.
        AUDIT (
          name condition_occurrence_199876_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 199876
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Mucous polyp of cervix'.
        AUDIT (
          name condition_occurrence_199877_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 199877
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Light and infrequent menstruation'.
        AUDIT (
          name condition_occurrence_199878_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 199878
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Endometriosis of ovary'.
        AUDIT (
          name condition_occurrence_199881_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 199881
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Primary malignant neoplasm of ovary'.
        AUDIT (
          name condition_occurrence_200051_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 200051
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Primary malignant neoplasm of uterine adnexa'.
        AUDIT (
          name condition_occurrence_200052_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 200052
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Atrophy of prostate'.
        AUDIT (
          name condition_occurrence_200147_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 200147
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Chronic prostatitis'.
        AUDIT (
          name condition_occurrence_200445_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 200445
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Disorder of female genital organs'.
        AUDIT (
          name condition_occurrence_200452_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 200452
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Endometriosis of uterus'.
        AUDIT (
          name condition_occurrence_200461_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 200461
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Benign neoplasm of male genital organ'.
        AUDIT (
          name condition_occurrence_200670_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 200670
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Neoplasm of uncertain behavior of ovary'.
        AUDIT (
          name condition_occurrence_200675_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 200675
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Endometrial hyperplasia'.
        AUDIT (
          name condition_occurrence_200775_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 200775
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Polyp of corpus uteri'.
        AUDIT (
          name condition_occurrence_200779_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 200779
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Disorder of uterus'.
        AUDIT (
          name condition_occurrence_200780_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 200780
  AND p.gender_concept_id <> 8532;;

-- Description: Prevalence of concept 'Primary malignant neoplasm of prostate' in 'CONDITION_OCCURRENCE' is below 0.0052.
        AUDIT (
          name condition_occurrence_200962_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 200962
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 200962 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0052;;

-- Description: Prevalence of concept 'Primary malignant neoplasm of prostate' in 'CONDITION_OCCURRENCE' is above 0.0471.
        AUDIT (
          name condition_occurrence_200962_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 200962
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 200962 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.0471;;

-- Description: Gender check for concept 'Primary malignant neoplasm of prostate'.
        AUDIT (
          name condition_occurrence_200962_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 200962
  AND p.gender_concept_id <> 8507;;

-- Description: Temporal constancy check for concept 'Primary malignant neoplasm of prostate'.
        AUDIT (
          name condition_occurrence_200962_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 200962
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Gender check for concept 'Carcinoma in situ of prostate'.
        AUDIT (
          name condition_occurrence_200970_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 200970
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Benign prostatic hypertrophy without outflow obstruction'.
        AUDIT (
          name condition_occurrence_201072_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 201072
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Atrophic vaginitis'.
        AUDIT (
          name condition_occurrence_201078_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 201078
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Herpetic vulvovaginitis'.
        AUDIT (
          name condition_occurrence_201211_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 201211
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Primary malignant neoplasm of female genital organ'.
        AUDIT (
          name condition_occurrence_201238_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 201238
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Benign neoplasm of vagina'.
        AUDIT (
          name condition_occurrence_201244_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 201244
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Disorder of endocrine ovary'.
        AUDIT (
          name condition_occurrence_201257_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 201257
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Edema of penis'.
        AUDIT (
          name condition_occurrence_201346_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 201346
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Erosion and ectropion of the cervix'.
        AUDIT (
          name condition_occurrence_201355_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 201355
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Neoplasm of uncertain behavior of prostate'.
        AUDIT (
          name condition_occurrence_201527_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 201527
  AND p.gender_concept_id <> 8507;;

-- Description: Prevalence of concept 'Crohn's disease' in 'CONDITION_OCCURRENCE' is below 0.0012.
        AUDIT (
          name condition_occurrence_201606_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 201606
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 201606 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0012;;

-- Description: Prevalence of concept 'Crohn's disease' in 'CONDITION_OCCURRENCE' is above 0.0112.
        AUDIT (
          name condition_occurrence_201606_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 201606
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 201606 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.0112;;

-- Description: Temporal constancy check for concept 'Crohn's disease'.
        AUDIT (
          name condition_occurrence_201606_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 201606
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Gender check for concept 'Prostatic cyst'.
        AUDIT (
          name condition_occurrence_201617_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 201617
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Malposition of uterus'.
        AUDIT (
          name condition_occurrence_201625_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 201625
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Primary malignant neoplasm of fallopian tube'.
        AUDIT (
          name condition_occurrence_201801_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 201801
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Benign neoplasm of female genital organ'.
        AUDIT (
          name condition_occurrence_201817_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 201817
  AND p.gender_concept_id <> 8532;;

-- Description: Prevalence of concept 'Diabetes mellitus' in 'CONDITION_OCCURRENCE' is below 0.039.
        AUDIT (
          name condition_occurrence_201820_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 201820
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 201820 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.039;;

-- Description: Prevalence of concept 'Diabetes mellitus' in 'CONDITION_OCCURRENCE' is above 0.3514.
        AUDIT (
          name condition_occurrence_201820_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 201820
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 201820 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.3514;;

-- Description: Temporal constancy check for concept 'Diabetes mellitus'.
        AUDIT (
          name condition_occurrence_201820_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 201820
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Gender check for concept 'Benign neoplasm of penis'.
        AUDIT (
          name condition_occurrence_201823_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 201823
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Edema of male genital organs'.
        AUDIT (
          name condition_occurrence_201907_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 201907
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Female infertility'.
        AUDIT (
          name condition_occurrence_201909_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 201909
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Torsion of the ovary, ovarian pedicle or fallopian tube'.
        AUDIT (
          name condition_occurrence_201913_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 201913
  AND p.gender_concept_id <> 8532;;

-- Description: Prevalence of concept 'Chronic obstructive lung disease' in 'CONDITION_OCCURRENCE' is below 0.0194.
        AUDIT (
          name condition_occurrence_255573_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 255573
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 255573 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0194;;

-- Description: Prevalence of concept 'Chronic obstructive lung disease' in 'CONDITION_OCCURRENCE' is above 0.1742.
        AUDIT (
          name condition_occurrence_255573_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 255573
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 255573 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.1742;;

-- Description: Temporal constancy check for concept 'Chronic obstructive lung disease'.
        AUDIT (
          name condition_occurrence_255573_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 255573
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Prevalence of concept 'Pneumonia' in 'CONDITION_OCCURRENCE' is below 0.0218.
        AUDIT (
          name condition_occurrence_255848_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 255848
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 255848 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0218;;

-- Description: Prevalence of concept 'Pneumonia' in 'CONDITION_OCCURRENCE' is above 0.1966.
        AUDIT (
          name condition_occurrence_255848_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 255848
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 255848 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.1966;;

-- Description: Temporal constancy check for concept 'Pneumonia'.
        AUDIT (
          name condition_occurrence_255848_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 255848
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Prevalence of concept 'Atrial fibrillation' in 'CONDITION_OCCURRENCE' is below 0.0128.
        AUDIT (
          name condition_occurrence_313217_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 313217
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 313217 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0128;;

-- Description: Prevalence of concept 'Atrial fibrillation' in 'CONDITION_OCCURRENCE' is above 0.1155.
        AUDIT (
          name condition_occurrence_313217_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 313217
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 313217 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.1155;;

-- Description: Temporal constancy check for concept 'Atrial fibrillation'.
        AUDIT (
          name condition_occurrence_313217_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 313217
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Gender check for concept 'Vascular disorder of penis'.
        AUDIT (
          name condition_occurrence_314409_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 314409
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Priapism'.
        AUDIT (
          name condition_occurrence_315586_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 315586
  AND p.gender_concept_id <> 8507;;

-- Description: Prevalence of concept 'Heart failure' in 'CONDITION_OCCURRENCE' is below 0.0161.
        AUDIT (
          name condition_occurrence_316139_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 316139
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 316139 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0161;;

-- Description: Prevalence of concept 'Heart failure' in 'CONDITION_OCCURRENCE' is above 0.1452.
        AUDIT (
          name condition_occurrence_316139_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 316139
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 316139 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.1452;;

-- Description: Temporal constancy check for concept 'Heart failure'.
        AUDIT (
          name condition_occurrence_316139_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 316139
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Prevalence of concept 'Hypertensive disorder' in 'CONDITION_OCCURRENCE' is below 0.0913.
        AUDIT (
          name condition_occurrence_316866_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 316866
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 316866 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0913;;

-- Description: Prevalence of concept 'Hypertensive disorder' in 'CONDITION_OCCURRENCE' is above 0.8215.
        AUDIT (
          name condition_occurrence_316866_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 316866
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 316866 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.8215;;

-- Description: Temporal constancy check for concept 'Hypertensive disorder'.
        AUDIT (
          name condition_occurrence_316866_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 316866
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Prevalence of concept 'Coronary arteriosclerosis' in 'CONDITION_OCCURRENCE' is below 0.0206.
        AUDIT (
          name condition_occurrence_317576_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 317576
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 317576 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0206;;

-- Description: Prevalence of concept 'Coronary arteriosclerosis' in 'CONDITION_OCCURRENCE' is above 0.1852.
        AUDIT (
          name condition_occurrence_317576_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 317576
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 317576 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.1852;;

-- Description: Temporal constancy check for concept 'Coronary arteriosclerosis'.
        AUDIT (
          name condition_occurrence_317576_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 317576
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Prevalence of concept 'Gastroesophageal reflux disease' in 'CONDITION_OCCURRENCE' is below 0.0337.
        AUDIT (
          name condition_occurrence_318800_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 318800
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 318800 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0337;;

-- Description: Prevalence of concept 'Gastroesophageal reflux disease' in 'CONDITION_OCCURRENCE' is above 0.3033.
        AUDIT (
          name condition_occurrence_318800_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 318800
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 318800 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.3033;;

-- Description: Temporal constancy check for concept 'Gastroesophageal reflux disease'.
        AUDIT (
          name condition_occurrence_318800_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 318800
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Prevalence of concept 'Peripheral vascular disease' in 'CONDITION_OCCURRENCE' is below 0.0426.
        AUDIT (
          name condition_occurrence_321052_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 321052
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 321052 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0426;;

-- Description: Prevalence of concept 'Peripheral vascular disease' in 'CONDITION_OCCURRENCE' is above 0.3832.
        AUDIT (
          name condition_occurrence_321052_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 321052
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 321052 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.3832;;

-- Description: Temporal constancy check for concept 'Peripheral vascular disease'.
        AUDIT (
          name condition_occurrence_321052_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 321052
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Prevalence of concept 'Heart disease' in 'CONDITION_OCCURRENCE' is below 0.061.
        AUDIT (
          name condition_occurrence_321588_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 321588
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 321588 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.061;;

-- Description: Prevalence of concept 'Heart disease' in 'CONDITION_OCCURRENCE' is above 0.5491.
        AUDIT (
          name condition_occurrence_321588_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 321588
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 321588 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.5491;;

-- Description: Temporal constancy check for concept 'Heart disease'.
        AUDIT (
          name condition_occurrence_321588_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 321588
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Prevalence of concept 'Cerebrovascular disease' in 'CONDITION_OCCURRENCE' is below 0.0142.
        AUDIT (
          name condition_occurrence_381591_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 381591
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 381591 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0142;;

-- Description: Prevalence of concept 'Cerebrovascular disease' in 'CONDITION_OCCURRENCE' is above 0.1274.
        AUDIT (
          name condition_occurrence_381591_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 381591
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 381591 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.1274;;

-- Description: Temporal constancy check for concept 'Cerebrovascular disease'.
        AUDIT (
          name condition_occurrence_381591_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 381591
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Prevalence of concept 'Malignant lymphoma' in 'CONDITION_OCCURRENCE' is below 0.0016.
        AUDIT (
          name condition_occurrence_432571_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 432571
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 432571 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0016;;

-- Description: Prevalence of concept 'Malignant lymphoma' in 'CONDITION_OCCURRENCE' is above 0.0143.
        AUDIT (
          name condition_occurrence_432571_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 432571
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 432571 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.0143;;

-- Description: Temporal constancy check for concept 'Malignant lymphoma'.
        AUDIT (
          name condition_occurrence_432571_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 432571
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Prevalence of concept 'Hyperlipidemia' in 'CONDITION_OCCURRENCE' is below 0.0712.
        AUDIT (
          name condition_occurrence_432867_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 432867
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 432867 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0712;;

-- Description: Prevalence of concept 'Hyperlipidemia' in 'CONDITION_OCCURRENCE' is above 0.6412.
        AUDIT (
          name condition_occurrence_432867_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 432867
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 432867 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.6412;;

-- Description: Temporal constancy check for concept 'Hyperlipidemia'.
        AUDIT (
          name condition_occurrence_432867_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 432867
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Gender check for concept 'Primary malignant neoplasm of testis'.
        AUDIT (
          name condition_occurrence_433716_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 433716
  AND p.gender_concept_id <> 8507;;

-- Description: Prevalence of concept 'Obesity' in 'CONDITION_OCCURRENCE' is below 0.038.
        AUDIT (
          name condition_occurrence_433736_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 433736
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 433736 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.038;;

-- Description: Prevalence of concept 'Obesity' in 'CONDITION_OCCURRENCE' is above 0.3422.
        AUDIT (
          name condition_occurrence_433736_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 433736
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 433736 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.3422;;

-- Description: Temporal constancy check for concept 'Obesity'.
        AUDIT (
          name condition_occurrence_433736_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 433736
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Gender check for concept 'Injury of male external genital organs'.
        AUDIT (
          name condition_occurrence_434251_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 434251
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Torsion of testis'.
        AUDIT (
          name condition_occurrence_435315_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 435315
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Retractile testis'.
        AUDIT (
          name condition_occurrence_435648_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 435648
  AND p.gender_concept_id <> 8507;;

-- Description: Prevalence of concept 'Schizophrenia' in 'CONDITION_OCCURRENCE' is below 0.0021.
        AUDIT (
          name condition_occurrence_435783_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 435783
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 435783 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0021;;

-- Description: Prevalence of concept 'Schizophrenia' in 'CONDITION_OCCURRENCE' is above 0.0186.
        AUDIT (
          name condition_occurrence_435783_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 435783
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 435783 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.0186;;

-- Description: Temporal constancy check for concept 'Schizophrenia'.
        AUDIT (
          name condition_occurrence_435783_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 435783
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Gender check for concept 'Redundant prepuce and phimosis'.
        AUDIT (
          name condition_occurrence_436155_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 436155
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Primary malignant neoplasm of exocervix'.
        AUDIT (
          name condition_occurrence_436358_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 436358
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Benign neoplasm of testis'.
        AUDIT (
          name condition_occurrence_436366_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 436366
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Balanoposthitis'.
        AUDIT (
          name condition_occurrence_436466_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 436466
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Primary malignant neoplasm of labia majora'.
        AUDIT (
          name condition_occurrence_437501_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 437501
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Undescended testicle'.
        AUDIT (
          name condition_occurrence_437655_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 437655
  AND p.gender_concept_id <> 8507;;

-- Description: Prevalence of concept 'Attention deficit hyperactivity disorder' in 'CONDITION_OCCURRENCE' is below 0.0078.
        AUDIT (
          name condition_occurrence_438409_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 438409
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 438409 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0078;;

-- Description: Prevalence of concept 'Attention deficit hyperactivity disorder' in 'CONDITION_OCCURRENCE' is above 0.0706.
        AUDIT (
          name condition_occurrence_438409_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 438409
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 438409 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.0706;;

-- Description: Temporal constancy check for concept 'Attention deficit hyperactivity disorder'.
        AUDIT (
          name condition_occurrence_438409_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 438409
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Gender check for concept 'Atrophy of testis'.
        AUDIT (
          name condition_occurrence_438477_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 438477
  AND p.gender_concept_id <> 8507;;

-- Description: Prevalence of concept 'Human immunodeficiency virus infection' in 'CONDITION_OCCURRENCE' is below 0.0006.
        AUDIT (
          name condition_occurrence_439727_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 439727
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 439727 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0006;;

-- Description: Prevalence of concept 'Human immunodeficiency virus infection' in 'CONDITION_OCCURRENCE' is above 0.0057.
        AUDIT (
          name condition_occurrence_439727_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 439727
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 439727 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.0057;;

-- Description: Temporal constancy check for concept 'Human immunodeficiency virus infection'.
        AUDIT (
          name condition_occurrence_439727_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 439727
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Gender check for concept 'Hemospermia'.
        AUDIT (
          name condition_occurrence_439871_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 439871
  AND p.gender_concept_id <> 8507;;

-- Description: Prevalence of concept 'Depressive disorder' in 'CONDITION_OCCURRENCE' is below 0.0392.
        AUDIT (
          name condition_occurrence_440383_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 440383
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 440383 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0392;;

-- Description: Prevalence of concept 'Depressive disorder' in 'CONDITION_OCCURRENCE' is above 0.3531.
        AUDIT (
          name condition_occurrence_440383_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 440383
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 440383 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.3531;;

-- Description: Temporal constancy check for concept 'Depressive disorder'.
        AUDIT (
          name condition_occurrence_440383_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 440383
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Prevalence of concept 'Pulmonary embolism' in 'CONDITION_OCCURRENCE' is below 0.0024.
        AUDIT (
          name condition_occurrence_440417_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 440417
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 440417 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0024;;

-- Description: Prevalence of concept 'Pulmonary embolism' in 'CONDITION_OCCURRENCE' is above 0.022.
        AUDIT (
          name condition_occurrence_440417_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 440417
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 440417 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.022;;

-- Description: Temporal constancy check for concept 'Pulmonary embolism'.
        AUDIT (
          name condition_occurrence_440417_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 440417
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Gender check for concept 'Neoplasm of uncertain behavior of testis'.
        AUDIT (
          name condition_occurrence_440971_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 440971
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Torsion of appendix of testis'.
        AUDIT (
          name condition_occurrence_441068_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 441068
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Stenosis of cervix'.
        AUDIT (
          name condition_occurrence_441077_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 441077
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Primary malignant neoplasm of endocervix'.
        AUDIT (
          name condition_occurrence_441805_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 441805
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Disorder of uterine cervix'.
        AUDIT (
          name condition_occurrence_442781_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 442781
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Benign prostatic hypertrophy with outflow obstruction'.
        AUDIT (
          name condition_occurrence_443211_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 443211
  AND p.gender_concept_id <> 8507;;

-- Description: Prevalence of concept 'Malignant tumor of lung' in 'CONDITION_OCCURRENCE' is below 0.0021.
        AUDIT (
          name condition_occurrence_443388_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 443388
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 443388 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0021;;

-- Description: Prevalence of concept 'Malignant tumor of lung' in 'CONDITION_OCCURRENCE' is above 0.0185.
        AUDIT (
          name condition_occurrence_443388_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 443388
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 443388 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.0185;;

-- Description: Temporal constancy check for concept 'Malignant tumor of lung'.
        AUDIT (
          name condition_occurrence_443388_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 443388
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Prevalence of concept 'Malignant neoplastic disease' in 'CONDITION_OCCURRENCE' is below 0.0326.
        AUDIT (
          name condition_occurrence_443392_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 443392
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 443392 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0326;;

-- Description: Prevalence of concept 'Malignant neoplastic disease' in 'CONDITION_OCCURRENCE' is above 0.2932.
        AUDIT (
          name condition_occurrence_443392_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 443392
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 443392 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.2932;;

-- Description: Temporal constancy check for concept 'Malignant neoplastic disease'.
        AUDIT (
          name condition_occurrence_443392_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 443392
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Gender check for concept 'Primary uterine inertia'.
        AUDIT (
          name condition_occurrence_443435_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 443435
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Amenorrhea'.
        AUDIT (
          name condition_occurrence_443800_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 443800
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Inflammation of cervix'.
        AUDIT (
          name condition_occurrence_444078_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 444078
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Candidiasis of vulva'.
        AUDIT (
          name condition_occurrence_444106_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 444106
  AND p.gender_concept_id <> 8532;;

-- Description: Prevalence of concept 'Venous thrombosis' in 'CONDITION_OCCURRENCE' is below 0.0082.
        AUDIT (
          name condition_occurrence_444247_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 444247
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 444247 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0082;;

-- Description: Prevalence of concept 'Venous thrombosis' in 'CONDITION_OCCURRENCE' is above 0.0737.
        AUDIT (
          name condition_occurrence_444247_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 444247
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 444247 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.0737;;

-- Description: Temporal constancy check for concept 'Venous thrombosis'.
        AUDIT (
          name condition_occurrence_444247_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 444247
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Gender check for concept 'Female sterility'.
        AUDIT (
          name condition_occurrence_4005743_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4005743
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Hypospadias, penile'.
        AUDIT (
          name condition_occurrence_4005933_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4005933
  AND p.gender_concept_id <> 8507;;

-- Description: Prevalence of concept 'Acute respiratory disease' in 'CONDITION_OCCURRENCE' is below 0.1703.
        AUDIT (
          name condition_occurrence_4006969_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 4006969
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 4006969 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.1703;;

-- Description: Prevalence of concept 'Acute respiratory disease' in 'CONDITION_OCCURRENCE' is above 1.0.
        AUDIT (
          name condition_occurrence_4006969_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 4006969
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 4006969 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 1.0;;

-- Description: Temporal constancy check for concept 'Acute respiratory disease'.
        AUDIT (
          name condition_occurrence_4006969_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 4006969
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Gender check for concept 'Vaginal discharge symptom'.
        AUDIT (
          name condition_occurrence_4012343_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4012343
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Prostatism'.
        AUDIT (
          name condition_occurrence_4016155_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4016155
  AND p.gender_concept_id <> 8507;;

-- Description: Prevalence of concept 'Renal impairment' in 'CONDITION_OCCURRENCE' is below 0.0174.
        AUDIT (
          name condition_occurrence_4030518_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 4030518
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 4030518 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0174;;

-- Description: Prevalence of concept 'Renal impairment' in 'CONDITION_OCCURRENCE' is above 0.1568.
        AUDIT (
          name condition_occurrence_4030518_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 4030518
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 4030518 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.1568;;

-- Description: Temporal constancy check for concept 'Renal impairment'.
        AUDIT (
          name condition_occurrence_4030518_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 4030518
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Gender check for concept 'Inflammation of scrotum'.
        AUDIT (
          name condition_occurrence_4032594_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4032594
  AND p.gender_concept_id <> 8507;;

-- Description: Prevalence of concept 'Hematologic neoplasm' in 'CONDITION_OCCURRENCE' is below 0.0037.
        AUDIT (
          name condition_occurrence_4044013_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 4044013
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 4044013 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0037;;

-- Description: Prevalence of concept 'Hematologic neoplasm' in 'CONDITION_OCCURRENCE' is above 0.0331.
        AUDIT (
          name condition_occurrence_4044013_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 4044013
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 4044013 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.0331;;

-- Description: Temporal constancy check for concept 'Hematologic neoplasm'.
        AUDIT (
          name condition_occurrence_4044013_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 4044013
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Gender check for concept 'Neoplasm of endometrium'.
        AUDIT (
          name condition_occurrence_4048225_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4048225
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Open wound of penis'.
        AUDIT (
          name condition_occurrence_4050091_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4050091
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Vulvovaginal disease'.
        AUDIT (
          name condition_occurrence_4051956_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4051956
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Open wound of scrotum and testes'.
        AUDIT (
          name condition_occurrence_4054550_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4054550
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Vaginitis associated with another disorder'.
        AUDIT (
          name condition_occurrence_4056903_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4056903
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Vulval irritation'.
        AUDIT (
          name condition_occurrence_4060207_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4060207
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Uterine scar from previous surgery in pregnancy, childbirth and the puerperium'.
        AUDIT (
          name condition_occurrence_4060556_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4060556
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Uterine scar from previous surgery in pregnancy, childbirth and the puerperium - delivered'.
        AUDIT (
          name condition_occurrence_4060558_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4060558
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Uterine scar from previous surgery in pregnancy, childbirth and the puerperium with antenatal problem'.
        AUDIT (
          name condition_occurrence_4060559_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4060559
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Subacute and chronic vaginitis'.
        AUDIT (
          name condition_occurrence_4061050_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4061050
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Pain in scrotum'.
        AUDIT (
          name condition_occurrence_4071874_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4071874
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Acute vaginitis'.
        AUDIT (
          name condition_occurrence_4081648_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4081648
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Penile arterial insufficiency'.
        AUDIT (
          name condition_occurrence_4090039_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4090039
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Malignant neoplasm, overlapping lesion of cervix uteri'.
        AUDIT (
          name condition_occurrence_4092515_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4092515
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Large prostate'.
        AUDIT (
          name condition_occurrence_4093346_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4093346
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Finding of pattern of menstrual cycle'.
        AUDIT (
          name condition_occurrence_4095940_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4095940
  AND p.gender_concept_id <> 8532;;

-- Description: Prevalence of concept 'Lesion of liver' in 'CONDITION_OCCURRENCE' is below 0.0029.
        AUDIT (
          name condition_occurrence_4104000_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 4104000
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 4104000 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0029;;

-- Description: Prevalence of concept 'Lesion of liver' in 'CONDITION_OCCURRENCE' is above 0.0265.
        AUDIT (
          name condition_occurrence_4104000_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 4104000
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 4104000 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.0265;;

-- Description: Temporal constancy check for concept 'Lesion of liver'.
        AUDIT (
          name condition_occurrence_4104000_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 4104000
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Gender check for concept 'Pain in penis'.
        AUDIT (
          name condition_occurrence_4109081_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4109081
  AND p.gender_concept_id <> 8507;;

-- Description: Prevalence of concept 'Malignant tumor of breast' in 'CONDITION_OCCURRENCE' is below 0.0047.
        AUDIT (
          name condition_occurrence_4112853_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 4112853
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 4112853 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0047;;

-- Description: Prevalence of concept 'Malignant tumor of breast' in 'CONDITION_OCCURRENCE' is above 0.0421.
        AUDIT (
          name condition_occurrence_4112853_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 4112853
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 4112853 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.0421;;

-- Description: Temporal constancy check for concept 'Malignant tumor of breast'.
        AUDIT (
          name condition_occurrence_4112853_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 4112853
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Gender check for concept 'Menopause present'.
        AUDIT (
          name condition_occurrence_4128329_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4128329
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Vaginal bleeding'.
        AUDIT (
          name condition_occurrence_4129155_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4129155
  AND p.gender_concept_id <> 8532;;

-- Description: Prevalence of concept 'Visual system disorder' in 'CONDITION_OCCURRENCE' is below 0.1181.
        AUDIT (
          name condition_occurrence_4134440_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 4134440
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 4134440 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.1181;;

-- Description: Prevalence of concept 'Visual system disorder' in 'CONDITION_OCCURRENCE' is above 1.0.
        AUDIT (
          name condition_occurrence_4134440_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 4134440
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 4134440 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 1.0;;

-- Description: Temporal constancy check for concept 'Visual system disorder'.
        AUDIT (
          name condition_occurrence_4134440_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 4134440
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Gender check for concept 'Acute vulvitis'.
        AUDIT (
          name condition_occurrence_4140828_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4140828
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Azoospermia'.
        AUDIT (
          name condition_occurrence_4143116_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4143116
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Contusion, scrotum or testis'.
        AUDIT (
          name condition_occurrence_4147021_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4147021
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Vaginitis'.
        AUDIT (
          name condition_occurrence_4149084_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4149084
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Vaginal ulcer'.
        AUDIT (
          name condition_occurrence_4150042_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4150042
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Bicornuate uterus'.
        AUDIT (
          name condition_occurrence_4150816_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4150816
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Mechanical complication of intrauterine contraceptive device'.
        AUDIT (
          name condition_occurrence_4155529_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4155529
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Malignant neoplasm of body of uterus'.
        AUDIT (
          name condition_occurrence_4156113_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4156113
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Primary malignant neoplasm of body of uterus'.
        AUDIT (
          name condition_occurrence_4162860_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4162860
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Malignant tumor of prostate'.
        AUDIT (
          name condition_occurrence_4163261_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4163261
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Abnormal menstrual cycle'.
        AUDIT (
          name condition_occurrence_4171394_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4171394
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Orchitis'.
        AUDIT (
          name condition_occurrence_4171915_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4171915
  AND p.gender_concept_id <> 8507;;

-- Description: Prevalence of concept 'Malignant tumor of colon' in 'CONDITION_OCCURRENCE' is below 0.0019.
        AUDIT (
          name condition_occurrence_4180790_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 4180790
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 4180790 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0019;;

-- Description: Prevalence of concept 'Malignant tumor of colon' in 'CONDITION_OCCURRENCE' is above 0.0173.
        AUDIT (
          name condition_occurrence_4180790_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 4180790
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 4180790 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.0173;;

-- Description: Temporal constancy check for concept 'Malignant tumor of colon'.
        AUDIT (
          name condition_occurrence_4180790_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 4180790
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Gender check for concept 'Vulvovaginitis'.
        AUDIT (
          name condition_occurrence_4180978_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4180978
  AND p.gender_concept_id <> 8532;;

-- Description: Prevalence of concept 'Dementia' in 'CONDITION_OCCURRENCE' is below 0.0086.
        AUDIT (
          name condition_occurrence_4182210_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 4182210
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 4182210 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0086;;

-- Description: Prevalence of concept 'Dementia' in 'CONDITION_OCCURRENCE' is above 0.0773.
        AUDIT (
          name condition_occurrence_4182210_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 4182210
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 4182210 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.0773;;

-- Description: Temporal constancy check for concept 'Dementia'.
        AUDIT (
          name condition_occurrence_4182210_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 4182210
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Prevalence of concept 'Ischemic heart disease' in 'CONDITION_OCCURRENCE' is below 0.0201.
        AUDIT (
          name condition_occurrence_4185932_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 4185932
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 4185932 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0201;;

-- Description: Prevalence of concept 'Ischemic heart disease' in 'CONDITION_OCCURRENCE' is above 0.1813.
        AUDIT (
          name condition_occurrence_4185932_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 4185932
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 4185932 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.1813;;

-- Description: Temporal constancy check for concept 'Ischemic heart disease'.
        AUDIT (
          name condition_occurrence_4185932_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 4185932
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Gender check for concept 'Pruritus of vulva'.
        AUDIT (
          name condition_occurrence_4194652_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4194652
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Candidal balanitis'.
        AUDIT (
          name condition_occurrence_4199600_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4199600
  AND p.gender_concept_id <> 8507;;

-- Description: Prevalence of concept 'Chronic liver disease' in 'CONDITION_OCCURRENCE' is below 0.0053.
        AUDIT (
          name condition_occurrence_4212540_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 4212540
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 4212540 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0053;;

-- Description: Prevalence of concept 'Chronic liver disease' in 'CONDITION_OCCURRENCE' is above 0.0476.
        AUDIT (
          name condition_occurrence_4212540_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 4212540
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 4212540 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.0476;;

-- Description: Temporal constancy check for concept 'Chronic liver disease'.
        AUDIT (
          name condition_occurrence_4212540_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 4212540
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Gender check for concept 'Swelling of testicle'.
        AUDIT (
          name condition_occurrence_4235215_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4235215
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Balanitis'.
        AUDIT (
          name condition_occurrence_4260520_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4260520
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Pain in testicle'.
        AUDIT (
          name condition_occurrence_4270932_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4270932
  AND p.gender_concept_id <> 8507;;

-- Description: Prevalence of concept 'Substance abuse' in 'CONDITION_OCCURRENCE' is below 0.0063.
        AUDIT (
          name condition_occurrence_4279309_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 4279309
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 4279309 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.0063;;

-- Description: Prevalence of concept 'Substance abuse' in 'CONDITION_OCCURRENCE' is above 0.0568.
        AUDIT (
          name condition_occurrence_4279309_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 4279309
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 4279309 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.0568;;

-- Description: Temporal constancy check for concept 'Substance abuse'.
        AUDIT (
          name condition_occurrence_4279309_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 4279309
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Gender check for concept 'Primary ovarian failure'.
        AUDIT (
          name condition_occurrence_4279913_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4279913
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Secondary malignant neoplasm of right ovary'.
        AUDIT (
          name condition_occurrence_4281030_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4281030
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Ulcer of penis'.
        AUDIT (
          name condition_occurrence_4294393_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4294393
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Postmenopausal state'.
        AUDIT (
          name condition_occurrence_4295261_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4295261
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Bacterial vaginosis'.
        AUDIT (
          name condition_occurrence_4303258_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4303258
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Hydrocele of tunica vaginalis'.
        AUDIT (
          name condition_occurrence_4320332_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4320332
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Testicular mass'.
        AUDIT (
          name condition_occurrence_4339088_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 4339088
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Benign localized hyperplasia of prostate'.
        AUDIT (
          name condition_occurrence_40481080_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 40481080
  AND p.gender_concept_id <> 8507;;

-- Description: Prevalence of concept 'Malignant neoplasm of anorectum' in 'CONDITION_OCCURRENCE' is below 0.001.
        AUDIT (
          name condition_occurrence_40481902_valid_low,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 40481902
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 40481902 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) < 0.001;;

-- Description: Prevalence of concept 'Malignant neoplasm of anorectum' in 'CONDITION_OCCURRENCE' is above 0.0089.
        AUDIT (
          name condition_occurrence_40481902_valid_high,
          dialect duckdb,
          blocking FALSE
        );
        WITH concept_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE WHERE CONDITION_CONCEPT_ID = 40481902
), total_cnt AS (
    SELECT COUNT(*) n FROM omop.CONDITION_OCCURRENCE
)
SELECT 'CONDITION_OCCURRENCE' AS table_name, 40481902 AS concept_id
FROM concept_cnt c CROSS JOIN total_cnt t
WHERE (c.n::FLOAT / NULLIF(t.n, 0)) > 0.0089;;

-- Description: Temporal constancy check for concept 'Malignant neoplasm of anorectum'.
        AUDIT (
          name condition_occurrence_40481902_temp,
          dialect duckdb,
          blocking FALSE
        );
        SELECT person_id, COUNT(*) AS num_records
FROM omop.CONDITION_OCCURRENCE
WHERE CONDITION_CONCEPT_ID = 40481902
GROUP BY person_id
HAVING COUNT(*) > 1;;

-- Description: Gender check for concept 'Dysplasia of prostate'.
        AUDIT (
          name condition_occurrence_40482030_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 40482030
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Low lying placenta'.
        AUDIT (
          name condition_occurrence_40482406_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 40482406
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Inflammatory disease of female genital structure'.
        AUDIT (
          name condition_occurrence_40483613_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 40483613
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Herniation of rectum into vagina'.
        AUDIT (
          name condition_occurrence_40490888_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 40490888
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Phimosis'.
        AUDIT (
          name condition_occurrence_42709954_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 42709954
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Benign endometrial hyperplasia'.
        AUDIT (
          name condition_occurrence_45757415_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 45757415
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Disorder of skin of penis'.
        AUDIT (
          name condition_occurrence_45766654_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 45766654
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Primary malignant neoplasm of uterus'.
        AUDIT (
          name condition_occurrence_45770892_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 45770892
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Nodular prostate without urinary obstruction'.
        AUDIT (
          name condition_occurrence_45772671_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID = 45772671
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for descendants of concept 'Male genitalia finding, Male reproductive finding'.
        AUDIT (
          name condition_occurrence_4090861_gender_desc,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID IN (
    SELECT descendant_concept_id FROM vocab.concept_ancestor WHERE ancestor_concept_id = 4090861
)
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for descendants of concept 'Male genitalia finding, Male reproductive finding'.
        AUDIT (
          name condition_occurrence_4025213_gender_desc,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID IN (
    SELECT descendant_concept_id FROM vocab.concept_ancestor WHERE ancestor_concept_id = 4025213
)
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for descendants of concept 'Female genitalia finding, Disorder of intrauterine contraceptive device, Menopause finding, Disorder of female genital system, Malignant neoplasm of uterine adnexa, Finding related to pregnancy, Female reproductive finding'.
        AUDIT (
          name condition_occurrence_4095793_gender_desc,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID IN (
    SELECT descendant_concept_id FROM vocab.concept_ancestor WHERE ancestor_concept_id = 4095793
)
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for descendants of concept 'Female genitalia finding, Disorder of intrauterine contraceptive device, Menopause finding, Disorder of female genital system, Malignant neoplasm of uterine adnexa, Finding related to pregnancy, Female reproductive finding'.
        AUDIT (
          name condition_occurrence_443343_gender_desc,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID IN (
    SELECT descendant_concept_id FROM vocab.concept_ancestor WHERE ancestor_concept_id = 443343
)
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for descendants of concept 'Female genitalia finding, Disorder of intrauterine contraceptive device, Menopause finding, Disorder of female genital system, Malignant neoplasm of uterine adnexa, Finding related to pregnancy, Female reproductive finding'.
        AUDIT (
          name condition_occurrence_4024004_gender_desc,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID IN (
    SELECT descendant_concept_id FROM vocab.concept_ancestor WHERE ancestor_concept_id = 4024004
)
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for descendants of concept 'Female genitalia finding, Disorder of intrauterine contraceptive device, Menopause finding, Disorder of female genital system, Malignant neoplasm of uterine adnexa, Finding related to pregnancy, Female reproductive finding'.
        AUDIT (
          name condition_occurrence_4172857_gender_desc,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID IN (
    SELECT descendant_concept_id FROM vocab.concept_ancestor WHERE ancestor_concept_id = 4172857
)
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for descendants of concept 'Female genitalia finding, Disorder of intrauterine contraceptive device, Menopause finding, Disorder of female genital system, Malignant neoplasm of uterine adnexa, Finding related to pregnancy, Female reproductive finding'.
        AUDIT (
          name condition_occurrence_444094_gender_desc,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID IN (
    SELECT descendant_concept_id FROM vocab.concept_ancestor WHERE ancestor_concept_id = 444094
)
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for descendants of concept 'Female genitalia finding, Disorder of intrauterine contraceptive device, Menopause finding, Disorder of female genital system, Malignant neoplasm of uterine adnexa, Finding related to pregnancy, Female reproductive finding'.
        AUDIT (
          name condition_occurrence_197810_gender_desc,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID IN (
    SELECT descendant_concept_id FROM vocab.concept_ancestor WHERE ancestor_concept_id = 197810
)
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for descendants of concept 'Female genitalia finding, Disorder of intrauterine contraceptive device, Menopause finding, Disorder of female genital system, Malignant neoplasm of uterine adnexa, Finding related to pregnancy, Female reproductive finding'.
        AUDIT (
          name condition_occurrence_4158481_gender_desc,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.CONDITION_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.CONDITION_CONCEPT_ID IN (
    SELECT descendant_concept_id FROM vocab.concept_ancestor WHERE ancestor_concept_id = 4158481
)
  AND p.gender_concept_id <> 8532;;

