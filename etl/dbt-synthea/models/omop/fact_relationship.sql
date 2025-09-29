{{ config(materialized='table', alias='fact_relationship') }}

select
    cast(null as int) as domain_concept_id_1,
    cast(null as bigint) as fact_id_1,
    cast(null as int) as domain_concept_id_2,
    cast(null as bigint) as fact_id_2,
    cast(null as int) as relationship_concept_id
where 1 = 0
