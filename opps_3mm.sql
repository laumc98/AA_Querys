SELECT str_to_date(concat(yearweek(`source`.`match_date`), ' Sunday'), '%X%V %W') AS `match_date`, count(distinct `source`.`opportunity_id`) AS `count`
FROM (select date(final.member_interested) as match_date,
    date(final.created) as created,
    final.opportunity_id as opportunity_id,
    final.objective as opportunity_objective,
    final.review as review,
    final.match_sum as match_sum,
    date(final.reviewed) as reviewed,
    datediff(date(final.member_interested), date(final.reviewed)) as diff_reviewed_to_match
from (select potential_matches.*,
        if( @index<>potential_matches.opportunity_id , @sum:= 1, @sum := @sum + 1) as match_sum,
        if( @index<>potential_matches.opportunity_id , @index:=potential_matches.opportunity_id, @index := @index) as idd 
    from(select o.id as opportunity_id,
            o.objective as objective,
            oc.person_id as candidate_person_id,
            oc.interested as candidate_interested,
            me.interested as member_interested,
            o.stable_on as stable_on,
            o.review as review,
            o.reviewed as reviewed,
            o.created as created 
        from opportunities o 
            inner join opportunity_candidates oc on oc.opportunity_id = o.id and oc.interested is not null and o.objective not like "**%"
            inner join metrics_people ocp on ocp.id = oc.person_id 
            inner join member_evaluations me on me.candidate_id = oc.id and me.interested is not null 
            inner join opportunity_members om on om.id = me.member_id
            inner join metrics_people mep on mep.id = om.person_id
            inner join opportunity_organizations org on org.opportunity_id = o.id and org.organization_id != '665801' and org.active = true
        where me.interested > '2020-01-01' 
    ) as potential_matches 
    cross join (select @sum := 0, @index := 0) params 
    order by potential_matches.opportunity_id, potential_matches.member_interested asc
) as final 
where final.match_sum = 3 
order by 1 desc) `source`
WHERE (`source`.`created` >= date(date_add(now(6), INTERVAL -60 day))
   AND `source`.`created` < date(date_add(now(6), INTERVAL 1 day)))
GROUP BY str_to_date(concat(yearweek(`source`.`match_date`), ' Sunday'), '%X%V %W')
ORDER BY str_to_date(concat(yearweek(`source`.`match_date`), ' Sunday'), '%X%V %W') ASC