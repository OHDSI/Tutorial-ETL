## Achilles results DDL

CREATE TABLE cdm_synthea_results.achilles_analysis
(
    analysis_id integer,
    analysis_name text COLLATE pg_catalog."default",
    stratum_1_name text COLLATE pg_catalog."default",
    stratum_2_name text COLLATE pg_catalog."default",
    stratum_3_name text COLLATE pg_catalog."default",
    stratum_4_name text COLLATE pg_catalog."default",
    stratum_5_name text COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

CREATE TABLE cdm_synthea_results.achilles_heel_results
(
    analysis_id integer,
    achilles_heel_warning character varying(255) COLLATE pg_catalog."default",
    rule_id integer,
    record_count numeric
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

CREATE TABLE cdm_synthea_results.achilles_results
(
    analysis_id integer,
    stratum_1 character varying(255) COLLATE pg_catalog."default",
    stratum_2 character varying(255) COLLATE pg_catalog."default",
    stratum_3 character varying(255) COLLATE pg_catalog."default",
    stratum_4 character varying(255) COLLATE pg_catalog."default",
    stratum_5 character varying(255) COLLATE pg_catalog."default",
    count_value bigint
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

CREATE TABLE cdm_synthea_results.achilles_results_derived
(
    analysis_id integer,
    stratum_1 character varying(255) COLLATE pg_catalog."default",
    stratum_2 character varying(255) COLLATE pg_catalog."default",
    statistic_value numeric,
    measure_id character varying COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

## This one has indices
CREATE TABLE cdm_synthea_ohdsi_results.achilles_results_dist
(
    analysis_id integer,
    stratum_1 character varying(255) COLLATE pg_catalog."default",
    stratum_2 character varying(255) COLLATE pg_catalog."default",
    stratum_3 character varying(255) COLLATE pg_catalog."default",
    stratum_4 character varying(255) COLLATE pg_catalog."default",
    stratum_5 character varying(255) COLLATE pg_catalog."default",
    count_value bigint,
    min_value numeric,
    max_value numeric,
    avg_value numeric,
    stdev_value numeric,
    median_value numeric,
    p10_value numeric,
    p25_value numeric,
    p75_value numeric,
    p90_value numeric
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

-- Index: idx_ard_aid

-- DROP INDEX cdm_synthea_ohdsi_results.idx_ard_aid;

CREATE INDEX idx_ard_aid
    ON cdm_synthea_ohdsi_results.achilles_results_dist USING btree
    (analysis_id)
    TABLESPACE pg_default;

-- Index: idx_ard_s1

-- DROP INDEX cdm_synthea_ohdsi_results.idx_ard_s1;

CREATE INDEX idx_ard_s1
    ON cdm_synthea_ohdsi_results.achilles_results_dist USING btree
    (stratum_1 COLLATE pg_catalog."default")
    TABLESPACE pg_default;

-- Index: idx_ard_s2

-- DROP INDEX cdm_synthea_ohdsi_results.idx_ard_s2;

CREATE INDEX idx_ard_s2
    ON cdm_synthea_ohdsi_results.achilles_results_dist USING btree
    (stratum_2 COLLATE pg_catalog."default")
    TABLESPACE pg_default;

