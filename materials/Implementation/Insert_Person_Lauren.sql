truncate cdm_lauren.person;

insert into cdm_lauren.person (
			person_id,
			gender_concept_id,
			year_of_birth,
			month_of_birth,
			day_of_birth,
			birth_datetime,
			race_concept_id,
			ethnicity_concept_id,
			location_id,
			provider_id,
			care_site_id,
			person_source_value,
			gender_source_value,
			gender_source_concept_id,
			race_source_value,
			race_source_concept_id,
			ethnicity_source_value,
			ethnicity_source_concept_id
)
select
	row_number()over(order by p.id) as person_id,
	case upper(p.gender)
		when 'M' then 8507
		when 'F' then 8532
	end as gender_concept_id,
	date_part('year', p.birthdate) as year_of_birth,
	date_part('month', p.birthdate) as month_of_birth,
	date_part('day', p.birthdate) as day_of_birth,
	p.birthdate as birth_datetime,
	case upper(p.race)
		when 'WHITE' then 8527
		when 'BLACK' then 8516
		when 'ASIAN' then 8515
	else 0
	end as race_concept_id,
	case
		when upper(p.race) = 'HISPANIC'
		then 38003563 else 0
	end as ethnicity_concept_id,
	NULL as location_id,
	NULL as provider_id,
	NULL as care_site_id,
	p.id as person_source_value,
	p.gender as gender_source_value,
	0 as gender_source_concept_id,
	p.race as race_source_value,
	0 as race_source_concept_id,
	p.ethnicity as ethnicity_source_value,
	0 as ethnicity_source_concept_id
from raw_lauren.patients p
where p.gender is not null;
