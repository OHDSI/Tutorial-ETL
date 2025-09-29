{{ config(materialized='table', alias='location') }}

select distinct
    location_id,
    street_address as address_1,
    cast(null as text) as address_2,
    city,
    state,
    zip,
    county,
    zip as location_source_value,
    4330442 as country_concept_id,
    'US' as country_source_value,
    try_cast(latitude as double) as latitude,
    try_cast(longitude as double) as longitude
from {{ ref('patient_locations') }}
