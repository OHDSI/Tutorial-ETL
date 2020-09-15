# Standardized Vocabulary Queries
These queries represent standardized ways to query the Vocabulary for CONCEPT_IDs regardless of if the mappings are in the OMOP Vocabulary or a mapping you added to the SOURCE_TO_CONCEPT_MAP table.

The inside of the CTE pulls all codes and their mappings (regardless if it is in the Vocabulary or in the SOURCE_TO_CONCEPT_MAP table.  You can then filter those mappings based on what you need. Some people who had performance issues with this query actually wrote out the results of the CTE and indexed those to get better preformance. 

## SOURCE_TO_STANDARD
This query is designed for taking a source code and mapping it to its standard CONCEPT_ID.  You should be able to tell the query what your Vocabulary is (SOURCE_VOCABULARY_ID = 'NDC') and then filter to where TARGET_STANDARD_CONCEPT = 'S'.  

## SOURCE_TO_SOURCE
This query is designed for if your source codes exist in the OMOP Vocabulary and already have CONCEPT_IDs.  For example, ICD9 codes have CONCEPT_IDs and you can put those into the SOURCE_CONCEPT_ID fields in the CDM.

