## Utility helpers that tidy DuckDB schema-qualified table names.
## DuckDB writes schema-qualified tables as literal strings ("schema.table").
## These shortcuts enumerate the tables we expect from the tutorial pipeline
## and provide a helper to migrate them into their intended schemas.

library(DatabaseConnector)

# Tables expected in synthea_native after loading Synthea CSVs.
syntheaSourceTables <- c(
  "allergies",
  "careplans",
  "claims",
  "claims_transactions",
  "conditions",
  "devices",
  "encounters",
  "imaging_studies",
  "immunizations",
  "medications",
  "observations",
  "organizations",
  "patients",
  "payer_transitions",
  "payers",
  "procedures",
  "providers",
  "supplies"
)

# Vocabulary tables created from OMOP CSVs.
cdmVocabularyTables <- c(
  "concept",
  "concept_ancestor",
  "concept_class",
  "concept_relationship",
  "concept_synonym",
  "domain",
  "drug_strength",
  "relationship",
  "vocabulary"
)

# Core OMOP CDM tables populated by the ETL.
cdmEventTables <- c(
  cdmVocabularyTables,
  "care_site",
  "cdm_source",
  "condition_occurrence",
  "cost",
  "death",
  "device_exposure",
  "drug_exposure",
  "fact_relationship",
  "location",
  "measurement",
  "note",
  "note_nlp",
  "observation",
  "observation_period",
  "payer_plan_period",
  "person",
  "procedure_occurrence",
  "provider",
  "specimen",
  "visit_detail",
  "visit_occurrence"
)

materializeSchemaQualifiedTables <- function(connectionDetails, schema, tables) {
  # Copy data from DuckDB's literal `"schema.table"` staging tables into real schemas.
  conn <- DatabaseConnector::connect(connectionDetails)
  on.exit(DatabaseConnector::disconnect(conn), add = TRUE)
  for (table in tables) {
    literalName <- sprintf('\"%s.%s\"', schema, table)
    existsSql <- sprintf(
      "select count(*) as n from information_schema.tables where table_schema = 'main' and table_name = '%s.%s'",
      schema,
      table
    )
    existsDf <- DatabaseConnector::querySql(conn, existsSql)
    existsCount <- if (nrow(existsDf) && !is.null(existsDf[[1]])) existsDf[[1]][1] else 0
    if (is.na(existsCount) || existsCount == 0) {
      next
    }
    DatabaseConnector::executeSql(
      conn,
      sprintf("create or replace table %s.%s as select * from %s;", schema, table, literalName)
    )
    DatabaseConnector::executeSql(conn, sprintf("drop table %s;", literalName))
  }
}
