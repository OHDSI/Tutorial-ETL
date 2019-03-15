#### Running achilles on synthea data ####

library(Achilles)
library(DatabaseConnector)

connectionDetails <- DatabaseConnector::createConnectionDetails(
  dbms="postgresql",
  server="pgsql03.cqnqzwtn5s1q.us-east-1.rds.amazonaws.com/etl",
  user=Sys.getenv("postgresOhdsiUser"),
  password= Sys.getenv("postgresOhdsiPw"),
  port=5432
)

outputFolder <- "C:/syntheaAchilles"

Achilles::validateSchema(connectionDetails = connectionDetails,
                         cdmDatabaseSchema = "cdm_synthea",
                         resultsDatabaseSchema = "cdm_synthea_ohdsi_results",
                         cdmVersion = 5.3,
                         runCostAnalysis = FALSE,
                         outputFolder = outputFolder,
                         sqlOnly = FALSE)
##throws an error - logged an issue on the github

Achilles::achilles(connectionDetails = connectionDetails,
                   cdmDatabaseSchema = "cdm_synthea",
                   resultsDatabaseSchema = "cdm_synthea_ohdsi_results",
                   vocabDatabaseSchema = "cdm_synthea",
                   sourceName = "synthea",
                   createTable = TRUE,
                   smallCellCount = 5,
                   cdmVersion = 5.3,
                   runCostAnalysis = FALSE,
                   numThreads = 1,
                   outputFolder = outputFolder
                   )

Achilles::createConceptHierarchy(connectionDetails = connectionDetails,
                                 resultsDatabaseSchema = "cdm_synthea_ohdsi_results",
                                 vocabDatabaseSchema = "cdm_synthea",
                                 scratchDatabaseSchema = "#",
                                 outputFolder = outputFolder
                                 )

# Achilles::exportToJson(connectionDetails = connectionDetails,
#                        cdmDatabaseSchema = "cdm_synthea",
#                        resultsDatabaseSchema = "cdm_synthea_ohdsi_results",
#                        outputPath = "C:/syntheaAchilles/data",
#                        vocabDatabaseSchema = "cdm_synthea",
#                        compressIntoOneFile = FALSE)
# gets hung on drug ea




Achilles::exportConditionToJson(connectionDetails = connectionDetails,
                       cdmDatabaseSchema = "cdm_synthea",
                       resultsDatabaseSchema = "cdm_synthea_ohdsi_results",
                       outputPath = "C:/syntheaAchilles/data",
                       vocabDatabaseSchema = "cdm_synthea")

Achilles::exportConditionEraToJson(connectionDetails = connectionDetails,
                                cdmDatabaseSchema = "cdm_synthea",
                                resultsDatabaseSchema = "cdm_synthea_ohdsi_results",
                                outputPath = "C:/syntheaAchilles/data",
                                vocabDatabaseSchema = "cdm_synthea")

Achilles::exportPersonToJson(connectionDetails = connectionDetails,
                                cdmDatabaseSchema = "cdm_synthea",
                                resultsDatabaseSchema = "cdm_synthea_ohdsi_results",
                                outputPath = "C:/syntheaAchilles/data",
                                vocabDatabaseSchema = "cdm_synthea")

Achilles::exportVisitToJson(connectionDetails = connectionDetails,
                             cdmDatabaseSchema = "cdm_synthea",
                             resultsDatabaseSchema = "cdm_synthea_ohdsi_results",
                             outputPath = "C:/syntheaAchilles/data",
                             vocabDatabaseSchema = "cdm_synthea")

Achilles::exportDataDensityToJson(connectionDetails = connectionDetails,
                            cdmDatabaseSchema = "cdm_synthea",
                            resultsDatabaseSchema = "cdm_synthea_ohdsi_results",
                            outputPath = "C:/syntheaAchilles/data",
                            vocabDatabaseSchema = "cdm_synthea")

Achilles::exportHeelToJson(connectionDetails = connectionDetails,
                            cdmDatabaseSchema = "cdm_synthea",
                            resultsDatabaseSchema = "cdm_synthea_ohdsi_results",
                            outputPath = "C:/syntheaAchilles/data",
                            vocabDatabaseSchema = "cdm_synthea")

Achilles::exportMeasurementToJson(connectionDetails = connectionDetails,
                           cdmDatabaseSchema = "cdm_synthea",
                           resultsDatabaseSchema = "cdm_synthea_ohdsi_results",
                           outputPath = "C:/syntheaAchilles/data",
                           vocabDatabaseSchema = "cdm_synthea")


Achilles::exportDashboardToJson(connectionDetails = connectionDetails,
                                   cdmDatabaseSchema = "cdm_synthea",
                                   resultsDatabaseSchema = "cdm_synthea_ohdsi_results",
                                   outputPath = "C:/syntheaAchilles/data",
                                   vocabDatabaseSchema = "cdm_synthea")
