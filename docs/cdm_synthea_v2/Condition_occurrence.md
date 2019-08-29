---
layout: default
title: Condition_occurrence
nav_order: 4
parent: CDM Synthea v2
description: "Condition_occurrence mapping from conditions.csv"
---

# Condition_occurrence

## Reading from Synthea table conditions.csv

![](syntheaETL_files/image2.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| condition_occurrence_id |  |Autogenerate  |  |
| person_id | patient | Map by mapping person.person_source_value to patient.  Find person.person_id by mapping encouters.patient to person.person_source_value. |  |
| condition_concept_id | code | Use code to lookup target_concept_id in SOURCE_TO_STANDARD_VOCAB_MAP:    select v.target_concept_id    from conditions c     join source_to_standard_vocab_map v       on v.source_code              = c.code     and v.target_domain_id       = 'Condition'     and v.target_standard_concept = 'S'  and  **v.source_vocabulary_id in ('ICD10CM', 'Synthea_conditions')** |  |
| condition_start_date | start |  |  |
| condition_start_datetime | start |  |  |
| condition_end_date | stop |  |  |
| condition_end_datetime | stop |  |  |
| condition_type_concept_id |32020  |Set to 32020 (EHR Encounter Diagnosis) for all records | |
| stop_reason |  |  |  |
| provider_id |  |  |  |
| visit_occurrence_id | encounter | Lookup visit_occurrence_id using encounter, joining to temp table defined in AllVisitTable.sql. |  |
| visit_detail_id |  |  |  |
| condition_source_value | code |  |  |
| condition_source_concept_id | code | Use code to lookup source_concept_id in SOURCE_TO_SOURCE_VOCAB_MAP:     select v.source_concept_id     from source_to_source_vocab_map v      join conditions c        on v.source_code                 = c.code      and **v.source_vocabulary_id  in ('ICD10CM','Synthea_conditions')** |  |
| condition_status_source_value |  |  |  |
| condition_status_concept_id |  |  |  |
