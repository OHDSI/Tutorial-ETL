truncate cdm_lauren.condition_occurrence;

insert into cdm_lauren.condition_occurrence (
			condition_occurrence_id,
			person_id,
			condition_concept_id,
			condition_start_date,
			condition_start_datetime,
			condition_end_date,
			condition_end_datetime,
			condition_type_concept_id,
			stop_reason,
			provider_id,
			visit_occurrence_id,
			visit_detail_id,
			condition_source_value,
			condition_source_concept_id,
			condition_status_source_value,
			condition_status_concept_id
)
select
		row_number()over(order by p.person_id) as condition_occurrence_id,
		p.person_id,
		case when srctostdvm.target_concept_id is null 
			 then 0 
			 else srctostdvm.target_concept_id 
		end as target_concept_id,
		c.start as condition_start_date,
		c.start as condition_start_datetime,
		c.stop as condition_end_date,
		c.stop as condition_end_datetime,
		32020 as condition_type_concept_id,
		cast(null as varchar) as stop_reason,
		cast(null as integer) as provider_id,
		1 as visit_occurrence_id,
		0 as visit_detail_id,
		c.code as condition_source_value,
		(
			select case when source_concept_id
						 is null then 0 else source_concept_id end as source_concept_id
			from (
							select srctosrcvm.source_concept_id
						   from cdm_synthea.source_to_source_vocab_map srctosrcvm
						  where srctosrcvm.source_code = c.code
							and srctosrcvm.source_vocabulary_id  = 'SNOMED'
				) a
		) as condition_source_concept_id,
		NULL condition_status_source_value,
		0 as condition_status_concept_id
from raw_lauren.conditions c
left join cdm_synthea.source_to_standard_vocab_map srctostdvm
	  on srctostdvm.source_code             = c.code
	 and srctostdvm.target_domain_id        = 'Condition'
	 and srctostdvm.target_vocabulary_id    = 'SNOMED'
	 and srctostdvm.target_standard_concept = 'S'
	 and srctostdvm.target_invalid_reason IS NULL
join cdm_lauren.person p
	 on c.patient = p.person_source_value;
