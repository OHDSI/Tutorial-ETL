MODEL (
  name omop.metadata,
  kind FULL,
  description "The METADATA table contains metadata information about a dataset that has been transformed to the OMOP Common Data Model.",
  columns (
    metadata_id BIGINT,
    metadata_concept_id INT,
    metadata_type_concept_id INT,
    name TEXT,
    value_as_string TEXT,
    value_as_concept_id INT,
    value_as_number REAL,
    metadata_date DATE,
    metadata_datetime TIMESTAMP
  ),
  depends_on (
    vocab.concept,
  ),
  audits (
    metadata_metadata_concept_id_is_required,
    metadata_metadata_concept_id_is_foreign_key,
    metadata_metadata_id_is_required,
    metadata_metadata_id_is_primary_key,
    metadata_metadata_type_concept_id_is_required,
    metadata_metadata_type_concept_id_is_foreign_key,
    metadata_name_is_required,
    metadata_value_as_concept_id_is_foreign_key
  )
);

/* Note: This model is typically populated manually or by specific ETL processes, */ /* not directly from raw Synthea data in this basic ETL. */ /* Creating an empty table structure for compatibility. */
SELECT
  NULL::BIGINT AS metadata_id,
  NULL::INT AS metadata_concept_id,
  NULL::INT AS metadata_type_concept_id,
  NULL::TEXT AS name,
  NULL::TEXT AS value_as_string,
  NULL::INT AS value_as_concept_id,
  NULL::REAL AS value_as_number,
  NULL::DATE AS metadata_date,
  NULL::TIMESTAMP AS metadata_datetime
WHERE
  1 = 0