insert into cdm_synthea_v2.cdm_source  (
	cdm_source_name,
    cdm_source_abbreviation,
    cdm_holder,
    source_description,
    source_documentation_reference,
    cdm_etl_reference,
    source_release_date,
    cdm_release_date,
    cdm_version,
    vocabulary_version
)
select 'Synthea',
	   'cdm_synthea_v2',
       'OHDSI',
       'Synthea is a synthetic patient generator that models the medical history of synthetic patients. This 1,000 person sample was generated and modified for the purposes of the OHDSI ETL Tutorial',
       'https://github.com/synthetichealth/synthea/wiki',
       'https://ohdsi.github.io/Tutorial-ETL/',
       '28Aug2019',
       '28Aug2019',
       'v5.3.1',
       'v5.0 10-JAN-19'
       

       
