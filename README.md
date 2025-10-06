# Tutorial-ETL

Materials necessary for the "OMOP Common Data Model Extract, Transform & Load Tutorial".  The goal of this tutorial is to learn about best practices and OHDSI tools developed to help with designing an extract, transform, & load process to take your database from raw observational data to the OMOP Common Data Model.  Pre-requisite course would be the OMOP CDM & Vocabulary Tutorial or working experience with the OMOP CDM and OMOP Vocabulary.

## Optional Demo: ETL-Synthea

Here we will use [OHDSI/ETL-Synthea](https://github.com/OHDSI/ETL-Synthea) to demonstrate how to transform Synthea v3.3.0 data into the OMOP CDM v5.4 on a local DuckDB instance.

### Prerequisites

1. Install [R](https://cran.r-project.org/) (version 4.0 or higher recommended).
2. Install OHDSI R packages: `ETLSyntheaBuilder`, `DatabaseConnector`, `SqlRender`, `duckdb`, and their dependencies. You might need to consult [OHDSI HADES installation instructions](https://ohdsi.github.io/Hades/rSetup.html). (Tip: if you are on a Mac with Homebrew, you may install Java with `brew install openjdk` and `Sys.setenv(JAVA_HOME = "/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home")` in R.)

```r
devtools::install_github("OHDSI/ETL-Synthea")
install.packages("DatabaseConnector")
install.packages("SqlRender")
install.packages("duckdb")
```

3. [Git](https://github.com/git-guides/install-git) (optional, for cloning the repository).
4. [DBeaver](https://dbeaver.io/download/) or [DuckDB UI](https://duckdb.org/2025/03/12/duckdb-ui.html) or other database clients (optional, for inspecting the resulting DuckDB file).

### Steps

1. Download this repository by `git clone https://github.com/OHDSI/Tutorial-ETL.git`. If you don't have Git installed, you can also download the ZIP file from GitHub (look for the green button '< > Code' on the top of this page) and extract it.
2. Data are included in the repository at `data/syntheaRaw/` and `data/vocabulary/`. If you want to use your own Synthea exports or vocabulary files, replace the contents of these folders.
3. Run the ETL script from the project root: `Rscript etl/etl-synthea/run.R`. The [script](etl/etl-synthea/run.R) is well commented step-by-step.
4. Inspect the resulting DuckDB file created at `data/syntheaCDM.duckdb`.

Further explanations and instructions can be found in the [README](etl/etl-synthea/README.md) in the [`etl/etl-synthea`](etl/etl-synthea) folder.

## Optional Demo: SQLMesh Synthea

A Python alternative to the R-based workflow is demonstrated in `etl/sqlmesh-synthea`. It uses SQLMesh with DuckDB to transform the same Synthea extracts into OMOP v5.4 via SQL models.

Given SQLMesh provides more advanced features like data lineage, environment isolation, data quality checks, and an optional UI, please refer to the [README](etl/sqlmesh-synthea/README.md) in [etl/sqlmesh-synthea](etl/sqlmesh-synthea) folder for instructions.

## Optional Demo: dbt Synthea

dbt is another popular open-source tool for SQL-based data transformations. It is a more mature and widely adopted tool than SQLMesh with a large ecosystem and community, but it could miss [some desirable features implemented in SQLMesh](etl/dbt-synthea/README.md#dbt-vs-sqlmesh).

The dbt version of the Synthea to OMOP transformation lives in [etl/dbt-synthea](etl/dbt-synthea) and is documented in its [README](etl/dbt-synthea/README.md).
