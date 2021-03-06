/* AA : AA Main dashboard : list mm remote : prod */ 
SELECT 
    occh.candidate_id AS candidate_id,
    date(occh.created) AS MM_interested
FROM
    opportunity_candidate_column_history occh
    INNER JOIN opportunity_columns oc ON occh.to = oc.id
    INNER JOIN opportunities o ON oc.opportunity_id = o.id
WHERE
    oc.name = 'mutual matches'
    AND occh.created >= '2021-06-20'
    AND o.objective NOT LIKE '**%'
    AND o.remote = 1
    AND o.id IN (
        SELECT
            DISTINCT o.id AS opportunity_id
        FROM
            opportunities o
            INNER JOIN opportunity_members omp ON omp.opportunity_id = o.id
            AND omp.poster = TRUE
            INNER JOIN person_flags pf ON pf.person_id = omp.person_id
            AND pf.opportunity_crawler = FALSE
        WHERE
            o.reviewed >= '2021/01/01'
            AND o.objective NOT LIKE '**%'
            AND o.review = 'approved'
    )
GROUP BY
    occh.candidate_id