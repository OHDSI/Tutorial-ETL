#!/usr/bin/env Rscript

# Minimal driver to build a DuckDB copy of Synthea v3.3 in OMOP CDM v5.4.
# Mirrors ETL-Synthea's tutorial pipeline while adding DuckDB-specific fixes.

# Core ETL packages should already be installed.
library(ETLSyntheaBuilder)
library(DatabaseConnector)
library(SqlRender)

# Helper that post-processes DuckDB's schema-qualified table names.
# This is an adhoc workaround for DuckDB's handling of schemas that isn't fully supported by ETLSyntheaBuilder yet.
source(file.path("etl", "etl-synthea", "schemaFix.R"))

# Local folders carrying raw Synthea exports and OMOP vocabularies.
syntheaDir <- file.path("data", "syntheaRaw")
vocabDir <- file.path("data", "vocabulary")
if (!dir.exists(syntheaDir)) {
  stop(sprintf("Synthea source directory not found: %s", syntheaDir))
}
if (!dir.exists(vocabDir)) {
  stop(sprintf("Vocabulary directory not found: %s", vocabDir))
}

# Path to the local DuckDB file. Remove any existing file to start fresh.
duckdbPath <- normalizePath(file.path("data", "syntheaCDM.duckdb"), mustWork = FALSE)
dir.create(dirname(duckdbPath), recursive = TRUE, showWarnings = FALSE)
if (file.exists(duckdbPath)) {
  file.remove(duckdbPath)
}

# Connection details for the local DuckDB file.
connectionDetails <- DatabaseConnector::createConnectionDetails(
  dbms = "duckdb",
  server = duckdbPath,
  extraSettings = "threads=1"
)

# Schemas and versions.
cdmVersion <- "5.4"
syntheaVersion <- "3.3.0"
cdmSchema <- "cdm"
syntheaSchema <- "synthea_native"

# Create the target schemas if they don't already exist.
conn <- DatabaseConnector::connect(connectionDetails)
for (schemaName in c(cdmSchema, syntheaSchema)) {
  schemaSql <- SqlRender::render("create schema if not exists @schema;", schema = schemaName)
  schemaSql <- SqlRender::translate(schemaSql, targetDialect = connectionDetails$dbms)
  DatabaseConnector::executeSql(conn, schemaSql)
}
DatabaseConnector::disconnect(conn)

# Create empty OMOP CDM tables.
ETLSyntheaBuilder::CreateCDMTables(connectionDetails, cdmSchema, cdmVersion)

# Create native Synthea staging tables.
ETLSyntheaBuilder::CreateSyntheaTables(connectionDetails, syntheaSchema, syntheaVersion)

# Load Synthea CSV exports into staging.
ETLSyntheaBuilder::LoadSyntheaTables(connectionDetails, syntheaSchema, syntheaDir)

# DuckDB stages tables as "schema.table"; move them into the actual schema.
materializeSchemaQualifiedTables(connectionDetails, syntheaSchema, syntheaSourceTables)

# Import OMOP vocabulary files.
ETLSyntheaBuilder::LoadVocabFromCsv(connectionDetails, cdmSchema, vocabDir, delimiter = ",")

# Again, fix the schema for vocabulary tables.
materializeSchemaQualifiedTables(connectionDetails, cdmSchema, cdmVocabularyTables)

# Build vocabulary mappings and visit rollups.
ETLSyntheaBuilder::CreateMapAndRollupTables(connectionDetails, cdmSchema, syntheaSchema, cdmVersion, syntheaVersion)

# Add optional performance indexes.
ETLSyntheaBuilder::CreateExtraIndices(connectionDetails, cdmSchema, syntheaSchema, syntheaVersion)

# Populate OMOP clinical event tables.
ETLSyntheaBuilder::LoadEventTables(connectionDetails, cdmSchema, syntheaSchema, cdmVersion, syntheaVersion)

# Final pass to relocate any schema-qualified tables into their proper homes.
materializeSchemaQualifiedTables(connectionDetails, cdmSchema, cdmEventTables)

message("DuckDB ETL completed. Database stored at: ", duckdbPath)
