/* AA : AA Main dashboard : general unsubmited torre opps : prod */
select 
    str_to_date(concat(yearweek(`opportunity_candidates`.`created`),' Sunday'),'%X%V %W') as date,
    IF(ISNULL(interested), 'started', 'finished') as finished,
    count(distinct opportunity_candidates.id) as applications
from
    opportunity_candidates
    inner join opportunities as o on opportunity_candidates.opportunity_id = o.id
    left join tracking_code_candidates as tcc
    left join tracking_codes as tc on tcc.tracking_code_id = tc.id on tcc.candidate_id = opportunity_candidates.id
    left join opportunity_members on o.id = opportunity_members.opportunity_id and poster = 1
    left join people on opportunity_members.person_id = people.id
    left join person_flags on people.id = person_flags.person_id
where
    date(opportunity_candidates.created) > "2021-7-18"
    AND o.objective not like '***%'
    AND date(coalesce(null, o.first_reviewed, o.last_reviewed)) >= '2022-3-31'
    AND opportunity_candidates.application_step IS NOT NULL
    AND o.id IN (
        SELECT
            DISTINCT opportunity_id
        FROM
            opportunity_organizations oorg
        WHERE
            oorg.organization_id = '748404'
            AND oorg.active = true
    )
group by 1,2