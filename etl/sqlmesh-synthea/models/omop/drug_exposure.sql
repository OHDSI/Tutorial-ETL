MODEL (
  name omop.drug_exposure,
  kind FULL,
  columns (
    drug_exposure_id BIGINT,
    person_id BIGINT,
    drug_concept_id INT,
    drug_exposure_start_date DATE,
    drug_exposure_start_datetime TIMESTAMP,
    drug_exposure_end_date DATE,
    drug_exposure_end_datetime TIMESTAMP,
    verbatim_end_date DATE,
    drug_type_concept_id INT,
    stop_reason TEXT,
    refills INT,
    quantity DOUBLE,
    days_supply BIGINT,
    sig TEXT,
    route_concept_id INT,
    lot_number TEXT,
    provider_id BIGINT,
    visit_occurrence_id BIGINT,
    visit_detail_id BIGINT,
    drug_source_value TEXT,
    drug_source_concept_id INT,
    route_source_value TEXT,
    dose_unit_source_value TEXT
  )
);

WITH encounter_providers AS (
  SELECT
    encounter_id,
    prov.provider_id
  FROM stg.encounters AS e
  LEFT JOIN stg.providers AS prov
    ON e.provider_source_value = prov.provider_source_value
),
medication_base AS (
  SELECT
    ids.person_id,
    meds.encounter_id,
    meds.drug_exposure_start_date,
    meds.drug_exposure_start_datetime,
    meds.drug_exposure_end_date,
    meds.drug_exposure_end_datetime,
    meds.medication_code AS source_code,
    meds.medication_description AS source_description,
    meds.quantity,
    std_map.target_concept_id,
    std_map.source_concept_id,
    'medication' AS record_type,
    COALESCE(DATEDIFF('day', meds.drug_exposure_start_date, meds.drug_exposure_end_date), 0) AS days_supply,
    prov.provider_id
  FROM stg.medications AS meds
  JOIN stg.patient_ids AS ids
    ON meds.patient_id = ids.patient_id
  LEFT JOIN stg.source_to_standard_map AS std_map
    ON std_map.source_code = meds.medication_code
   AND std_map.source_vocabulary_id = 'RXNORM'
   AND std_map.target_domain_id = 'DRUG'
  LEFT JOIN encounter_providers AS prov
    ON prov.encounter_id = meds.encounter_id
), immunization_base AS (
  SELECT
    ids.person_id,
    imm.encounter_id,
    imm.immunization_date AS drug_exposure_start_date,
    imm.immunization_datetime AS drug_exposure_start_datetime,
    imm.immunization_date AS drug_exposure_end_date,
    imm.immunization_datetime AS drug_exposure_end_datetime,
    imm.immunization_code AS source_code,
    imm.immunization_description AS source_description,
    CAST(NULL AS DOUBLE) AS quantity,
    std_map.target_concept_id,
    std_map.source_concept_id,
    'immunization' AS record_type,
    0 AS days_supply,
    prov.provider_id
  FROM stg.immunizations AS imm
  JOIN stg.patient_ids AS ids
    ON imm.patient_id = ids.patient_id
  LEFT JOIN stg.source_to_standard_map AS std_map
    ON std_map.source_code = imm.immunization_code
   AND std_map.source_vocabulary_id = 'CVX'
   AND std_map.target_domain_id = 'DRUG'
  LEFT JOIN encounter_providers AS prov
    ON prov.encounter_id = imm.encounter_id
), combined AS (
  SELECT * FROM medication_base
  UNION ALL
  SELECT * FROM immunization_base
), visits AS (
  SELECT encounter_id, visit_occurrence_id
  FROM stg.final_visit_ids
)
SELECT
  ROW_NUMBER() OVER (ORDER BY person_id, drug_exposure_start_datetime, source_code) AS drug_exposure_id,
  person_id,
  COALESCE(target_concept_id, 0) AS drug_concept_id,
  drug_exposure_start_date,
  TRY_CAST(drug_exposure_start_datetime AS TIMESTAMP) AS drug_exposure_start_datetime,
  COALESCE(drug_exposure_end_date, drug_exposure_start_date) AS drug_exposure_end_date,
  TRY_CAST(COALESCE(drug_exposure_end_datetime, drug_exposure_start_datetime) AS TIMESTAMP) AS drug_exposure_end_datetime,
  CASE WHEN record_type = 'medication'
       THEN COALESCE(drug_exposure_end_date, drug_exposure_start_date)
       ELSE drug_exposure_start_date
  END AS verbatim_end_date,
  CASE WHEN record_type = 'medication' THEN 32838 ELSE 32827 END AS drug_type_concept_id,
  CAST(NULL AS TEXT) AS stop_reason,
  CAST(NULL AS INTEGER) AS refills,
  quantity AS quantity,
  days_supply,
  CAST(NULL AS TEXT) AS sig,
  CAST(NULL AS INTEGER) AS route_concept_id,
  CAST(NULL AS TEXT) AS lot_number,
  provider_id,
  visits.visit_occurrence_id,
  CASE WHEN visits.visit_occurrence_id IS NOT NULL THEN visits.visit_occurrence_id + 1000000 ELSE NULL END AS visit_detail_id,
  source_code AS drug_source_value,
  COALESCE(source_concept_id, 0) AS drug_source_concept_id,
  CAST(NULL AS TEXT) AS route_source_value,
  CAST(NULL AS TEXT) AS dose_unit_source_value
FROM combined
LEFT JOIN visits USING (encounter_id);
