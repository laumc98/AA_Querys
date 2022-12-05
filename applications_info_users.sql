/* AA : AA Main dashboard : Applications - users info : prod */ 
SELECT
    opportunity_candidates.interested AS 'application date',
    opportunity_candidates.opportunity_id AS 'OppID',
    people.id AS 'people_id',
    people.subject_identifier AS 'subject_id',
    people.gg_id AS 'gg_id'
FROM 
    opportunity_candidates
    LEFT JOIN people ON opportunity_candidates.person_id = people.id 
WHERE 
    opportunity_candidates.interested IS NOT NULL 
    AND opportunity_candidates.interested > '2022-01-01'