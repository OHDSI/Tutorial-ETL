# ETL-Synthea OMOP Tutorial

In the demo, we use [OHDSI/ETL-Synthea](https://github.com/OHDSI/ETL-Synthea) to demonstrate how to transform Synthea v3.3.0 data into the OMOP CDM v5.4 on a local DuckDB instance.

When installed, the package provides an `ETLSyntheaBuilder` R function that orchestrates the entire ETL process. We will walk through the steps in the [run.R](run.R) script.

1. Connect to a DuckDB database (creates a new file if it doesn't exist) via `DatabaseConnector` package. It's a package from OHDSI that provides a common interface to connect to various database management systems (DBMS) including DuckDB, PostgreSQL, SQL Server, Oracle, etc.
2. Create empty OMOP CDM tables via `CreateCDMTables` function.
3. Create Synthea staging tables via `CreateSyntheaTables` function.
4. Load raw Synthea CSV files into the staging tables via `LoadSyntheaTables` function.
5. `LoadVocabFromCsv` function to import OMOP vocabulary CSV files into the vocabulary tables.
6. Build vocabulary mappings and visit rollups via `CreateMapAndRollupTables` function. This function will execute these SQL scripts: 
   - [AllVisitTable.sql](https://github.com/OHDSI/ETL-Synthea/blob/main/inst/sql/sql_server/cdm_version/v540/AllVisitTable.sql): Aggregates Synthea encounter records into inpatient, emergency/urgent, and outpatient visit groups (collapsing contiguous lines per class) and unions them into a single ALL_VISITS table with generated visit_occurrence_ids.
   - [AAVITable.sql](https://github.com/OHDSI/ETL-Synthea/blob/main/inst/sql/sql_server/cdm_version/v540/AAVITable.sql): Matches each raw encounter to the appropriate aggregated visit interval and conditionally assigns a proposed VISIT_OCCURRENCE_ID based on encounter class hierarchy and timing rules.
   - [final_visit_ids.sql](https://github.com/OHDSI/ETL-Synthea/blob/main/inst/sql/sql_server/cdm_version/v540/final_visit_ids.sql): Resolves multiple candidate visit assignments per encounter by prioritizing inpatient mappings over same-class mappings and retaining only the highest-priority (row_number = 1) visit_occurrence_id.
   - [create_source_to_standard_vocab_map.sql](https://github.com/OHDSI/ETL-Synthea/blob/main/inst/sql/sql_server/cdm_version/v540/create_source_to_standard_vocab_map.sql): Builds a source-to-standard vocabulary mapping table by combining direct CONCEPT_RELATIONSHIP 'maps to' links and SOURCE_TO_CONCEPT_MAP entries, then indexes source code and vocabulary.
   - [create_source_to_source_vocab_map.sql](https://github.com/OHDSI/ETL-Synthea/blob/main/inst/sql/sql_server/cdm_version/v540/create_source_to_source_vocab_map.sql): Builds a comprehensive source-to-source concept mapping table including identity (self) mappings from CONCEPT plus SOURCE_TO_CONCEPT_MAP-derived links, with indexing for lookup performance.
   - [create_states_map.sql](https://github.com/OHDSI/ETL-Synthea/blob/main/inst/sql/sql_server/cdm_version/v540/create_states_map.sql): Creates and populates a lookup table mapping full U.S. state names to their two-letter abbreviations.
7. Optionally, add performance indexes via `CreateExtraIndices` function. This will execute [CreateExtraIndices.sql](https://github.com/OHDSI/ETL-Synthea/blob/main/inst/sql/sql_server/extra_indices.sql) to create indexes on frequently queried columns in the OMOP CDM tables.
8. Populate OMOP clinical event tables via `LoadEventTables` function. This will execute multiple SQL scripts to transform and load data from the Synthea tables into the corresponding OMOP CDM tables. See the scripts with prefix `insert_` in the original [ETL-Synthea GitHub repository](https://github.com/OHDSI/ETL-Synthea/tree/main/inst/sql/sql_server/cdm_version/v540). For example, [insert_person.sql](https://github.com/OHDSI/ETL-Synthea/blob/main/inst/sql/sql_server/cdm_version/v540/insert_person.sql) populates the `person` table.

## Remarks

`ETLSyntheaBuilder` isn't quite fully compatible with DuckDB. As a workaround for now, we manually move the staged tables into the correct schema after loading them. See the `materializeSchemaQualifiedTables` function in [run.R](run.R) and [schemaFix.R](schemaFix.R) for details.
