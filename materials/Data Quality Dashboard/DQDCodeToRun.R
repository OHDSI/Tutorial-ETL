connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = "postgresql", user = "postgres", 
                                                                password = "ohdsi", server = "localhost/ETL", 
                                                                port = "5432", extraSettings = "")

cdmDatabaseSchema <- "cdm_synthea_v1" # the fully qualified database schema name of the CDM
resultsDatabaseSchema <- "cdm_synthea_v1_results" # the fully qualified database schema name of the results schema (that you can write to)
cdmSourceName <- "CDM Synthea v1" # a human readable name for your CDM source

numThreads <- 1 # on Redshift, 3 seems to work well

# specify if you want to execute the queries or inspect them ------------------------------------------
sqlOnly <- FALSE # set to TRUE if you just want to get the SQL scripts and not actually run the queries

# where should the logs go? -------------------------------------------------------------------------
outputFolder <- "output"

# logging type -------------------------------------------------------------------------------------
verboseMode <- TRUE # set to TRUE if you want to see activity written to the console

# write results to table? -----------------------------------------------------------------------
writeToTable <- TRUE # set to FALSE if you want to skip writing to results table

checkLevels <- c("TABLE", "FIELD", "CONCEPT")

# which DQ checks to run? ------------------------------------

checkNames <- c() #Names can be found in inst/csv/OMOP_CDM_v5.3.1_Check_Desciptions.csv

# run the job --------------------------------------------------------------------------------------
DataQualityDashboard::executeDqChecks(connectionDetails = connectionDetails, 
                                      cdmDatabaseSchema = cdmDatabaseSchema, 
                                      resultsDatabaseSchema = resultsDatabaseSchema,
                                      cdmSourceName = cdmSourceName, 
                                      numThreads = numThreads,
                                      sqlOnly = sqlOnly, 
                                      outputFolder = outputFolder, 
                                      verboseMode = verboseMode,
                                      writeToTable = writeToTable,
                                      checkLevels = checkLevels,
                                      checkNames = checkNames)

# inspect logs ----------------------------------------------------------------------------
ParallelLogger::launchLogViewer(logFileName = file.path(outputFolder, cdmSourceName, 
                                                        sprintf("log_DqDashboard_%s.txt", cdmSourceName)))

# (OPTIONAL) if you want to write the JSON file to the results table separately -----------------------------
jsonFilePath <- ""
DataQualityDashboard::writeJsonResultsToTable(connectionDetails = connectionDetails, 
                                              resultsDatabaseSchema = resultsDatabaseSchema, 
                                              jsonFilePath = jsonFilePath)

DataQualityDashboard::viewDqDashboard(file.path(getwd(),outputFolder, cdmSourceName, paste0("results_", cdmSourceName, ".json")))
