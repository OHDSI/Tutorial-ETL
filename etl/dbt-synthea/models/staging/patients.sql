{{ config(materialized='table', alias='patients') }}

select
    Id as patient_id,
    try_cast(BIRTHDATE as date) as birth_date,
    try_cast(DEATHDATE as date) as death_date,
    upper(trim(GENDER)) as gender,
    upper(trim(GENDER)) as gender_source_value,
    upper(trim(RACE)) as race,
    upper(trim(RACE)) as race_source_value,
    upper(trim(ETHNICITY)) as ethnicity,
    upper(trim(ETHNICITY)) as ethnicity_source_value,
    trim(CITY) as city,
    upper(trim(STATE)) as state_name,
    trim(cast(ZIP as varchar)) as zip,
    trim(ADDRESS) as street_address,
    trim(COUNTY) as county,
    try_cast(LAT as double) as latitude,
    try_cast(LON as double) as longitude,
    Id as patient_source_value,
    try_cast(HEALTHCARE_EXPENSES as double) as healthcare_expenses,
    try_cast(HEALTHCARE_COVERAGE as double) as healthcare_coverage,
    try_cast(INCOME as double) as income
from {{ ref('synthea_patients') }}
