/* AA : AA Main dashboard : weekly ss mm per channel : prod */ 
SELECT
    str_to_date(concat(yearweek(occh.created), ' Sunday'),'%X%V %W') AS 'date',
    oca.opportunity_id AS 'ID',
    tc.utm_medium AS 'Tracking Codes__utm_medium',
    count(distinct occh.candidate_id) AS 'weekly_mm_channel_ss'
FROM
    opportunity_candidate_column_history occh
    INNER JOIN opportunity_columns oc ON occh.to = oc.id
    INNER JOIN opportunities o ON oc.opportunity_id = o.id
    LEFT JOIN opportunity_candidates oca ON occh.candidate_id = oca.id
    LEFT JOIN tracking_code_candidates tcc ON oca.id = tcc.candidate_id
    LEFT JOIN tracking_codes tc ON tcc.tracking_code_id = tc.id
WHERE
    oc.name = 'mutual matches'
    AND occh.created >= '2021-07-18'
    AND oca.interested IS NOT NULL
    AND (o.fulfillment LIKE '%self_service%' or o.fulfillment LIKE '%essentials%')
    AND o.objective NOT LIKE '**%'
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
            date(coalesce(null, o.first_reviewed, o.last_reviewed)) >= '2021/01/01'
            AND o.objective NOT LIKE '**%'
            AND o.review = 'approved'
    )
GROUP BY
    str_to_date(concat(yearweek(occh.created), ' Sunday'),'%X%V %W'),
    tc.utm_medium,
    oca.opportunity_id
ORDER BY
    str_to_date(concat(yearweek(occh.created), ' Sunday'),'%X%V %W') ASC