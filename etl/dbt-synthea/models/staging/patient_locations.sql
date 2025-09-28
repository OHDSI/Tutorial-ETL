{{ config(materialized='table', alias='patient_locations') }}

with base as (
    select distinct
        p.patient_id,
        coalesce(p.city, 'Unknown') as city,
        coalesce(p.state_name, 'Unknown') as state_name,
        p.zip,
        p.street_address,
        p.latitude,
        p.longitude,
        p.county
    from {{ ref('patients') }} as p
), dedup as (
    select distinct
        city,
        state_name,
        zip,
        street_address,
        latitude,
        longitude,
        county
    from base
), numbered as (
    select
        row_number() over (
            order by state_name, city, coalesce(zip, ''), coalesce(street_address, '')
        ) as location_id,
        city,
        state_name,
        zip,
        street_address,
        latitude,
        longitude,
        county
    from dedup
)
select
    b.patient_id,
    n.location_id,
    n.city,
    sm.state_abbreviation as state,
    n.state_name,
    n.zip,
    n.street_address,
    n.latitude,
    n.longitude,
    n.county
from base as b
join numbered as n
  on b.city = n.city
 and b.state_name = n.state_name
 and (b.zip is not distinct from n.zip)
 and (b.street_address is not distinct from n.street_address)
left join {{ ref('states_map') }} as sm
  on n.state_name = sm.state_name
