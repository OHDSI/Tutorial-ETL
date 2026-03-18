library(DataQualityDashboard)

connectionDetails <- DatabaseConnector::createConnectionDetails(
  dbms     = "postgresql",
  server   = "localhost/postgres",
  user     = "postgres",
  password = "",
  port     = 5433
)

DataQualityDashboard::executeDqChecks(connectionDetails, 
                                      cdmDatabaseSchema = "synthea_cdm_v2",
                                      resultsDatabaseSchema = "synthea_results_v2",
                                      outputFolder = "",
                                      cdmVersion = "5.4",
                                      cdmSourceName = "synthea_characterization",
                                      checkSeverity = "characterization")


DataQualityDashboard::viewDqDashboard("link to json file location")
