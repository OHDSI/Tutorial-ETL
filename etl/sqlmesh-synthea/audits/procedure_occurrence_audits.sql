-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────
-- MODEL (
--   name omop.procedure_occurrence,
--   audits (
--     person_completeness_procedure_occurrence,
--     procedure_occurrence_modifier_concept_id_is_foreign_key,
--     procedure_occurrence_modifier_concept_id_is_standard_valid_concept,
--     procedure_occurrence_modifier_concept_id_standard_concept_record_completeness,
--     procedure_occurrence_person_id_is_required,
--     procedure_occurrence_person_id_is_foreign_key,
--     procedure_occurrence_procedure_concept_id_is_required,
--     procedure_occurrence_procedure_concept_id_is_foreign_key,
--     procedure_occurrence_procedure_concept_id_fk_domain,
--     procedure_occurrence_procedure_concept_id_is_standard_valid_concept,
--     procedure_occurrence_procedure_concept_id_standard_concept_record_completeness,
--     procedure_occurrence_procedure_date_is_required,
--     procedure_occurrence_procedure_date_start_before_end,
--     procedure_occurrence_procedure_date_after_birth,
--     procedure_occurrence_procedure_datetime_start_before_end,
--     procedure_occurrence_procedure_datetime_after_birth,
--     procedure_occurrence_procedure_end_date_after_birth,
--     procedure_occurrence_procedure_end_datetime_after_birth,
--     procedure_occurrence_procedure_occurrence_id_is_required,
--     procedure_occurrence_procedure_occurrence_id_is_primary_key,
--     procedure_occurrence_procedure_source_concept_id_is_foreign_key,
--     procedure_occurrence_procedure_type_concept_id_is_required,
--     procedure_occurrence_procedure_type_concept_id_is_foreign_key,
--     procedure_occurrence_procedure_type_concept_id_fk_domain,
--     procedure_occurrence_procedure_type_concept_id_is_standard_valid_concept,
--     procedure_occurrence_procedure_type_concept_id_standard_concept_record_completeness,
--     procedure_occurrence_provider_id_is_foreign_key,
--     procedure_occurrence_visit_detail_id_is_foreign_key,
--     procedure_occurrence_visit_occurrence_id_is_foreign_key,
--     procedure_occurrence_2003947_gender,
--     procedure_occurrence_2003966_gender,
--     procedure_occurrence_2003983_gender,
--     procedure_occurrence_2004031_gender,
--     procedure_occurrence_2004063_gender,
--     procedure_occurrence_2004070_gender,
--     procedure_occurrence_2004090_gender,
--     procedure_occurrence_2004164_gender,
--     procedure_occurrence_2004263_gender,
--     procedure_occurrence_2004329_gender,
--     procedure_occurrence_2004342_gender,
--     procedure_occurrence_2004443_gender,
--     procedure_occurrence_2004627_gender,
--     procedure_occurrence_2109825_gender,
--     procedure_occurrence_2109833_gender,
--     procedure_occurrence_2109900_gender,
--     procedure_occurrence_2109902_gender,
--     procedure_occurrence_2109905_gender,
--     procedure_occurrence_2109906_gender,
--     procedure_occurrence_2109916_gender,
--     procedure_occurrence_2109968_gender,
--     procedure_occurrence_2109973_gender,
--     procedure_occurrence_2109981_gender,
--     procedure_occurrence_2110004_gender,
--     procedure_occurrence_2110011_gender,
--     procedure_occurrence_2110026_gender,
--     procedure_occurrence_2110039_gender,
--     procedure_occurrence_2110044_gender,
--     procedure_occurrence_2110078_gender,
--     procedure_occurrence_2110116_gender,
--     procedure_occurrence_2110142_gender,
--     procedure_occurrence_2110144_gender,
--     procedure_occurrence_2110169_gender,
--     procedure_occurrence_2110175_gender,
--     procedure_occurrence_2110194_gender,
--     procedure_occurrence_2110195_gender,
--     procedure_occurrence_2110203_gender,
--     procedure_occurrence_2110222_gender,
--     procedure_occurrence_2110227_gender,
--     procedure_occurrence_2110230_gender,
--     procedure_occurrence_2110307_gender,
--     procedure_occurrence_2110315_gender,
--     procedure_occurrence_2110316_gender,
--     procedure_occurrence_2110317_gender,
--     procedure_occurrence_2110326_gender,
--     procedure_occurrence_2211747_gender,
--     procedure_occurrence_2211749_gender,
--     procedure_occurrence_2211751_gender,
--     procedure_occurrence_2211753_gender,
--     procedure_occurrence_2211755_gender,
--     procedure_occurrence_2211756_gender,
--     procedure_occurrence_2211757_gender,
--     procedure_occurrence_2211765_gender,
--     procedure_occurrence_2211769_gender,
--     procedure_occurrence_2617204_gender,
--     procedure_occurrence_2721063_gender,
--     procedure_occurrence_2721064_gender,
--     procedure_occurrence_2780478_gender,
--     procedure_occurrence_2780523_gender,
--     procedure_occurrence_4021531_gender,
--     procedure_occurrence_4032622_gender,
--     procedure_occurrence_4038747_gender,
--     procedure_occurrence_4052532_gender,
--     procedure_occurrence_4058792_gender,
--     procedure_occurrence_4073700_gender,
--     procedure_occurrence_4083772_gender,
--     procedure_occurrence_4096783_gender,
--     procedure_occurrence_4127886_gender,
--     procedure_occurrence_4138738_gender,
--     procedure_occurrence_4141940_gender,
--     procedure_occurrence_4146777_gender,
--     procedure_occurrence_4161944_gender,
--     procedure_occurrence_4181912_gender,
--     procedure_occurrence_4234536_gender,
--     procedure_occurrence_4238715_gender,
--     procedure_occurrence_4243919_gender,
--     procedure_occurrence_4275113_gender,
--     procedure_occurrence_4294805_gender,
--     procedure_occurrence_4306780_gender,
--     procedure_occurrence_4310552_gender,
--     procedure_occurrence_4321575_gender,
--     procedure_occurrence_4330583_gender,
--     procedure_occurrence_4041261_gender_desc,
--     procedure_occurrence_4250917_gender_desc,
--     procedure_occurrence_4077750_gender_desc,
--     procedure_occurrence_4043199_gender_desc,
--     procedure_occurrence_4040577_gender_desc,
--   )
-- );

-- Description: Check for persons missing from table 'PROCEDURE_OCCURRENCE'.
        AUDIT (
          name person_completeness_procedure_occurrence,
          dialect duckdb,
          blocking FALSE
        );
        SELECT p.person_id
FROM omop.person p
LEFT JOIN omop.PROCEDURE_OCCURRENCE e ON p.person_id = e.person_id
WHERE e.person_id IS NULL;;

-- Description: Check for orphaned foreign keys in 'PROCEDURE_OCCURRENCE.MODIFIER_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name procedure_occurrence_modifier_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PROCEDURE_OCCURRENCE c
LEFT JOIN vocab.CONCEPT p ON c.MODIFIER_CONCEPT_ID = p.CONCEPT_ID
WHERE c.MODIFIER_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'PROCEDURE_OCCURRENCE.MODIFIER_CONCEPT_ID' are standard and valid.
        AUDIT (
          name procedure_occurrence_modifier_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
LEFT JOIN vocab.CONCEPT c ON t.MODIFIER_CONCEPT_ID = c.concept_id
WHERE t.MODIFIER_CONCEPT_ID IS NOT NULL
  AND t.MODIFIER_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'PROCEDURE_OCCURRENCE.MODIFIER_CONCEPT_ID'.
AUDIT (
  name procedure_occurrence_modifier_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.PROCEDURE_OCCURRENCE WHERE MODIFIER_CONCEPT_ID = 0;

-- Description: Check for NULLs in required field 'PROCEDURE_OCCURRENCE.PERSON_ID'.
AUDIT (
  name procedure_occurrence_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.PROCEDURE_OCCURRENCE WHERE PERSON_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'PROCEDURE_OCCURRENCE.PERSON_ID' pointing to 'PERSON.PERSON_ID'.
        AUDIT (
          name procedure_occurrence_person_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PROCEDURE_OCCURRENCE c
LEFT JOIN omop.PERSON p ON c.PERSON_ID = p.PERSON_ID
WHERE c.PERSON_ID IS NOT NULL AND p.PERSON_ID IS NULL;;

-- Description: Check for NULLs in required field 'PROCEDURE_OCCURRENCE.PROCEDURE_CONCEPT_ID'.
AUDIT (
  name procedure_occurrence_procedure_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.PROCEDURE_OCCURRENCE WHERE PROCEDURE_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'PROCEDURE_OCCURRENCE.PROCEDURE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name procedure_occurrence_procedure_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PROCEDURE_OCCURRENCE c
LEFT JOIN vocab.CONCEPT p ON c.PROCEDURE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.PROCEDURE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'PROCEDURE_OCCURRENCE.PROCEDURE_CONCEPT_ID' belong to the 'Procedure' domain.
        AUDIT (
          name procedure_occurrence_procedure_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN vocab.CONCEPT c ON t.PROCEDURE_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Procedure';;

-- Description: Check that concepts in 'PROCEDURE_OCCURRENCE.PROCEDURE_CONCEPT_ID' are standard and valid.
        AUDIT (
          name procedure_occurrence_procedure_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
LEFT JOIN vocab.CONCEPT c ON t.PROCEDURE_CONCEPT_ID = c.concept_id
WHERE t.PROCEDURE_CONCEPT_ID IS NOT NULL
  AND t.PROCEDURE_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'PROCEDURE_OCCURRENCE.PROCEDURE_CONCEPT_ID'.
AUDIT (
  name procedure_occurrence_procedure_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.PROCEDURE_OCCURRENCE WHERE PROCEDURE_CONCEPT_ID = 0;

-- Description: Check for NULLs in required field 'PROCEDURE_OCCURRENCE.PROCEDURE_DATE'.
AUDIT (
  name procedure_occurrence_procedure_date_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.PROCEDURE_OCCURRENCE WHERE PROCEDURE_DATE IS NULL;

-- Description: Check that 'PROCEDURE_OCCURRENCE.PROCEDURE_DATE' occurs before 'PROCEDURE_OCCURRENCE.PROCEDURE_END_DATE'.
AUDIT (
  name procedure_occurrence_procedure_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.PROCEDURE_OCCURRENCE WHERE PROCEDURE_DATE > PROCEDURE_END_DATE;

-- Description: Check that date 'PROCEDURE_OCCURRENCE.PROCEDURE_DATE' is after person's birth date.
        AUDIT (
          name procedure_occurrence_procedure_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_DATE < p.birth_datetime;;

-- Description: Check that 'PROCEDURE_OCCURRENCE.PROCEDURE_DATETIME' occurs before 'PROCEDURE_OCCURRENCE.PROCEDURE_END_DATETIME'.
AUDIT (
  name procedure_occurrence_procedure_datetime_start_before_end,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.PROCEDURE_OCCURRENCE WHERE PROCEDURE_DATETIME > PROCEDURE_END_DATETIME;

-- Description: Check that date 'PROCEDURE_OCCURRENCE.PROCEDURE_DATETIME' is after person's birth date.
        AUDIT (
          name procedure_occurrence_procedure_datetime_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_DATETIME < p.birth_datetime;;

-- Description: Check that date 'PROCEDURE_OCCURRENCE.PROCEDURE_END_DATE' is after person's birth date.
        AUDIT (
          name procedure_occurrence_procedure_end_date_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_END_DATE < p.birth_datetime;;

-- Description: Check that date 'PROCEDURE_OCCURRENCE.PROCEDURE_END_DATETIME' is after person's birth date.
        AUDIT (
          name procedure_occurrence_procedure_end_datetime_after_birth,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_END_DATETIME < p.birth_datetime;;

-- Description: Check for NULLs in required field 'PROCEDURE_OCCURRENCE.PROCEDURE_OCCURRENCE_ID'.
AUDIT (
  name procedure_occurrence_procedure_occurrence_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.PROCEDURE_OCCURRENCE WHERE PROCEDURE_OCCURRENCE_ID IS NULL;

-- Description: Check for duplicate values in primary key field 'PROCEDURE_OCCURRENCE.PROCEDURE_OCCURRENCE_ID'.
        AUDIT (
          name procedure_occurrence_procedure_occurrence_id_is_primary_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT PROCEDURE_OCCURRENCE_ID, COUNT(*)
FROM omop.PROCEDURE_OCCURRENCE
WHERE PROCEDURE_OCCURRENCE_ID IS NOT NULL
GROUP BY PROCEDURE_OCCURRENCE_ID
HAVING COUNT(*) > 1;;

-- Description: Check for orphaned foreign keys in 'PROCEDURE_OCCURRENCE.PROCEDURE_SOURCE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name procedure_occurrence_procedure_source_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PROCEDURE_OCCURRENCE c
LEFT JOIN vocab.CONCEPT p ON c.PROCEDURE_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.PROCEDURE_SOURCE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check for NULLs in required field 'PROCEDURE_OCCURRENCE.PROCEDURE_TYPE_CONCEPT_ID'.
AUDIT (
  name procedure_occurrence_procedure_type_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.PROCEDURE_OCCURRENCE WHERE PROCEDURE_TYPE_CONCEPT_ID IS NULL;

-- Description: Check for orphaned foreign keys in 'PROCEDURE_OCCURRENCE.PROCEDURE_TYPE_CONCEPT_ID' pointing to 'CONCEPT.CONCEPT_ID'.
        AUDIT (
          name procedure_occurrence_procedure_type_concept_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PROCEDURE_OCCURRENCE c
LEFT JOIN vocab.CONCEPT p ON c.PROCEDURE_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE c.PROCEDURE_TYPE_CONCEPT_ID IS NOT NULL AND p.CONCEPT_ID IS NULL;;

-- Description: Check that concepts in 'PROCEDURE_OCCURRENCE.PROCEDURE_TYPE_CONCEPT_ID' belong to the 'Type Concept' domain.
        AUDIT (
          name procedure_occurrence_procedure_type_concept_id_fk_domain,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN vocab.CONCEPT c ON t.PROCEDURE_TYPE_CONCEPT_ID = c.concept_id
WHERE c.domain_id <> 'Type Concept';;

-- Description: Check that concepts in 'PROCEDURE_OCCURRENCE.PROCEDURE_TYPE_CONCEPT_ID' are standard and valid.
        AUDIT (
          name procedure_occurrence_procedure_type_concept_id_is_standard_valid_concept,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
LEFT JOIN vocab.CONCEPT c ON t.PROCEDURE_TYPE_CONCEPT_ID = c.concept_id
WHERE t.PROCEDURE_TYPE_CONCEPT_ID IS NOT NULL
  AND t.PROCEDURE_TYPE_CONCEPT_ID <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);;

-- Description: Check for concept ID 0 in standard concept field 'PROCEDURE_OCCURRENCE.PROCEDURE_TYPE_CONCEPT_ID'.
AUDIT (
  name procedure_occurrence_procedure_type_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);
SELECT * FROM omop.PROCEDURE_OCCURRENCE WHERE PROCEDURE_TYPE_CONCEPT_ID = 0;

-- Description: Check for orphaned foreign keys in 'PROCEDURE_OCCURRENCE.PROVIDER_ID' pointing to 'PROVIDER.PROVIDER_ID'.
        AUDIT (
          name procedure_occurrence_provider_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PROCEDURE_OCCURRENCE c
LEFT JOIN omop.PROVIDER p ON c.PROVIDER_ID = p.PROVIDER_ID
WHERE c.PROVIDER_ID IS NOT NULL AND p.PROVIDER_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'PROCEDURE_OCCURRENCE.VISIT_DETAIL_ID' pointing to 'VISIT_DETAIL.VISIT_DETAIL_ID'.
        AUDIT (
          name procedure_occurrence_visit_detail_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PROCEDURE_OCCURRENCE c
LEFT JOIN omop.VISIT_DETAIL p ON c.VISIT_DETAIL_ID = p.VISIT_DETAIL_ID
WHERE c.VISIT_DETAIL_ID IS NOT NULL AND p.VISIT_DETAIL_ID IS NULL;;

-- Description: Check for orphaned foreign keys in 'PROCEDURE_OCCURRENCE.VISIT_OCCURRENCE_ID' pointing to 'VISIT_OCCURRENCE.VISIT_OCCURRENCE_ID'.
        AUDIT (
          name procedure_occurrence_visit_occurrence_id_is_foreign_key,
          dialect duckdb,
          blocking FALSE
        );
        SELECT c.*
FROM omop.PROCEDURE_OCCURRENCE c
LEFT JOIN omop.VISIT_OCCURRENCE p ON c.VISIT_OCCURRENCE_ID = p.VISIT_OCCURRENCE_ID
WHERE c.VISIT_OCCURRENCE_ID IS NOT NULL AND p.VISIT_OCCURRENCE_ID IS NULL;;

-- Description: Gender check for concept 'Closed [percutaneous] [needle] biopsy of prostate'.
        AUDIT (
          name procedure_occurrence_2003947_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2003947
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Other transurethral prostatectomy'.
        AUDIT (
          name procedure_occurrence_2003966_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2003966
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Other prostatectomy'.
        AUDIT (
          name procedure_occurrence_2003983_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2003983
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Other repair of scrotum and tunica vaginalis'.
        AUDIT (
          name procedure_occurrence_2004031_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2004031
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Unilateral orchiectomy'.
        AUDIT (
          name procedure_occurrence_2004063_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2004063
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Other repair of testis'.
        AUDIT (
          name procedure_occurrence_2004070_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2004070
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Excision of varicocele and hydrocele of spermatic cord'.
        AUDIT (
          name procedure_occurrence_2004090_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2004090
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Local excision or destruction of lesion of penis'.
        AUDIT (
          name procedure_occurrence_2004164_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2004164
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Other removal of both ovaries and tubes at same operative episode'.
        AUDIT (
          name procedure_occurrence_2004263_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2004263
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Other bilateral destruction or occlusion of fallopian tubes'.
        AUDIT (
          name procedure_occurrence_2004329_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2004329
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Removal of both fallopian tubes at same operative episode'.
        AUDIT (
          name procedure_occurrence_2004342_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2004342
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Closed biopsy of uterus'.
        AUDIT (
          name procedure_occurrence_2004443_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2004443
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Vaginal suspension and fixation'.
        AUDIT (
          name procedure_occurrence_2004627_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2004627
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Transurethral electrosurgical resection of prostate, including control of postoperative bleeding, complete (vasectomy, meatotomy, cystourethroscopy, urethral calibration and/or dilation, and internal urethrotomy are included)'.
        AUDIT (
          name procedure_occurrence_2109825_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2109825
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Laser vaporization of prostate, including control of postoperative bleeding, complete (vasectomy, meatotomy, cystourethroscopy, urethral calibration and/or dilation, internal urethrotomy and transurethral resection of prostate are included if performed)'.
        AUDIT (
          name procedure_occurrence_2109833_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2109833
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Destruction of lesion(s), penis (eg, condyloma, papilloma, molluscum contagiosum, herpetic vesicle), simple; chemical'.
        AUDIT (
          name procedure_occurrence_2109900_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2109900
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Destruction of lesion(s), penis (eg, condyloma, papilloma, molluscum contagiosum, herpetic vesicle), simple; cryosurgery'.
        AUDIT (
          name procedure_occurrence_2109902_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2109902
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Destruction of lesion(s), penis (eg, condyloma, papilloma, molluscum contagiosum, herpetic vesicle), extensive (eg, laser surgery, electrosurgery, cryosurgery, chemosurgery)'.
        AUDIT (
          name procedure_occurrence_2109905_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2109905
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Biopsy of penis, (separate procedure)'.
        AUDIT (
          name procedure_occurrence_2109906_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2109906
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Circumcision, using clamp or other device with regional dorsal penile or ring block'.
        AUDIT (
          name procedure_occurrence_2109916_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2109916
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Foreskin manipulation including lysis of preputial adhesions and stretching'.
        AUDIT (
          name procedure_occurrence_2109968_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2109968
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Orchiectomy, simple (including subcapsular), with or without testicular prosthesis, scrotal or inguinal approach'.
        AUDIT (
          name procedure_occurrence_2109973_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2109973
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Orchiopexy, inguinal approach, with or without hernia repair'.
        AUDIT (
          name procedure_occurrence_2109981_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2109981
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Drainage of scrotal wall abscess'.
        AUDIT (
          name procedure_occurrence_2110004_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2110004
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Vasectomy, unilateral or bilateral (separate procedure), including postoperative semen examination(s)'.
        AUDIT (
          name procedure_occurrence_2110011_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2110011
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Biopsy, prostate; needle or punch, single or multiple, any approach'.
        AUDIT (
          name procedure_occurrence_2110026_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2110026
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Prostatectomy, retropubic radical, with or without nerve sparing; with bilateral pelvic lymphadenectomy, including external iliac, hypogastric, and obturator nodes'.
        AUDIT (
          name procedure_occurrence_2110039_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2110039
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Laparoscopy, surgical prostatectomy, retropubic radical, including nerve sparing, includes robotic assistance, when performed'.
        AUDIT (
          name procedure_occurrence_2110044_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2110044
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Colposcopy of the vulva'.
        AUDIT (
          name procedure_occurrence_2110078_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2110078
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Colpopexy, vaginal; extra-peritoneal approach (sacrospinous, iliococcygeus)'.
        AUDIT (
          name procedure_occurrence_2110116_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2110116
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Laparoscopy, surgical, colpopexy (suspension of vaginal apex)'.
        AUDIT (
          name procedure_occurrence_2110142_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2110142
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Colposcopy of the cervix including upper/adjacent vagina, with biopsy(s) of the cervix and endocervical curettage'.
        AUDIT (
          name procedure_occurrence_2110144_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2110144
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Endometrial sampling (biopsy) with or without endocervical sampling (biopsy), without cervical dilation, any method (separate procedure)'.
        AUDIT (
          name procedure_occurrence_2110169_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2110169
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Total abdominal hysterectomy (corpus and cervix), with or without removal of tube(s), with or without removal of ovary(s)'.
        AUDIT (
          name procedure_occurrence_2110175_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2110175
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Insertion of intrauterine device (IUD)'.
        AUDIT (
          name procedure_occurrence_2110194_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2110194
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Removal of intrauterine device (IUD)'.
        AUDIT (
          name procedure_occurrence_2110195_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2110195
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Endometrial ablation, thermal, without hysteroscopic guidance'.
        AUDIT (
          name procedure_occurrence_2110203_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2110203
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Hysteroscopy, surgical; with sampling (biopsy) of endometrium and/or polypectomy, with or without D & C'.
        AUDIT (
          name procedure_occurrence_2110222_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2110222
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Hysteroscopy, surgical; with endometrial ablation (eg, endometrial resection, electrosurgical ablation, thermoablation)'.
        AUDIT (
          name procedure_occurrence_2110227_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2110227
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Laparoscopy, surgical, with total hysterectomy, for uterus 250 g or less; with removal of tube(s) and/or ovary(s)'.
        AUDIT (
          name procedure_occurrence_2110230_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2110230
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Routine obstetric care including antepartum care, vaginal delivery (with or without episiotomy, and/or forceps) and postpartum care'.
        AUDIT (
          name procedure_occurrence_2110307_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2110307
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Routine obstetric care including antepartum care, cesarean delivery, and postpartum care'.
        AUDIT (
          name procedure_occurrence_2110315_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2110315
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Cesarean delivery only'.
        AUDIT (
          name procedure_occurrence_2110316_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2110316
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Cesarean delivery only, including postpartum care'.
        AUDIT (
          name procedure_occurrence_2110317_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2110317
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Treatment of missed abortion, completed surgically; first trimester'.
        AUDIT (
          name procedure_occurrence_2110326_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2110326
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Ultrasound, pregnant uterus, real time with image documentation, fetal and maternal evaluation, first trimester (< 14 weeks 0 days), transabdominal approach; single or first gestation'.
        AUDIT (
          name procedure_occurrence_2211747_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2211747
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Ultrasound, pregnant uterus, real time with image documentation, fetal and maternal evaluation, after first trimester (> or = 14 weeks 0 days), transabdominal approach; single or first gestation'.
        AUDIT (
          name procedure_occurrence_2211749_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2211749
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Ultrasound, pregnant uterus, real time with image documentation, fetal and maternal evaluation plus detailed fetal anatomic examination, transabdominal approach; single or first gestation'.
        AUDIT (
          name procedure_occurrence_2211751_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2211751
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Ultrasound, pregnant uterus, real time with image documentation, first trimester fetal nuchal translucency measurement, transabdominal or transvaginal approach; single or first gestation'.
        AUDIT (
          name procedure_occurrence_2211753_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2211753
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Ultrasound, pregnant uterus, real time with image documentation, limited (eg, fetal heart beat, placental location, fetal position and/or qualitative amniotic fluid volume), 1 or more fetuses'.
        AUDIT (
          name procedure_occurrence_2211755_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2211755
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Ultrasound, pregnant uterus, real time with image documentation, follow-up (eg, re-evaluation of fetal size by measuring standard growth parameters and amniotic fluid volume, re-evaluation of organ system(s) suspected or confirmed to be abnormal on a prev'.
        AUDIT (
          name procedure_occurrence_2211756_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2211756
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Ultrasound, pregnant uterus, real time with image documentation, transvaginal'.
        AUDIT (
          name procedure_occurrence_2211757_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2211757
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Ultrasound, transvaginal'.
        AUDIT (
          name procedure_occurrence_2211765_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2211765
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Ultrasound, scrotum and contents'.
        AUDIT (
          name procedure_occurrence_2211769_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2211769
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Cervical or vaginal cancer screening, pelvic and clinical breast examination'.
        AUDIT (
          name procedure_occurrence_2617204_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2617204
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Annual gynecological examination, new patient'.
        AUDIT (
          name procedure_occurrence_2721063_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2721063
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Annual gynecological examination, established patient'.
        AUDIT (
          name procedure_occurrence_2721064_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2721064
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Resection of Prostate, Percutaneous Endoscopic Approach'.
        AUDIT (
          name procedure_occurrence_2780478_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2780478
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Resection of Prepuce, External Approach'.
        AUDIT (
          name procedure_occurrence_2780523_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 2780523
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Total abdominal hysterectomy'.
        AUDIT (
          name procedure_occurrence_4021531_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 4021531
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Laparoscopic supracervical hysterectomy'.
        AUDIT (
          name procedure_occurrence_4032622_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 4032622
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Obstetric examination'.
        AUDIT (
          name procedure_occurrence_4038747_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 4038747
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Hysteroscopy'.
        AUDIT (
          name procedure_occurrence_4052532_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 4052532
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Douche of vagina'.
        AUDIT (
          name procedure_occurrence_4058792_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 4058792
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Transurethral laser prostatectomy'.
        AUDIT (
          name procedure_occurrence_4073700_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 4073700
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Echography of scrotum and contents'.
        AUDIT (
          name procedure_occurrence_4083772_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 4083772
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Radical prostatectomy'.
        AUDIT (
          name procedure_occurrence_4096783_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 4096783
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Hysterectomy'.
        AUDIT (
          name procedure_occurrence_4127886_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 4127886
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Vaginal hysterectomy'.
        AUDIT (
          name procedure_occurrence_4138738_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 4138738
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Endometrial ablation'.
        AUDIT (
          name procedure_occurrence_4141940_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 4141940
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Radical abdominal hysterectomy'.
        AUDIT (
          name procedure_occurrence_4146777_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 4146777
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Low cervical cesarean section'.
        AUDIT (
          name procedure_occurrence_4161944_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 4161944
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Cone biopsy of cervix'.
        AUDIT (
          name procedure_occurrence_4181912_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 4181912
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Transurethral prostatectomy'.
        AUDIT (
          name procedure_occurrence_4234536_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 4234536
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Removal of intrauterine device'.
        AUDIT (
          name procedure_occurrence_4238715_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 4238715
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Incision of ovary'.
        AUDIT (
          name procedure_occurrence_4243919_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 4243919
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Insertion of intrauterine contraceptive device'.
        AUDIT (
          name procedure_occurrence_4275113_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 4275113
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Laparoscopic-assisted vaginal hysterectomy'.
        AUDIT (
          name procedure_occurrence_4294805_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 4294805
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Gynecologic examination'.
        AUDIT (
          name procedure_occurrence_4306780_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 4306780
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for concept 'Orchidopexy'.
        AUDIT (
          name procedure_occurrence_4310552_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 4310552
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Lysis of penile adhesions'.
        AUDIT (
          name procedure_occurrence_4321575_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 4321575
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for concept 'Vasectomy'.
        AUDIT (
          name procedure_occurrence_4330583_gender,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID = 4330583
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for descendants of concept 'Procedure on female genital system'.
        AUDIT (
          name procedure_occurrence_4041261_gender_desc,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID IN (
    SELECT descendant_concept_id FROM vocab.CONCEPT_ancestor WHERE ancestor_concept_id = 4041261
)
  AND p.gender_concept_id <> 8532;;

-- Description: Gender check for descendants of concept 'Operation on prostate, Operation on scrotum, Procedure on penis, Procedure on testis'.
        AUDIT (
          name procedure_occurrence_4250917_gender_desc,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID IN (
    SELECT descendant_concept_id FROM vocab.CONCEPT_ancestor WHERE ancestor_concept_id = 4250917
)
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for descendants of concept 'Operation on prostate, Operation on scrotum, Procedure on penis, Procedure on testis'.
        AUDIT (
          name procedure_occurrence_4077750_gender_desc,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID IN (
    SELECT descendant_concept_id FROM vocab.CONCEPT_ancestor WHERE ancestor_concept_id = 4077750
)
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for descendants of concept 'Operation on prostate, Operation on scrotum, Procedure on penis, Procedure on testis'.
        AUDIT (
          name procedure_occurrence_4043199_gender_desc,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID IN (
    SELECT descendant_concept_id FROM vocab.CONCEPT_ancestor WHERE ancestor_concept_id = 4043199
)
  AND p.gender_concept_id <> 8507;;

-- Description: Gender check for descendants of concept 'Operation on prostate, Operation on scrotum, Procedure on penis, Procedure on testis'.
        AUDIT (
          name procedure_occurrence_4040577_gender_desc,
          dialect duckdb,
          blocking FALSE
        );
        SELECT t.*
FROM omop.PROCEDURE_OCCURRENCE t
JOIN omop.person p ON t.person_id = p.person_id
WHERE t.PROCEDURE_CONCEPT_ID IN (
    SELECT descendant_concept_id FROM vocab.CONCEPT_ancestor WHERE ancestor_concept_id = 4040577
)
  AND p.gender_concept_id <> 8507;;

