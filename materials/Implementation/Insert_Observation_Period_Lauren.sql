truncate table cdm_lauren.observation_period;

insert into cdm_lauren.observation_period (
observation_period_id,
person_id,
observation_period_start_date,
observation_period_end_date,
period_type_concept_id
)
select
		1 as observation_period_id,
		p.person_id,
		min(e.start) as observation_period_start_date,
		max(e.stop) as observation_period_end_date,
		44814724 as period_type_concept_id
from cdm_lauren.person p
join raw_lauren.encounters e
   on p.person_source_value = e.patient
group by p.person_id;
