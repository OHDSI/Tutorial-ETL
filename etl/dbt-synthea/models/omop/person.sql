{{ config(materialized='table', alias='person') }}

with ids as (
    select * from {{ ref('patient_ids') }}
)
select
    ids.person_id,
    case upper(p.gender_source_value)
        when 'M' then 8507
        when 'MALE' then 8507
        when 'F' then 8532
        when 'FEMALE' then 8532
        else 0
    end as gender_concept_id,
    cast(extract(year from p.birth_date) as integer) as year_of_birth,
    cast(extract(month from p.birth_date) as integer) as month_of_birth,
    cast(extract(day from p.birth_date) as integer) as day_of_birth,
    cast(p.birth_date as timestamp) as birth_datetime,
    case upper(p.race_source_value)
        when 'WHITE' then 8527
        when 'BLACK' then 8516
        when 'ASIAN' then 8515
        when 'NATIVE' then 8657
        else 0
    end as race_concept_id,
    case upper(p.ethnicity_source_value)
        when 'HISPANIC' then 38003563
        when 'NONHISPANIC' then 38003564
        else 0
    end as ethnicity_concept_id,
    loc.location_id,
    cast(null as integer) as provider_id,
    cast(null as integer) as care_site_id,
    p.patient_id as person_source_value,
    p.gender_source_value,
    0 as gender_source_concept_id,
    p.race_source_value,
    0 as race_source_concept_id,
    p.ethnicity_source_value,
    0 as ethnicity_source_concept_id
from {{ ref('patients') }} as p
join ids
  on p.patient_id = ids.patient_id
left join {{ ref('patient_locations') }} as loc
  on p.patient_id = loc.patient_id
