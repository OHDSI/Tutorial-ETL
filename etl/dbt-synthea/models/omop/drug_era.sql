{{ config(materialized='table', alias='drug_era') }}

with ingredient_exposures as (
    select
        de.person_id,
        ca.ancestor_concept_id as ingredient_concept_id,
        de.drug_exposure_start_date as exposure_start_date,
        case
            when de.drug_exposure_end_date is not null then de.drug_exposure_end_date
            when coalesce(de.days_supply, 0) > 0 then de.drug_exposure_start_date + cast(de.days_supply as integer) * interval '1 day'
            else de.drug_exposure_start_date + interval '1 day'
        end as exposure_end_date
    from {{ ref('drug_exposure') }} as de
    join {{ ref('concept_ancestor') }} as ca
      on ca.descendant_concept_id = de.drug_concept_id
    join {{ ref('concept') }} as c
      on c.concept_id = ca.ancestor_concept_id
    where c.vocabulary_id = 'RxNorm'
      and c.concept_class_id = 'Ingredient'
      and de.drug_concept_id <> 0
),
normalized as (
    select
        person_id,
        ingredient_concept_id,
        exposure_start_date,
        greatest(exposure_start_date, exposure_end_date) as exposure_end_date
    from ingredient_exposures
),
ordered as (
    select
        *,
        case
            when lag(exposure_end_date) over (partition by person_id, ingredient_concept_id order by exposure_start_date, exposure_end_date) is null then 1
            when datediff('day', lag(exposure_end_date) over (partition by person_id, ingredient_concept_id order by exposure_start_date, exposure_end_date), exposure_start_date) > 30 then 1
            else 0
        end as new_era_flag
    from normalized
),
era_assignment as (
    select
        *,
        sum(new_era_flag) over (
            partition by person_id, ingredient_concept_id
            order by exposure_start_date, exposure_end_date
            rows between unbounded preceding and current row
        ) as era_group
    from ordered
),
eras as (
    select
        person_id,
        ingredient_concept_id,
        era_group,
        min(exposure_start_date) as drug_era_start_date,
        max(exposure_end_date) as drug_era_end_date,
        count(*) as drug_exposure_count,
        sum(datediff('day', exposure_start_date, exposure_end_date)) as days_exposed
    from era_assignment
    group by person_id, ingredient_concept_id, era_group
)
select
    row_number() over (order by person_id, ingredient_concept_id, drug_era_start_date) as drug_era_id,
    person_id,
    ingredient_concept_id as drug_concept_id,
    drug_era_start_date,
    drug_era_end_date,
    drug_exposure_count,
    greatest(datediff('day', drug_era_start_date, drug_era_end_date) - days_exposed, 0) as gap_days
from eras
