{{ config(materialized='table', alias='organizations') }}

select
    Id as organization_id,
    NAME as name,
    trim(CITY) as city,
    upper(trim(STATE)) as state_name,
    ZIP as zip,
    ADDRESS as address,
    try_cast(LAT as double) as latitude,
    try_cast(LON as double) as longitude,
    PHONE as phone,
    try_cast(REVENUE as double) as revenue,
    try_cast(UTILIZATION as double) as utilization
from {{ ref('synthea_organizations') }}
