# SQLMesh Synthea OMOP Tutorial

This tutorial shows how to load the Synthea synthetic patient dataset into the OMOP CDM v5.4 using [SQLMesh](https://sqlmesh.com/). It is intentionally minimal and mirrors the straightforward SQL patterns found in the original `ETL-Synthea` workbooks while providing reproducible pipelines, environment isolation with `uv`, and lightweight data quality checks.

## Prerequisites

- macOS or Linux shell with `uv` (v0.5+) and `duckdb` CLI (optional, SQLMesh will install the Python package).
- Local copy of the Synthea source data under `data/syntheaRaw/` and OMOP vocabulary CSVs under `data/vocabulary/` (already included in this repository).
- Python 3.11 (managed automatically by `uv`).

## Quick Start

1. Change into the tutorial directory:
   ```bash
   cd etl/sqlmesh-synthea
   ```
2. Create a virtual environment with `uv` (works on macOS, Linux, and Windows):
   ```bash
   uv venv
   ```
3. Activate the environment:
   - macOS / Linux (bash, zsh): `source .venv/bin/activate`
   - Windows PowerShell: `.venv\Scripts\Activate.ps1`
   - Windows Command Prompt: `.venv\Scripts\activate.bat`
4. Install project dependencies inside the active environment:
   ```bash
   uv pip install -e .
   ```
5. Plan and run the SQLMesh project:
 ```bash
  sqlmesh plan
  sqlmesh run
  ```

   > The first `sqlmesh plan` streams the vocabulary CSV seeds (concept, concept_ancestor, etc.). This can take a minute, but subsequent runs reuse the DuckDB tables.

The default DuckDB database lives at `artifacts/sqlmesh-synthea.duckdb`. Launch the SQLMesh UI with `sqlmesh ui` if you want a visual DAG and run history.

## Project Layout

```
etl/sqlmesh-synthea/
├── audits/                 # Lightweight data quality checks (e.g., person id not null)
├── macros/                 # Misc reusable SQL helpers (e.g., hashing utilities)
├── models/
│   ├── seeds/              # SQLMesh SEED models pointing to raw Synthea & vocabulary CSVs
│   ├── staging/            # Raw Synthea extracts normalized for downstream joins
│   └── omop/               # OMOP CDM tables built from the staging layer
├── notebooks/              # (Optional) space for walkthrough notebooks
├── sqlmesh.yaml            # SQLMesh project configuration
├── pyproject.toml          # Dependency declarations managed by uv
└── uv.lock                 # Reproducible dependency lockfile
```

Key modelling choices:
- **Deterministic IDs** – `stg.patient_ids` and `stg.visit_dimension` assign stable numeric identifiers so all downstream OMOP tables stay in sync.
- **Vocabulary joins** – Only the required vocabularies (SNOMED, ICD10CM, RxNorm, CVX, LOINC, UCUM) are loaded via `stg.source_to_standard_map` to keep SQL readable while still producing standard concept IDs.
- **Simplified mappings** – Encounter class and demographic concepts are mapped with compact CASE logic inspired by `ETL-Synthea` to keep the tutorial approachable.
- **DuckDB-first execution** – The default gateway runs entirely on DuckDB so the whole tutorial is self-contained and reproducible.

Populated OMOP tables:
`person`, `location`, `care_site`, `provider`, `visit_occurrence`, `visit_detail`, `condition_occurrence`, `condition_era`, `drug_exposure`, `drug_era`, `device_exposure`, `measurement`, `observation`, `observation_period`, `procedure_occurrence`, `death`, `payer_plan_period`, `cost`, `cdm_source`.

## Running Audits

Audits run automatically during `sqlmesh run`, but you can execute them ad-hoc:

```bash
sqlmesh audit omop.person --gateway duckdb_local
sqlmesh audit omop.visit_occurrence --gateway duckdb_local
```

Add new audits by creating files in `audits/` and referencing them inside the target model's `MODEL (...)` block.

## Working with the Outputs

1. Connect to the DuckDB file for ad-hoc exploration:
   ```bash
   duckdb artifacts/sqlmesh-synthea.duckdb
   ```
2. Inspect OMOP tables:
   ```sql
   SELECT * FROM omop.person LIMIT 5;
   SELECT COUNT(*) FROM omop.visit_occurrence;
   ```
3. Compare against the R-based tutorial in `etl/etl-synthea` to highlight differences in approach.

## Next Steps

- Extend the audit suite with record count and concept quality checks for the new domains.
- Package example notebooks in `notebooks/` for workshop delivery.
- Add CI automation (e.g., GitHub Actions) to run `sqlmesh plan --no-confirm` when definitions change.
- Explore incremental materializations for large Synthea extracts once comfortable with the core flow.
