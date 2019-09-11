#### Running achilles on synthea data ####

library(Achilles)
library(DatabaseConnector)

connectionDetails <- DatabaseConnector::createConnectionDetails(
	dbms="postgresql",
	server="localhost/ETL",
	user="postgres",
	password= "ohdsi",
	port=5432
)


outputFolder <- "C:/ohdsi/achilles/output/cdm_synthea_v2"

Achilles::validateSchema(connectionDetails = connectionDetails,
                         cdmDatabaseSchema = "cdm_synthea_v2",
                         resultsDatabaseSchema = "cdm_synthea_v2_results",
                         cdmVersion = 5.3,
                         runCostAnalysis = FALSE,
                         outputFolder = outputFolder,
                         sqlOnly = FALSE)
##throws an error - logged an issue on the github

Achilles::achilles(connectionDetails = connectionDetails,
                   cdmDatabaseSchema = "cdm_synthea_v2",
                   resultsDatabaseSchema = "cdm_synthea_v2_results",
                   vocabDatabaseSchema = "cdm_synthea_v2",
                   sourceName = "cdm_synthea_v2",
                   createTable = TRUE,
                   smallCellCount = 5,
                   cdmVersion = 5.3,
                   runCostAnalysis = FALSE,
                   numThreads = 1,
                   outputFolder = outputFolder
                   )

# Achilles::createConceptHierarchy(connectionDetails = connectionDetails,
#                                  resultsDatabaseSchema = "cdm_synthea_ohdsi_results",
#                                  vocabDatabaseSchema = "cdm_synthea",
#                                  scratchDatabaseSchema = "#",
#                                  outputFolder = outputFolder
#                                  )

Achilles::exportToJson(connectionDetails = connectionDetails,
                        cdmDatabaseSchema = "cdm_synthea_v2",
                        resultsDatabaseSchema = "cdm_synthea_v2_results",
                        outputPath = "C:/ohdsi/achilles/output/cdm_synthea_v2",
                        vocabDatabaseSchema = "cdm_synthea_v2",
                        compressIntoOneFile = FALSE)
